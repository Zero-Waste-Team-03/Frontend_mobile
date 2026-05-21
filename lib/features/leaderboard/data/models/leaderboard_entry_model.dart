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
    int _asInt(dynamic value, {required int fallback}) {
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value) ?? fallback;
      return fallback;
    }

    double _asDouble(dynamic value, {required double fallback}) {
      if (value is double) return value;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? fallback;
      return fallback;
    }

    String _asString(dynamic value, {required String fallback}) {
      final result = value?.toString().trim();
      return result == null || result.isEmpty ? fallback : result;
    }

    final id = _asString(
      json['id'] ?? json['userId'],
      fallback: 'unknown-user',
    );
    final name = _asString(
      json['name'] ?? json['displayName'],
      fallback: 'Unknown user',
    );
    final avatarUrl = _asString(json['avatarUrl'], fallback: '');
    final rank = _asInt(json['rank'], fallback: 0);
    final points = _asInt(json['points'] ?? json['score'], fallback: 0);
    final kgSaved = json['kgSaved'] != null
        ? _asDouble(json['kgSaved'], fallback: points / 52.0)
        : points / 52.0;

    return LeaderboardEntryModel(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      rank: rank,
      points: points,
      kgSaved: kgSaved,
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
