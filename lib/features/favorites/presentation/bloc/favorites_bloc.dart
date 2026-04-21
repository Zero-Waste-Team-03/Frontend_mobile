import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/favorites_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({required this.favoritesRepository})
    : super(const FavoritesInitial()) {
    on<LoadFavoritesEvent>(_onLoadFavorites);
    on<RefreshFavoritesEvent>(_onRefreshFavorites);
    on<LoadMoreFavoritesEvent>(_onLoadMoreFavorites);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  final FavoritesRepository favoritesRepository;
  int _currentLimit = 10;

  Future<void> _onLoadFavorites(
    LoadFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(const FavoritesLoading());
    } else if (currentState is FavoritesLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      emit(
        FavoritesLoaded(
          currentState.donations,
          currentPage: currentState.currentPage,
          totalCount: currentState.totalCount,
          isLoadingMore: true,
          hasReachedMax: currentState.hasReachedMax,
        ),
      );
    }

    _currentLimit = event.limit;

    try {
      final pageData = await favoritesRepository.getLikedDonations(
        page: event.page,
        limit: event.limit,
      );
      if (isFirstPage || currentState is! FavoritesLoaded) {
        emit(
          FavoritesLoaded(
            pageData.donations,
            currentPage: pageData.page,
            totalCount: pageData.totalCount,
            isLoadingMore: false,
            hasReachedMax: !pageData.hasNextPage,
          ),
        );
        return;
      }

      final existingById = {
        for (final donation in currentState.donations) donation.id: donation,
      };
      for (final donation in pageData.donations) {
        existingById[donation.id] = donation;
      }

      emit(
        FavoritesLoaded(
          existingById.values.toList(),
          currentPage: pageData.page,
          totalCount: pageData.totalCount,
          isLoadingMore: false,
          hasReachedMax: !pageData.hasNextPage,
        ),
      );
    } catch (e) {
      if (!isFirstPage && currentState is FavoritesLoaded) {
        emit(
          FavoritesLoaded(
            currentState.donations,
            currentPage: currentState.currentPage,
            totalCount: currentState.totalCount,
            isLoadingMore: false,
            hasReachedMax: currentState.hasReachedMax,
          ),
        );
      } else {
        emit(FavoritesError(e.toString()));
      }
    }
  }

  Future<void> _onRefreshFavorites(
    RefreshFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    add(LoadFavoritesEvent(page: 1, limit: event.limit));
  }

  Future<void> _onLoadMoreFavorites(
    LoadMoreFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FavoritesLoaded) {
      return;
    }

    if (currentState.hasReachedMax || currentState.isLoadingMore) {
      return;
    }

    add(
      LoadFavoritesEvent(
        page: currentState.currentPage + 1,
        limit: _currentLimit,
      ),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is! FavoritesLoaded) {
      return;
    }

    try {
      if (event.isCurrentlyLiked) {
        await favoritesRepository.unlikeDonation(event.donationId);
        final updated = currentState.donations
            .where((item) => item.id != event.donationId)
            .toList();

        emit(
          FavoritesLoaded(
            updated,
            currentPage: currentState.currentPage,
            totalCount: currentState.totalCount > 0
                ? currentState.totalCount - 1
                : 0,
            isLoadingMore: false,
            hasReachedMax: currentState.hasReachedMax,
          ),
        );
      } else {
        await favoritesRepository.likeDonation(event.donationId);
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
      emit(
        FavoritesLoaded(
          currentState.donations,
          currentPage: currentState.currentPage,
          totalCount: currentState.totalCount,
          isLoadingMore: false,
          hasReachedMax: currentState.hasReachedMax,
        ),
      );
    }
  }
}
