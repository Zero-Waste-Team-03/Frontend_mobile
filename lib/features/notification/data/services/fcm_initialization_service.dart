import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../data/services/fcm_manager.dart';
import '../../domain/usecases/fcm_token_usecases.dart';
import '../../presentation/bloc/notification_bloc.dart';
import '../../presentation/bloc/notification_event.dart';

/// Global FCM initialization service
/// Handles all FCM setup and configuration at app startup
class FcmInitializationService {
  static bool _postLoginListenersConfigured = false;
  static bool _postLoginInitializationInProgress = false;

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  /// Initialize FCM at app startup
  /// Call this in main() before running the app
  static Future<void> initializeFcm() async {
    _logger.i('🔔 FcmInitializationService: Starting FCM initialization...');

    try {
      // Initialize Firebase
      _logger.i('🔥 FcmInitializationService: Initializing Firebase...');
      await Firebase.initializeApp();
      _logger.i('✅ FcmInitializationService: Firebase initialized');

      // Setup background message handler
      _logger.i(
        '📲 FcmInitializationService: Setting up background message handler...',
      );
      FcmManager.setupBackgroundNotificationHandler(
        _handleBackgroundNotification,
      );
      // Ensure iOS presents notifications while app is foregrounded
      try {
        if (Platform.isIOS) {
          _logger.i(
            '🔔 FcmInitializationService: Configuring iOS foreground presentation options',
          );
          await FirebaseMessaging.instance
              .setForegroundNotificationPresentationOptions(
                alert: true,
                badge: true,
                sound: true,
              );
          _logger.i(
            '✅ FcmInitializationService: iOS foreground presentation options set',
          );
        }
      } catch (e, st) {
        _logger.w(
          '⚠️ FcmInitializationService: Failed to set iOS foreground presentation options',
          error: e,
          stackTrace: st,
        );
      }

      // Add a global debug listener to verify messages arrive in foreground
      try {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          _logger.i(
            '🔍 FcmInitializationService: Global onMessage received (debug)',
          );
          _logger.d('📋 Raw message: ${message.toMap()}');
        });
        _logger.i(
          '✅ FcmInitializationService: Global onMessage debug listener registered',
        );
      } catch (e, st) {
        _logger.w(
          '⚠️ FcmInitializationService: Could not register global onMessage debug listener',
          error: e,
          stackTrace: st,
        );
      }
      _logger.i(
        '✅ FcmInitializationService: Background message handler setup complete',
      );

      _logger.i(
        '🎉 FcmInitializationService: FCM initialization completed successfully',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmInitializationService: Error during FCM initialization',
        error: e,
        stackTrace: stackTrace,
      );
      // Do not rethrow - allow app to continue running without Firebase configured.
      _logger.w(
        '⚠️ FcmInitializationService: Continuing without Firebase - push notifications disabled until configured',
      );
      return;
    }
  }

  /// Initialize notification permissions and FCM registration after login.
  /// This avoids prompting users before they have authenticated.
  static Future<void> initializeAfterLogin() async {
    if (_postLoginInitializationInProgress) {
      _logger.i(
        '🔔 FcmInitializationService: Post-login FCM initialization already running',
      );
      return;
    }

    _postLoginInitializationInProgress = true;

    try {
      _logger.i(
        '🔔 FcmInitializationService: Starting post-login FCM initialization...',
      );

      final fcmManager = GetIt.I<FcmManager>();
      final registerFcmTokenUseCase = GetIt.I<RegisterFcmTokenUseCase>();

      if (!_postLoginListenersConfigured) {
        _logger.i(
          '📡 FcmInitializationService: Configuring FCM listeners after login...',
        );
        fcmManager.setupTokenRefreshListener((newToken) {
          _logger.i(
            '🔄 FcmInitializationService: Token refresh detected after login',
          );
          unawaited(_registerFcmToken(registerFcmTokenUseCase, newToken));
        });

        fcmManager.setupForegroundNotificationHandler((
          RemoteMessage message,
        ) async {
          _logger.i(
            '📬 FcmInitializationService: Foreground notification received',
          );
          try {
            final notificationBloc = GetIt.I<NotificationBloc>();
            notificationBloc.add(FcmNotificationReceivedEvent(message.data));
          } catch (e) {
            _logger.w(
              '⚠️  FcmInitializationService: Unable to forward foreground notification to NotificationBloc',
              error: e,
            );
          }
        });

        fcmManager.setupNotificationTapHandler((RemoteMessage message) async {
          _logger.i(
            '👆 FcmInitializationService: Notification tapped after login',
          );
        });

        _postLoginListenersConfigured = true;
      }

      // Always request permission after a successful login so the user
      // is prompted explicitly when they authenticate.

      _logger.i(
        '🔔 FcmInitializationService: Requesting notification permission after login...',
      );
      final settings = await fcmManager.requestNotificationPermission();
      if (settings == null) {
        _logger.w(
          '⚠️  FcmInitializationService: Notification settings unavailable after login',
        );
        return;
      }

      if (settings.authorizationStatus != AuthorizationStatus.authorized &&
          settings.authorizationStatus != AuthorizationStatus.provisional) {
        _logger.w(
          '⚠️  FcmInitializationService: Notification permission not granted after login: ${settings.authorizationStatus}',
        );
        return;
      }

      final token = await fcmManager.getFcmToken();
      if (token == null || token.isEmpty) {
        _logger.w(
          '⚠️  FcmInitializationService: No FCM token available after login',
        );
        return;
      }

      await _registerFcmToken(registerFcmTokenUseCase, token);
      _logger.i(
        '🎉 FcmInitializationService: Post-login FCM initialization completed',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmInitializationService: Error during post-login FCM initialization',
        error: e,
        stackTrace: stackTrace,
      );
    } finally {
      _postLoginInitializationInProgress = false;
    }
  }

  /// Initialize FCM after widget binding is ready
  /// Call this in the first frame after MaterialApp is built
  static void initializeFcmAfterBuild(BuildContext context) {
    _logger.i('🔔 FcmInitializationService: Initializing FCM after build...');

    try {
      // Get FCM Manager and try to initialize Firebase Messaging
      try {
        GetIt.I<FcmManager>();
        _logger.i(
          '✅ FcmInitializationService: FcmManager retrieved successfully',
        );
      } catch (e) {
        _logger.w(
          '⚠️ FcmInitializationService: Could not retrieve FcmManager (Firebase may not be configured)',
          error: e,
        );
      }

      // FCM token initialization will be triggered after user authenticates
      _logger.i(
        '⏳ FcmInitializationService: FCM token initialization deferred until after auth',
      );

      _logger.i(
        '🎉 FcmInitializationService: FCM post-build initialization complete',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmInitializationService: Error during FCM post-build initialization',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Handle notifications received in background/terminated state
  /// This is a static method that Firebase calls directly
  static Future<void> _handleBackgroundNotification(
    RemoteMessage message,
  ) async {
    _logger.i(
      '📲 FcmInitializationService._handleBackgroundNotification: Processing background notification',
    );
    _logger.d(
      '📋 FcmInitializationService: Title: ${message.notification?.title}',
    );
    _logger.d(
      '📋 FcmInitializationService: Body: ${message.notification?.body}',
    );
    if (message.data.isNotEmpty) {
      _logger.d('📋 FcmInitializationService: Data: ${message.data}');
    }

    try {
      // Process the notification here
      // You can store it, log it, or trigger analytics
      _logger.i(
        '✅ FcmInitializationService: Background notification processed',
      );

      // If you need to update the BLoC, you may need to retrieve it from GetIt
      // However, be careful as the app might not be fully initialized
      try {
        final notificationBloc = GetIt.I<NotificationBloc>();
        _logger.i(
          '📬 FcmInitializationService: Adding background notification to BLoC...',
        );
        notificationBloc.add(FcmNotificationReceivedEvent(message.data));
      } catch (e) {
        _logger.w(
          '⚠️  FcmInitializationService: Unable to update BLoC (app might not be ready): ${e.toString()}',
        );
      }
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmInitializationService: Error processing background notification',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Cleanup FCM resources when the app is destroyed
  static Future<void> cleanup() async {
    _logger.i('🔔 FcmInitializationService: Cleaning up FCM resources...');

    try {
      // You can add cleanup logic here if needed
      _logger.i('✅ FcmInitializationService: FCM cleanup complete');
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmInitializationService: Error during FCM cleanup',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log FCM configuration status for debugging
  static Future<void> logFcmStatus() async {
    _logger.i(
      '🔔 FcmInitializationService: Logging FCM configuration status...',
    );

    try {
      // Try to get FcmManager from DI
      FcmManager fcmManager;
      try {
        fcmManager = GetIt.I<FcmManager>();
        _logger.i('✅ FcmInitializationService: FcmManager retrieved from DI');
      } catch (e) {
        _logger.w(
          '⚠️  FcmInitializationService: FcmManager not available in DI (Firebase may not be configured)',
        );
        return;
      }

      final isEnabled = await fcmManager.areNotificationsEnabled();
      _logger.i(
        '📋 FcmInitializationService: Notifications enabled: $isEnabled',
      );

      final token = await fcmManager.getFcmToken();
      if (token != null) {
        final _preview = token.length > 20
            ? '...${token.substring(token.length - 20)}'
            : token;
        _logger.i(
          '📱 FcmInitializationService: FCM token (last 20 chars): $_preview',
        );
      } else {
        _logger.w('⚠️  FcmInitializationService: No FCM token available');
      }

      final settings = await fcmManager.getNotificationSettings();
      if (settings != null) {
        _logger.i(
          '📋 FcmInitializationService: Authorization status: ${settings.authorizationStatus}',
        );
        _logger.i(
          '📋 FcmInitializationService: Alert: ${settings.alert}, Badge: ${settings.badge}, Sound: ${settings.sound}',
        );
      } else {
        _logger.w(
          '⚠️  FcmInitializationService: Notification settings unavailable (Firebase may not be initialized)',
        );
      }
    } catch (e) {
      _logger.w(
        '⚠️  FcmInitializationService: Could not log FCM status (Firebase may not be initialized)',
        error: e,
      );
    }
  }

  static Future<void> _registerFcmToken(
    RegisterFcmTokenUseCase registerFcmTokenUseCase,
    String token,
  ) async {
    _logger.i(
      '📤 FcmInitializationService: Registering FCM token with backend...',
    );

    final result = await registerFcmTokenUseCase(token);
    result.fold(
      (failure) {
        _logger.e(
          '❌ FcmInitializationService: Failed to register FCM token: ${failure.message}',
        );
      },
      (registeredToken) {
        final _preview = registeredToken.length > 20
            ? '...${registeredToken.substring(registeredToken.length - 20)}'
            : registeredToken;
        _logger.i(
          '✅ FcmInitializationService: FCM token registered successfully: $_preview',
        );
      },
    );
  }
}
