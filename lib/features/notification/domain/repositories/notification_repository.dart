import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<Notification>>> getNotifications({
    required String userId,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, List<Notification>>> getFilteredNotifications({
    required String userId,
    String? typeFilter,
    bool? isReadFilter,
    int page = 1,
    int limit = 20,
  });

  Future<Either<Failure, Notification>> markAsRead(String notificationId);

  Future<Either<Failure, void>> markAllAsRead(String userId);
}
