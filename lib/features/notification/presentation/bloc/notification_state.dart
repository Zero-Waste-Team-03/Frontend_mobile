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
  final int currentPage;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final String? activeFilter;
  final bool? activeReadFilter;

  const NotificationsLoaded(
    this.notifications, {
    this.currentPage = 1,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.activeFilter,
    this.activeReadFilter,
  });

  @override
  List<Object?> get props => [
    notifications,
    currentPage,
    isLoadingMore,
    hasReachedMax,
    activeFilter,
    activeReadFilter,
  ];
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

/// FCM Token States

/// FCM token initialization in progress
class FcmTokenInitializing extends NotificationState {
  const FcmTokenInitializing();
}

/// FCM token successfully registered
class FcmTokenRegistered extends NotificationState {
  final String fcmToken;

  const FcmTokenRegistered(this.fcmToken);

  @override
  List<Object?> get props => [fcmToken];
}

/// FCM token registration failed
class FcmTokenRegistrationFailed extends NotificationState {
  final String errorMessage;

  const FcmTokenRegistrationFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

/// FCM token refreshed (token has been renewed by Firebase)
class FcmTokenRefreshed extends NotificationState {
  final String newFcmToken;

  const FcmTokenRefreshed(this.newFcmToken);

  @override
  List<Object?> get props => [newFcmToken];
}

/// FCM token deleted successfully
class FcmTokenDeleted extends NotificationState {
  const FcmTokenDeleted();
}

/// FCM notification received while app is in foreground
class FcmNotificationReceived extends NotificationState {
  final String? title;
  final String? body;
  final Map<String, dynamic> data;

  const FcmNotificationReceived({this.title, this.body, required this.data});

  @override
  List<Object?> get props => [title, body, data];
}

/// FCM is ready and configured
class FcmReady extends NotificationState {
  final String fcmToken;
  final bool isPermissionGranted;

  const FcmReady({required this.fcmToken, required this.isPermissionGranted});

  @override
  List<Object?> get props => [fcmToken, isPermissionGranted];
}
