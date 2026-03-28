import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/exceptions/exceptions.dart';

import 'package:injectable/injectable.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheTokens(String accessToken, String? refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;

  static const accessTokenKey = 'CACHED_ACCESS_TOKEN';
  static const refreshTokenKey = 'CACHED_REFRESH_TOKEN';

  AuthLocalDataSourceImpl(this.secureStorage);

  @override
  Future<void> cacheTokens(String accessToken, String? refreshToken) async {
    try {
      await secureStorage.write(key: accessTokenKey, value: accessToken);
      if (refreshToken != null) {
        await secureStorage.write(key: refreshTokenKey, value: refreshToken);
      }
    } catch (e) {
      throw CacheException('Failed to cache tokens');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    try {
      return await secureStorage.read(key: accessTokenKey);
    } catch (e) {
      throw CacheException('Failed to get access token');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await secureStorage.read(key: refreshTokenKey);
    } catch (e) {
      throw CacheException('Failed to get refresh token');
    }
  }

  @override
  Future<void> clearTokens() async {
    try {
      await secureStorage.delete(key: accessTokenKey);
      await secureStorage.delete(key: refreshTokenKey);
    } catch (e) {
      throw CacheException('Failed to clear tokens');
    }
  }
}
