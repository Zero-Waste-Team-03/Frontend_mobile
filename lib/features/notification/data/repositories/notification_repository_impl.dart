import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../models/notification_model.dart';
import '../sources/notification_remote_data_source.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Notification>>> getNotifications({
    required String userId,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final notifications = await remoteDataSource.getNotifications(
        userId: userId,
        page: page,
        limit: limit,
      );
      return Right(notifications.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Notification>>> getFilteredNotifications({
    required String userId,
    String? typeFilter,
    bool? isReadFilter,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final notifications = await remoteDataSource.getFilteredNotifications(
        userId: userId,
        typeFilter: typeFilter,
        isReadFilter: isReadFilter,
        page: page,
        limit: limit,
      );
      return Right(notifications.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, Notification>> markAsRead(
    String notificationId,
  ) async {
    try {
      final notification = await remoteDataSource.markAsRead(notificationId);
      return Right(notification.toEntity());
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead(String userId) async {
    try {
      await remoteDataSource.markAllAsRead(userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure( e.toString()));
    }
  }
}
