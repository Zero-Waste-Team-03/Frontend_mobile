import 'package:dartz/dartz.dart';
import 'package:gaspzero/core/errors/failures.dart';
import 'package:gaspzero/features/reservation/domain/entities/reservation.dart';
import '../repositories/reservation_repository.dart';

class GetUserReservationsUseCase {
  final ReservationRepository repository;

  GetUserReservationsUseCase(this.repository);

  Future<Either<Failure, List<Reservation>>> call({
    required String userId,
    String? roleFilter,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    return repository.getUserReservations(
      userId: userId,
      roleFilter: roleFilter,
      status: status,
      page: page,
      limit: limit,
    );
  }
}
