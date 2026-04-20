import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_leaderboard_usecase.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboardUseCase getLeaderboardUseCase;

  LeaderboardBloc({required this.getLeaderboardUseCase})
    : super(const LeaderboardInitial()) {
    on<FetchLeaderboardEvent>(_onFetchLeaderboard);
    on<ChangeLeaderboardPeriodEvent>(_onChangePeriod);
    on<LoadMoreLeaderboardEvent>(_onLoadMore);
  }

  Future<void> _onFetchLeaderboard(
    FetchLeaderboardEvent event,
    Emitter<LeaderboardState> emit,
  ) async {
    final currentState = state;
    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(const LeaderboardLoading());
    } else if (currentState is LeaderboardLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      emit(
        LeaderboardLoaded(
          entries: currentState.entries,
          currentUser: currentState.currentUser,
          period: currentState.period,
          currentPage: currentState.currentPage,
          totalCount: currentState.totalCount,
          isLoadingMore: true,
          hasReachedMax: currentState.hasReachedMax,
        ),
      );
    }

    final result = await getLeaderboardUseCase(
      period: event.period,
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) {
        if (!isFirstPage && currentState is LeaderboardLoaded) {
          emit(
            LeaderboardLoaded(
              entries: currentState.entries,
              currentUser: currentState.currentUser,
              period: currentState.period,
              currentPage: currentState.currentPage,
              totalCount: currentState.totalCount,
              isLoadingMore: false,
              hasReachedMax: currentState.hasReachedMax,
            ),
          );
        } else {
          emit(LeaderboardError(failure.message));
        }
      },
      (pageData) {
        if (isFirstPage || currentState is! LeaderboardLoaded) {
          emit(
            LeaderboardLoaded(
              entries: pageData.entries,
              currentUser: pageData.currentUser,
              period: pageData.period,
              currentPage: pageData.page,
              totalCount: pageData.totalCount,
              isLoadingMore: false,
              hasReachedMax: !pageData.hasNextPage,
            ),
          );
          return;
        }

        final existingByRank = {
          for (final entry in currentState.entries) entry.rank: entry,
        };
        for (final entry in pageData.entries) {
          existingByRank[entry.rank] = entry;
        }

        final merged = existingByRank.values.toList()
          ..sort((a, b) => a.rank.compareTo(b.rank));

        emit(
          LeaderboardLoaded(
            entries: merged,
            currentUser: pageData.currentUser,
            period: pageData.period,
            currentPage: pageData.page,
            totalCount: pageData.totalCount,
            isLoadingMore: false,
            hasReachedMax: !pageData.hasNextPage,
          ),
        );
      },
    );
  }

  Future<void> _onChangePeriod(
    ChangeLeaderboardPeriodEvent event,
    Emitter<LeaderboardState> emit,
  ) async {
    add(FetchLeaderboardEvent(period: event.period, page: 1, limit: 10));
  }

  Future<void> _onLoadMore(
    LoadMoreLeaderboardEvent event,
    Emitter<LeaderboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is! LeaderboardLoaded) {
      return;
    }

    if (currentState.hasReachedMax || currentState.isLoadingMore) {
      return;
    }

    add(
      FetchLeaderboardEvent(
        period: currentState.period,
        page: currentState.currentPage + 1,
        limit: event.limit,
      ),
    );
  }
}
