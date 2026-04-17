import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/reservation.dart';
import '../../../donations/domain/entities/donation.dart';

abstract class ReservationRepository {
  /// Get all donations where the current user is the donor
  Future<Either<Failure, List<Donation>>> getUserDonations({
    required String userId,
    String? status,
  });

  /// Get all reservations for the current user as beneficiary
  Future<Either<Failure, List<Reservation>>> getUserReservations({
    required String userId,
    String? status,
  });

  /// Get donation details by ID
  Future<Either<Failure, Donation>> getDonationDetails(String donationId);

  /// Get reservation details
  Future<Either<Failure, Reservation>> getReservationDetails(
    String reservationId,
  );

  /// Create a new reservation for a donation
  Future<Either<Failure, Reservation>> createReservation({
    required String donationId,
  });

  /// Update reservation status
  Future<Either<Failure, Reservation>> updateReservationStatus({
    required String reservationId,
    required String newStatus,
  });

  /// Get all reservations for a donation (for donor view)
  Future<Either<Failure, List<Reservation>>> getDonationReservations(
    String donationId,
  );
}
