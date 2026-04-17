import '../../domain/entities/leaderboard_page_data.dart';
import '../../domain/entities/leaderboard_period.dart';
import 'leaderboard_entry_model.dart';

class LeaderboardPageModel {
  final List<LeaderboardEntryModel> entries;
  final LeaderboardEntryModel? currentUser;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int limit;
  final int page;
  final int totalCount;
  final LeaderboardPeriod period;

  const LeaderboardPageModel({
    required this.entries,
    required this.currentUser,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.limit,
    required this.page,
    required this.totalCount,
    required this.period,
  });

  LeaderboardPageData toEntity() {
    return LeaderboardPageData(
      entries: entries.map((e) => e.toEntity()).toList(),
      currentUser: currentUser?.toEntity(),
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
      limit: limit,
      page: page,
      totalCount: totalCount,
      period: period,
    );
  }
}
