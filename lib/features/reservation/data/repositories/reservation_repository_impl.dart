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
    String? roleFilter,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    if (remoteDataSource == null) {
      return Left(ServerFailure('Reservation data source is not available'));
    }

    try {
      final reservationModels = await remoteDataSource!.getUserReservations(
        userId: userId,
        roleFilter: roleFilter,
        statusFilter: status,
        page: page,
        limit: limit,
      );

      // Convert models to entities
      final reservations =
          reservationModels.map((model) => model.toEntity()).toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return Right(reservations);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
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
    if (remoteDataSource == null) {
      return Left(ServerFailure('Reservation data source is not available'));
    }

    try {
      final reservation = await remoteDataSource!.getReservationDetails(
        reservationId,
      );

      return Right(reservation.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Reservation>> createReservation({
    required String donationId,
    required int quantity,
  }) async {
    if (remoteDataSource == null) {
      return Left(ServerFailure('Reservation data source is not available'));
    }

    try {
      final result = await remoteDataSource!.createReservation(
        donationId: donationId,
        quantity: quantity,
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
