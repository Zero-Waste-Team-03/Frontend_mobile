import 'package:dartz/dartz.dart';
import 'dart:io';
import '../../../../core/errors/failures.dart';
import '../../../auth/domain/entities/user.dart';
import '../entities/profile_activities_page.dart';
import '../entities/donations_state.dart';
import '../entities/verification_request.dart';
import '../entities/verification_requests_page.dart';

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

  /// Get user donations to display profile activity history
  Future<Either<Failure, ProfileActivitiesPage>> getUserActivities({
    required String userId,
    String? statusFilter,
    int page = 1,
    int limit = 10,
  });

  /// Get simple donations counters for the profile header
  Future<Either<Failure, DonationsState>> getDonationsStats();

  /// Update user settings (notifications, appearance, etc.)
  Future<Either<Failure, User>> updateUserSettings({
    required bool isPushNotificationsEnabled,
    required bool isNewDonationsAlertsEnabled,
    required bool isUrgentAlertsEnabled,
    required bool isSystemReports,
    required String appearance,
  });

  /// Get verification requests sent by the user
  Future<Either<Failure, VerificationRequestsPage>> getSentVerificationRequests({
    int page = 1,
    int limit = 10,
  });

  /// Get verification requests received as a food saver
  Future<Either<Failure, VerificationRequestsPage>> getVerificationRequestsForFoodSaver({
    int page = 1,
    int limit = 10,
    String? search,
  });

  /// Update verification request status (approve/reject)
  Future<Either<Failure, VerificationRequest>> updateVerificationRequestStatus({
    required String id,
    required VerificationRequestStatus status,
  });

  /// Search for users to request verification from
  Future<Either<Failure, List<User>>> searchUsersToVerify({
    int page = 1,
    int limit = 10,
    String? search,
  });

  /// Create a new verification request
  Future<Either<Failure, VerificationRequest>> createVerificationRequest({
    required String targetFoodSaverId,
  });
}
