import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/leaderboard_page_data.dart';
import '../entities/leaderboard_period.dart';

abstract class LeaderboardRepository {
  Future<Either<Failure, LeaderboardPageData>> getLeaderboard({
    required LeaderboardPeriod period,
    int page = 1,
    int limit = 10,
  });
}
