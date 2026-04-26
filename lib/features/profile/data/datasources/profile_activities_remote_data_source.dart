import 'package:injectable/injectable.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../donations/data/models/donation_model.dart';
import '../../domain/entities/profile_activities_page.dart';
import 'graphql/__generated__/get_myDonations.req.gql.dart';
import 'graphql/__generated__/get_myDonations.var.gql.dart';

abstract class ProfileActivitiesRemoteDataSource {
  Future<ProfileActivitiesPage> getUserActivities({
    required String userId,
    String? statusFilter,
    int page = 1,
    int limit = 10,
  });
}

@LazySingleton(as: ProfileActivitiesRemoteDataSource)
class ProfileActivitiesRemoteDataSourceImpl
    implements ProfileActivitiesRemoteDataSource {
  ProfileActivitiesRemoteDataSourceImpl(this._ferryClient);

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
  Future<ProfileActivitiesPage> getUserActivities({
    required String userId,
    String? statusFilter,
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final normalizedStatus = statusFilter?.trim().toUpperCase();

      final variables = <String, dynamic>{
        'pagination': {'page': page, 'limit': limit},
        if (normalizedStatus != null && normalizedStatus.isNotEmpty)
          'filter': {'status': normalizedStatus},
      };

      _logger.i(
        'ProfileActivitiesRemoteDataSource: Fetching myDonations with filter=$normalizedStatus',
      );

      final vars = GMyDonationsVars.fromJson(variables);
      if (vars == null) {
        throw ServerException('Failed to build myDonations request');
      }

      final data = await _executeRequest(
        GMyDonationsReq(
          (b) => b
            ..vars = vars.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        'myDonations',
      );

      final items = data.myDonations.items;

      final mapped = items == null
          ? <DonationModel>[]
          : items
                .map(
                  (item) => DonationModel.fromJson(
                    Map<String, dynamic>.from(item.toJson()),
                  ),
                )
                .toList();

      _logger.i(
        'ProfileActivitiesRemoteDataSource: Retrieved ${mapped.length} activity item(s)',
      );

      return ProfileActivitiesPage(
        activities: mapped,
        hasNextPage: data.myDonations.hasNextPage,
        hasPreviousPage: data.myDonations.hasPreviousPage,
        limit: data.myDonations.limit,
        page: data.myDonations.page,
        totalCount: data.myDonations.totalCount,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to fetch myDonations: $e');
    }
  }

  Future<TData> _executeRequest<TData, TVars>(
    OperationRequest<TData, TVars> request,
    String operationName,
  ) async {
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
        final graphQLErrorMessage =
            response.graphqlErrors != null && response.graphqlErrors!.isNotEmpty
            ? response.graphqlErrors!.first.message
            : null;

        final message =
            graphQLErrorMessage ??
            response.linkException?.originalException?.toString() ??
            response.linkException.toString();

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
