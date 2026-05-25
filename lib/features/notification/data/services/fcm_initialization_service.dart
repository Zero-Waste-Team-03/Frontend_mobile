import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../../core/router/app_router.dart';
import 'android_notification_display_service.dart';
import '../../data/services/fcm_manager.dart';
import '../../domain/entities/notification.dart' as n;
import '../../domain/entities/notification_type.dart';
import '../../domain/usecases/fcm_token_usecases.dart';
import '../../presentation/bloc/notification_bloc.dart';
import '../../presentation/bloc/notification_event.dart';
import '../../presentation/notification_action_handler.dart';

/// Global FCM initialization service
/// Handles all FCM setup and configuration at app startup
class FcmInitializationService {
  static bool _postLoginListenersConfigured = false;
  static bool _postLoginInitializationInProgress = false;
  static bool _tapHandlersConfigured = false;
  static final Set<String> _handledTapIds = <String>{};

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
            await AndroidNotificationDisplayService.showForegroundNotification(
              message,
            );
          } catch (e, st) {
            _logger.w(
              '⚠️  FcmInitializationService: Android foreground notification display failed',
              error: e,
              stackTrace: st,
            );
          }

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

        _ensureTapHandlersConfigured(fcmManager);

        _postLoginListenersConfigured = true;
      }

      await _processInitialNotificationTap(fcmManager, source: 'after-login');

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
        final fcmManager = GetIt.I<FcmManager>();
        _logger.i(
          '✅ FcmInitializationService: FcmManager retrieved successfully',
        );

        _ensureTapHandlersConfigured(fcmManager);
        unawaited(
          _processInitialNotificationTap(fcmManager, source: 'after-build'),
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
  @pragma('vm:entry-point')
  static Future<void> _handleBackgroundNotification(
    RemoteMessage message,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      await Firebase.initializeApp();
    } catch (_) {
      // Firebase may already be initialized in some app states.
    }

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
      try {
        await AndroidNotificationDisplayService.showBackgroundNotification(
          message,
        );
      } catch (e, st) {
        _logger.w(
          '⚠️ FcmInitializationService: Failed to display background notification card',
          error: e,
          stackTrace: st,
        );
      }

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

  static void _ensureTapHandlersConfigured(FcmManager fcmManager) {
    if (_tapHandlersConfigured) {
      return;
    }

    _logger.i(
      '👆 FcmInitializationService: Configuring notification tap handlers',
    );

    fcmManager.setupNotificationTapHandler((RemoteMessage message) async {
      await _handleNotificationTap(message, source: 'onMessageOpenedApp');
    });

    _tapHandlersConfigured = true;
    _logger.i(
      '✅ FcmInitializationService: Notification tap handlers configured',
    );
  }

  static Future<void> _processInitialNotificationTap(
    FcmManager fcmManager, {
    required String source,
  }) async {
    final initialMessage = await fcmManager.getInitialNotification();
    if (initialMessage == null) {
      _logger.d(
        '📭 FcmInitializationService: No initial notification tap ($source)',
      );
      return;
    }

    await _handleNotificationTap(initialMessage, source: '$source-initial');
  }

  static Future<void> _handleNotificationTap(
    RemoteMessage message, {
    required String source,
  }) async {
    final tapId =
        message.messageId ??
        (message.data['id']?.toString() ??
            '${message.sentTime?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch}');

    if (_handledTapIds.contains(tapId)) {
      _logger.d(
        '↩️ FcmInitializationService: Skipping duplicate tap handling for id=$tapId from $source',
      );
      return;
    }

    final context = await _waitForRouterContext();
    if (context == null) {
      _logger.w(
        '⚠️ FcmInitializationService: Navigation context unavailable for tap id=$tapId from $source',
      );
      return;
    }

    final notification = _buildNotificationFromRemoteMessage(message);

    _logger.i(
      '🚦 FcmInitializationService: Handling notification tap id=$tapId from $source',
    );
    _logger.d('📋 FcmInitializationService: Tap meta=${notification.meta}');

    try {
      await NotificationActionHandler.handle(context, notification);
      _handledTapIds.add(tapId);
      _logger.i(
        '✅ FcmInitializationService: Notification tap handled id=$tapId',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmInitializationService: Failed to handle notification tap id=$tapId',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<BuildContext?> _waitForRouterContext() async {
    for (var i = 0; i < 12; i++) {
      final context = appRouter.routerDelegate.navigatorKey.currentContext;
      if (context != null && context.mounted) {
        return context;
      }
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
    return null;
  }

  static n.Notification _buildNotificationFromRemoteMessage(
    RemoteMessage message,
  ) {
    final data = <String, dynamic>{...message.data};
    final meta = _extractMetaFromMessageData(data);

    final action =
        (meta['action'] as String?) ??
        (data['action'] as String?) ??
        (data['click_action'] as String?);
    if (action != null && action.isNotEmpty) {
      meta['action'] = action;
    }

    return n.Notification(
      id:
          data['id']?.toString() ??
          message.messageId ??
          'fcm-${DateTime.now().millisecondsSinceEpoch}',
      receiverId: data['receiverId']?.toString() ?? '',
      title:
          message.notification?.title ??
          data['title']?.toString() ??
          'Notification',
      body: message.notification?.body ?? data['body']?.toString() ?? '',
      type: NotificationTypeExt.fromString(data['type']?.toString() ?? 'TEST'),
      isRead: false,
      meta: meta,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Map<String, dynamic> _extractMetaFromMessageData(
    Map<String, dynamic> data,
  ) {
    final metaValue = data['meta'];

    if (metaValue is Map<String, dynamic>) {
      return <String, dynamic>{...metaValue};
    }

    if (metaValue is Map) {
      return Map<String, dynamic>.from(metaValue);
    }

    if (metaValue is String && metaValue.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(metaValue);
        if (decoded is Map<String, dynamic>) {
          return <String, dynamic>{...decoded};
        }
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
        if (decoded is List) {
          return <String, dynamic>{'value': decoded};
        }
      } catch (_) {
        // Keep parsing resilient; if invalid JSON, fall through to flat payload.
      }
    }

    final flatMeta = <String, dynamic>{};
    for (final entry in data.entries) {
      if (entry.key == 'meta') {
        continue;
      }
      flatMeta[entry.key] = entry.value;
    }
    return flatMeta;
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
