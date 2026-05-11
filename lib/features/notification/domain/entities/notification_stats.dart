import 'package:equatable/equatable.dart';

class NotificationStats extends Equatable {
  final int unreadCount;

  const NotificationStats({required this.unreadCount});

  NotificationStats copyWith({int? unreadCount}) {
    return NotificationStats(unreadCount: unreadCount ?? this.unreadCount);
  }

  @override
  List<Object?> get props => [unreadCount];
}
