import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../domain/usecases/notification_usecases.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationsAsReadUseCase markNotificationsAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
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
  }) : super(const NotificationInitial()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<MarkNotificationsAsReadEvent>(_onMarkNotificationsAsRead);
    on<DeleteNotificationEvent>(_onDeleteNotification);
    on<RefreshNotificationsEvent>(_onRefreshNotifications);
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
}
