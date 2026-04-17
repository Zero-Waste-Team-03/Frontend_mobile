import 'leaderboard_period.dart';

class LeaderboardEntry {
  final String id;
  final String name;
  final String avatarUrl;
  final int rank;
  final int points;
  final double kgSaved;
  final LeaderboardPeriod period;

  const LeaderboardEntry({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rank,
    required this.points,
    required this.kgSaved,
    required this.period,
  });
}
