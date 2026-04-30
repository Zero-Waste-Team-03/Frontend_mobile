import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

/// Handles FCM token operations with comprehensive logging and error handling
class FcmManager {
  late FirebaseMessaging _firebaseMessaging;
  bool _isInitialized = false;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  /// Initialize Firebase Messaging (called after Firebase.initializeApp())
  void _ensureInitialized() {
    if (_isInitialized) return;
    try {
      _firebaseMessaging = FirebaseMessaging.instance;
      _isInitialized = true;
      _logger.i('✅ FcmManager: Firebase Messaging initialized');
    } catch (e) {
      _logger.w('⚠️ FcmManager: Firebase not fully initialized yet');
    }
  }

  /// Get current FCM token with logging
  /// Returns null if token cannot be obtained
  Future<String?> getFcmToken() async {
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for getFcmToken',
      );
      return null;
    }
    _logger.i('🔔 FcmManager: Attempting to get FCM token...');
    try {
      final token = await _firebaseMessaging.getToken();
      if (token != null && token.isNotEmpty) {
        _logger.i('✅ FcmManager: FCM token obtained successfully');
        _logger.d(
          '📱 FcmManager: Token (last 20 chars): ...${token.substring(token.length - 20)}',
        );
        return token;
      } else {
        _logger.w('⚠️  FcmManager: FCM token is null or empty');
        return null;
      }
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error getting FCM token',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Request user notification permissions
  /// Returns NotificationSettings object or null if Firebase isn't initialized
  Future<NotificationSettings?> requestNotificationPermission() async {
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for requestNotificationPermission',
      );
      return null;
    }
    _logger.i('🔔 FcmManager: Requesting notification permissions...');
    try {
      final settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      _logger.i('✅ FcmManager: Notification permission requested');
      _logger.d(
        '📋 FcmManager: Authorization status: ${settings.authorizationStatus}',
      );
      _logger.d(
        '📋 FcmManager: Alert: ${settings.alert}, Badge: ${settings.badge}, Sound: ${settings.sound}',
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _logger.i('✅ FcmManager: Notifications authorized');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        _logger.i(
          '⚠️  FcmManager: Provisional notification permission granted',
        );
      } else {
        _logger.w(
          '⚠️  FcmManager: Notification permission denied or not determined',
        );
      }

      return settings;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error requesting notification permissions',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Setup token refresh listener
  /// Calls [onTokenRefresh] whenever FCM token is refreshed
  void setupTokenRefreshListener(void Function(String token) onTokenRefresh) {
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for setupTokenRefreshListener',
      );
      return;
    }
    _logger.i('🔔 FcmManager: Setting up FCM token refresh listener...');
    try {
      _firebaseMessaging.onTokenRefresh.listen(
        (newToken) {
          _logger.i('🔄 FcmManager: FCM token refreshed');
          _logger.d(
            '📱 FcmManager: New token (last 20 chars): ...${newToken.substring(newToken.length - 20)}',
          );
          onTokenRefresh(newToken);
        },
        onError: (error, stackTrace) {
          _logger.e(
            '❌ FcmManager: Error in token refresh listener',
            error: error,
            stackTrace: stackTrace,
          );
        },
        onDone: () {
          _logger.w('⚠️  FcmManager: Token refresh stream closed');
        },
      );
      _logger.i('✅ FcmManager: Token refresh listener setup complete');
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error setting up token refresh listener',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't rethrow; just log and continue so app doesn't crash on FCM setup errors
      return;
    }
  }

  /// Setup foreground notification handler
  /// Calls [onForegroundMessage] when notification is received while app is in foreground
  void setupForegroundNotificationHandler(
    Future<void> Function(RemoteMessage message) onForegroundMessage,
  ) {
    _logger.i('🔔 FcmManager: setupForegroundNotificationHandler excuting... ');
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for setupForegroundNotificationHandler',
      );
      return;
    }
    _logger.i('🔔 FcmManager: Setting up foreground notification handler...');
    try {
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) {
          _logger.i('📢 FcmManager: Received foreground notification');
          _logger.d('📋 FcmManager: Title: ${message.notification?.title}');
          _logger.d('📋 FcmManager: Body: ${message.notification?.body}');
          if (message.data.isNotEmpty) {
            _logger.d('📋 FcmManager: Data: ${message.data}');
          }
          onForegroundMessage(message);
        },
        onError: (error, stackTrace) {
          _logger.e(
            '❌ FcmManager: Error in foreground message handler',
            error: error,
            stackTrace: stackTrace,
          );
        },
        onDone: () {
          _logger.w('⚠️  FcmManager: Foreground message stream closed');
        },
      );
      _logger.i('✅ FcmManager: Foreground notification handler setup complete');
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error setting up foreground notification handler',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't rethrow; log and continue
      return;
    }
  }

  /// Setup background notification handler (static for app state termination)
  /// Should be called at app startup before Firebase initialization
  static void setupBackgroundNotificationHandler(
    Future<void> Function(RemoteMessage message) onBackgroundMessage,
  ) {
    final logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 3,
        lineLength: 80,
        colors: true,
        printEmojis: false,
      ),
    );

    logger.i('🔔 FcmManager: Setting up background notification handler...');
    try {
      FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
      logger.i('✅ FcmManager: Background notification handler setup complete');
    } catch (e, stackTrace) {
      logger.e(
        '❌ FcmManager: Error setting up background notification handler',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't rethrow; log and continue
      return;
    }
  }

  /// Setup notification tap handler (when user taps on notification)
  /// Calls [onNotificationTap] when notification is tapped
  void setupNotificationTapHandler(
    Future<void> Function(RemoteMessage message) onNotificationTap,
  ) {
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for setupNotificationTapHandler',
      );
      return;
    }
    _logger.i('🔔 FcmManager: Setting up notification tap handler...');
    try {
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          _logger.i('👆 FcmManager: User tapped on notification');
          _logger.d('📋 FcmManager: Title: ${message.notification?.title}');
          _logger.d('📋 FcmManager: Body: ${message.notification?.body}');
          if (message.data.isNotEmpty) {
            _logger.d('📋 FcmManager: Data: ${message.data}');
          }
          onNotificationTap(message);
        },
        onError: (error, stackTrace) {
          _logger.e(
            '❌ FcmManager: Error in notification tap handler',
            error: error,
            stackTrace: stackTrace,
          );
        },
        onDone: () {
          _logger.w('⚠️  FcmManager: Notification tap stream closed');
        },
      );
      _logger.i('✅ FcmManager: Notification tap handler setup complete');
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error setting up notification tap handler',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't rethrow; log and continue
      return;
    }
  }

  /// Get initial notification message (when app opened from notification)
  /// Returns null if no notification was used to open the app
  Future<RemoteMessage?> getInitialNotification() async {
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for getInitialNotification',
      );
      return null;
    }
    _logger.i('🔔 FcmManager: Checking for initial notification message...');
    try {
      final initialMessage = await _firebaseMessaging.getInitialMessage();
      if (initialMessage != null) {
        _logger.i('📬 FcmManager: Initial notification message found');
        _logger.d(
          '📋 FcmManager: Title: ${initialMessage.notification?.title}',
        );
        _logger.d('📋 FcmManager: Body: ${initialMessage.notification?.body}');
        if (initialMessage.data.isNotEmpty) {
          _logger.d('📋 FcmManager: Data: ${initialMessage.data}');
        }
      } else {
        _logger.d('📬 FcmManager: No initial notification message');
      }
      return initialMessage;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error getting initial notification',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Get current notification settings safely
  /// Returns null if Firebase isn't initialized or on error
  Future<NotificationSettings?> getNotificationSettings() async {
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for getNotificationSettings',
      );
      return null;
    }
    try {
      final settings = await _firebaseMessaging.getNotificationSettings();
      return settings;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error getting notification settings',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Delete FCM token
  Future<void> deleteToken() async {
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for deleteToken',
      );
      return;
    }
    _logger.i('🔔 FcmManager: Deleting FCM token...');
    try {
      await _firebaseMessaging.deleteToken();
      _logger.i('✅ FcmManager: FCM token deleted successfully');
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error deleting FCM token',
        error: e,
        stackTrace: stackTrace,
      );
      // Don't rethrow; log and continue
      return;
    }
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    _ensureInitialized();
    if (!_isInitialized) {
      _logger.w(
        '⚠️ FcmManager: Firebase Messaging not initialized for areNotificationsEnabled',
      );
      return false;
    }
    _logger.d('🔔 FcmManager: Checking notification settings...');
    try {
      final settings = await _firebaseMessaging.getNotificationSettings();
      final isEnabled =
          settings.authorizationStatus == AuthorizationStatus.authorized;
      _logger.d('📋 FcmManager: Notifications enabled: $isEnabled');
      return isEnabled;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmManager: Error checking notification settings',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  /// Set APNs token (iOS only) - needed for iOS APNs
  void setApnsToken(String? token) {
    _logger.i('🔔 FcmManager: Setting APNS token...');
    if (token != null && token.isNotEmpty) {
      _logger.d(
        '📱 FcmManager: APNS token (last 20 chars): ...${token.substring(token.length - 20)}',
      );
    } else {
      _logger.w('⚠️  FcmManager: APNS token is null or empty');
    }
  }
}
