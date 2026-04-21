import 'package:equatable/equatable.dart';

import '../../../donations/domain/entities/donation.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<Donation> donations;
  final int currentPage;
  final int totalCount;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const FavoritesLoaded(
    this.donations, {
    this.currentPage = 1,
    this.totalCount = 0,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [
    donations,
    currentPage,
    totalCount,
    isLoadingMore,
    hasReachedMax,
  ];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}
