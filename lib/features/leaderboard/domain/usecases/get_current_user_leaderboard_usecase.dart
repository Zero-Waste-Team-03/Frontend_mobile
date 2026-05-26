import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/leaderboard_entry.dart';
import '../entities/leaderboard_period.dart';
import '../repositories/leaderboard_repository.dart';

class GetCurrentUserLeaderboardUseCase {
  final LeaderboardRepository repository;

  GetCurrentUserLeaderboardUseCase(this.repository);

  Future<Either<Failure, LeaderboardEntry?>> call({
    required LeaderboardPeriod period,
  }) {
    return repository.getCurrentUserLeaderboardEntry(period: period);
  }
}
