import 'package:equatable/equatable.dart';
import '../../domain/entities/notification.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotificationsEvent extends NotificationEvent {
  final String userId;
  final int page;
  final int limit;

  const FetchNotificationsEvent(this.userId, {this.page = 1, this.limit = 20});

  @override
  List<Object?> get props => [userId, page, limit];
}

class FilterNotificationsEvent extends NotificationEvent {
  final String userId;
  final String? typeFilter;
  final bool? isReadFilter;
  final int page;
  final int limit;

  const FilterNotificationsEvent(
    this.userId, {
    this.typeFilter,
    this.isReadFilter,
    this.page = 1,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [userId, typeFilter, isReadFilter, page, limit];
}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final String notificationId;

  const MarkNotificationAsReadEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

class MarkAllNotificationsAsReadEvent extends NotificationEvent {
  final String userId;

  const MarkAllNotificationsAsReadEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ClearNotificationFilterEvent extends NotificationEvent {
  final String userId;

  const ClearNotificationFilterEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
