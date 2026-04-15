import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotificationsEvent extends NotificationEvent {
  final int page;
  final int limit;

  const FetchNotificationsEvent({this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [page, limit];
}

class MarkNotificationsAsReadEvent extends NotificationEvent {
  final List<String> notificationIds;

  const MarkNotificationsAsReadEvent(this.notificationIds);

  @override
  List<Object?> get props => [notificationIds];
}

class DeleteNotificationEvent extends NotificationEvent {
  final String notificationId;

  const DeleteNotificationEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

class RefreshNotificationsEvent extends NotificationEvent {
  const RefreshNotificationsEvent();

  @override
  List<Object?> get props => [];
}
