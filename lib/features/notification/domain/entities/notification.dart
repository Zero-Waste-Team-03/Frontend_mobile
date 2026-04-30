import 'package:equatable/equatable.dart';
import 'notification_type.dart';

class Notification extends Equatable {
  final String id;
  final String receiverId;
  final String title;
  final String body;
  final NotificationType type;
  final bool isRead;
  final Map<String, dynamic>? meta;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Notification({
    required this.id,
    required this.receiverId,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    this.meta,
    required this.createdAt,
    required this.updatedAt,
  });

  Notification copyWith({
    String? id,
    String? receiverId,
    String? title,
    String? body,
    NotificationType? type,
    bool? isRead,
    Map<String, dynamic>? meta,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notification(
      id: id ?? this.id,
      receiverId: receiverId ?? this.receiverId,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      meta: meta ?? this.meta,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    receiverId,
    title,
    body,
    type,
    isRead,
    meta,
    createdAt,
    updatedAt,
  ];
}
