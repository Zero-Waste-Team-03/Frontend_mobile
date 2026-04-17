import 'package:equatable/equatable.dart';

import '../../domain/entities/leaderboard_period.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

class FetchLeaderboardEvent extends LeaderboardEvent {
  final LeaderboardPeriod period;
  final int page;
  final int limit;

  const FetchLeaderboardEvent({
    required this.period,
    this.page = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [period, page, limit];
}

class ChangeLeaderboardPeriodEvent extends LeaderboardEvent {
  final LeaderboardPeriod period;

  const ChangeLeaderboardPeriodEvent(this.period);

  @override
  List<Object?> get props => [period];
}

class LoadMoreLeaderboardEvent extends LeaderboardEvent {
  final int limit;

  const LoadMoreLeaderboardEvent({this.limit = 10});

  @override
  List<Object?> get props => [limit];
}
