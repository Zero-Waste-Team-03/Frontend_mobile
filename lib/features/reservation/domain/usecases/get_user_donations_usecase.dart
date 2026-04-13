import 'package:gaspzero/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../donations/domain/entities/donation.dart';
import '../repositories/reservation_repository.dart';

class GetUserDonationsUseCase {
  final ReservationRepository repository;

  GetUserDonationsUseCase(this.repository);

  Future<Either<Failure, List<Donation>>> call({
    required String userId,
    String? status,
  }) async {
    return repository.getUserDonations(userId: userId, status: status);
  }
}
