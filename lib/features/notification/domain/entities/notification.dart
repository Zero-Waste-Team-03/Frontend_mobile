import 'package:equatable/equatable.dart';

enum NotificationType { alert, confirmation, donation, impact }

extension NotificationTypeExt on NotificationType {
  String get value {
    switch (this) {
      case NotificationType.alert:
        return 'ALERT';
      case NotificationType.confirmation:
        return 'CONFIRMATION';
      case NotificationType.donation:
        return 'DONATION';
      case NotificationType.impact:
        return 'IMPACT';
    }
  }

  String get displayName {
    switch (this) {
      case NotificationType.alert:
        return 'Alert';
      case NotificationType.confirmation:
        return 'Confirmation';
      case NotificationType.donation:
        return 'Donation';
      case NotificationType.impact:
        return 'Impact';
    }
  }

  static NotificationType fromString(String value) {
    return NotificationType.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => NotificationType.alert,
    );
  }
}

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
