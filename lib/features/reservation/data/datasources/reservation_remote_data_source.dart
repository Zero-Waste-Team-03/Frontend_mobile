import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/reservation.dart';
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
  Future<ReservationModel> createReservation({required String donationId});

  /// Get user reservations
  Future<List<ReservationModel>> getUserReservations({
    required String userId,
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
}

class ReservationRemoteDataSourceImpl implements ReservationRemoteDataSource {
  final Dio dio;
  final Client _ferryClient;

  ReservationRemoteDataSourceImpl(this.dio, this._ferryClient);

  @override
  Future<ReservationModel> createReservation({
    required String donationId,
  }) async {
    final vars = GReserveDonationVars.fromJson({'donationId': donationId});
    if (vars == null) {
      throw ServerException('Failed to build reserveDonation request');
    }

    final data = await _executeRequest(
      GReserveDonationReq((b) => b.vars = vars.toBuilder()),
      'reserveDonation',
    );

    return ReservationModel.fromJson(
      Map<String, dynamic>.from(data.reserveDonation.toJson()),
    );
  }

  @override
  Future<List<ReservationModel>> getUserReservations({
    required String userId,
    String? statusFilter,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      // Note: The myReservations query returns current user's reservations
      // userId parameter is kept for compatibility but not used in the GraphQL call
      final vars = GMyReservationsVars.fromJson({
        'pagination': {'page': page, 'limit': limit},
      });
      if (vars == null) {
        throw ServerException('Failed to build myReservations request');
      }

      final data = await _executeRequest(
        GMyReservationsReq((b) => b.vars = vars.toBuilder()),
        'myReservations',
      );

      final items = data.myReservations.items;
      if (items == null || items.isEmpty) {
        return [];
      }

      var reservations = items
          .map(
            (item) => ReservationModel.fromJson(
              Map<String, dynamic>.from(item.toJson()),
            ),
          )
          .toList();

      final normalizedStatus = statusFilter?.trim().toUpperCase();
      if (normalizedStatus != null && normalizedStatus.isNotEmpty) {
        final status = ReservationStatusExt.fromString(normalizedStatus);
        reservations = reservations
            .where((reservation) => reservation.status == status)
            .toList();
      }

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

    final data = await _executeRequest(
      GConfirmReservationReq((b) => b.vars = vars.toBuilder()),
      'confirmReservation',
    );

    return ReservationModel.fromJson(
      Map<String, dynamic>.from(data.confirmReservation.toJson()),
    );
  }

  @override
  Future<ReservationModel> getReservationDetails(String reservationId) async {
    print(
      '[ReservationRemoteDataSource] getReservationDetails() called with ID: $reservationId',
    );

    final vars = GMyReservationVars.fromJson({'id': reservationId});
    if (vars == null) {
      print(
        '[ReservationRemoteDataSource] ERROR: Failed to build myReservation request',
      );
      throw ServerException('Failed to build myReservation request');
    }

    try {
      print(
        '[ReservationRemoteDataSource] Executing GraphQL query: myReservation',
      );
      final data = await _executeRequest(
        GMyReservationReq((b) => b.vars = vars.toBuilder()),
        'myReservation',
      );

      print('[ReservationRemoteDataSource] GraphQL response received');
      final responseJson = data.myReservation.toJson();
      print(
        '[ReservationRemoteDataSource] Parsing response to ReservationModel...',
      );
      final model = ReservationModel.fromJson(
        Map<String, dynamic>.from(responseJson),
      );
      print(
        '[ReservationRemoteDataSource] SUCCESS: Reservation model created with ID: ${model.id}',
      );
      return model;
    } on ServerException catch (e) {
      print(
        '[ReservationRemoteDataSource] ServerException caught: ${e.message}',
      );
      rethrow;
    } catch (e) {
      print(
        '[ReservationRemoteDataSource] Unexpected error: ${e.runtimeType} - $e',
      );
      throw ServerException('Error fetching reservation: $e');
    }
  }

  @override
  Future<ReservationModel> markAsPickedUp(String reservationId) async {
    // Temporary fallback until a dedicated pickup mutation is available in schema.
    final mutation = '''
      mutation MarkReservationAsPickedUp(\$reservationId: ID!) {
        markReservationAsPickedUp(reservationId: \$reservationId) {
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
          response.data['data']['markReservationAsPickedUp'] == null) {
        throw ServerException('Invalid response format');
      }

      return ReservationModel.fromJson(
        response.data['data']['markReservationAsPickedUp']
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

        throw ServerException(message);
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
      throw ServerException('GraphQL request failed: $e');
    }
  }
}
