import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import '../../../../core/errors/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final AuthRepository authRepository;

  ProfileRepositoryImpl({required this.authRepository});

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
}
