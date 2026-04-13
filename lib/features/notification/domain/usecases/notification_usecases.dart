import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<Either<Failure, List<Notification>>> call({
    required String userId,
    int page = 1,
    int limit = 20,
  }) {
    return repository.getNotifications(
      userId: userId,
      page: page,
      limit: limit,
    );
  }
}

class GetFilteredNotificationsUseCase {
  final NotificationRepository repository;

  GetFilteredNotificationsUseCase({required this.repository});

  Future<Either<Failure, List<Notification>>> call({
    required String userId,
    String? typeFilter,
    bool? isReadFilter,
    int page = 1,
    int limit = 20,
  }) {
    return repository.getFilteredNotifications(
      userId: userId,
      typeFilter: typeFilter,
      isReadFilter: isReadFilter,
      page: page,
      limit: limit,
    );
  }
}

class MarkNotificationAsReadUseCase {
  final NotificationRepository repository;

  MarkNotificationAsReadUseCase({required this.repository});

  Future<Either<Failure, Notification>> call(String notificationId) {
    return repository.markAsRead(notificationId);
  }
}

class MarkAllNotificationsAsReadUseCase {
  final NotificationRepository repository;

  MarkAllNotificationsAsReadUseCase({required this.repository});

  Future<Either<Failure, void>> call(String userId) {
    return repository.markAllAsRead(userId);
  }
}
