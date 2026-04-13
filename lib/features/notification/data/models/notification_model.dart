import '../../domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.receiverId,
    required super.title,
    required super.body,
    required super.type,
    required super.isRead,
    super.meta,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      receiverId: json['receiverId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: NotificationTypeExt.fromString(json['type'] as String? ?? 'ALERT'),
      isRead: json['isRead'] as bool? ?? false,
      meta: json['meta'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiverId': receiverId,
      'title': title,
      'body': body,
      'type': type.value,
      'isRead': isRead,
      'meta': meta,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Notification toEntity() {
    return Notification(
      id: id,
      receiverId: receiverId,
      title: title,
      body: body,
      type: type,
      isRead: isRead,
      meta: meta,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
