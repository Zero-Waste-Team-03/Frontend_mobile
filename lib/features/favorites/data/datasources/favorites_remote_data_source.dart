import 'package:ferry/ferry.dart' hide ServerException;
import 'package:ferry_exec/ferry_exec.dart' show FetchPolicy;
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
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
  FavoritesRemoteDataSourceImpl(this._ferryClient);

  final Client _ferryClient;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  @override
Future<FavoriteDonationsPage> getLikedDonations({
  int page = 1,
  int limit = 10,
}) async {
  try {
    print('getLikedDonations started');
    print('Input params => page: $page, limit: $limit');

    final vars = GLikedDonationsVars.fromJson({
      'pagination': {'page': page, 'limit': limit},
    });

    print('Vars created => $vars');

    if (vars == null) {
      print('Vars creation failed');
      throw ServerException('Failed to build likedDonations request');
    }

    print('Sending request...');

    final data = await _executeRequest(
      GLikedDonationsReq(
        (b) => b
          ..vars = vars.toBuilder()
          ..fetchPolicy = FetchPolicy.NetworkOnly,
      ),
      'likedDonations',
    );

    print('Request success');
    print(
      'Response meta => page: ${data.likedDonations.page}, '
      'limit: ${data.likedDonations.limit}, '
      'totalCount: ${data.likedDonations.totalCount}, '
      'hasNextPage: ${data.likedDonations.hasNextPage}, '
      'hasPreviousPage: ${data.likedDonations.hasPreviousPage}',
    );

    final items = data.likedDonations.items;

    print('Raw items count => ${items?.length ?? 0}');

    final mapped = items == null
        ? <DonationModel>[]
        : items
            .map((item) {
              final json = Map<String, dynamic>.from(item.toJson());
              print('Mapping donation => $json');
              return DonationModel.fromJson(json);
            })
            .toList();

    print('Mapped donations count => ${mapped.length}');
    print('getLikedDonations completed successfully');

    return FavoriteDonationsPage(
      donations: mapped,
      hasNextPage: data.likedDonations.hasNextPage,
      hasPreviousPage: data.likedDonations.hasPreviousPage,
      limit: data.likedDonations.limit,
      page: data.likedDonations.page,
      totalCount: data.likedDonations.totalCount,
    );
  } catch (e, stackTrace) {
    print('getLikedDonations failed');
    print('Error => $e');
    print('StackTrace => $stackTrace');
    rethrow;
  }
}

  @override
  Future<void> likeDonation(String donationId) async {
    final vars = GLikeDonationVars.fromJson({'donationId': donationId});
    if (vars == null) {
      throw ServerException('Failed to build likeDonation request');
    }

    await _executeRequest(
      GLikeDonationReq(
        (b) => b
          ..vars = vars.toBuilder()
          ..fetchPolicy = FetchPolicy.NetworkOnly,
      ),
      'likeDonation',
    );
  }

  @override
  Future<void> unlikeDonation(String donationId) async {
    final vars = GUnlikeDonationVars.fromJson({'donationId': donationId});
    if (vars == null) {
      throw ServerException('Failed to build unlikeDonation request');
    }

    await _executeRequest(
      GUnlikeDonationReq(
        (b) => b
          ..vars = vars.toBuilder()
          ..fetchPolicy = FetchPolicy.NetworkOnly,
      ),
      'unlikeDonation',
    );
  }

 Future<TData> _executeRequest<TData, TVars>(
  OperationRequest<TData, TVars> request,
  String operationName,
) async {
  _logger.i('================================================');
  _logger.i('Executing GraphQL operation: $operationName');
  _logger.i('Request type: ${request.runtimeType}');
  _logger.i('Vars: ${request.vars}');
  _logger.i('Fetch policy: ${request.fetchPolicy}');
  _logger.i('================================================');

  try {
    final response = await _ferryClient.request(request).firstWhere(
      (event) =>
          event.data != null ||
          event.hasErrors ||
          event.linkException != null,
    );

    _logger.i('Response received for $operationName');
    _logger.i('Has errors: ${response.hasErrors}');
    _logger.i('Has data: ${response.data != null}');
    _logger.i('Link exception: ${response.linkException}');
    _logger.i('GraphQL errors count: ${response.graphqlErrors?.length ?? 0}');

    if (response.graphqlErrors != null &&
        response.graphqlErrors!.isNotEmpty) {
      for (var i = 0; i < response.graphqlErrors!.length; i++) {
        final err = response.graphqlErrors![i];
        _logger.e('GraphQL Error [$i]');
        _logger.e('Message: ${err.message}');
        _logger.e('Path: ${err.path}');
        _logger.e('Locations: ${err.locations}');
        _logger.e('Extensions: ${err.extensions}');
      }
    }

    if (response.linkException != null) {
      _logger.e('LinkException type: ${response.linkException.runtimeType}');
      _logger.e(
        'Original exception: ${response.linkException?.originalException}',
      );
      _logger.e('LinkException full: ${response.linkException}');
    }

    if (response.hasErrors || response.linkException != null) {
      final graphQLErrorMessage =
          response.graphqlErrors != null &&
              response.graphqlErrors!.isNotEmpty
          ? response.graphqlErrors!.first.message
          : null;

      final message =
          graphQLErrorMessage ??
          response.linkException?.originalException?.toString() ??
          response.linkException.toString();

      _logger.e('Operation failed: $operationName');
      _logger.e('Resolved error message: $message');

      throw ServerException('GraphQL error in $operationName: $message');
    }

    final data = response.data;

    if (data == null) {
      _logger.e('No data returned for $operationName');
      throw ServerException('No data returned for $operationName');
    }

    _logger.i('Operation succeeded: $operationName');
    _logger.i('Returned data type: ${data.runtimeType}');
    _logger.i('================================================');

    return data;
  } catch (e, stackTrace) {
    _logger.e('Unhandled exception in $operationName');
    _logger.e('Error: $e');
    _logger.e('StackTrace: $stackTrace');

    if (e is ServerException) {
      rethrow;
    }

    throw ServerException(
      'GraphQL request failed for $operationName: $e',
    );
  }
}
}