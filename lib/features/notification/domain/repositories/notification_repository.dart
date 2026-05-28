import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';
import '../entities/notification_stats.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getNotifications({
    int page = 1,
    int limit = 10,
  });

  Future<Either<Failure, NotificationStats>> getNotificationStats();

  Future<Either<Failure, void>> markAllNotificationsAsRead();

  Future<Either<Failure, void>> markNotificationsAsRead(
    List<String> notificationIds,
  );

  Future<Either<Failure, void>> deleteNotification(String notificationId);
}
