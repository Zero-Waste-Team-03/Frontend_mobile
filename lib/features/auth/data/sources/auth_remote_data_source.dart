import 'package:dio/dio.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/auth_response_model.dart';
import '../models/user_model.dart';
import 'package:logger/logger.dart';

import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> login(String email, String password);
  Future<void> sendOtp(String email);
  Future<AuthResponseModel> register(String name, String email, String password, String otp);
  Future<AuthResponseModel> oAuthLogin(String provider, String accessToken);
  Future<UserModel> getCurrentUser();
  Future<void> changePassword(String oldPassword, String newPassword);
  Future<void> resetPassword(String email);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
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
            id
            email
            name
          }
        }
      }
    ''';
    
    return _executeGraphqlMutation(query, {
      'loginInput': {
        'email': email,
        'password': password,
      }
    }, 'login');
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
    await _executeGraphqlMutation(query, {
      'email': email,
    }, 'sendVerification');
  }

  @override
  Future<AuthResponseModel> register(String name, String email, String password, String otp) async {
    const query = '''
      mutation Register(\$otp: String!, \$registerInput: RegisterInput!) {
        register(otp: \$otp, registerInput: \$registerInput) {
          message
        }
      }
    ''';
    
    return _executeGraphqlMutation(query, {
      'otp': otp,
      'registerInput': {
        'name': name,
        'email': email,
        'password': password,
      }
    }, 'register');
  }

  @override
  Future<AuthResponseModel> oAuthLogin(String provider, String accessToken) async {
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
      final errorMessage = e.response?.data?['message'] ?? e.message ?? e.error?.toString() ?? 'OAuth request failed';
      throw ServerException(errorMessage);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    const query = '''
      query GetCurrentUser {
        me {
          id
          email
          name
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
      
      return UserModel.fromJson(response.data['data']['me']);
    } on DioException catch (e) {
      final errorMessage = e.message ?? e.error?.toString() ?? 'Failed to get user';
      throw ServerException(errorMessage);
    }
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    const query = '''
      mutation ChangePassword(\$changePasswordInput: ChangePasswordInput!) {
        changePassword(changePasswordInput: \$changePasswordInput) {
          message
        }
      }
    ''';
    await _executeGraphqlMutation(query, {
      'changePasswordInput': {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }
    }, 'changePassword');
  }

  @override
  Future<void> resetPassword(String email) async {
    const query = '''
      mutation ResetPassword(\$resetPasswordInput: ResetPasswordInput!) {
        resetPassword(resetPasswordInput: \$resetPasswordInput) {
          message
        }
      }
    ''';
    await _executeGraphqlMutation(query, {
      'resetPasswordInput': {
        'email': email,
      }
    }, 'resetPassword');
  }

  Future<AuthResponseModel> _executeGraphqlMutation(String query, Map<String, dynamic> variables, String operationName) async {
    _logger.i('🚀 Executing GraphQL: $operationName\nVariables: $variables');
    try {
      final response = await dio.post('/graphql', data: {
        'query': query,
        'variables': variables,
      });

      _logger.d('📥 GraphQL Response [$operationName]: ${response.statusCode}\nData: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data['errors'] != null) {
          _logger.e('❌ GraphQL Error: ${response.data['errors'][0]['message']}');
          throw ServerException(response.data['errors'][0]['message']);
        }
        _logger.i('✅ GraphQL Success: $operationName');
        return AuthResponseModel.fromJson(response.data['data'][operationName]);
      } else {
        _logger.e('❌ GraphQL Failed with status: ${response.statusCode}');
        throw ServerException('Action failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      _logger.e('❌ DioException in $operationName: ${e.message} | Error: ${e.error} | Type: ${e.type}\nResponse Data: ${e.response?.data}');
      final errorMessage = e.response?.data?['errors']?[0]?['message'] ?? e.message ?? e.error?.toString() ?? 'GraphQL request failed';
      throw ServerException(errorMessage);
    }
  }
}
