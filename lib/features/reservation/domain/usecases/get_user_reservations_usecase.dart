import 'package:dartz/dartz.dart';
import 'package:gaspzero/core/errors/failures.dart';
import 'package:gaspzero/features/donations/domain/entities/donation.dart';
import '../repositories/reservation_repository.dart';

class GetUserReservationsUseCase {
  final ReservationRepository repository;

  GetUserReservationsUseCase(this.repository);

  Future<Either<Failure, List<Donation>>> call({
    required String userId,
    String? status,
  }) async {
    return repository.getUserReservations(userId: userId, status: status);
  }
}
