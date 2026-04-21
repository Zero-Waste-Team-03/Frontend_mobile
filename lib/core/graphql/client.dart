import 'dart:async';

import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

import '../../features/auth/data/sources/auth_local_data_source.dart';
import '../env.dart';

class GraphQLClientFactory {
  GraphQLClientFactory(this._authLocalDataSource);

  final AuthLocalDataSource _authLocalDataSource;

  bool _isPlaceholderEndpoint(String value) {
    return value.contains('api.example.com') ||
        value.contains('your-api.com') ||
        value.contains('localhost/graphql');
  }

  Client create() {
    final rawGraphQLEndpoint = Env.get('GRAPHQL_ENDPOINT')?.trim();
    final configuredBaseUrl =
        Env.get('API_BASE_URL')?.trim() ??
        const String.fromEnvironment(
          'API_BASE_URL',
          defaultValue: 'https://api.gaspzero.qzz.io/',
        );

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

    final authLink = Link.function((request, [forward]) async* {
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

    final errorLink = Link.function((request, [forward]) async* {
      try {
        if (forward != null) {
          yield* forward(request);
        }
      } catch (_) {
        rethrow;
      }
    });

    final link = Link.from([authLink, errorLink, httpLink]);

    return Client(
      link: link,
      cache: Cache(),
      requestController: StreamController<OperationRequest>.broadcast(),
    );
  }
}
