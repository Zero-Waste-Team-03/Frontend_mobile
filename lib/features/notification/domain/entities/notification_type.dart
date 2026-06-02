enum NotificationType {
  accountStatusAlert,
  chatMessage,
  message,
  newAchievement,
  newPost,
  reportAlert,
  reservationAlert,
  reservationCancelled,
  test,
}

extension NotificationTypeExt on NotificationType {
  String get value {
    switch (this) {
      case NotificationType.accountStatusAlert:
        return 'ACCOUNT_STATUS_ALERT';
      case NotificationType.chatMessage:
        return 'CHAT_MESSAGE';
      case NotificationType.message:
        return 'MESSAGE';
      case NotificationType.newAchievement:
        return 'NEW_ACHIEVEMENT';
      case NotificationType.newPost:
        return 'NEW_POST';
      case NotificationType.reportAlert:
        return 'REPORT_ALERT';
      case NotificationType.reservationAlert:
        return 'RESERVATION_ALERT';
      case NotificationType.reservationCancelled:
        return 'RESERVATION_CANCELLED';
      case NotificationType.test:
        return 'TEST';
    }
  }

  String get displayName {
    switch (this) {
      case NotificationType.accountStatusAlert:
        return 'Account Status';
      case NotificationType.chatMessage:
        return 'Chat Message';
      case NotificationType.message:
        return 'Message';
      case NotificationType.newAchievement:
        return 'New Achievement';
      case NotificationType.newPost:
        return 'New Post';
      case NotificationType.reportAlert:
        return 'Report Alert';
      case NotificationType.reservationAlert:
        return 'Reservation Alert';
      case NotificationType.reservationCancelled:
        return 'Reservation Cancelled';
      case NotificationType.test:
        return 'Test';
    }
  }

  static NotificationType fromString(String value) {
    final v = value.toUpperCase();

    // Handle new canonical names
    for (final e in NotificationType.values) {
      if (e.value == v) return e;
    }

    // Handle legacy or shorthand names mapping
    switch (v) {
      case 'ALERT':
        return NotificationType.accountStatusAlert;
      case 'CONFIRMATION':
        return NotificationType.message;
      case 'DONATION':
        return NotificationType.reservationAlert;
      case 'RESERVATION_CANCELLED':
        return NotificationType.reservationCancelled;
      case 'IMPACT':
        return NotificationType.newAchievement;
      default:
        return NotificationType.test;
    }
  }
}
