import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

/// Abstract repository for FCM token operations
/// Defines the contract for FCM token management business logic
abstract class FcmTokenRepository {
  /// Register FCM token with the backend
  /// Returns [Right] with the registered token on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, String>> registerFcmToken(String fcmToken);

  /// Retrieve the stored FCM token from local storage
  /// Returns [Right] with the token (or null if not found) on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, String?>> getFcmToken();

  /// Check if the FCM token has been registered with the backend
  /// Returns [Right] with boolean value on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, bool>> isFcmTokenRegistered();

  /// Delete the stored FCM token from local storage and backend
  /// Returns [Right] with null on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, void>> deleteFcmToken();

  /// Get the timestamp of the last successful token registration
  /// Returns [Right] with the DateTime (or null if never registered) on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, DateTime?>> getLastTokenRegistrationTime();
}
