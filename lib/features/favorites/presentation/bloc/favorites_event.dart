import 'package:equatable/equatable.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavoritesEvent extends FavoritesEvent {
  final int page;
  final int limit;

  const LoadFavoritesEvent({this.page = 1, this.limit = 10});

  @override
  List<Object?> get props => [page, limit];
}

class RefreshFavoritesEvent extends FavoritesEvent {
  final int limit;

  const RefreshFavoritesEvent({this.limit = 10});

  @override
  List<Object?> get props => [limit];
}

class LoadMoreFavoritesEvent extends FavoritesEvent {
  const LoadMoreFavoritesEvent();
}

class ToggleFavoriteEvent extends FavoritesEvent {
  final String donationId;
  final bool isCurrentlyLiked;

  const ToggleFavoriteEvent({
    required this.donationId,
    required this.isCurrentlyLiked,
  });

  @override
  List<Object?> get props => [donationId, isCurrentlyLiked];
}
