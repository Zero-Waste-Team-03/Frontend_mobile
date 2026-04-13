import 'package:equatable/equatable.dart';
import '../../domain/entities/notification.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationsLoading extends NotificationState {
  const NotificationsLoading();
}

class NotificationsLoaded extends NotificationState {
  final List<Notification> notifications;
  final String? activeFilter;
  final bool? activeReadFilter;

  const NotificationsLoaded(
    this.notifications, {
    this.activeFilter,
    this.activeReadFilter,
  });

  @override
  List<Object?> get props => [notifications, activeFilter, activeReadFilter];
}

class NotificationsError extends NotificationState {
  final String message;

  const NotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NotificationMarkedAsRead extends NotificationState {
  final String notificationId;
  final List<Notification> updatedNotifications;

  const NotificationMarkedAsRead(
    this.notificationId,
    this.updatedNotifications,
  );

  @override
  List<Object?> get props => [notificationId, updatedNotifications];
}

class AllNotificationsMarkedAsRead extends NotificationState {
  final List<Notification> updatedNotifications;

  const AllNotificationsMarkedAsRead(this.updatedNotifications);

  @override
  List<Object?> get props => [updatedNotifications];
}
