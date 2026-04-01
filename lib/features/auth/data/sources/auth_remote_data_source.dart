import 'package:dio/dio.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';
import 'package:logger/logger.dart';

import 'package:injectable/injectable.dart';

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
  Future<void> changePassword(String oldPassword, String newPassword,
      {bool logoutFromOtherDevices = false});
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String token, String newPassword);
  Future<AuthResponseModel> refreshTokens();
  Future<void> logoutFromAllDevices();
  Future<void> deleteAccount();
  Future<UserModel> updateProfile({String? displayName, String? email, String? phoneNumber, Map<String, dynamic>? location});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  static const String _userFields = '''
    id
    email
    displayName
    role
    description
    isMailVerified
    phoneNumber
    reputationScore
    locationId
    location {
      id
      city
      country
      latitude
      longitude
      neighborhood
    }
  ''';
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthResponseModel> login(String email, String password) async {
    const query = '''
      mutation Login(\$loginInput: LoginInput!) {
        login(loginInput: \$loginInput) {
          accessToken
          refreshToken
          user {
            $_userFields
          }
        }
      }
    ''';

    return _executeGraphqlMutation(
        query,
        {
          'loginInput': {
            'email': email.trim(),
            'password': password,
          }
        },
        'login');
  }

  @override
  Future<void> sendOtp(String email) async {
    const query = '''
      mutation SendVerification(\$email: String!) {
        sendVerification(email: \$email) {
          message
        }
      }
    ''';
    await _executeGraphqlVoidMutation(
        query,
        {
          'email': email.trim(),
        },
        'sendVerification');
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
    const query = '''
      mutation Register(\$otp: String!, \$registerInput: RegisterInput!) {
        register(otp: \$otp, registerInput: \$registerInput) {
          message
        }
      }
    ''';

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

    await _executeGraphqlVoidMutation(
        query,
        {
          'otp': otp,
          'registerInput': registerInput,
        },
        'register');
  }

  @override
  Future<AuthResponseModel> oAuthLogin(
      String provider, String accessToken) async {
    try {
      // NOTE: Using REST for OAuth integration as structurally requested
      final response = await dio.post(
        '/api/auth/oauth/$provider',
        data: {
          'access_token': accessToken,
        },
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw ServerException('OAuth login failed.');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data?['message'] ??
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
    const query = '''
      query GetCurrentUser {
        currentUser {
          $_userFields
        }
      }
    ''';

    try {
      final response = await dio.post('/graphql', data: {
        'query': query,
      });

      if (response.data['errors'] != null) {
        throw ServerException(response.data['errors'][0]['message']);
      }

      return UserModel.fromJson(response.data['data']['currentUser']);
    } on DioException catch (e) {
      final errorMessage =
          e.message ?? e.error?.toString() ?? 'Failed to get user';
      throw ServerException(errorMessage);
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword,
      {bool logoutFromOtherDevices = false}) async {
    const query = '''
      mutation ChangePassword(\$changePasswordInput: ChangePasswordInput!) {
        changePassword(changePasswordInput: \$changePasswordInput) {
          message
        }
      }
    ''';
    await _executeGraphqlVoidMutation(
        query,
        {
          'changePasswordInput': {
            'currentPassword': oldPassword,
            'newPassword': newPassword,
            'logoutFromOtherDevices': logoutFromOtherDevices,
          }
        },
        'changePassword');
  }

  @override
  Future<void> forgotPassword(String email) async {
    const query = '''
      mutation ForgotPassword(\$email: String!) {
        forgotPassword(email: \$email) {
          message
        }
      }
    ''';
    await _executeGraphqlVoidMutation(
        query,
        {
          'email': email.trim(),
        },
        'forgotPassword');
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    const query = '''
      mutation ResetPassword(\$resetPasswordInput: ResetPasswordInput!) {
        resetPassword(resetPasswordInput: \$resetPasswordInput) {
          message
        }
      }
    ''';
    await _executeGraphqlVoidMutation(
        query,
        {
          'resetPasswordInput': {
            'token': token,
            'password': newPassword,
          }
        },
        'resetPassword');
  }

  @override
  Future<AuthResponseModel> refreshTokens() async {
    const query = '''
      mutation RefreshTokens {
        refreshTokens {
          accessToken
          refreshToken
          user {
            $_userFields
          }
        }
      }
    ''';
    return _executeGraphqlMutation(query, {}, 'refreshTokens');
  }

  @override
  Future<void> logoutFromAllDevices() async {
    const query = '''
      mutation LogoutFromAllDevices {
        logoutFromAllDevices {
          message
        }
      }
    ''';
    await _executeGraphqlVoidMutation(query, {}, 'logoutFromAllDevices');
  }

  @override
  Future<void> deleteAccount() async {
    const query = '''
      mutation DeleteAccount {
        deleteAccount {
          message
        }
      }
    ''';
    await _executeGraphqlVoidMutation(query, {}, 'deleteAccount');
  }

  @override
  Future<UserModel> updateProfile({String? displayName, String? email, String? phoneNumber, Map<String, dynamic>? location}) async {
    const query = '''
      mutation UpdateProfile(\$updateProfileInput: UpdateProfileInput!) {
        updateProfile(updateProfileInput: \$updateProfileInput) {
          $_userFields
        }
      }
    ''';

    _logger.i('ðŸš€ Executing GraphQL: updateProfile');
    try {
      final response = await dio.post('/graphql', data: {
        'query': query,
        'variables': {
          'updateProfileInput': {
            if (displayName != null && displayName.trim().isNotEmpty) 'displayName': displayName.trim(),
            if (email != null && email.trim().isNotEmpty) 'email': email.trim(),
            if (phoneNumber != null && phoneNumber.trim().isNotEmpty) 'phoneNumber': phoneNumber.trim(),
            if (location != null) 'location': location,
          }
        },
      });

      if (response.data['errors'] != null) {
        throw ServerException(response.data['errors'][0]['message']);
      }

      return UserModel.fromJson(response.data['data']['updateProfile']);
    } on DioException catch (e) {
      final errorMessage =
          e.message ?? e.error?.toString() ?? 'Failed to update profile';
      throw ServerException(errorMessage);
    }
  }

  Future<AuthResponseModel> _executeGraphqlMutation(String query,
      Map<String, dynamic> variables, String operationName) async {
    _logger.i('ðŸš€ Executing GraphQL: $operationName\nVariables: $variables');
    try {
      final response = await dio.post('/graphql', data: {
        'query': query,
        'variables': variables,
      });

      _logger.d(
          'ðŸ“¥ GraphQL Response [$operationName]: ${response.statusCode}\nData: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['errors'] != null) {
          _logger
              .e('âŒ GraphQL Error: ${response.data['errors'][0]['message']}');
          throw ServerException(response.data['errors'][0]['message']);
        }
        _logger.i('âœ… GraphQL Success: $operationName');
        return AuthResponseModel.fromJson(response.data['data'][operationName]);
      } else {
        _logger.e('âŒ GraphQL Failed with status: ${response.statusCode}');
        throw ServerException(
            'Action failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e(
          'âŒ DioException in $operationName: ${e.message} | Error: ${e.error} | Type: ${e.type}\nResponse Data: ${e.response?.data}');
      final errorMessage = e.response?.data?['errors']?[0]?['message'] ??
          e.message ??
          e.error?.toString() ??
          'GraphQL request failed';
      throw ServerException(errorMessage);
    }
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
    if (country != null && country.trim().isNotEmpty)
      location['country'] = country.trim();
    if (latitude != null) location['latitude'] = latitude;
    if (longitude != null) location['longitude'] = longitude;
    if (neighborhood != null && neighborhood.trim().isNotEmpty)
      location['neighborhood'] = neighborhood.trim();
    return location;
  }

  /// Execute a GraphQL mutation that returns void (MessageResponse)
  Future<void> _executeGraphqlVoidMutation(String query,
      Map<String, dynamic> variables, String operationName) async {
    _logger.i('ðŸš€ Executing GraphQL: $operationName\nVariables: $variables');
    try {
      final response = await dio.post('/graphql', data: {
        'query': query,
        'variables': variables,
      });

      _logger.d(
          'ðŸ“¥ GraphQL Response [$operationName]: ${response.statusCode}\nData: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['errors'] != null) {
          _logger
              .e('âŒ GraphQL Error: ${response.data['errors'][0]['message']}');
          throw ServerException(response.data['errors'][0]['message']);
        }
        _logger.i('âœ… GraphQL Success: $operationName');
      } else {
        _logger.e('âŒ GraphQL Failed with status: ${response.statusCode}');
        throw ServerException(
            'Action failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e(
          'âŒ DioException in $operationName: ${e.message} | Error: ${e.error} | Type: ${e.type}\nResponse Data: ${e.response?.data}');
      final errorMessage = e.response?.data?['errors']?[0]?['message'] ??
          e.message ??
          e.error?.toString() ??
          'GraphQL request failed';
      throw ServerException(errorMessage);
    }
  }
}
