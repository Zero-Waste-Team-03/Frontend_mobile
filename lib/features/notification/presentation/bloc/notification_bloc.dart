import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/notification_usecases.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final GetFilteredNotificationsUseCase getFilteredNotificationsUseCase;
  final MarkNotificationAsReadUseCase markNotificationAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase markAllNotificationsAsReadUseCase;

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.getFilteredNotificationsUseCase,
    required this.markNotificationAsReadUseCase,
    required this.markAllNotificationsAsReadUseCase,
  }) : super(const NotificationInitial()) {
    on<FetchNotificationsEvent>(_onFetchNotifications);
    on<FilterNotificationsEvent>(_onFilterNotifications);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    on<MarkAllNotificationsAsReadEvent>(_onMarkAllNotificationsAsRead);
    on<ClearNotificationFilterEvent>(_onClearFilter);
  }

  Future<void> _onFetchNotifications(
    FetchNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationsLoading());

    final result = await getNotificationsUseCase(
      userId: event.userId,
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(NotificationsError(failure.message)),
      (notifications) => emit(NotificationsLoaded(notifications)),
    );
  }

  Future<void> _onFilterNotifications(
    FilterNotificationsEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationsLoading());

    final result = await getFilteredNotificationsUseCase(
      userId: event.userId,
      typeFilter: event.typeFilter,
      isReadFilter: event.isReadFilter,
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) => emit(NotificationsError(failure.message)),
      (notifications) => emit(
        NotificationsLoaded(
          notifications,
          activeFilter: event.typeFilter,
          activeReadFilter: event.isReadFilter,
        ),
      ),
    );
  }

  Future<void> _onMarkNotificationAsRead(
    MarkNotificationAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;

    if (currentState is NotificationsLoaded) {
      final result = await markNotificationAsReadUseCase(event.notificationId);

      result.fold((failure) => emit(NotificationsError(failure.message)), (
        updatedNotification,
      ) {
        final updatedList = currentState.notifications
            .map(
              (notif) => notif.id == event.notificationId
                  ? updatedNotification
                  : notif,
            )
            .toList();

        emit(NotificationMarkedAsRead(event.notificationId, updatedList));
        emit(
          NotificationsLoaded(
            updatedList,
            activeFilter: currentState.activeFilter,
            activeReadFilter: currentState.activeReadFilter,
          ),
        );
      });
    }
  }

  Future<void> _onMarkAllNotificationsAsRead(
    MarkAllNotificationsAsReadEvent event,
    Emitter<NotificationState> emit,
  ) async {
    final currentState = state;

    if (currentState is NotificationsLoaded) {
      final result = await markAllNotificationsAsReadUseCase(event.userId);

      result.fold((failure) => emit(NotificationsError(failure.message)), (_) {
        final updatedList = currentState.notifications
            .map((notif) => notif.copyWith(isRead: true))
            .toList();

        emit(AllNotificationsMarkedAsRead(updatedList));
        emit(
          NotificationsLoaded(
            updatedList,
            activeFilter: currentState.activeFilter,
            activeReadFilter: currentState.activeReadFilter,
          ),
        );
      });
    }
  }

  Future<void> _onClearFilter(
    ClearNotificationFilterEvent event,
    Emitter<NotificationState> emit,
  ) async {
    emit(const NotificationsLoading());

    final result = await getNotificationsUseCase(userId: event.userId);

    result.fold(
      (failure) => emit(NotificationsError(failure.message)),
      (notifications) => emit(NotificationsLoaded(notifications)),
    );
  }
}
