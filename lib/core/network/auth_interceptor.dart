import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import '../../features/auth/data/sources/auth_local_data_source.dart';

/// Interceptor that automatically attaches the stored access token
/// to every outgoing request and handles 401 token-refresh logic.
class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource localDataSource;
  final Dio dio;
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
  });

  /// ---------- REQUEST ----------
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      bool isRefreshRequest = false;
      if (options.data is Map && options.data?['query'] != null) {
        if (options.data['query'].toString().contains('mutation RefreshTokens')) {
          isRefreshRequest = true;
        }
      }

      if (isRefreshRequest) {
        final refreshToken = await localDataSource.getRefreshToken();
        if (refreshToken != null && refreshToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $refreshToken';
          _logger.i('🔑 [AuthInterceptor] Bearer refresh token attached to ${options.path}');
        } else {
          _logger.w('⚠️ [AuthInterceptor] Could not read refresh token for refresh request');
        }
      } else {
        final accessToken = await localDataSource.getAccessToken();
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
          _logger.i('🔑 [AuthInterceptor] Bearer access token attached to ${options.path}');
        }
      }
    } catch (_) {
      // If we can't read the token, just proceed without it
      _logger.w('⚠️ [AuthInterceptor] Could not read token');
    }
    handler.next(options);
  }

  Future<String?> _attemptRefresh() async {
    final refreshToken = await localDataSource.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      _logger.e('â Œ [AuthInterceptor] No refresh token available, clearing session');
      await localDataSource.clearTokens();
      return null;
    }

    try {
      final refreshDio = Dio(BaseOptions(
        baseUrl: dio.options.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      ));

      const refreshQuery = '''
        mutation RefreshTokens {
          refreshTokens {
            accessToken
            refreshToken
          }
        }
      ''';

      final response = await refreshDio.post('/graphql', data: {
        'query': refreshQuery,
      });

      if (response.statusCode == 200 && response.data['errors'] == null) {
        final data = response.data['data']?['refreshTokens'];
        if (data != null) {
          final newAccessToken = data['accessToken'] as String;
          final newRefreshToken = data['refreshToken'] as String?;
          await localDataSource.cacheTokens(newAccessToken, newRefreshToken);
          _logger.i('âœ… [AuthInterceptor] Token refreshed successfully');
          return newAccessToken;
        }
      }
    } catch (e) {
      _logger.e('â Œ [AuthInterceptor] Refresh exception: $e');
    }

    _logger.e('â Œ [AuthInterceptor] Refresh failed, clearing session');
    await localDataSource.clearTokens();
    return null;
  }

  /// ---------- RESPONSE ----------
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // Check for GraphQL errors with 401 UNAUTHENTICATED inside a 200 OK response
    if (response.statusCode == 200 && response.data != null && response.data is Map && response.data['errors'] != null) {
      final errors = response.data['errors'] as List;
      bool isUnauthorized = false;
      for (var error in errors) {
        if (error is Map && (error['code'] == 'UNAUTHENTICATED' || error['statusCode'] == 401 || error['message'] == 'Unauthorized')) {
          isUnauthorized = true;
          break;
        }
      }

      if (isUnauthorized) {
        _logger.w('ðŸ”„ [AuthInterceptor] GraphQL Unauthorized error received, attempting token refresh');
        final newAccessToken = await _attemptRefresh();
        
        if (newAccessToken != null) {
          // Retry original request
          final retryOptions = response.requestOptions;
          retryOptions.headers['Authorization'] = 'Bearer $newAccessToken';
          try {
            final retryResponse = await dio.fetch(retryOptions);
            return handler.resolve(retryResponse);
          } catch (e) {
            return handler.next(response);
          }
        }
      }
    }
    handler.next(response);
  }

  /// ---------- ERROR ----------
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If the server returns 401 Unauthorized, attempt to refresh the token
    if (err.response?.statusCode == 401) {
      _logger.w('ðŸ”„ [AuthInterceptor] HTTP 401 received, attempting token refresh');
      
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
