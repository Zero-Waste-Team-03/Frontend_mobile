import 'package:dartz/dartz.dart';
import 'dart:io';
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
    Map<String, dynamic>? location,
  });

  /// Upload profile avatar file and get attachment ID
  Future<Either<Failure, String>> uploadProfileAvatar(File file);

  /// Update profile with avatar attachment ID
  Future<Either<Failure, User>> updateProfileWithAvatarId(
    String avatarAttachmentId,
  );
}
