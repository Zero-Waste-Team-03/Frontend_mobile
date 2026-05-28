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

class MarkAllNotificationsAsReadEvent extends NotificationEvent {
  const MarkAllNotificationsAsReadEvent();

  @override
  List<Object?> get props => [];
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

/// FCM Token Events

/// Initialize and register FCM token on app startup
class InitializeFcmTokenEvent extends NotificationEvent {
  const InitializeFcmTokenEvent();

  @override
  List<Object?> get props => [];
}

/// Register FCM token with backend
class RegisterFcmTokenEvent extends NotificationEvent {
  final String fcmToken;

  const RegisterFcmTokenEvent(this.fcmToken);

  @override
  List<Object?> get props => [fcmToken];
}

/// Handle FCM token refresh
class FcmTokenRefreshedEvent extends NotificationEvent {
  final String newFcmToken;

  const FcmTokenRefreshedEvent(this.newFcmToken);

  @override
  List<Object?> get props => [newFcmToken];
}

/// Check if FCM token is registered
class CheckFcmTokenRegistrationEvent extends NotificationEvent {
  const CheckFcmTokenRegistrationEvent();

  @override
  List<Object?> get props => [];
}

/// Delete FCM token
class DeleteFcmTokenEvent extends NotificationEvent {
  const DeleteFcmTokenEvent();

  @override
  List<Object?> get props => [];
}

/// Handle incoming FCM notification (foreground)
class FcmNotificationReceivedEvent extends NotificationEvent {
  final Map<String, dynamic> data;

  const FcmNotificationReceivedEvent(this.data);

  @override
  List<Object?> get props => [data];
}
