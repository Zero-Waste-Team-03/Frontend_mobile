import 'package:ferry/ferry.dart' hide ServerException;

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
import '../../../donations/data/models/donation_model.dart';
import '../../domain/entities/favorite_donations_page.dart';
import 'graphql/__generated__/liked_donations.req.gql.dart';
import 'graphql/__generated__/liked_donations.var.gql.dart';
import 'graphql/__generated__/like_donation.req.gql.dart';
import 'graphql/__generated__/like_donation.var.gql.dart';
import 'graphql/__generated__/unlike_donation.req.gql.dart';
import 'graphql/__generated__/unlike_donation.var.gql.dart';

abstract class FavoritesRemoteDataSource {
  Future<FavoriteDonationsPage> getLikedDonations({
    int page = 1,
    int limit = 10,
  });

  Future<void> likeDonation(String donationId);

  Future<void> unlikeDonation(String donationId);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  FavoritesRemoteDataSourceImpl(
    this._ferryClient,
    this._graphqlRequestExecutor,
  );

  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;

  @override
  Future<FavoriteDonationsPage> getLikedDonations({
    int page = 1,
    int limit = 10,
  }) async {
    try {
      final vars = GLikedDonationsVars.fromJson({
        'pagination': {'page': page, 'limit': limit},
      });

      if (vars == null) {
        throw ServerException('Failed to build likedDonations request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GLikedDonationsReq(
          (b) => b
            ..vars = vars.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'likedDonations',
      );

      final items = data.likedDonations.items;

      final mapped = items == null
          ? <DonationModel>[]
          : items.map((item) {
              final json = Map<String, dynamic>.from(item.toJson());
              return DonationModel.fromJson(json);
            }).toList();

      return FavoriteDonationsPage(
        donations: mapped,
        hasNextPage: data.likedDonations.hasNextPage,
        hasPreviousPage: data.likedDonations.hasPreviousPage,
        limit: data.likedDonations.limit,
        page: data.likedDonations.page,
        totalCount: data.likedDonations.totalCount,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likeDonation(String donationId) async {
    final vars = GLikeDonationVars.fromJson({'donationId': donationId});
    if (vars == null) {
      throw ServerException('Failed to build likeDonation request');
    }

    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GLikeDonationReq(
        (b) => b
          ..vars = vars.toBuilder()
          ..fetchPolicy = FetchPolicy.NetworkOnly,
      ),
      operationName: 'likeDonation',
    );
  }

  @override
  Future<void> unlikeDonation(String donationId) async {
    final vars = GUnlikeDonationVars.fromJson({'donationId': donationId});
    if (vars == null) {
      throw ServerException('Failed to build unlikeDonation request');
    }

    await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GUnlikeDonationReq(
        (b) => b
          ..vars = vars.toBuilder()
          ..fetchPolicy = FetchPolicy.NetworkOnly,
      ),
      operationName: 'unlikeDonation',
    );
  }
}
