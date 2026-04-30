import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/user_model.dart';

import 'package:injectable/injectable.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheTokens(String accessToken, String? refreshToken);
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();

  // Profile caching methods
  Future<void> cacheUserProfile(UserModel user);
  Future<UserModel?> getCachedUserProfile();
  Future<void> clearUserProfile();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  static const accessTokenKey = 'CACHED_ACCESS_TOKEN';
  static const refreshTokenKey = 'CACHED_REFRESH_TOKEN';
  static const userProfileKey = 'CACHED_USER_PROFILE';

  AuthLocalDataSourceImpl(this.secureStorage, this.sharedPreferences);

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
      var access_token = await secureStorage.read(key: accessTokenKey);
      return access_token;
    } catch (e) {
      throw CacheException('Failed to get access token');
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      var refresh_token = await secureStorage.read(key: refreshTokenKey);
      return refresh_token;
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

  // Profile caching methods
  @override
  Future<void> cacheUserProfile(UserModel user) async {
    try {
      final userJson = user.toJson();
      final jsonString = jsonEncode(userJson);
      await sharedPreferences.setString(userProfileKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache user profile');
    }
  }

  @override
  Future<UserModel?> getCachedUserProfile() async {
    try {
      final userJsonString = sharedPreferences.getString(userProfileKey);
      if (userJsonString == null) {
        return null;
      }
      final userJson = jsonDecode(userJsonString) as Map<String, dynamic>;
      return UserModel.fromJson(userJson);
    } catch (e) {
      throw CacheException('Failed to get cached user profile');
    }
  }

  @override
  Future<void> clearUserProfile() async {
    try {
      await sharedPreferences.remove(userProfileKey);
    } catch (e) {
      throw CacheException('Failed to clear user profile');
    }
  }
}
