import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/device/device_id_provider.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
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
import 'graphql/__generated__/logout.req.gql.dart';
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
    String? zipCode,
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
  Future<void> logout();
  Future<void> logoutFromAllDevices();
  Future<void> deleteAccount();
  Future<UserModel> updateProfile({
    String? displayName,
    String? email,
    String? phoneNumber,
    Map<String, dynamic>? location,
    Map<String, dynamic>? settings,
  });
  Future<UserModel> updateUserSettings({
    required bool isPushNotificationsEnabled,
    required bool isNewDonationsAlertsEnabled,
    required bool isUrgentAlertsEnabled,
    required bool isSystemReports,
    required String appearance,
  });
  Future<FileUploadResponseModel> uploadProfileAvatar(File file);
  Future<UserModel> updateProfileWithAvatarId(String avatarAttachmentId);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(
    this.dio,
    this._ferryClient,
    this._graphqlRequestExecutor,
    this._deviceIdProvider,
  );

  final Dio dio;
  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;
  final DeviceIdProvider _deviceIdProvider;

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
    await _deviceIdProvider.getOrCreateDeviceId();

    final vars = GLoginVars.fromJson({
      'loginInput': {'email': email.trim(), 'password': password},
    });
    if (vars == null) {
      throw ServerException('Failed to build login request');
    }

    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GLoginReq((b) => b.vars = vars.toBuilder()),
      operationName: 'login',
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

    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GSendVerificationReq((b) => b.vars = vars.toBuilder()),
      operationName: 'sendVerification',
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
    String? zipCode,
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
        zipCode: zipCode,
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

    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GRegisterReq((b) => b.vars = vars.toBuilder()),
      operationName: 'register',
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
    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GGetCurrentUserReq(
        (b) => b..fetchPolicy = FetchPolicy.NetworkOnly,
      ),
      operationName: 'getCurrentUser',
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

    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GChangePasswordReq((b) => b.vars = vars.toBuilder()),
      operationName: 'changePassword',
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    final vars = GForgotPasswordVars.fromJson({'email': email.trim()});
    if (vars == null) {
      throw ServerException('Failed to build forgotPassword request');
    }

    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GForgotPasswordReq((b) => b.vars = vars.toBuilder()),
      operationName: 'forgotPassword',
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

    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GResetPasswordReq((b) => b.vars = vars.toBuilder()),
      operationName: 'resetPassword',
    );
  }

  @override
  Future<AuthResponseModel> refreshTokens() async {
    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GRefreshTokensReq(),
      operationName: 'refreshTokens',
    );
    return AuthResponseModel.fromJson(
      Map<String, dynamic>.from(data.refreshTokens.toJson()),
    );
  }

  @override
  Future<void> logout() async {
    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GLogoutReq(),
      operationName: 'logout',
    );
  }

  @override
  Future<void> logoutFromAllDevices() async {
    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GLogoutFromAllDevicesReq(),
      operationName: 'logoutFromAllDevices',
    );
  }

  @override
  Future<void> deleteAccount() async {
    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GDeleteAccountReq(),
      operationName: 'deleteAccount',
    );
  }

  @override
  Future<UserModel> updateProfile({
    String? displayName,
    String? email,
    String? phoneNumber,
    Map<String, dynamic>? location,
    Map<String, dynamic>? settings,
  }) async {
    final updateProfileInput = <String, dynamic>{
      if (displayName != null && displayName.trim().isNotEmpty)
        'displayName': displayName.trim(),
      if (email != null && email.trim().isNotEmpty) 'email': email.trim(),
      if (phoneNumber != null && phoneNumber.trim().isNotEmpty)
        'phoneNumber': phoneNumber.trim(),
      if (location != null) 'location': Map<String, dynamic>.from(location),
      if (settings != null) 'settings': Map<String, dynamic>.from(settings),
    };

    print('Updating profile with input: $updateProfileInput');
    final vars = GUpdateProfileVars.fromJson({
      'updateProfileInput': updateProfileInput,
    });
    if (vars == null) {
      throw ServerException('Failed to build updateProfile request');
    }

    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GUpdateProfileReq((b) => b.vars = vars.toBuilder()),
      operationName: 'updateProfile',
    );
    var userModel = UserModel.fromJson(
      Map<String, dynamic>.from(data.updateProfile.toJson()),
    );
    print('UserModel after updateProfile: ${userModel.toJson()}');
    return userModel;
  }

  @override
  Future<UserModel> updateUserSettings({
    required bool isPushNotificationsEnabled,
    required bool isNewDonationsAlertsEnabled,
    required bool isUrgentAlertsEnabled,
    required bool isSystemReports,
    required String appearance,
  }) async {
    return updateProfile(
      settings: {
        'isPushNotificationsEnabled': isPushNotificationsEnabled,
        'isNewDonationsAlertsEnabled': isNewDonationsAlertsEnabled,
        'isUrgentAlertsEnabled': isUrgentAlertsEnabled,
        'isSystemReports': isSystemReports,
        'appearance': appearance,
      },
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

    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GUpdateProfileReq((b) => b.vars = vars.toBuilder()),
      operationName: 'updateProfile',
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
            isVerified: userModel.isVerified,
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
    String? zipCode,
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
    if (zipCode != null && zipCode.trim().isNotEmpty) {
      location['zipCode'] = zipCode.trim();
    }
    return location;
  }
}
