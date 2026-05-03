import 'package:ferry/ferry.dart' hide ServerException;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
import 'graphql/__generated__/register_fcm_token.req.gql.dart';
import 'graphql/__generated__/register_fcm_token.var.gql.dart';

/// Abstract data source for FCM token operations
abstract class FcmTokenRemoteDataSource {
  /// Register FCM token with backend
  /// Throws [ServerException] if registration fails
  Future<String> registerFcmToken(String fcmToken);
}

/// Implementation of FCM token data source with comprehensive logging and error handling
@LazySingleton(as: FcmTokenRemoteDataSource)
class FcmTokenRemoteDataSourceImpl implements FcmTokenRemoteDataSource {
  FcmTokenRemoteDataSourceImpl(this._ferryClient, this._graphqlRequestExecutor);

  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  @override
  Future<String> registerFcmToken(String fcmToken) async {
    _logger.i(
      '📤 FcmTokenRemoteDataSourceImpl: Attempting to register FCM token...',
    );
    final tokenPreview = fcmToken.length > 20
        ? fcmToken.substring(fcmToken.length - 20)
        : fcmToken;
    _logger.d(
      '📱 FcmTokenRemoteDataSourceImpl: Token (last 20 chars): ...$tokenPreview',
    );

    if (fcmToken.isEmpty) {
      _logger.e('❌ FcmTokenRemoteDataSourceImpl: FCM token is empty');
      throw ServerException('FCM token cannot be empty');
    }

    try {
      _logger.i(
        '📋 FcmTokenRemoteDataSourceImpl: Building registerFcmToken request...',
      );

      final varsMap = <String, dynamic>{'fcmToken': fcmToken};
      _logger.d('🔧 FcmTokenRemoteDataSourceImpl: Variables: $varsMap');

      final vars = GRegisterFcmTokenVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e(
          '❌ FcmTokenRemoteDataSourceImpl: Failed to build registerFcmToken variables from: $varsMap',
        );
        throw ServerException('Failed to build register FCM token request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GRegisterFcmTokenReq(
          (b) => b
            ..vars = vars.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly
            ..requestId =
                'registerFcmToken-${DateTime.now().microsecondsSinceEpoch}',
        ),
        operationName: 'registerFcmToken',
      );

      final registeredMessage = data.registerFcmToken.message;
      _logger.i(
        '✅ FcmTokenRemoteDataSourceImpl: FCM token registered successfully: $registeredMessage',
      );

      return registeredMessage;
    } catch (e, stackTrace) {
      _logger.e(
        '❌ FcmTokenRemoteDataSourceImpl: Error registering FCM token',
        error: e,
        stackTrace: stackTrace,
      );

      if (e is ServerException) {
        rethrow;
      }

      throw ServerException('Failed to register FCM token: ${e.toString()}');
    }
  }
}
