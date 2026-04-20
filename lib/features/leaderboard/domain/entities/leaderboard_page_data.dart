import 'leaderboard_entry.dart';
import 'leaderboard_period.dart';

class LeaderboardPageData {
  final List<LeaderboardEntry> entries;
  final LeaderboardEntry? currentUser;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int limit;
  final int page;
  final int totalCount;
  final LeaderboardPeriod period;

  const LeaderboardPageData({
    required this.entries,
    required this.currentUser,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.limit,
    required this.page,
    required this.totalCount,
    required this.period,
  });
}
