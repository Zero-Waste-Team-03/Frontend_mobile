import 'package:injectable/injectable.dart';

import '../../domain/entities/leaderboard_period.dart';
import '../models/leaderboard_entry_model.dart';
import '../models/leaderboard_page_model.dart';

abstract class LeaderboardRemoteDataSource {
  Future<LeaderboardPageModel> getLeaderboard({
    required LeaderboardPeriod period,
    int page = 1,
    int limit = 10,
  });
}

@LazySingleton(as: LeaderboardRemoteDataSource)
class LeaderboardRemoteDataSourceImpl implements LeaderboardRemoteDataSource {
  @override
  Future<LeaderboardPageModel> getLeaderboard({
    required LeaderboardPeriod period,
    int page = 1,
    int limit = 10,
  }) async {
    // Placeholder remote payload until backend API is available.
    final allEntries = _buildPlaceholderEntries(period);
    const currentUserId = 'current-user';

    final currentUser = allEntries.firstWhere(
      (e) => e.id == currentUserId,
      orElse: () => allEntries[11],
    );

    final start = (page - 1) * limit;
    final end = (start + limit) > allEntries.length
        ? allEntries.length
        : (start + limit);

    final pageEntries = start >= allEntries.length
        ? <LeaderboardEntryModel>[]
        : allEntries.sublist(start, end);

    return LeaderboardPageModel(
      entries: pageEntries,
      currentUser: currentUser,
      hasNextPage: end < allEntries.length,
      hasPreviousPage: page > 1,
      limit: limit,
      page: page,
      totalCount: allEntries.length,
      period: period,
    );
  }

  List<LeaderboardEntryModel> _buildPlaceholderEntries(
    LeaderboardPeriod period,
  ) {
    final base = period == LeaderboardPeriod.monthly ? 0 : 120;

    final names = <String>[
      'Marco R.',
      'Sarah J.',
      'Lila W.',
      'Jack Thompson',
      'Emma Wilson',
      'Sam Chen',
      'Oliver Smith',
      'Ava Martinez',
      'Noah Green',
      'Mia Johnson',
      'Ethan Brown',
      'You (Alex)',
      'Lucas White',
      'Ella Davis',
      'Mason Lee',
      'Sophia Harris',
      'Logan Clark',
      'Amelia Young',
      'James Hall',
      'Isabella King',
      'Benjamin Scott',
      'Charlotte Hill',
      'Daniel Adams',
      'Harper Baker',
      'Henry Carter',
      'Evelyn Turner',
    ];

    final avatars = <String>[
      'https://i.pravatar.cc/150?img=47',
      'https://i.pravatar.cc/150?img=12',
      'https://i.pravatar.cc/150?img=5',
      'https://i.pravatar.cc/150?img=15',
      'https://i.pravatar.cc/150?img=32',
      'https://i.pravatar.cc/150?img=21',
      'https://i.pravatar.cc/150?img=11',
      'https://i.pravatar.cc/150?img=20',
      'https://i.pravatar.cc/150?img=18',
      'https://i.pravatar.cc/150?img=39',
      'https://i.pravatar.cc/150?img=23',
      'https://i.pravatar.cc/150?img=56',
      'https://i.pravatar.cc/150?img=42',
      'https://i.pravatar.cc/150?img=29',
      'https://i.pravatar.cc/150?img=7',
      'https://i.pravatar.cc/150?img=45',
      'https://i.pravatar.cc/150?img=35',
      'https://i.pravatar.cc/150?img=49',
      'https://i.pravatar.cc/150?img=9',
      'https://i.pravatar.cc/150?img=27',
      'https://i.pravatar.cc/150?img=14',
      'https://i.pravatar.cc/150?img=52',
      'https://i.pravatar.cc/150?img=31',
      'https://i.pravatar.cc/150?img=40',
      'https://i.pravatar.cc/150?img=26',
      'https://i.pravatar.cc/150?img=33',
    ];

    return List<LeaderboardEntryModel>.generate(names.length, (index) {
      final rank = index + 1;
      final points = (1450 - (rank * 85) + base).clamp(320, 1600);
      final kgSaved = (points / 52.0);

      return LeaderboardEntryModel(
        id: rank == 12 ? 'current-user' : 'user-$rank',
        name: names[index],
        avatarUrl: avatars[index],
        rank: rank,
        points: points,
        kgSaved: double.parse(kgSaved.toStringAsFixed(1)),
        period: period,
      );
    });
  }
}
