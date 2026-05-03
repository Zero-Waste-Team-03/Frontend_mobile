import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../domain/repositories/fcm_token_repository.dart';
import '../sources/fcm_token_local_data_source.dart';
import '../sources/fcm_token_remote_data_source.dart';

/// Implementation of FCM Token Repository 
@LazySingleton(as: FcmTokenRepository)
class FcmTokenRepositoryImpl implements FcmTokenRepository {
  final FcmTokenRemoteDataSource _remoteDataSource;
  final FcmTokenLocalDataSource _localDataSource;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  FcmTokenRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, String>> registerFcmToken(String fcmToken) async {
    _logger.i('🔐 FcmTokenRepositoryImpl: Starting FCM token registration...');
    final _preview = fcmToken.length > 20
        ? '...${fcmToken.substring(fcmToken.length - 20)}'
        : fcmToken;
    _logger.d('📱 FcmTokenRepositoryImpl: Token (last 20 chars): $_preview');

    try {
      // Validate token
      if (fcmToken.isEmpty) {
        _logger.e('❌ FcmTokenRepositoryImpl: FCM token is empty');
        return Left(ValidationFailure('FCM token cannot be empty'));
      }

      _logger.i('📤 FcmTokenRepositoryImpl: Registering token with backend...');

      // Register token with backend
      final registeredToken = await _remoteDataSource.registerFcmToken(
        fcmToken,
      );
      _logger.i(
        '✅ FcmTokenRepositoryImpl: Token registered with backend successfully',
      );

      // Save token locally
      _logger.i('💾 FcmTokenRepositoryImpl: Saving token locally...');
      await _localDataSource.saveFcmToken(registeredToken);
      _logger.i('✅ FcmTokenRepositoryImpl: Token saved locally');

      // Mark token as registered
      _logger.i('✔️  FcmTokenRepositoryImpl: Marking token as registered...');
      await _localDataSource.markFcmTokenAsRegistered();
      _logger.i('✅ FcmTokenRepositoryImpl: Token marked as registered');

      // Update last registration time
      _logger.i(
        '⏱️  FcmTokenRepositoryImpl: Updating registration timestamp...',
      );
      await _localDataSource.updateLastTokenRegistrationTime();
      _logger.i('✅ FcmTokenRepositoryImpl: Registration timestamp updated');

      _logger.i(
        '🎉 FcmTokenRepositoryImpl: FCM token registration completed successfully',
      );
      return Right(registeredToken);
    } on ServerException catch (e) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Server error during token registration',
        error: e,
      );
      return Left(ServerFailure('Failed to register FCM token: ${e.message}'));
    } on CacheException catch (e) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Cache error during token storage',
        error: e,
      );
      return Left(
        CacheFailure('Failed to store FCM token locally: ${e.message}'),
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Unexpected error during token registration',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        UnknownFailure(
          'Unexpected error during FCM token registration: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String?>> getFcmToken() async {
    _logger.d('🔐 FcmTokenRepositoryImpl: Retrieving stored FCM token...');

    try {
      final token = await _localDataSource.getFcmToken();
      if (token != null && token.isNotEmpty) {
        _logger.i('✅ FcmTokenRepositoryImpl: FCM token retrieved successfully');
        final _preview = token.length > 20
            ? '...${token.substring(token.length - 20)}'
            : token;
        _logger.d('📱 FcmTokenRepositoryImpl: Token (last 20 chars): $_preview');
      } else {
        _logger.w('⚠️  FcmTokenRepositoryImpl: No stored FCM token found');
      }
      return Right(token);
    } on CacheException catch (e) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Cache error retrieving token',
        error: e,
      );
      return Left(CacheFailure('Failed to retrieve FCM token: ${e.message}'));
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Unexpected error retrieving token',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        UnknownFailure(
          'Unexpected error retrieving FCM token: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isFcmTokenRegistered() async {
    _logger.d(
      '🔐 FcmTokenRepositoryImpl: Checking FCM token registration status...',
    );

    try {
      final isRegistered = await _localDataSource.isFcmTokenRegistered();
      _logger.i(
        'ℹ️  FcmTokenRepositoryImpl: Token registration status: $isRegistered',
      );
      return Right(isRegistered);
    } on CacheException catch (e) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Cache error checking registration status',
        error: e,
      );
      return Left(
        CacheFailure('Failed to check registration status: ${e.message}'),
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Unexpected error checking registration status',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        UnknownFailure(
          'Unexpected error checking registration status: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteFcmToken() async {
    _logger.i('🔐 FcmTokenRepositoryImpl: Deleting FCM token...');

    try {
      // Delete token from local storage
      _logger.i('💾 FcmTokenRepositoryImpl: Deleting stored token...');
      await _localDataSource.deleteFcmToken();
      _logger.i('✅ FcmTokenRepositoryImpl: Token deleted from storage');

      // Clear registration status
      _logger.i('✔️  FcmTokenRepositoryImpl: Clearing registration status...');
      await _localDataSource.clearFcmTokenRegistrationStatus();
      _logger.i('✅ FcmTokenRepositoryImpl: Registration status cleared');

      _logger.i('🎉 FcmTokenRepositoryImpl: FCM token deleted successfully');
      return const Right(null);
    } on CacheException catch (e) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Cache error deleting token',
        error: e,
      );
      return Left(CacheFailure('Failed to delete FCM token: ${e.message}'));
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Unexpected error deleting token',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        UnknownFailure('Unexpected error deleting FCM token: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getLastTokenRegistrationTime() async {
    _logger.d(
      '🔐 FcmTokenRepositoryImpl: Retrieving last registration time...',
    );

    try {
      final time = await _localDataSource.getLastTokenRegistrationTime();
      if (time != null) {
        _logger.i('ℹ️  FcmTokenRepositoryImpl: Last registration time: $time');
      } else {
        _logger.w(
          '⚠️  FcmTokenRepositoryImpl: No previous registration time found',
        );
      }
      return Right(time);
    } on CacheException catch (e) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Cache error retrieving registration time',
        error: e,
      );
      return Left(
        CacheFailure('Failed to retrieve registration time: ${e.message}'),
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenRepositoryImpl: Unexpected error retrieving registration time',
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        UnknownFailure(
          'Unexpected error retrieving registration time: ${e.toString()}',
        ),
      );
    }
  }
}
