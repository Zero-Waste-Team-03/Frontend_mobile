import 'package:ferry/ferry.dart' hide ServerException;
import 'package:logger/logger.dart';

import '../device/device_id_provider.dart';
import '../exceptions/exceptions.dart';

class GraphqlRequestExecutor {
  GraphqlRequestExecutor(this._deviceIdProvider);

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

  Future<TData> execute<TData, TVars>({
    required Client client,
    required OperationRequest<TData, TVars> request,
    required String operationName,
    bool skipOptimisticResponse = false,
  }) async {
    _logger.i('Executing GraphQL operation: $operationName');

    try {
      await _deviceIdProvider.getOrCreateDeviceId();

      final response = await client.request(request).firstWhere((event) {
        final validSource =
            !skipOptimisticResponse ||
            event.dataSource != DataSource.Optimistic;
        final hasTerminalPayload =
            (event.data != null && !event.hasErrors) ||
            event.hasErrors ||
            event.linkException != null;
        return validSource && hasTerminalPayload;
      });

      if (response.hasErrors || response.linkException != null) {
        final graphQLErrors = response.graphqlErrors;
        final graphQLErrorMessage =
            graphQLErrors != null && graphQLErrors.isNotEmpty
            ? graphQLErrors.first.message
            : null;

        final linkExceptionMessage =
            response.linkException?.originalException?.toString() ??
            response.linkException?.toString() ??
            'Unknown link exception';

        final message = graphQLErrorMessage ?? linkExceptionMessage;

        throw ServerException('GraphQL error in $operationName: $message');
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
      throw ServerException('GraphQL request failed for $operationName: $e');
    }
  }
}
