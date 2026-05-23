import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../domain/usecases/get_leaderboard_usecase.dart';
import '../../../auth/data/sources/auth_local_data_source.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboardUseCase getLeaderboardUseCase;
  final AuthLocalDataSource authLocalDataSource;
  final Logger _logger = Logger();

  LeaderboardBloc({
    required this.getLeaderboardUseCase,
    required this.authLocalDataSource,
  }) : super(const LeaderboardInitial()) {
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
    String? cachedUserId;
    if (isFirstPage) {
      // try to get cached user id to include in state (use local data source)
      try {
        final cachedModel = await authLocalDataSource.getCachedUserProfile();
        cachedUserId = cachedModel?.id;
        _logger.i(
          'LeaderboardBloc: cached user lookup => '
          'cachedUserId=$cachedUserId, page=${event.page}, period=${event.period}',
        );
      } catch (_) {
        cachedUserId = null;
        _logger.w(
          'LeaderboardBloc: failed to load cached user profile for leaderboard',
        );
      }
    }

    if (isFirstPage) {
      emit(const LeaderboardLoading());
    } else if (currentState is LeaderboardLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      emit(
        LeaderboardLoaded(
          entries: currentState.entries,
          currentUserId: currentState.currentUserId,
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
        _logger.e(
          'LeaderboardBloc: fetch failed for page=${event.page}, '
          'period=${event.period}, isFirstPage=$isFirstPage',
          error: failure.message,
        );
        if (!isFirstPage && currentState is LeaderboardLoaded) {
          emit(
            LeaderboardLoaded(
              entries: currentState.entries,
              currentUserId: currentState.currentUserId,
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
        _logger.i(
          'LeaderboardBloc: page received => '
          'entries=${pageData.entries.length}, '
          'currentUserId=${pageData.currentUser?.id}, '
          'cachedUserId=$cachedUserId, '
          'page=${pageData.page}, hasNextPage=${pageData.hasNextPage}',
        );
        if (isFirstPage || currentState is! LeaderboardLoaded) {
          emit(
            LeaderboardLoaded(
              entries: pageData.entries,
              currentUserId: pageData.currentUser?.id ?? cachedUserId,
              period: pageData.period,
              currentPage: pageData.page,
              totalCount: pageData.totalCount,
              isLoadingMore: false,
              hasReachedMax: !pageData.hasNextPage,
            ),
          );
          _logger.i(
            'LeaderboardBloc: emitted first-page state with currentUserId='
            '${pageData.currentUser?.id ?? cachedUserId}',
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
            currentUserId:
                pageData.currentUser?.id ?? currentState.currentUserId,
            period: pageData.period,
            currentPage: pageData.page,
            totalCount: pageData.totalCount,
            isLoadingMore: false,
            hasReachedMax: !pageData.hasNextPage,
          ),
        );
        _logger.i(
          'LeaderboardBloc: emitted merged state with currentUserId='
          '${pageData.currentUser?.id ?? currentState.currentUserId}',
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
