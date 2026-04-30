import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/exceptions/exceptions.dart';

/// Abstract local data source for FCM token storage
abstract class FcmTokenLocalDataSource {
  /// Get stored FCM token
  Future<String?> getFcmToken();

  /// Store FCM token locally
  Future<void> saveFcmToken(String token);

  /// Delete stored FCM token
  Future<void> deleteFcmToken();

  /// Check if FCM token was registered with backend
  Future<bool> isFcmTokenRegistered();

  /// Mark FCM token as registered
  Future<void> markFcmTokenAsRegistered();

  /// Clear FCM token registration status
  Future<void> clearFcmTokenRegistrationStatus();

  /// Get timestamp of last token registration
  Future<DateTime?> getLastTokenRegistrationTime();

  /// Update last token registration timestamp
  Future<void> updateLastTokenRegistrationTime();
}

/// Implementation of FCM token local data source using SharedPreferences
@LazySingleton(as: FcmTokenLocalDataSource)
class FcmTokenLocalDataSourceImpl implements FcmTokenLocalDataSource {
  FcmTokenLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  static const String _fcmTokenKey = 'fcm_token';
  static const String _fcmTokenRegisteredKey = 'fcm_token_registered';
  static const String _lastTokenRegistrationTimeKey =
      'last_token_registration_time';

  @override
  Future<String?> getFcmToken() async {
    _logger.i('💾 FcmTokenLocalDataSourceImpl: Retrieving stored FCM token...');
    try {
      final token = _prefs.getString(_fcmTokenKey);
      if (token != null && token.isNotEmpty) {
        _logger.d(
          '✅ FcmTokenLocalDataSourceImpl: FCM token retrieved (last 20 chars): ...${token.substring(token.length - 20)}',
        );
      } else {
        _logger.d('⚠️  FcmTokenLocalDataSourceImpl: No stored FCM token found');
      }
      return token;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenLocalDataSourceImpl: Error retrieving FCM token',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException('Failed to retrieve FCM token: ${e.toString()}');
    }
  }

  @override
  Future<void> saveFcmToken(String token) async {
    _logger.i('💾 FcmTokenLocalDataSourceImpl: Saving FCM token locally...');
    _logger.d(
      '📱 FcmTokenLocalDataSourceImpl: Token (last 20 chars): ...${token.substring(token.length - 20)}',
    );

    if (token.isEmpty) {
      _logger.e('❌ FcmTokenLocalDataSourceImpl: Cannot save empty FCM token');
      throw CacheException('FCM token cannot be empty');
    }

    try {
      await _prefs.setString(_fcmTokenKey, token);
      _logger.i('✅ FcmTokenLocalDataSourceImpl: FCM token saved successfully');
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenLocalDataSourceImpl: Error saving FCM token',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException('Failed to save FCM token: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteFcmToken() async {
    _logger.i('💾 FcmTokenLocalDataSourceImpl: Deleting stored FCM token...');
    try {
      await _prefs.remove(_fcmTokenKey);
      _logger.i(
        '✅ FcmTokenLocalDataSourceImpl: FCM token deleted successfully',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenLocalDataSourceImpl: Error deleting FCM token',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException('Failed to delete FCM token: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFcmTokenRegistered() async {
    _logger.d(
      '💾 FcmTokenLocalDataSourceImpl: Checking FCM token registration status...',
    );
    try {
      final isRegistered = _prefs.getBool(_fcmTokenRegisteredKey) ?? false;
      _logger.d(
        'ℹ️  FcmTokenLocalDataSourceImpl: FCM token registered: $isRegistered',
      );
      return isRegistered;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenLocalDataSourceImpl: Error checking registration status',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException(
        'Failed to check FCM token registration status: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> markFcmTokenAsRegistered() async {
    _logger.i(
      '💾 FcmTokenLocalDataSourceImpl: Marking FCM token as registered...',
    );
    try {
      await _prefs.setBool(_fcmTokenRegisteredKey, true);
      _logger.i(
        '✅ FcmTokenLocalDataSourceImpl: FCM token marked as registered',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenLocalDataSourceImpl: Error marking token as registered',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException(
        'Failed to mark FCM token as registered: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> clearFcmTokenRegistrationStatus() async {
    _logger.i(
      '💾 FcmTokenLocalDataSourceImpl: Clearing FCM token registration status...',
    );
    try {
      await _prefs.setBool(_fcmTokenRegisteredKey, false);
      _logger.i(
        '✅ FcmTokenLocalDataSourceImpl: FCM token registration status cleared',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenLocalDataSourceImpl: Error clearing registration status',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException(
        'Failed to clear FCM token registration status: ${e.toString()}',
      );
    }
  }

  @override
  Future<DateTime?> getLastTokenRegistrationTime() async {
    _logger.d(
      '💾 FcmTokenLocalDataSourceImpl: Retrieving last token registration time...',
    );
    try {
      final timestamp = _prefs.getInt(_lastTokenRegistrationTimeKey);
      if (timestamp != null) {
        final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
        _logger.d(
          'ℹ️  FcmTokenLocalDataSourceImpl: Last registration time: $dateTime',
        );
        return dateTime;
      }
      _logger.d(
        '⚠️  FcmTokenLocalDataSourceImpl: No previous registration time found',
      );
      return null;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenLocalDataSourceImpl: Error retrieving registration time',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException(
        'Failed to retrieve last registration time: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> updateLastTokenRegistrationTime() async {
    _logger.i(
      '💾 FcmTokenLocalDataSourceImpl: Updating last token registration time...',
    );
    try {
      final now = DateTime.now();
      await _prefs.setInt(
        _lastTokenRegistrationTimeKey,
        now.millisecondsSinceEpoch,
      );
      _logger.i(
        '✅ FcmTokenLocalDataSourceImpl: Last registration time updated to $now',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenLocalDataSourceImpl: Error updating registration time',
        error: e,
        stackTrace: stackTrace,
      );
      throw CacheException(
        'Failed to update last registration time: ${e.toString()}',
      );
    }
  }
}
