import 'package:equatable/equatable.dart';

import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/leaderboard_period.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object?> get props => [];
}

class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial();
}

class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

class LeaderboardLoaded extends LeaderboardState {
  final List<LeaderboardEntry> entries;
  final LeaderboardEntry? currentUser;
  final LeaderboardPeriod period;
  final int currentPage;
  final int totalCount;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const LeaderboardLoaded({
    required this.entries,
    required this.currentUser,
    required this.period,
    required this.currentPage,
    required this.totalCount,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  List<LeaderboardEntry> get topThree =>
      entries.where((entry) => entry.rank <= 3).toList()
        ..sort((a, b) => a.rank.compareTo(b.rank));

  List<LeaderboardEntry> get remainingRanks =>
      entries.where((entry) => entry.rank > 3).toList()
        ..sort((a, b) => a.rank.compareTo(b.rank));

  @override
  List<Object?> get props => [
    entries,
    currentUser,
    period,
    currentPage,
    totalCount,
    isLoadingMore,
    hasReachedMax,
  ];
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError(this.message);

  @override
  List<Object?> get props => [message];
}
