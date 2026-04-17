import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../sources/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  @override
  Future<Either<Failure, List<Notification>>> getNotifications({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      _logger.i(
        'NotificationRepository: getNotifications called with page=$page, limit=$limit',
      );

      final notifications = await remoteDataSource.getNotifications(
        page: page,
        limit: limit,
      );

      _logger.i(
        'NotificationRepository: Retrieved ${notifications.length} notifications',
      );

      return Right(notifications.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      _logger.e(
        'NotificationRepository: ServerException in getNotifications: $e',
      );
      return Left(ServerFailure(e.message));
    } catch (e) {
      _logger.e(
        'NotificationRepository: Unexpected error in getNotifications: $e',
      );
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markNotificationsAsRead(
    List<String> notificationIds,
  ) async {
    try {
      _logger.i(
        'NotificationRepository: markNotificationsAsRead called with ${notificationIds.length} IDs',
      );

      if (notificationIds.isEmpty) {
        _logger.w(
          'NotificationRepository: markNotificationsAsRead called with empty list',
        );
        return const Right(null);
      }

      await remoteDataSource.markNotificationsAsRead(notificationIds);

      _logger.i(
        'NotificationRepository: Successfully marked ${notificationIds.length} notifications as read',
      );

      return const Right(null);
    } on ServerException catch (e) {
      _logger.e(
        'NotificationRepository: ServerException in markNotificationsAsRead: $e',
      );
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(
    String notificationId,
  ) async {
    try {
      _logger.i(
        'NotificationRepository: deleteNotification called with id=$notificationId',
      );

      await remoteDataSource.deleteNotification(notificationId);

      _logger.i(
        'NotificationRepository: Successfully deleted notification id=$notificationId',
      );

      return const Right(null);
    } on ServerException catch (e) {
      _logger.e(
        'NotificationRepository: ServerException in deleteNotification: $e',
      );
      return Left(ServerFailure(e.message));
    } catch (e) {
      _logger.e(
        'NotificationRepository: Unexpected error in deleteNotification: $e',
      );
      return Left(ServerFailure(e.toString()));
    }
  }
}
