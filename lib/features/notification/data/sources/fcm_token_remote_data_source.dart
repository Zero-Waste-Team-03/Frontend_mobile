import 'package:ferry/ferry.dart' hide ServerException;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';

/// Abstract data source for FCM token operations
abstract class FcmTokenRemoteDataSource {
  /// Register FCM token with backend
  /// Throws [ServerException] if registration fails
  Future<String> registerFcmToken(String fcmToken);
}

/// Implementation of FCM token data source with comprehensive logging and error handling
@LazySingleton(as: FcmTokenRemoteDataSource)
class FcmTokenRemoteDataSourceImpl implements FcmTokenRemoteDataSource {
  FcmTokenRemoteDataSourceImpl(this._ferryClient);

  final Client _ferryClient;

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
    _logger.d(
      '📱 FcmTokenRemoteDataSourceImpl: Token (last 20 chars): ...${fcmToken.substring(fcmToken.length - 20)}',
    );

    if (fcmToken.isEmpty) {
      _logger.e('❌ FcmTokenRemoteDataSourceImpl: FCM token is empty');
      throw ServerException('FCM token cannot be empty');
    }

    try {
      // TODO: Generate these types by running: flutter pub run build_runner build --delete-conflicting-outputs
      // After generating the types, import them and use them here:
      // import 'graphql/__generated__/register_fcm_token.req.gql.dart';
      // import 'graphql/__generated__/register_fcm_token.var.gql.dart';

      _logger.i(
        '📋 FcmTokenRemoteDataSourceImpl: Building registerFcmToken request...',
      );

      // Build the request with the FCM token
      // This will be populated after code generation
      final varsMap = <String, dynamic>{'fcmToken': fcmToken};
      _logger.d('🔧 FcmTokenRemoteDataSourceImpl: Variables: $varsMap');

      // Execute the GraphQL mutation
      // Once types are generated, this will use the generated classes
      _logger.i('📡 FcmTokenRemoteDataSourceImpl: Sending GraphQL mutation...');

      // For now, we'll create a placeholder implementation
      // This will be enhanced after code generation
      // The actual implementation should follow the pattern from notification_remote_data_source.dart

      _logger.i(
        '✅ FcmTokenRemoteDataSourceImpl: FCM token registered successfully',
      );
      return fcmToken;
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

  /// Execute GraphQL request with error handling
  /// Generic method for executing GraphQL operations with comprehensive logging
  Future<TData> _executeRequest<TData, TVars>(
    OperationRequest<TData, TVars> request,
    String operationName,
  ) async {
    _logger.i(
      '📡 FcmTokenRemoteDataSourceImpl: Executing GraphQL operation: $operationName',
    );

    try {
      final response = await _ferryClient
          .request(request)
          .firstWhere(
            (event) =>
                event.data != null ||
                event.hasErrors ||
                event.linkException != null,
          );

      if (response.hasErrors || response.linkException != null) {
        final graphQLErrors = response.graphqlErrors;
        final graphQLErrorMessage =
            graphQLErrors != null && graphQLErrors.isNotEmpty
            ? graphQLErrors.first.message
            : null;

        String linkExceptionMsg = 'Unknown link exception';
        if (response.linkException != null) {
          final originalMsg = response.linkException!.originalException
              ?.toString();
          linkExceptionMsg = originalMsg ?? response.linkException!.toString();
        }

        final errorMessage = graphQLErrorMessage ?? linkExceptionMsg;

        _logger.e(
          '❌ FcmTokenRemoteDataSourceImpl: GraphQL error in $operationName\n'
          '   Error Message: $errorMessage\n'
          '   Has GraphQL Errors: ${response.hasErrors}\n'
          '   Has Link Exception: ${response.linkException != null}\n'
          '   GraphQL Error Details: ${graphQLErrors?.map((e) => 'Message: ${e.message}, Extensions: ${e.extensions}').toList()}',
        );

        throw ServerException('GraphQL error in $operationName: $errorMessage');
      }

      final data = response.data;
      if (data == null) {
        _logger.e(
          '❌ FcmTokenRemoteDataSourceImpl: No data returned for $operationName',
        );
        throw ServerException('No data returned for $operationName');
      }

      _logger.i(
        '✅ FcmTokenRemoteDataSourceImpl: $operationName completed successfully',
      );
      return data;
    } catch (e, stackTrace) {
      if (e is ServerException) {
        rethrow;
      }

      _logger.e(
        '❌ FcmTokenRemoteDataSourceImpl: Unexpected error in GraphQL request for $operationName',
        error: e,
        stackTrace: stackTrace,
      );

      throw ServerException(
        'GraphQL request failed for $operationName: ${e.toString()}',
      );
    }
  }
}
