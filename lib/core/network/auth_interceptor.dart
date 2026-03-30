import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../features/auth/data/sources/auth_local_data_source.dart';

/// Interceptor that automatically attaches the stored access token
/// to every outgoing request and handles 401 token-refresh logic.
class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource localDataSource;
  final Dio dio;

  AuthInterceptor({
    required this.localDataSource,
    required this.dio,
  });

  /// ---------- REQUEST ----------
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final accessToken = await localDataSource.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
        debugPrint('🔑 AuthInterceptor: Token attached to ${options.path}');
      }
    } catch (_) {
      // If we can't read the token, just proceed without it
      debugPrint('⚠️ AuthInterceptor: Could not read token');
    }
    handler.next(options);
  }

  /// ---------- ERROR ----------
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If the server returns 401 Unauthorized, attempt to refresh the token
    if (err.response?.statusCode == 401) {
      debugPrint('🔄 AuthInterceptor: 401 received – attempting token refresh');

      try {
        final refreshToken = await localDataSource.getRefreshToken();
        if (refreshToken == null || refreshToken.isEmpty) {
          debugPrint('❌ AuthInterceptor: No refresh token available — clearing session');
          await localDataSource.clearTokens();
          return handler.next(err);
        }

        // Call the refresh-token endpoint
        final refreshDio = Dio(BaseOptions(
          baseUrl: dio.options.baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ));

        const refreshQuery = '''
          mutation RefreshToken(\$refreshToken: String!) {
            refreshToken(refreshToken: \$refreshToken) {
              accessToken
              refreshToken
            }
          }
        ''';

        final response = await refreshDio.post('/graphql', data: {
          'query': refreshQuery,
          'variables': {'refreshToken': refreshToken},
        });

        if (response.statusCode == 200 && response.data['errors'] == null) {
          final data = response.data['data']['refreshToken'];
          final newAccessToken = data['accessToken'] as String;
          final newRefreshToken = data['refreshToken'] as String?;

          // Persist the new tokens
          await localDataSource.cacheTokens(newAccessToken, newRefreshToken);

          debugPrint('✅ AuthInterceptor: Token refreshed successfully');

          // Retry the original request with the new token
          final retryOptions = err.requestOptions;
          retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';

          final retryResponse = await dio.fetch(retryOptions);
          return handler.resolve(retryResponse);
        } else {
          debugPrint('❌ AuthInterceptor: Refresh failed — clearing session');
          await localDataSource.clearTokens();
        }
      } catch (e) {
        debugPrint('❌ AuthInterceptor: Refresh exception — $e');
        await localDataSource.clearTokens();
      }
    }
    handler.next(err);
  }
}
