import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_exec/gql_exec.dart' show Context;
import 'package:gql_http_link/gql_http_link.dart';
import 'package:logger/logger.dart';
import '../../features/auth/data/sources/auth_local_data_source.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/auth_event.dart';
import '../../features/auth/presentation/bloc/auth_state.dart';
import '../../core/di/injection.dart';
import 'graphql/__generated__/refresh_tokens_interceptor.req.gql.dart';

/// Interceptor that automatically attaches the stored access token
/// to every outgoing request and handles 401 token-refresh logic.
class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource localDataSource;
  final Dio dio;
  final Client _ferryClient;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 2,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  AuthInterceptor({
    required this.localDataSource,
    required this.dio,
    required Client ferryClient,
  }) : _ferryClient = ferryClient;

  /// ---------- REQUEST ----------
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      bool isRefreshRequest = false;
      if (options.data is Map && options.data?['query'] != null) {
        if (options.data['query'].toString().contains(
          'mutation RefreshTokens',
        )) {
          isRefreshRequest = true;
        }
      }

      if (isRefreshRequest) {
        final refreshToken = await localDataSource.getRefreshToken();
        if (refreshToken != null && refreshToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $refreshToken';
          _logger.i(
            '[AuthInterceptor] Bearer refresh token attached to ${options.path}',
          );
        } else {
          _logger.w(
            '[AuthInterceptor] Could not read refresh token for refresh request',
          );
        }
      } else {
        final accessToken = await localDataSource.getAccessToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
          _logger.i(
            '[AuthInterceptor] Bearer access token attached to ${options.path}',
          );
        }
      }
    } catch (_) {
      // If we can't read the token, just proceed without it
      _logger.w('[AuthInterceptor] Could not read token');
    }
    handler.next(options);
  }

  Future<String?> _attemptRefresh() async {
    final refreshToken = await localDataSource.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      _logger.e(
        'â Œ [AuthInterceptor] No refresh token available, clearing session',
      );
      // We don't call clearTokens here to avoid double-wipe if logout is pending,
      // but we return null to signal failure.
      return null;
    }

    try {
      final request = GRefreshTokensForInterceptorReq(
        (b) => b
          ..context = Context.fromList([
            HttpLinkHeaders(headers: {'Authorization': 'Bearer $refreshToken'}),
          ])
          ..fetchPolicy = FetchPolicy.NetworkOnly,
      );

      final response = await _ferryClient
          .request(request)
          .firstWhere(
            (event) =>
                event.data != null ||
                event.hasErrors ||
                event.linkException != null,
          );

      if (!response.hasErrors && response.linkException == null) {
        final data = response.data?.refreshTokens;
        final newAccessToken = data?.accessToken;
        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await localDataSource.cacheTokens(newAccessToken, data?.refreshToken);
          _logger.i('âœ… [AuthInterceptor] Token refreshed successfully');
          return newAccessToken;
        }
      }

      final graphQLErrorMessage =
          response.graphqlErrors != null && response.graphqlErrors!.isNotEmpty
          ? response.graphqlErrors!.first.message
          : response.linkException?.toString();
      if (graphQLErrorMessage != null) {
        _logger.e('â Œ [AuthInterceptor] Refresh failed: $graphQLErrorMessage');
      }
    } catch (e) {
      _logger.e('â Œ [AuthInterceptor] Refresh exception: $e');
    }

    _logger.e('â Œ [AuthInterceptor] Refresh failed, session remains invalid');
    return null;
  }

  /// ---------- RESPONSE ----------
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    _logger.d('[AuthInterceptor] onResponse: ${response.requestOptions.path}');
    final bool handled = await _handleUnauthorizedResponse(response, handler);
    if (!handled) {
      handler.next(response);
    }
  }

  Future<bool> _handleUnauthorizedResponse(
    Response response,
    dynamic handler, // ResponseInterceptorHandler or ErrorInterceptorHandler
  ) async {
    _logger.d(
      '[AuthInterceptor] _handleUnauthorizedResponse checking: ${response.requestOptions.path}',
    );

    // Check if it's a GraphQL response with potential errors in the body
    final bool isGraphQLResponse = response.data != null && response.data is Map;
    final bool hasExplicitUnauthorizedHeader = response.statusCode == 401;

    if (!isGraphQLResponse && !hasExplicitUnauthorizedHeader) {
      return false;
    }

    bool isUnauthorized = hasExplicitUnauthorizedHeader;

    if (isGraphQLResponse) {
      final dataMap = response.data as Map;
      if (dataMap['errors'] != null) {
        final errors = dataMap['errors'] as List;
        _logger.d('[AuthInterceptor] Found ${errors.length} errors in body');

        for (var error in errors) {
          if (error is Map) {
            final extensions = error['extensions'] as Map?;
            final code = extensions?['code'] ?? error['code'];
            final statusCode = extensions?['status'] ??
                extensions?['statusCode'] ??
                error['statusCode'];
            final message = error['message']?.toString() ?? '';

            _logger.d(
              '[AuthInterceptor] Checking error: code=$code, statusCode=$statusCode, message=$message',
            );

            if (code == 'UNAUTHENTICATED' ||
                code == 'AUTH_NOT_LOGGED_IN' ||
                statusCode == 401 ||
                message.contains('Unauthorized') ||
                message.contains('Unauthenticated')) {
              isUnauthorized = true;
              _logger.i(
                '[AuthInterceptor] Match found for Unauthorized error in GraphQL body',
              );
              break;
            }
          }
        }
      }
    }

    if (isUnauthorized) {
      _logger.w(
        '🔄 [AuthInterceptor] Unauthorized detected, attempting token refresh',
      );

      // Prevent infinite loops if the refresh request itself returns 401
      final requestQuery = response.requestOptions.data is Map
          ? response.requestOptions.data['query']?.toString() ?? ''
          : '';
      if (requestQuery.contains('mutation RefreshTokens') ||
          requestQuery.contains('RefreshTokensForInterceptor')) {
        _logger.e('[AuthInterceptor] Refresh loop detected, aborting');
        // Trigger global logout if the refresh request itself is unauthorized
        _logger.e(
          '[AuthInterceptor] Refresh request was unauthorized, triggering global logout',
        );
        try {
          // Trigger logout if the refresh request itself is unauthorized
          _logger.e(
            '[AuthInterceptor] Refresh request was unauthorized, triggering global logout',
          );
          final authBloc = getIt<AuthBloc>();
          if (authBloc.state is! AuthUnauthenticated) {
            authBloc.add(AuthLogoutRequested());
          }
        } catch (e) {
          _logger.e('[AuthInterceptor] Failed to trigger logout: $e');
        }
        return false;
      }

      final newAccessToken = await _attemptRefresh();

      if (newAccessToken != null) {
        // Retry original request
        final retryOptions = response.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        try {
          // Retry using the same Dio instance
          final retryResponse = await dio.fetch(retryOptions);
          if (handler is ResponseInterceptorHandler) {
            handler.resolve(retryResponse);
          } else if (handler is ErrorInterceptorHandler) {
            handler.resolve(retryResponse);
          }
          return true;
        } catch (e) {
          _logger.e('[AuthInterceptor] Retry request failed: $e');
          return false;
        }
      } else {
        // Refresh failed, trigger logout
        _logger.e(
          '[AuthInterceptor] Refresh failed, triggering global logout',
        );
        try {
          final authBloc = getIt<AuthBloc>();
          if (authBloc.state is! AuthUnauthenticated) {
            authBloc.add(AuthLogoutRequested());
          }
        } catch (e) {
          _logger.e('[AuthInterceptor] Failed to trigger logout: $e');
        }
      }
    }

    return false;
  }



  /// ---------- ERROR ----------
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    _logger.d('[AuthInterceptor] onError: ${err.requestOptions.path} - ${err.message}');
    if (err.response != null) {
      final bool handled =
          await _handleUnauthorizedResponse(err.response!, handler);
      if (handled) return;
    }

    // If the server returns 401 Unauthorized, attempt to refresh the token
    if (err.response?.statusCode == 401) {
      _logger.w(
        '🔄 [AuthInterceptor] HTTP 401 received, attempting token refresh',
      );

      final newAccessToken = await _attemptRefresh();
      if (newAccessToken != null) {
        final retryOptions = err.requestOptions;
        retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        try {
          final retryResponse = await dio.fetch(retryOptions);
          return handler.resolve(retryResponse);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    handler.next(err);
  }
}
