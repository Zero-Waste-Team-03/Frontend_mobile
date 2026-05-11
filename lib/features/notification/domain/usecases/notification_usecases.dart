import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';
import '../entities/notification_stats.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<Either<Failure, List<Notification>>> call({
    int page = 1,
    int limit = 10,
  }) {
    return repository.getNotifications(page: page, limit: limit);
  }
}

class MarkNotificationsAsReadUseCase {
  final NotificationRepository repository;

  MarkNotificationsAsReadUseCase({required this.repository});

  Future<Either<Failure, void>> call(List<String> notificationIds) {
    return repository.markNotificationsAsRead(notificationIds);
  }
}

class DeleteNotificationUseCase {
  final NotificationRepository repository;

  DeleteNotificationUseCase({required this.repository});

  Future<Either<Failure, void>> call(String notificationId) {
    return repository.deleteNotification(notificationId);
  }
}

class GetNotificationStatsUseCase {
  final NotificationRepository repository;

  GetNotificationStatsUseCase({required this.repository});

  Future<Either<Failure, NotificationStats>> call() {
    return repository.getNotificationStats();
  }
}
