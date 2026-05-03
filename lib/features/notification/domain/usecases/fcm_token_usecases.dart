import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/fcm_token_repository.dart';

/// Register FCM token use case
/// Orchestrates the registration of a new FCM token with the backend
@singleton
class RegisterFcmTokenUseCase {
  final FcmTokenRepository _repository;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  RegisterFcmTokenUseCase(this._repository);

  /// Execute the use case
  /// [fcmToken] - The FCM token to register
  /// Returns [Right] with the registered token on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, String>> call(String fcmToken) async {
    _logger.i('🚀 RegisterFcmTokenUseCase: Starting FCM token registration...');
    final _tokenPreview = fcmToken.length > 20
        ? '...${fcmToken.substring(fcmToken.length - 20)}'
        : fcmToken;
    _logger.d(
      '📱 RegisterFcmTokenUseCase: Token (last 20 chars): $_tokenPreview',
    );

    return await _repository.registerFcmToken(fcmToken);
  }
}

/// Get FCM token use case
/// Retrieves the stored FCM token from local storage
@singleton
class GetFcmTokenUseCase {
  final FcmTokenRepository _repository;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  GetFcmTokenUseCase(this._repository);

  /// Execute the use case
  /// Returns [Right] with the FCM token (or null) on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, String?>> call() async {
    _logger.i('🚀 GetFcmTokenUseCase: Retrieving stored FCM token...');

    return await _repository.getFcmToken();
  }
}

/// Check FCM token registration use case
/// Checks if the FCM token has been registered with the backend
@singleton
class CheckFcmTokenRegistrationUseCase {
  final FcmTokenRepository _repository;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  CheckFcmTokenRegistrationUseCase(this._repository);

  /// Execute the use case
  /// Returns [Right] with boolean indicating registration status on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, bool>> call() async {
    _logger.i(
      '🚀 CheckFcmTokenRegistrationUseCase: Checking token registration status...',
    );

    return await _repository.isFcmTokenRegistered();
  }
}

/// Delete FCM token use case
/// Deletes the FCM token from both local storage and backend
@singleton
class DeleteFcmTokenUseCase {
  final FcmTokenRepository _repository;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  DeleteFcmTokenUseCase(this._repository);

  /// Execute the use case
  /// Returns [Right] with null on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, void>> call() async {
    _logger.i('🚀 DeleteFcmTokenUseCase: Deleting FCM token...');

    return await _repository.deleteFcmToken();
  }
}

/// Get last token registration time use case
/// Retrieves the timestamp of the last successful token registration
@singleton
class GetLastTokenRegistrationTimeUseCase {
  final FcmTokenRepository _repository;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  GetLastTokenRegistrationTimeUseCase(this._repository);

  /// Execute the use case
  /// Returns [Right] with the DateTime (or null) on success
  /// Returns [Left] with a [Failure] on error
  Future<Either<Failure, DateTime?>> call() async {
    _logger.i(
      '🚀 GetLastTokenRegistrationTimeUseCase: Retrieving last registration time...',
    );

    return await _repository.getLastTokenRegistrationTime();
  }
}
