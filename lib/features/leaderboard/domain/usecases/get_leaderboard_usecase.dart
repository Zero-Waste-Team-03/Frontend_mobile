import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/leaderboard_page_data.dart';
import '../entities/leaderboard_period.dart';
import '../repositories/leaderboard_repository.dart';

class GetLeaderboardUseCase {
  final LeaderboardRepository repository;

  GetLeaderboardUseCase(this.repository);

  Future<Either<Failure, LeaderboardPageData>> call({
    required LeaderboardPeriod period,
    int page = 1,
    int limit = 10,
  }) {
    return repository.getLeaderboard(period: period, page: page, limit: limit);
  }
}
