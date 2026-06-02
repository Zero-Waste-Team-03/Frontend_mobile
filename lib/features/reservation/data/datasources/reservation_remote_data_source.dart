import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
import '../models/reservation_model.dart';
import 'graphql/__generated__/confirm_reservation.req.gql.dart';
import 'graphql/__generated__/confirm_reservation.var.gql.dart';
import 'graphql/__generated__/my_reservation.req.gql.dart';
import 'graphql/__generated__/my_reservation.var.gql.dart';
import 'graphql/__generated__/my_reservations.req.gql.dart';
import 'graphql/__generated__/my_reservations.var.gql.dart';
import 'graphql/__generated__/reserve_donation.req.gql.dart';
import 'graphql/__generated__/reserve_donation.var.gql.dart';

abstract class ReservationRemoteDataSource {
  /// Create a reservation for a donation (GraphQL mutation)
  Future<ReservationModel> createReservation({
    required String donationId,
    required int quantity,
  });

  /// Get user reservations
  Future<List<ReservationModel>> getUserReservations({
    required String userId,
    String? roleFilter,
    String? statusFilter,
    int page = 1,
    int limit = 20,
  });

  /// Mark reservation as confirmed (Donor action)
  Future<ReservationModel> confirmReservation(String reservationId);

  /// Get a single reservation details by id.
  Future<ReservationModel> getReservationDetails(String reservationId);

  /// Mark reservation as picked up
  Future<ReservationModel> markAsPickedUp(String reservationId);

  /// Cancel a reservation (only for ACTIVE reservations)
  Future<ReservationModel> cancelReservation(String reservationId);
}

class ReservationRemoteDataSourceImpl implements ReservationRemoteDataSource {
  final Dio dio;
  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;

  ReservationRemoteDataSourceImpl(
    this.dio,
    this._ferryClient,
    this._graphqlRequestExecutor,
  );

  @override
  Future<ReservationModel> createReservation({
    required String donationId,
    required int quantity,
  }) async {
    final vars = GReserveDonationVars.fromJson({
      'donationId': donationId,
      'quantity': quantity,
    });
    if (vars == null) {
      throw ServerException('Failed to build reserveDonation request');
    }

    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GReserveDonationReq((b) => b.vars = vars.toBuilder()),
      operationName: 'reserveDonation',
    );

    return ReservationModel.fromJson(
      Map<String, dynamic>.from(data.reserveDonation.toJson()),
    );
  }

  @override
  Future<List<ReservationModel>> getUserReservations({
    required String userId,
    String? roleFilter,
    String? statusFilter,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // Note: The myReservations query returns current user's reservations
      // userId parameter is kept for compatibility but not used in the GraphQL call
      final normalizedRole = roleFilter?.trim().toUpperCase();
      final normalizedStatus = statusFilter?.trim().toUpperCase();

      final filter = <String, dynamic>{
        if (normalizedRole != null && normalizedRole.isNotEmpty)
          'roleFilter': normalizedRole,
        if (normalizedStatus != null && normalizedStatus.isNotEmpty)
          'status': normalizedStatus,
      };

      final vars = GMyReservationsVars.fromJson({
        'pagination': {'page': page, 'limit': limit},
        if (filter.isNotEmpty) 'filter': filter,
      });
      if (vars == null) {
        throw ServerException('Failed to build myReservations request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GMyReservationsReq(
          (b) => b
            ..vars = vars.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'myReservations',
      );

      final items = data.myReservations.items;
      if (items == null || items.isEmpty) {
        return [];
      }

      final reservations = items
          .map(
            (item) => ReservationModel.fromJson(
              Map<String, dynamic>.from(item.toJson()),
            ),
          )
          .toList();

      return reservations;
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException('Failed to fetch user reservations: $e');
    }
  }

  @override
  Future<ReservationModel> confirmReservation(String reservationId) async {
    final vars = GConfirmReservationVars.fromJson({'id': reservationId});
    if (vars == null) {
      throw ServerException('Failed to build confirmReservation request');
    }

    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GConfirmReservationReq((b) => b.vars = vars.toBuilder()),
      operationName: 'confirmReservation',
    );

    return ReservationModel.fromJson(
      Map<String, dynamic>.from(data.confirmReservation.toJson()),
    );
  }

  @override
  Future<ReservationModel> getReservationDetails(String reservationId) async {
    final vars = GMyReservationVars.fromJson({'id': reservationId});
    if (vars == null) {
      throw ServerException('Failed to build myReservation request');
    }

    try {
      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GMyReservationReq(
          (b) => b
            ..vars = vars.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'myReservation',
      );

      final responseJson = data.myReservation.toJson();

      final model = ReservationModel.fromJson(
        Map<String, dynamic>.from(responseJson),
      );

      return model;
    } on ServerException catch (e) {
      print('ServerException in getReservationDetails: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error fetching reservation: $e');
      throw ServerException('Error fetching reservation: $e');
    }
  }

  @override
  Future<ReservationModel> markAsPickedUp(String reservationId) async {
    // Temporary fallback until a dedicated pickup mutation is available in schema.
    final mutation = '''
      mutation confirmReservationCompleted(\$reservationId: ID!) {
        confirmReservationCompleted(reservationId: \$reservationId) {
          id
          donationId
          beneficiaryId
          status
          createdAt
          confirmedAt
          updatedAt
        }
      }
    ''';

    try {
      final response = await dio.post(
        '/graphql',
        data: {
          'query': mutation,
          'variables': {'reservationId': reservationId},
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to mark as picked up (${response.statusCode})',
        );
      }

      if (response.data['errors'] != null) {
        final errors = response.data['errors'] as List;
        final errorMessage = errors.isNotEmpty
            ? errors.first['message'] ?? 'Failed to mark as picked up'
            : 'Unknown error occurred';
        throw ServerException(errorMessage);
      }

      if (response.data['data'] == null ||
          response.data['data']['confirmReservationCompleted'] == null) {
        throw ServerException('Invalid response format');
      }

      return ReservationModel.fromJson(
        response.data['data']['confirmReservationCompleted']
            as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReservationModel> cancelReservation(String reservationId) async {
    // Use raw GraphQL mutation until generated code is available
    final mutation = '''
      mutation cancelReservation(\$id: ID!) {
        cancelReservation(id: \$id) {
          id
          donationId
          beneficiaryId
          status
          createdAt
          confirmedAt
          updatedAt
        }
      }
    ''';

    try {
      final response = await dio.post(
        '/graphql',
        data: {
          'query': mutation,
          'variables': {'id': reservationId},
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to cancel reservation (${response.statusCode})',
        );
      }

      if (response.data['errors'] != null) {
        final errors = response.data['errors'] as List;
        final errorMessage = errors.isNotEmpty
            ? errors.first['message'] ?? 'Failed to cancel reservation'
            : 'Unknown error occurred';
        throw ServerException(errorMessage);
      }

      if (response.data['data'] == null ||
          response.data['data']['cancelReservation'] == null) {
        throw ServerException('Invalid response format');
      }

      return ReservationModel.fromJson(
        response.data['data']['cancelReservation'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Network error');
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
