import 'package:injectable/injectable.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
import '../../domain/entities/verification_requests_page.dart';
import '../models/verification_request_model.dart';
import 'graphql/__generated__/get_verification_requests.req.gql.dart';
import 'graphql/__generated__/get_verification_requests.var.gql.dart';
import 'graphql/__generated__/update_verification_status.req.gql.dart';
import 'graphql/__generated__/update_verification_status.var.gql.dart';
import 'graphql/__generated__/verification_search.req.gql.dart';
import 'graphql/__generated__/verification_search.var.gql.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../../core/graphql/__generated__/schema.schema.gql.dart';
import '../../domain/entities/verification_request.dart';

abstract class VerificationRemoteDataSource {
  Future<VerificationRequestsPage> getSentVerificationRequests({
    int page = 1,
    int limit = 10,
  });

  Future<VerificationRequestsPage> getVerificationRequestsForFoodSaver({
    int page = 1,
    int limit = 10,
    String? search,
  });

  Future<VerificationRequestModel> updateVerificationRequestStatus({
    required String id,
    required VerificationRequestStatus status,
  });

  Future<List<User>> searchUsersToVerify({
    required int page,
    required int limit,
    String? search,
  });

  Future<VerificationRequestModel> createVerificationRequest({
    required String targetFoodSaverId,
  });
}

@LazySingleton(as: VerificationRemoteDataSource)
class VerificationRemoteDataSourceImpl implements VerificationRemoteDataSource {
  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;

  VerificationRemoteDataSourceImpl(
    this._ferryClient,
    this._graphqlRequestExecutor,
  );

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
  Future<VerificationRequestsPage> getSentVerificationRequests({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      _logger.i('VerificationRemoteDataSource: Fetching sent verification requests (page: $page)');

      final variables = GGetSentVerificationRequestsVars((b) => b
        ..pagination.page = page
        ..pagination.limit = limit);

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GGetSentVerificationRequestsReq(
          (b) => b
            ..vars = variables.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'getSentVerificationRequests',
      );

      final result = data.getSentVerificationRequests;
      final items = result.items
              ?.map((item) => VerificationRequestModel.fromJson(
                    Map<String, dynamic>.from(item.toJson()),
                  ))
              .toList() ??
          [];

      return VerificationRequestsPage(
        requests: items,
        hasNextPage: result.hasNextPage,
        hasPreviousPage: result.hasPreviousPage,
        limit: result.limit,
        page: result.page,
        totalCount: result.totalCount,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to fetch sent verification requests: $e');
    }
  }

  @override
  Future<VerificationRequestsPage> getVerificationRequestsForFoodSaver({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    try {
      _logger.i('VerificationRemoteDataSource: Fetching verification requests for food saver (page: $page)');

      final variables = GGetVerificationRequestsForFoodSaverVars((b) => b
        ..pagination.page = page
        ..pagination.limit = limit
        ..search = search);

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GGetVerificationRequestsForFoodSaverReq(
          (b) => b
            ..vars = variables.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'getVerificationRequestsForFoodSaver',
      );

      final result = data.getVerificationRequestsForFoodSaver;
      final items = result.items
              ?.map((item) => VerificationRequestModel.fromJson(
                    Map<String, dynamic>.from(item.toJson()),
                  ))
              .toList() ??
          [];

      return VerificationRequestsPage(
        requests: items,
        hasNextPage: result.hasNextPage,
        hasPreviousPage: result.hasPreviousPage,
        limit: result.limit,
        page: result.page,
        totalCount: result.totalCount,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to fetch food saver verification requests: $e');
    }
  }

  @override
  Future<VerificationRequestModel> updateVerificationRequestStatus({
    required String id,
    required VerificationRequestStatus status,
  }) async {
    try {
      _logger.i('VerificationRemoteDataSource: Updating verification request status (id: $id, status: $status)');

      final gStatus = status == VerificationRequestStatus.approved
          ? GVerficationStatusUpdateEnum.APPROVED
          : GVerficationStatusUpdateEnum.REJECTED;

      final variables = GUpdateVerificationRequestStatusVars((b) => b
        ..input.id = id
        ..input.status = gStatus);

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GUpdateVerificationRequestStatusReq(
          (b) => b
            ..vars = variables.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'updateVerificationRequestStatus',
      );

      final result = data.updateVerificationRequestStatus;
      return VerificationRequestModel.fromJson(
        Map<String, dynamic>.from(result.toJson()),
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to update verification request status: $e');
    }
  }

  @override
  Future<List<User>> searchUsersToVerify({
    required int page,
    required int limit,
    String? search,
  }) async {
    try {
      _logger.i('VerificationRemoteDataSource: Searching users (page: $page, search: $search)');

      final variables = GGetUsersFromSameNeighborhoodVars((b) => b
        ..pagination.page = page
        ..pagination.limit = limit
        ..search = search);

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GGetUsersFromSameNeighborhoodReq(
          (b) => b
            ..vars = variables.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'getUsersFromSameNeighborhood',
      );

      final result = data.getUsersFromSameNeighborhood;
      _logger.i('VerificationRemoteDataSource: Received ${result.items?.length ?? 0} users from same neighborhood. Total: ${result.totalCount}');
      return result.items
              ?.map((item) => UserModel.fromJson(
                    Map<String, dynamic>.from(item.toJson()),
                  ).toEntity())
              .toList() ??
          [];
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to search users: $e');
    }
  }

  @override
  Future<VerificationRequestModel> createVerificationRequest({
    required String targetFoodSaverId,
  }) async {
    try {
      _logger.i('VerificationRemoteDataSource: Creating verification request for: $targetFoodSaverId');

      final variables = GCreateVerificationRequestVars((b) => b
        ..targetFoodSaverId = targetFoodSaverId);

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GCreateVerificationRequestReq(
          (b) => b
            ..vars = variables.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'createVerificationRequest',
      );

      final result = data.createVerificationRequest;
      return VerificationRequestModel.fromJson(
        Map<String, dynamic>.from(result.toJson()),
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to create verification request: $e');
    }
  }
}
