import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_local_data_source.dart';
import '../sources/auth_remote_data_source.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final GoogleSignIn googleSignInClient;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.googleSignInClient,
  });

  @override
  Future<Either<Failure, AuthResponse>> login(String email, String password) async {
    try {
      final responseModel = await remoteDataSource.login(email, password);

      // Block admin users from using the mobile app
      final user = responseModel.toEntity().user;
      if (user != null && user.isAdmin) {
        return Left(ServerFailure('Admin accounts cannot access the mobile app. Please use the web dashboard.'));
      }

      if (responseModel.accessToken != null) {
        await localDataSource.cacheTokens(responseModel.accessToken!, responseModel.refreshToken);
      }
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendOtp(String email) async {
    try {
      await remoteDataSource.sendOtp(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register(String displayName, String email, String password, String otp) async {
    try {
      await remoteDataSource.register(displayName, email, password, otp);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> oAuthLogin(String provider, String accessToken) async {
    try {
      final responseModel = await remoteDataSource.oAuthLogin(provider, accessToken);

      // Block admin users from using the mobile app
      final user = responseModel.toEntity().user;
      if (user != null && user.isAdmin) {
        return Left(ServerFailure('Admin accounts cannot access the mobile app. Please use the web dashboard.'));
      }

      if (responseModel.accessToken != null) {
        await localDataSource.cacheTokens(responseModel.accessToken!, responseModel.refreshToken);
      }
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> googleSignIn() async {
    try {
      // google_sign_in v7.x: use authenticate() instead of signIn()
      final googleUser = await googleSignInClient.authenticate();

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        return Left(ServerFailure('Failed to get Google ID token'));
      }

      // Send the Google ID token to our backend
      final responseModel = await remoteDataSource.oAuthLogin('google', idToken);

      // Block admin users from using the mobile app
      final user = responseModel.toEntity().user;
      if (user != null && user.isAdmin) {
        return Left(ServerFailure('Admin accounts cannot access the mobile app. Please use the web dashboard.'));
      }

      if (responseModel.accessToken != null) {
        await localDataSource.cacheTokens(responseModel.accessToken!, responseModel.refreshToken);
      }
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      final user = userModel.toEntity();

      // Block admin users from using the mobile app
      if (user.isAdmin) {
        await localDataSource.clearTokens();
        return Left(ServerFailure('Admin accounts cannot access the mobile app. Please use the web dashboard.'));
      }

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await localDataSource.clearTokens();
      await googleSignInClient.signOut();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword) async {
    try {
      await remoteDataSource.changePassword(oldPassword, newPassword);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String token, String newPassword) async {
    try {
      await remoteDataSource.resetPassword(token, newPassword);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
