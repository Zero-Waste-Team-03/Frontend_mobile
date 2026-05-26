import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import '../../../../core/errors/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/profile_activities_page.dart';
import '../datasources/profile_activities_remote_data_source.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/donations_state.dart';
import '../../domain/entities/verification_request.dart';
import '../../domain/entities/verification_requests_page.dart';
import '../datasources/verification_remote_data_source.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final AuthRepository authRepository;
  final ProfileActivitiesRemoteDataSource profileActivitiesRemoteDataSource;
  final VerificationRemoteDataSource verificationRemoteDataSource;

  ProfileRepositoryImpl({
    required this.authRepository,
    required this.profileActivitiesRemoteDataSource,
    required this.verificationRemoteDataSource,
  });

  @override
  Future<Either<Failure, User>> getCachedOrRemoteUser() async {
    try {
      // Try to get cached user first
      final cachedResult = await authRepository.getCachedUser();

      // Check if we got a valid cached user
      final isSuccess = cachedResult is Right<Failure, User>;
      if (isSuccess) {
        return cachedResult;
      }

      // If cache fails or returns null, try to get from remote
      final remoteResult = await authRepository.getCurrentUser();
      return remoteResult;
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getRemoteUser() async {
    try {
      final result = await authRepository.getCurrentUser();
      return result;
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserProfile({
    required String displayName,
    String? email,
    String? phoneNumber,
    Map<String, dynamic>? location,
  }) async {
    try {
      // Currently the API only supports displayName update
      // TODO: Extend backend API to support email, phoneNumber, and location updates
      final result = await authRepository.updateProfile(
        displayName: displayName,
        email: email,
        phoneNumber: phoneNumber,
        location: location,
      );
      return result;
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfileAvatar(File file) async {
    try {
      final result = await authRepository.uploadProfileAvatar(file);
      if (result.id == null) {
        return Left(
          ServerFailure('Failed to get attachment ID from upload response'),
        );
      }
      return Right(result.id!);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfileWithAvatarId(
    String avatarAttachmentId,
  ) async {
    try {
      final result = await authRepository.updateProfileWithAvatarId(
        avatarAttachmentId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileActivitiesPage>> getUserActivities({
    required String userId,
    String? statusFilter,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final activitiesPage = await profileActivitiesRemoteDataSource
          .getUserActivities(
            userId: userId,
            statusFilter: statusFilter,
            page: page,
            limit: limit,
          );

      final sortedActivities = List.of(activitiesPage.activities)
        ..sort(
          (a, b) => (b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0))
              .compareTo(a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0)),
        );

      return Right(
        ProfileActivitiesPage(
          activities: sortedActivities,
          hasNextPage: activitiesPage.hasNextPage,
          hasPreviousPage: activitiesPage.hasPreviousPage,
          limit: activitiesPage.limit,
          page: activitiesPage.page,
          totalCount: activitiesPage.totalCount,
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DonationsState>> getDonationsStats() async {
    try {
      final dto = await profileActivitiesRemoteDataSource.getDonationsStats();
      return Right(
        DonationsState(
          likedDonations: dto.likedDonations,
          totalDonations: dto.totalDonations,
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserSettings({
    required bool isPushNotificationsEnabled,
    required bool isNewDonationsAlertsEnabled,
    required bool isUrgentAlertsEnabled,
    required bool isSystemReports,
    required String appearance,
  }) async {
    try {
      return authRepository.updateUserSettings(
        isPushNotificationsEnabled: isPushNotificationsEnabled,
        isNewDonationsAlertsEnabled: isNewDonationsAlertsEnabled,
        isUrgentAlertsEnabled: isUrgentAlertsEnabled,
        isSystemReports: isSystemReports,
        appearance: appearance,
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerificationRequestsPage>> getSentVerificationRequests({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final result = await verificationRemoteDataSource.getSentVerificationRequests(
        page: page,
        limit: limit,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerificationRequestsPage>> getVerificationRequestsForFoodSaver({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    try {
      final result = await verificationRemoteDataSource.getVerificationRequestsForFoodSaver(
        page: page,
        limit: limit,
        search: search,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerificationRequest>> updateVerificationRequestStatus({
    required String id,
    required VerificationRequestStatus status,
  }) async {
    try {
      final result = await verificationRemoteDataSource.updateVerificationRequestStatus(
        id: id,
        status: status,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> searchUsersToVerify({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    try {
      final result = await verificationRemoteDataSource.searchUsersToVerify(
        page: page,
        limit: limit,
        search: search,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerificationRequest>> createVerificationRequest({
    required String targetFoodSaverId,
  }) async {
    try {
      final result = await verificationRemoteDataSource.createVerificationRequest(
        targetFoodSaverId: targetFoodSaverId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
