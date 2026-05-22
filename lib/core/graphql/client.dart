import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio_lib;
import 'package:ferry/ferry.dart' as ferry;
import 'package:gql_http_link/gql_http_link.dart';
import 'package:get_it/get_it.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql/language.dart' as gql_lang;

import '../../features/auth/data/sources/auth_local_data_source.dart';
import '../device/device_id_provider.dart';
import '../env.dart';

class GraphQLClientFactory {
  GraphQLClientFactory(this._authLocalDataSource, this._deviceIdProvider);

  final AuthLocalDataSource _authLocalDataSource;
  final DeviceIdProvider _deviceIdProvider;

  bool _isPlaceholderEndpoint(String value) {
    return value.contains('api.example.com') ||
        value.contains('your-api.com') ||
        value.contains('localhost/graphql');
  }

  ferry.Client create() {
    final rawGraphQLEndpoint = Env.get('GRAPHQL_ENDPOINT')?.trim();
    final configuredBaseUrl =
        Env.get('API_BASE_URL')?.trim() ??
        const String.fromEnvironment('API_BASE_URL');

    final fallbackEndpoint = Uri.parse(
      configuredBaseUrl.endsWith('/')
          ? configuredBaseUrl
          : '$configuredBaseUrl/',
    ).resolve('graphql').toString();

    final endpoint =
        rawGraphQLEndpoint == null ||
            rawGraphQLEndpoint.isEmpty ||
            _isPlaceholderEndpoint(rawGraphQLEndpoint)
        ? fallbackEndpoint
        : rawGraphQLEndpoint;

    final httpLink = HttpLink(endpoint);

    final authLink = ferry.Link.function((request, [forward]) async* {
      final operationName = request.operation.operationName;
      final isRefreshOperation =
          operationName == 'RefreshTokens' ||
          operationName == 'RefreshTokensForInterceptor';

      final existingHeaders =
          request.context.entry<HttpLinkHeaders>()?.headers ??
          const <String, String>{};
      final hasAuthorizationHeader =
          existingHeaders.containsKey('Authorization') ||
          existingHeaders.containsKey('authorization');

      final headers = <String, String>{};
      final deviceId = await _deviceIdProvider.getOrCreateDeviceId();
      headers['x-device-id'] = deviceId;

      if (!hasAuthorizationHeader) {
        final token = isRefreshOperation
            ? await _authLocalDataSource.getRefreshToken()
            : await _authLocalDataSource.getAccessToken();
        if (token != null && token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        }
      }

      final next = request.updateContextEntry<HttpLinkHeaders>(
        (existing) =>
            HttpLinkHeaders(headers: {...?existing?.headers, ...headers}),
      );
      if (forward != null) {
        yield* forward(next);
      }
    });

    final errorLink = ferry.Link.function((request, [forward]) async* {
      if (forward == null) return;

      await for (final response in forward(request)) {
        // Transform JSON scalars in notifications to handle meta field properly
        _transformNotificationMetaFields(response);

        bool isUnauthorized = false;

        if (response.errors != null && response.errors!.isNotEmpty) {
          for (final error in response.errors!) {
            final code = error.extensions?['code'];
            final statusCode =
                error.extensions?['status'] ?? error.extensions?['statusCode'];
            final message = error.message;

            if (code == 'UNAUTHENTICATED' ||
                code == 'AUTH_NOT_LOGGED_IN' ||
                statusCode == 401 ||
                message.contains('Unauthorized') ||
                message.contains('Unauthenticated')) {
              isUnauthorized = true;
              break;
            }
          }
        }

        if (isUnauthorized) {
          final operationName = request.operation.operationName;
          if (operationName != 'RefreshTokens' &&
              operationName != 'RefreshTokensForInterceptor') {
            try {
              final dio = GetIt.instance<dio_lib.Dio>();

              final String queryString = gql_lang.printNode(
                request.operation.document,
              );

              final dioResponse = await dio.post(
                endpoint,
                data: {
                  'query': queryString,
                  'variables': request.variables,
                  'operationName': operationName,
                },
                options: dio_lib.Options(
                  headers: request.context.entry<HttpLinkHeaders>()?.headers,
                ),
              );

              if (dioResponse.data != null) {
                final Map<String, dynamic> data = dioResponse.data;
                yield Response(
                  data: data['data'],
                  errors: (data['errors'] as List?)
                      ?.map(
                        (e) => GraphQLError(
                          message: e['message'],
                          extensions: e['extensions'],
                        ),
                      )
                      .toList(),
                  context: response.context,
                  response: data,
                );
                continue;
              }
            } catch (e) {
              // If retry fails, let the original unauthorized response through
            }
          }
        }
        yield response;
      }
    });

    final link = ferry.Link.from([authLink, errorLink, httpLink]);

    return ferry.Client(
      link: link,
      cache: ferry.Cache(),
      requestController: StreamController<ferry.OperationRequest>.broadcast(),
    );
  }

  /// Transform meta fields in notification responses to ensure proper JSON serialization
  void _transformNotificationMetaFields(Response response) {
    try {
      if (response.data == null) return;

      // Handle getNotifications query
      final getNotifications =
          (response.data as Map<String, dynamic>)['getNotifications'];
      if (getNotifications is Map<String, dynamic>) {
        final items = getNotifications['items'];
        if (items is List) {
          for (final item in items) {
            if (item is Map<String, dynamic>) {
              _transformMetaField(item);
            }
          }
        }
      }
    } catch (e) {
      // Silent fail - don't break the response if transformation fails
    }
  }

  /// Convert meta field to JSON string if it's a Map or List
  void _transformMetaField(Map<String, dynamic> item) {
    final meta = item['meta'];
    if (meta == null) return;

    // If meta is already a string or primitive, leave it
    if (meta is String || meta is num || meta is bool) {
      return;
    }

    // If meta is a Map or List, convert to JSON string
    if (meta is Map || meta is List) {
      try {
        item['meta'] = jsonEncode(meta);
      } catch (e) {
        // If encoding fails, set to null
        item['meta'] = null;
      }
    }
  }
}
