import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../models/auth_response_model.dart';
import '../models/file_upload_response_model.dart';
import '../models/user_model.dart';
import 'graphql/__generated__/change_password.req.gql.dart';
import 'graphql/__generated__/change_password.var.gql.dart';
import 'graphql/__generated__/delete_account.req.gql.dart';
import 'graphql/__generated__/forgot_password.req.gql.dart';
import 'graphql/__generated__/forgot_password.var.gql.dart';
import 'graphql/__generated__/get_current_user.req.gql.dart';
import 'graphql/__generated__/login.req.gql.dart';
import 'graphql/__generated__/login.var.gql.dart';
import 'graphql/__generated__/logout_from_all_devices.req.gql.dart';
import 'graphql/__generated__/refresh_tokens.req.gql.dart';
import 'graphql/__generated__/register.req.gql.dart';
import 'graphql/__generated__/register.var.gql.dart';
import 'graphql/__generated__/reset_password.req.gql.dart';
import 'graphql/__generated__/reset_password.var.gql.dart';
import 'graphql/__generated__/send_verification.req.gql.dart';
import 'graphql/__generated__/send_verification.var.gql.dart';
import 'graphql/__generated__/update_profile.req.gql.dart';
import 'graphql/__generated__/update_profile.var.gql.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(String email, String password);
  Future<void> sendOtp(String email);
  Future<void> register({
    required String displayName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String otp,
    String? city,
    String? country,
    double? latitude,
    double? longitude,
    String? neighborhood,
  });
  Future<AuthResponseModel> oAuthLogin(String provider, String accessToken);
  String getOAuthProviderEntryUrl(String provider);
  Future<UserModel> getCurrentUser();
  Future<void> changePassword(
    String oldPassword,
    String newPassword, {
    bool logoutFromOtherDevices = false,
  });
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String token, String newPassword);
  Future<AuthResponseModel> refreshTokens();
  Future<void> logoutFromAllDevices();
  Future<void> deleteAccount();
  Future<UserModel> updateProfile({
    String? displayName,
    String? email,
    String? phoneNumber,
    Map<String, dynamic>? location,
  });
  Future<FileUploadResponseModel> uploadProfileAvatar(File file);
  Future<UserModel> updateProfileWithAvatarId(String avatarAttachmentId);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.dio, this._ferryClient);

  final Dio dio;
  final Client _ferryClient;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    final vars = GLoginVars.fromJson({
      'loginInput': {'email': email.trim(), 'password': password},
    });
    if (vars == null) {
      throw ServerException('Failed to build login request');
    }

    final data = await _executeRequest(
      GLoginReq((b) => b.vars = vars.toBuilder()),
      'login',
    );

    return AuthResponseModel.fromJson(
      Map<String, dynamic>.from(data.login.toJson()),
    );
  }

  @override
  Future<void> sendOtp(String email) async {
    final vars = GSendVerificationVars.fromJson({'email': email.trim()});
    if (vars == null) {
      throw ServerException('Failed to build sendVerification request');
    }

    await _executeRequest(
      GSendVerificationReq((b) => b.vars = vars.toBuilder()),
      'sendVerification',
    );
  }

  @override
  Future<void> register({
    required String displayName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String otp,
    String? city,
    String? country,
    double? latitude,
    double? longitude,
    String? neighborhood,
  }) async {
    final registerInput = <String, dynamic>{
      'email': email.trim(),
      'password': password,
      'phoneNumber': phoneNumber,
      'location': _buildRegisterLocationInput(
        city: city,
        country: country,
        latitude: latitude,
        longitude: longitude,
        neighborhood: neighborhood,
      ),
    };

    final normalizedDisplayName = displayName.trim();
    if (normalizedDisplayName.isNotEmpty) {
      registerInput['displayName'] = normalizedDisplayName;
    }

    final vars = GRegisterVars.fromJson({
      'otp': otp,
      'registerInput': registerInput,
    });
    if (vars == null) {
      throw ServerException('Failed to build register request');
    }

    await _executeRequest(
      GRegisterReq((b) => b.vars = vars.toBuilder()),
      'register',
    );
  }

  @override
  Future<AuthResponseModel> oAuthLogin(
    String provider,
    String accessToken,
  ) async {
    try {
      final response = await dio.post(
        '/api/auth/oauth/$provider',
        data: {'access_token': accessToken},
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      }
      throw ServerException('OAuth login failed.');
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ??
          e.message ??
          e.error?.toString() ??
          'OAuth request failed';
      throw ServerException(errorMessage);
    }
  }

  @override
  String getOAuthProviderEntryUrl(String provider) {
    final baseUri = Uri.parse(dio.options.baseUrl);
    return baseUri.resolve('/api/v1/authentication/oauth/$provider').toString();
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final data = await _executeRequest(
      GGetCurrentUserReq((b) => b..fetchPolicy = FetchPolicy.NetworkOnly),
      'getCurrentUser',
    );
    return UserModel.fromJson(
      Map<String, dynamic>.from(data.currentUser.toJson()),
    );
  }

  @override
  Future<void> changePassword(
    String oldPassword,
    String newPassword, {
    bool logoutFromOtherDevices = false,
  }) async {
    final vars = GChangePasswordVars.fromJson({
      'changePasswordInput': {
        'currentPassword': oldPassword,
        'newPassword': newPassword,
        'logoutFromOtherDevices': logoutFromOtherDevices,
      },
    });
    if (vars == null) {
      throw ServerException('Failed to build changePassword request');
    }

    await _executeRequest(
      GChangePasswordReq((b) => b.vars = vars.toBuilder()),
      'changePassword',
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    final vars = GForgotPasswordVars.fromJson({'email': email.trim()});
    if (vars == null) {
      throw ServerException('Failed to build forgotPassword request');
    }

    await _executeRequest(
      GForgotPasswordReq((b) => b.vars = vars.toBuilder()),
      'forgotPassword',
    );
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    final vars = GResetPasswordVars.fromJson({
      'resetPasswordInput': {'token': token, 'password': newPassword},
    });
    if (vars == null) {
      throw ServerException('Failed to build resetPassword request');
    }

    await _executeRequest(
      GResetPasswordReq((b) => b.vars = vars.toBuilder()),
      'resetPassword',
    );
  }

  @override
  Future<AuthResponseModel> refreshTokens() async {
    final data = await _executeRequest(GRefreshTokensReq(), 'refreshTokens');
    return AuthResponseModel.fromJson(
      Map<String, dynamic>.from(data.refreshTokens.toJson()),
    );
  }

  @override
  Future<void> logoutFromAllDevices() async {
    await _executeRequest(GLogoutFromAllDevicesReq(), 'logoutFromAllDevices');
  }

  @override
  Future<void> deleteAccount() async {
    await _executeRequest(GDeleteAccountReq(), 'deleteAccount');
  }

  @override
  Future<UserModel> updateProfile({
    String? displayName,
    String? email,
    String? phoneNumber,
    Map<String, dynamic>? location,
  }) async {
    final updateProfileInput = <String, dynamic>{
      if (displayName != null && displayName.trim().isNotEmpty)
        'displayName': displayName.trim(),
      if (email != null && email.trim().isNotEmpty) 'email': email.trim(),
      if (phoneNumber != null && phoneNumber.trim().isNotEmpty)
        'phoneNumber': phoneNumber.trim(),
      if (location != null) 'location': Map<String, dynamic>.from(location),
    };

    final vars = GUpdateProfileVars.fromJson({
      'updateProfileInput': updateProfileInput,
    });
    if (vars == null) {
      throw ServerException('Failed to build updateProfile request');
    }

    final data = await _executeRequest(
      GUpdateProfileReq((b) => b.vars = vars.toBuilder()),
      'updateProfile',
    );

    return UserModel.fromJson(
      Map<String, dynamic>.from(data.updateProfile.toJson()),
    );
  }

  @override
  Future<FileUploadResponseModel> uploadProfileAvatar(File file) async {
    _logger.i('Uploading profile avatar: ${file.path}');
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await dio.post(
        '/api/v1/upload/file?uploadType=USER_PROFILE',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return FileUploadResponseModel.fromJson(response.data);
      }

      throw ServerException('Avatar upload failed');
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ??
          e.message ??
          e.error?.toString() ??
          'Failed to upload avatar';
      throw ServerException(errorMessage);
    }
  }

  @override
  Future<UserModel> updateProfileWithAvatarId(String avatarAttachmentId) async {
    final vars = GUpdateProfileVars.fromJson({
      'updateProfileInput': {'avatarAttachmentId': avatarAttachmentId},
    });
    if (vars == null) {
      throw ServerException('Failed to build updateProfile avatar request');
    }

    final data = await _executeRequest(
      GUpdateProfileReq((b) => b.vars = vars.toBuilder()),
      'updateProfile',
    );

    var userModel = UserModel.fromJson(
      Map<String, dynamic>.from(data.updateProfile.toJson()),
    );

    if (userModel.avatarUrl == null || userModel.avatarUrl!.isEmpty) {
      final updateProfileJson = Map<String, dynamic>.from(
        data.updateProfile.toJson(),
      );
      final avatarMap = updateProfileJson['avatar'] as Map<String, dynamic>?;
      if (avatarMap != null) {
        final avatarId = avatarMap['id'] as String?;
        if (avatarId != null && avatarId.isNotEmpty) {
          final baseUrl = dio.options.baseUrl;
          userModel = UserModel(
            id: userModel.id,
            email: userModel.email,
            displayName: userModel.displayName,
            phoneNumber: userModel.phoneNumber,
            role: userModel.role,
            description: userModel.description,
            isMailVerified: userModel.isMailVerified,
            reputationScore: userModel.reputationScore,
            locationId: userModel.locationId,
            location: userModel.location,
            avatarUrl: '$baseUrl/api/v1/files/$avatarId',
          );
        }
      }
    }

    return userModel;
  }

  Map<String, dynamic> _buildRegisterLocationInput({
    String? city,
    String? country,
    double? latitude,
    double? longitude,
    String? neighborhood,
  }) {
    final location = <String, dynamic>{};
    if (city != null && city.trim().isNotEmpty) location['city'] = city.trim();
    if (country != null && country.trim().isNotEmpty) {
      location['country'] = country.trim();
    }
    if (latitude != null) location['latitude'] = latitude;
    if (longitude != null) location['longitude'] = longitude;
    if (neighborhood != null && neighborhood.trim().isNotEmpty) {
      location['neighborhood'] = neighborhood.trim();
    }
    return location;
  }

  Future<TData> _executeRequest<TData, TVars>(
    OperationRequest<TData, TVars> request,
    String operationName,
  ) async {
    _logger.i('Executing GraphQL operation: $operationName');

    try {
      final response = await _ferryClient.request(request).firstWhere(
            (event) =>
                (event.data != null && !event.hasErrors) ||
                event.hasErrors ||
                event.linkException != null,
          );

      if (response.hasErrors || response.linkException != null) {
        final graphQLErrors = response.graphqlErrors;
        final graphQLErrorMessage =
            graphQLErrors != null && graphQLErrors.isNotEmpty
            ? graphQLErrors.first.message
            : null;

        final message =
            graphQLErrorMessage ??
            response.linkException?.originalException?.toString() ??
            response.linkException.toString();

        throw ServerException(message);
      }

      final data = response.data;
      if (data == null) {
        throw ServerException('No data returned for $operationName');
      }

      return data;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('GraphQL request failed: $e');
    }
  }
}
