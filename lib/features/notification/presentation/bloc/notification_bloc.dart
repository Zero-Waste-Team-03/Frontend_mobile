import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../data/services/fcm_manager.dart';
import '../../domain/usecases/fcm_token_usecases.dart';
import '../../domain/usecases/notification_usecases.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationsAsReadUseCase markNotificationsAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
  final RegisterFcmTokenUseCase registerFcmTokenUseCase;
  final GetFcmTokenUseCase getFcmTokenUseCase;
  final CheckFcmTokenRegistrationUseCase checkFcmTokenRegistrationUseCase;
  final DeleteFcmTokenUseCase deleteFcmTokenUseCase;
  final GetLastTokenRegistrationTimeUseCase getLastTokenRegistrationTimeUseCase;
  final FcmManager? fcmManager; // Optional - Firebase may not be configured

  final Set<String> _locallyDeletedNotificationIds = <String>{};

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.markNotificationsAsReadUseCase,
    required this.deleteNotificationUseCase,
    required this.registerFcmTokenUseCase,
    required this.getFcmTokenUseCase,
    required this.checkFcmTokenRegistrationUseCase,
    required this.deleteFcmTokenUseCase,
    required this.getLastTokenRegistrationTimeUseCase,
    this.fcmManager, // Optional parameter
  }) : super(const NotificationInitial()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<MarkNotificationsAsReadEvent>(_onMarkNotificationsAsRead);
    on<DeleteNotificationEvent>(_onDeleteNotification);
    on<RefreshNotificationsEvent>(_onRefreshNotifications);

    // FCM Token Events
    on<InitializeFcmTokenEvent>(_onInitializeFcmToken);
    on<RegisterFcmTokenEvent>(_onRegisterFcmToken);
    on<FcmTokenRefreshedEvent>(_onFcmTokenRefreshed);
    on<CheckFcmTokenRegistrationEvent>(_onCheckFcmTokenRegistration);
    on<DeleteFcmTokenEvent>(_onDeleteFcmToken);
    on<FcmNotificationReceivedEvent>(_onFcmNotificationReceived);
  }

  Future<void> _onFetchNotifications(
    FetchNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i(
      'NotificationBloc: _onFetchNotifications - page=${event.page}, limit=${event.limit}',
    );

    final currentState = state;
    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(const NotificationsLoading());
    } else if (currentState is NotificationsLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      emit(
        NotificationsLoaded(
          currentState.notifications,
          currentPage: currentState.currentPage,
          isLoadingMore: true,
          hasReachedMax: currentState.hasReachedMax,
          activeFilter: currentState.activeFilter,
          activeReadFilter: currentState.activeReadFilter,
        ),
      );
    }

    final result = await getNotificationsUseCase(
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) {
        _logger.e(
          'NotificationBloc: Failed to fetch notifications: ${failure.message}',
        );
        if (!isFirstPage && currentState is NotificationsLoaded) {
          emit(
            NotificationsLoaded(
              currentState.notifications,
              currentPage: currentState.currentPage,
              isLoadingMore: false,
              hasReachedMax: currentState.hasReachedMax,
              activeFilter: currentState.activeFilter,
              activeReadFilter: currentState.activeReadFilter,
            ),
          );
        } else {
          emit(NotificationsError(failure.message));
        }
      },
      (notifications) {
        final filteredNotifications = notifications
            .where(
              (notification) =>
                  !_locallyDeletedNotificationIds.contains(notification.id),
            )
            .toList();

        _logger.i(
          'NotificationBloc: Successfully fetched ${filteredNotifications.length} notifications',
        );

        final hasReachedMax = filteredNotifications.length < event.limit;

        if (isFirstPage || currentState is! NotificationsLoaded) {
          emit(
            NotificationsLoaded(
              filteredNotifications,
              currentPage: event.page,
              isLoadingMore: false,
              hasReachedMax: hasReachedMax,
            ),
          );
          return;
        }

        final existingById = {
          for (final notification in currentState.notifications)
            notification.id: notification,
        };

        for (final notification in filteredNotifications) {
          existingById[notification.id] = notification;
        }

        emit(
          NotificationsLoaded(
            existingById.values.toList(),
            currentPage: event.page,
            isLoadingMore: false,
            hasReachedMax: hasReachedMax,
            activeFilter: currentState.activeFilter,
            activeReadFilter: currentState.activeReadFilter,
          ),
        );
      },
    );
  }

  Future<void> _onMarkNotificationsAsRead(
    MarkNotificationsAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i(
      'NotificationBloc: _onMarkNotificationsAsRead - ${event.notificationIds.length} notifications',
    );

    final currentState = state;

    if (currentState is NotificationsLoaded) {
      final result = await markNotificationsAsReadUseCase(
        event.notificationIds,
      );

      result.fold(
        (failure) {
          _logger.e(
            'NotificationBloc: Failed to mark as read: ${failure.message}',
          );
          emit(NotificationsError(failure.message));
        },
        (_) {
          _logger.i('NotificationBloc: Successfully marked as read');
          final updatedList = currentState.notifications.map((notif) {
            if (event.notificationIds.contains(notif.id)) {
              return notif.copyWith(isRead: true);
            }
            return notif;
          }).toList();

          emit(
            NotificationsLoaded(
              updatedList,
              currentPage: currentState.currentPage,
              isLoadingMore: false,
              hasReachedMax: currentState.hasReachedMax,
              activeFilter: currentState.activeFilter,
              activeReadFilter: currentState.activeReadFilter,
            ),
          );
        },
      );
    }
  }

  Future<void> _onDeleteNotification(
    DeleteNotificationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i(
      'NotificationBloc: _onDeleteNotification - id=${event.notificationId}',
    );

    final currentState = state;

    if (currentState is NotificationsLoaded) {
      final result = await deleteNotificationUseCase(event.notificationId);

      result.fold(
        (failure) {
          _logger.e(
            'NotificationBloc: Failed to delete notification: ${failure.message}',
          );
          emit(NotificationsError(failure.message));
        },
        (_) {
          _logger.i('NotificationBloc: Successfully deleted notification');
          _locallyDeletedNotificationIds.add(event.notificationId);

          final updatedList = currentState.notifications
              .where((notif) => notif.id != event.notificationId)
              .toList();

          emit(
            NotificationsLoaded(
              updatedList,
              currentPage: currentState.currentPage,
              isLoadingMore: false,
              hasReachedMax: currentState.hasReachedMax,
              activeFilter: currentState.activeFilter,
              activeReadFilter: currentState.activeReadFilter,
            ),
          );
        },
      );
    }
  }

  Future<void> _onRefreshNotifications(
    RefreshNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i('NotificationBloc: _onRefreshNotifications');

    // Force a distinct state transition so the refresh future always resolves
    // even if the refreshed list is identical to the current one.
    emit(const NotificationsLoading());

    final result = await getNotificationsUseCase(page: 1, limit: 10);

    result.fold(
      (failure) {
        _logger.e(
          'NotificationBloc: Failed to refresh notifications: ${failure.message}',
        );
        emit(NotificationsError(failure.message));
      },
      (notifications) {
        final filteredNotifications = notifications
            .where(
              (notification) =>
                  !_locallyDeletedNotificationIds.contains(notification.id),
            )
            .toList();

        _logger.i(
          'NotificationBloc: Successfully refreshed ${filteredNotifications.length} notifications',
        );
        emit(
          NotificationsLoaded(
            filteredNotifications,
            currentPage: 1,
            isLoadingMore: false,
            hasReachedMax: filteredNotifications.length < 10,
          ),
        );
      },
    );
  }

  /// Handle FCM token initialization on app startup
  Future<void> _onInitializeFcmToken(
    InitializeFcmTokenEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i(
      '🔔 NotificationBloc: _onInitializeFcmToken - Initializing FCM token...',
    );
    emit(const FcmTokenInitializing());

    // Check if FcmManager is available (Firebase must be configured)
    if (fcmManager == null) {
      _logger.w(
        '⚠️  NotificationBloc: FcmManager is not available - Firebase not configured',
      );
      emit(
        const FcmTokenRegistrationFailed(
          'Firebase Cloud Messaging is not configured. Please configure google-services.json on Android and GoogleService-Info.plist on iOS.',
        ),
      );
      return;
    }

    try {
      _logger.i('📋 NotificationBloc: Requesting notification permissions...');
      final settings = await fcmManager!.requestNotificationPermission();

      if (settings == null) {
        _logger.w(
          '⚠️  NotificationBloc: Notification settings unavailable (Firebase may not be initialized)',
        );
        emit(
          const FcmTokenRegistrationFailed(
            'Firebase Cloud Messaging is not initialized or permissions could not be requested.',
          ),
        );
        return;
      }

      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        _logger.w(
          '⚠️  NotificationBloc: Notification permission not granted: ${settings.authorizationStatus}',
        );
      }

      _logger.i('📱 NotificationBloc: Retrieving FCM token...');
      final token = await fcmManager!.getFcmToken();

      if (token == null || token.isEmpty) {
        _logger.e('❌ NotificationBloc: Failed to get FCM token');
        emit(
          const FcmTokenRegistrationFailed(
            'Failed to get FCM token from Firebase',
          ),
        );
        return;
      }

      _logger.i('🔄 NotificationBloc: Setting up token refresh listener...');
      fcmManager!.setupTokenRefreshListener((newToken) {
        _logger.i(
          '🔄 NotificationBloc: Token refresh detected, adding FcmTokenRefreshedEvent...',
        );
        add(FcmTokenRefreshedEvent(newToken));
      });

      _logger.i(
        '📢 NotificationBloc: Setting up foreground notification handler...',
      );
      fcmManager!.setupForegroundNotificationHandler((
        RemoteMessage message,
      ) async {
        _logger.i('📬 NotificationBloc: Foreground notification received');
        add(FcmNotificationReceivedEvent(message.data));
      });

      _logger.i('👆 NotificationBloc: Setting up notification tap handler...');
      fcmManager!.setupNotificationTapHandler((RemoteMessage message) async {
        _logger.i('👆 NotificationBloc: User tapped notification');
        // Handle notification tap navigation here if needed
      });

      _logger.i('📤 NotificationBloc: Registering FCM token with backend...');
      add(RegisterFcmTokenEvent(token));
    } catch (e, stackTrace) {
      _logger.e(
        '❌ NotificationBloc: Error during FCM initialization',
        error: e,
        stackTrace: stackTrace,
      );
      emit(
        FcmTokenRegistrationFailed(
          'FCM initialization failed: ${e.toString()}',
        ),
      );
    }
  }

  /// Handle FCM token registration with backend
  Future<void> _onRegisterFcmToken(
    RegisterFcmTokenEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i(
      '🔔 NotificationBloc: _onRegisterFcmToken - Registering token with backend',
    );
    final _preview = event.fcmToken.length > 20
        ? '...${event.fcmToken.substring(event.fcmToken.length - 20)}'
        : event.fcmToken;
    _logger.d('📱 NotificationBloc: Token (last 20 chars): $_preview');

    try {
      _logger.i('🚀 NotificationBloc: Calling registerFcmTokenUseCase...');
      final result = await registerFcmTokenUseCase(event.fcmToken);

      result.fold(
        (failure) {
          _logger.e(
            '❌ NotificationBloc: Failed to register FCM token: ${failure.message}',
          );
          emit(
            FcmTokenRegistrationFailed(
              'Failed to register FCM token: ${failure.message}',
            ),
          );
        },
        (registeredToken) {
          _logger.i('✅ NotificationBloc: FCM token registered successfully');
          final _regPreview = registeredToken.length > 20
              ? '...${registeredToken.substring(registeredToken.length - 20)}'
              : registeredToken;
          _logger.d(
            '📱 NotificationBloc: Registered token (last 20 chars): $_regPreview',
          );
          emit(FcmTokenRegistered(registeredToken));

          _logger.i('✔️  NotificationBloc: Emitting FcmReady state...');
          emit(FcmReady(fcmToken: registeredToken, isPermissionGranted: true));
        },
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ NotificationBloc: Unexpected error registering FCM token',
        error: e,
        stackTrace: stackTrace,
      );
      emit(FcmTokenRegistrationFailed('Unexpected error: ${e.toString()}'));
    }
  }

  /// Handle FCM token refresh (when Firebase renews the token)
  Future<void> _onFcmTokenRefreshed(
    FcmTokenRefreshedEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i('🔔 NotificationBloc: _onFcmTokenRefreshed - New token received');
    final _newPreview = event.newFcmToken.length > 20
        ? '...${event.newFcmToken.substring(event.newFcmToken.length - 20)}'
        : event.newFcmToken;
    _logger.d('📱 NotificationBloc: New token (last 20 chars): $_newPreview');

    try {
      emit(FcmTokenRefreshed(event.newFcmToken));

      _logger.i(
        '📤 NotificationBloc: Re-registering refreshed token with backend...',
      );
      add(RegisterFcmTokenEvent(event.newFcmToken));
    } catch (e, stackTrace) {
      _logger.e(
        '❌ NotificationBloc: Error handling token refresh',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Check if FCM token is registered with backend
  Future<void> _onCheckFcmTokenRegistration(
    CheckFcmTokenRegistrationEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i(
      '🔔 NotificationBloc: _onCheckFcmTokenRegistration - Checking registration status',
    );

    try {
      _logger.i(
        '🚀 NotificationBloc: Calling checkFcmTokenRegistrationUseCase...',
      );
      final result = await checkFcmTokenRegistrationUseCase();

      result.fold(
        (failure) {
          _logger.e(
            '❌ NotificationBloc: Failed to check registration status: ${failure.message}',
          );
        },
        (isRegistered) {
          _logger.i(
            'ℹ️  NotificationBloc: FCM token registration status: $isRegistered',
          );
        },
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ NotificationBloc: Error checking registration status',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Handle FCM token deletion
  Future<void> _onDeleteFcmToken(
    DeleteFcmTokenEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i('🔔 NotificationBloc: _onDeleteFcmToken - Deleting FCM token');

    try {
      _logger.i('🚀 NotificationBloc: Calling deleteFcmTokenUseCase...');
      final result = await deleteFcmTokenUseCase();

      result.fold(
        (failure) {
          _logger.e(
            '❌ NotificationBloc: Failed to delete FCM token: ${failure.message}',
          );
        },
        (_) {
          _logger.i('✅ NotificationBloc: FCM token deleted successfully');
          emit(const FcmTokenDeleted());
        },
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ NotificationBloc: Error deleting FCM token',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Handle incoming FCM notification (foreground)
  Future<void> _onFcmNotificationReceived(
    FcmNotificationReceivedEvent event,
    Emitter<NotificationState> emit,
  ) async {
    _logger.i(
      '🔔 NotificationBloc: _onFcmNotificationReceived - New foreground notification',
    );
    _logger.d('📋 NotificationBloc: Notification data: ${event.data}');

    try {
      final title = event.data['title'] as String?;
      final body = event.data['body'] as String?;

      _logger.i('📬 NotificationBloc: Title: $title, Body: $body');

      emit(FcmNotificationReceived(title: title, body: body, data: event.data));

      // Optionally refresh notifications list after receiving notification
      _logger.i('🔄 NotificationBloc: Refreshing notifications list...');
      add(const RefreshNotificationsEvent());
    } catch (e, stackTrace) {
      _logger.e(
        '❌ NotificationBloc: Error processing foreground notification',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}
