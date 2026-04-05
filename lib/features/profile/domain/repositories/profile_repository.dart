import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/user.dart';

abstract class ProfileRepository {
  /// Get cached user profile, fallback to remote if cache is empty
  Future<Either<Failure, User>> getCachedOrRemoteUser();

  /// Get user profile from remote (API)
  Future<Either<Failure, User>> getRemoteUser();

  /// Update user profile with new information
  Future<Either<Failure, User>> updateUserProfile({
    required String displayName,
    String? email,
    String? phoneNumber,
    String? location,
  });
}
