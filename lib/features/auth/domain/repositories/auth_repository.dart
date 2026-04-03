import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_response.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login(String email, String password);
  Future<Either<Failure, void>> sendOtp(String email);
  Future<Either<Failure, void>> register({
    required String displayName,
    required String email,
    required String password,
    required String confirmPassword,
    required String otp,
    String? city,
    String? country,
    double? latitude,
    double? longitude,
    String? neighborhood,
  });
  Future<Either<Failure, AuthResponse>> oAuthLogin(String provider, String accessToken);
  Future<Either<Failure, AuthResponse>> googleSignIn();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword, {bool logoutFromOtherDevices = false});
  Future<Either<Failure, void>> forgotPassword(String email);
  Future<Either<Failure, void>> resetPassword(String token, String newPassword);
  Future<Either<Failure, AuthResponse>> refreshTokens();
  Future<Either<Failure, void>> logoutFromAllDevices();
  Future<Either<Failure, void>> deleteAccount();
  Future<Either<Failure, User>> updateProfile(String displayName);
}
