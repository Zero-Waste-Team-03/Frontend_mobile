import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/leaderboard_period.dart';

class LeaderboardEntryModel {
  final String id;
  final String name;
  final String avatarUrl;
  final int rank;
  final int points;
  final double kgSaved;
  final LeaderboardPeriod period;

  const LeaderboardEntryModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.rank,
    required this.points,
    required this.kgSaved,
    required this.period,
  });

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      rank: json['rank'] as int,
      points: json['points'] as int,
      kgSaved: (json['kgSaved'] as num).toDouble(),
      period: json['period'] == 'allTime'
          ? LeaderboardPeriod.allTime
          : LeaderboardPeriod.monthly,
    );
  }

  LeaderboardEntry toEntity() {
    return LeaderboardEntry(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      rank: rank,
      points: points,
      kgSaved: kgSaved,
      period: period,
    );
  }
}
