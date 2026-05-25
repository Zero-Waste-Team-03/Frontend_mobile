import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/leaderboard_period.dart';
import '../../domain/usecases/get_current_user_leaderboard_usecase.dart';
import '../../domain/usecases/get_leaderboard_usecase.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboardUseCase getLeaderboardUseCase;
  final GetCurrentUserLeaderboardUseCase getCurrentUserLeaderboardUseCase;
  final Logger _logger = Logger();

  LeaderboardBloc({
    required this.getLeaderboardUseCase,
    required this.getCurrentUserLeaderboardUseCase,
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
    Future<LeaderboardEntry?>? currentUserFuture;
    if (isFirstPage) {
      currentUserFuture = _fetchCurrentUser(period: event.period);
    }

    if (isFirstPage) {
      emit(LeaderboardLoading(period: event.period));
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

    await result.fold<Future<void>>(
      (failure) async {
        if (emit.isDone) {
          return;
        }
        _logger.e(
          'LeaderboardBloc: fetch failed for page=${event.page}, '
          'period=${event.period}, isFirstPage=$isFirstPage',
          error: failure.message,
        );
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
          emit(LeaderboardError(failure.message, period: event.period));
        }
      },
      (pageData) async {
        final currentUserEntry = isFirstPage
            ? await currentUserFuture
            : currentState is LeaderboardLoaded
            ? currentState.currentUser
            : null;

        if (emit.isDone) {
          return;
        }

        _logger.i(
          'LeaderboardBloc: page received => '
          'entries=${pageData.entries.length}, '
          'currentUserId=${currentUserEntry?.id}, '
          'page=${pageData.page}, hasNextPage=${pageData.hasNextPage}',
        );
        if (isFirstPage || currentState is! LeaderboardLoaded) {
          emit(
            LeaderboardLoaded(
              entries: pageData.entries,
              currentUser: currentUserEntry,
              period: pageData.period,
              currentPage: pageData.page,
              totalCount: pageData.totalCount,
              isLoadingMore: false,
              hasReachedMax: !pageData.hasNextPage,
            ),
          );
          _logger.i(
            'LeaderboardBloc: emitted first-page state with currentUserId='
            '${currentUserEntry?.id}',
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
            currentUser: currentUserEntry,
            period: pageData.period,
            currentPage: pageData.page,
            totalCount: pageData.totalCount,
            isLoadingMore: false,
            hasReachedMax: !pageData.hasNextPage,
          ),
        );
        _logger.i(
          'LeaderboardBloc: emitted merged state with currentUserId='
          '${currentUserEntry?.id}',
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

  Future<LeaderboardEntry?> _fetchCurrentUser({
    required LeaderboardPeriod period,
  }) async {
    try {
      final result = await getCurrentUserLeaderboardUseCase(period: period);
      return result.fold(
        (failure) {
          _logger.w(
            'LeaderboardBloc: current user lookup failed for period=$period, '
            'error=${failure.message}',
          );
          return null;
        },
        (entry) {
          _logger.i(
            'LeaderboardBloc: current user lookup succeeded for '
            'period=$period, userId=${entry?.id}',
          );
          return entry;
        },
      );
    } catch (e) {
      _logger.w(
        'LeaderboardBloc: current user lookup threw for period=$period',
        error: e,
      );
      return null;
    }
  }
}
