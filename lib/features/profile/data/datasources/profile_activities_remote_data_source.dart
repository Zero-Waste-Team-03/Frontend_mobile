import 'package:injectable/injectable.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
import '../../../donations/data/models/donation_model.dart';
import '../../domain/entities/profile_activities_page.dart';
import 'graphql/__generated__/get_myDonations.req.gql.dart';
import 'graphql/__generated__/get_myDonations.var.gql.dart';
import 'graphql/__generated__/get_myDonationsState.req.gql.dart';

abstract class ProfileActivitiesRemoteDataSource {
  Future<ProfileActivitiesPage> getUserActivities({
    required String userId,
    String? statusFilter,
    int page = 1,
    int limit = 10,
  });

  Future<DonationsStateDto> getDonationsStats();
}

@LazySingleton(as: ProfileActivitiesRemoteDataSource)
class ProfileActivitiesRemoteDataSourceImpl
    implements ProfileActivitiesRemoteDataSource {
  ProfileActivitiesRemoteDataSourceImpl(
    this._ferryClient,
    this._graphqlRequestExecutor,
  );

  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;

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

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GMyDonationsReq(
          (b) => b
            ..vars = vars.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'myDonations',
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

  @override
  Future<DonationsStateDto> getDonationsStats() async {
    try {
      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GmyDonationsStatsReq(
          (b) => b..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'myDonationsStats',
      );

      final stats = data.myDonationsStats;

      final liked = stats.likedDonations ;
      final total = stats.totalDonations ;
      return DonationsStateDto(
        likedDonations: liked.toDouble(),
        totalDonations: total.toDouble(),
      );
    } on ServerException  catch (e) {
      throw ServerException('Failed to fetch donations stats: $e');
    }
  }
}

class DonationsStateDto {
  final double likedDonations;
  final double totalDonations;

  DonationsStateDto({
    required this.likedDonations,
    required this.totalDonations,
  });
}
