import 'package:dartz/dartz.dart';
import 'package:gaspzero/core/errors/failures.dart';
import '../entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class CreateReservationUseCase {
  final ReservationRepository repository;

  CreateReservationUseCase(this.repository);

  Future<Either<Failure, Reservation>> call({
    required String donationId,
    required int quantity,
  }) async {
    try {
      return await repository.createReservation(
        donationId: donationId,
        quantity: quantity,
      );
    } catch (e) {
      return Left(ServerFailure('Error creating reservation: ${e.toString()}'));
    }
  }
}
