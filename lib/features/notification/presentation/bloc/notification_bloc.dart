import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../domain/usecases/notification_usecases.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationsAsReadUseCase markNotificationsAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;

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

    emit(const NotificationsLoading());

    final result = await getNotificationsUseCase(
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) {
        _logger.e(
          'NotificationBloc: Failed to fetch notifications: ${failure.message}',
        );
        emit(NotificationsError(failure.message));
      },
      (notifications) {
        _logger.i(
          'NotificationBloc: Successfully fetched ${notifications.length} notifications',
        );
        emit(NotificationsLoaded(notifications));
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

          emit(NotificationsLoaded(updatedList));
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
          final updatedList = currentState.notifications
              .where((notif) => notif.id != event.notificationId)
              .toList();

          emit(NotificationsLoaded(updatedList));
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
        _logger.i(
          'NotificationBloc: Successfully refreshed ${notifications.length} notifications',
        );
        emit(NotificationsLoaded(notifications));
      },
    );
  }
}
