import 'package:dartz/dartz.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../donations/domain/entities/donation.dart';
import '../../../donations/data/sources/donation_remote_data_source.dart';
import '../../domain/entities/reservation.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../datasources/reservation_remote_data_source.dart';

class ReservationRepositoryImpl implements ReservationRepository {
  final ReservationRemoteDataSource? remoteDataSource;
  final DonationRemoteDataSource? donationRemoteDataSource;

  ReservationRepositoryImpl({
    this.remoteDataSource,
    this.donationRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<Donation>>> getUserDonations({
    required String userId,
    String? status,
  }) async {
    if (donationRemoteDataSource == null) {
      return Left(ServerFailure('Donation data source is not available'));
    }

    try {
      final donations = await donationRemoteDataSource!.getDonations(
        page: 1,
        limit: 100,
      );

      var filtered = List<Donation>.from(donations);
      final normalizedStatus = status?.trim().toUpperCase();
      if (normalizedStatus != null && normalizedStatus.isNotEmpty) {
        filtered = filtered
            .where((donation) => donation.status == normalizedStatus)
            .toList();
      }

      return Right(filtered);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> getUserReservations({
    required String userId,
    String? status,
  }) async {
    print(
      '[ReservationRepository] Fetching user reservations - userId: $userId, status: $status',
    );

    if (remoteDataSource == null) {
      print('[ReservationRepository] ERROR: remoteDataSource is null');
      return Left(ServerFailure('Reservation data source is not available'));
    }

    try {
      print(
        '[ReservationRepository] Calling remoteDataSource.getUserReservations()...',
      );
      final reservationModels = await remoteDataSource!.getUserReservations(
        userId: userId,
        statusFilter: status,
      );
      print(
        '[ReservationRepository] Received ${reservationModels.length} reservations from API',
      );

      // Convert models to entities
      final reservations = reservationModels
          .map((model) => model.toEntity())
          .toList();

      print(
        '[ReservationRepository] Converted ${reservations.length} reservations to entities',
      );
      return Right(reservations);
    } on ServerException catch (e) {
      print('[ReservationRepository] ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[ReservationRepository] Unexpected error: ${e.runtimeType} - $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Donation>> getDonationDetails(
    String donationId,
  ) async {
    if (donationRemoteDataSource == null) {
      return Left(ServerFailure('Donation data source is not available'));
    }

    try {
      final donation = await donationRemoteDataSource!.getDonationDetails(
        donationId,
      );
      return Right(donation);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Reservation>> getReservationDetails(
    String reservationId,
  ) async {
    print(
      '[ReservationRepository] Fetching reservation details for ID: $reservationId',
    );

    if (remoteDataSource == null) {
      print('[ReservationRepository] ERROR: remoteDataSource is null');
      return Left(ServerFailure('Reservation data source is not available'));
    }

    try {
      print(
        '[ReservationRepository] Calling remoteDataSource.getReservationDetails()...',
      );
      final reservation = await remoteDataSource!.getReservationDetails(
        reservationId,
      );
      print('[ReservationRepository] SUCCESS: Received reservation model');
      print('[ReservationRepository] Reservation ID: ${reservation.id}');
      print(
        '[ReservationRepository] Reservation Status: ${reservation.status}',
      );
      print(
        '[ReservationRepository] Reservation Donation: ${reservation.donation != null ? "Present" : "Null"}',
      );
      return Right(reservation.toEntity());
    } on ServerException catch (e) {
      print('[ReservationRepository] ServerException: ${e.message}');
      return Left(ServerFailure(e.message));
    } catch (e) {
      print('[ReservationRepository] Unexpected error: ${e.runtimeType} - $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Reservation>> createReservation({
    required String donationId,
  }) async {
    if (remoteDataSource == null) {
      return Left(ServerFailure('Reservation data source is not available'));
    }

    try {
      final result = await remoteDataSource!.createReservation(
        donationId: donationId,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Reservation>> updateReservationStatus({
    required String reservationId,
    required String newStatus,
  }) async {
    if (remoteDataSource == null) {
      return Left(ServerFailure('Reservation data source is not available'));
    }

    try {
      final normalizedStatus = newStatus.trim().toUpperCase();
      if (normalizedStatus == 'CONFIRMED') {
        final reservation = await remoteDataSource!.confirmReservation(
          reservationId,
        );
        return Right(reservation.toEntity());
      }
      if (normalizedStatus == 'PICKED_UP' || normalizedStatus == 'COMPLETED') {
        final reservation = await remoteDataSource!.markAsPickedUp(
          reservationId,
        );
        return Right(reservation.toEntity());
      }

      return Left(
        ServerFailure('Unsupported reservation status transition: $newStatus'),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Reservation>>> getDonationReservations(
    String donationId,
  ) async {
    if (remoteDataSource == null) {
      return Left(ServerFailure('Reservation data source is not available'));
    }

    try {
      final reservations = await remoteDataSource!.getUserReservations(
        userId: '',
        page: 1,
        limit: 100,
      );

      final filtered = reservations
          .map((reservation) => reservation.toEntity())
          .where((reservation) => reservation.donationId == donationId)
          .toList();

      return Right(filtered);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
