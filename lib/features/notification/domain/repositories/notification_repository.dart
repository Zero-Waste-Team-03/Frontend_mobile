import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getNotifications({
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, void>> markNotificationsAsRead(
    List<String> notificationIds,
  );

  Future<Either<Failure, void>> deleteNotification(String notificationId);
}
