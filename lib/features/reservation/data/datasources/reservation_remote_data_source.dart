import 'package:dio/dio.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/reservation_model.dart';

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

  /// Mark reservation as picked up
  Future<ReservationModel> markAsPickedUp(String reservationId);
}

class ReservationRemoteDataSourceImpl implements ReservationRemoteDataSource {
  final Dio dio;

  static const String _reservationFields = '''
    id
    donationId
    beneficiaryId
    status
    createdAt
    confirmedAt
    updatedAt
  ''';

  ReservationRemoteDataSourceImpl(this.dio);

  @override
  Future<ReservationModel> createReservation({
    required String donationId,
  }) async {
    final mutation =
        '''
      mutation ReserveDonation(\$donationId: ID!) {
        reserveDonation(donationId: \$donationId) {
          $_reservationFields
        }
      }
    ''';

    try {
      var data = {
        'query': mutation,
        'variables': {'donationId': donationId},
      };
      final response = await dio.post('/graphql', data: data);

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to create reservation (${response.statusCode})',
        );
      }

      // Handle GraphQL errors
      if (response.data['errors'] != null) {
        final errors = response.data['errors'] as List;
        final errorMessage = errors.isNotEmpty
            ? errors.first['message'] ?? 'Failed to create reservation'
            : 'Unknown error occurred';
        throw ServerException(errorMessage);
      }

      if (response.data['data'] == null ||
          response.data['data']['reserveDonation'] == null) {
        throw ServerException('Invalid response: Missing reservation data');
      }

      return ReservationModel.fromJson(
        response.data['data']['reserveDonation'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Network error while creating reservation',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ReservationModel>> getUserReservations({
    required String userId,
    String? statusFilter,
    int page = 1,
    int limit = 20,
  }) async {
    final query =
        '''
      query GetUserReservations(\$userId: ID!, \$status: String, \$page: Int!, \$limit: Int!) {
        userReservations(
          userId: \$userId
          status: \$status
          page: \$page
          limit: \$limit
        ) {
          items {
            $_reservationFields
          }
          page
          limit
          total
        }
      }
    ''';

    try {
      final variables = <String, dynamic>{
        'userId': userId,
        'page': page,
        'limit': limit,
      };

      if (statusFilter != null) {
        variables['status'] = statusFilter;
      }

      final response = await dio.post(
        '/graphql',
        data: {'query': query, 'variables': variables},
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to fetch reservations (${response.statusCode})',
        );
      }

      if (response.data['errors'] != null) {
        final errors = response.data['errors'] as List;
        final errorMessage = errors.isNotEmpty
            ? errors.first['message'] ?? 'Failed to fetch reservations'
            : 'Unknown error occurred';
        throw ServerException(errorMessage);
      }

      if (response.data['data'] == null ||
          response.data['data']['userReservations'] == null) {
        throw ServerException('Invalid response format');
      }

      final items = response.data['data']['userReservations']['items'] as List;
      return items
          .map(
            (item) => ReservationModel.fromJson(item as Map<String, dynamic>),
          )
          .toList();
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Network error while fetching reservations',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReservationModel> confirmReservation(String reservationId) async {
    final mutation =
        '''
      mutation ConfirmReservation(\$reservationId: ID!) {
        confirmReservation(reservationId: \$reservationId) {
          $_reservationFields
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
          'Failed to confirm reservation (${response.statusCode})',
        );
      }

      if (response.data['errors'] != null) {
        final errors = response.data['errors'] as List;
        final errorMessage = errors.isNotEmpty
            ? errors.first['message'] ?? 'Failed to confirm reservation'
            : 'Unknown error occurred';
        throw ServerException(errorMessage);
      }

      if (response.data['data'] == null ||
          response.data['data']['confirmReservation'] == null) {
        throw ServerException('Invalid response format');
      }

      return ReservationModel.fromJson(
        response.data['data']['confirmReservation'] as Map<String, dynamic>,
      );
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? 'Network error while confirming reservation',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ReservationModel> markAsPickedUp(String reservationId) async {
    final mutation =
        '''
      mutation MarkReservationAsPickedUp(\$reservationId: ID!) {
        markReservationAsPickedUp(reservationId: \$reservationId) {
          $_reservationFields
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
}
