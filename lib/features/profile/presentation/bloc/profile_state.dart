import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/donations_state.dart';
import '../../../donations/domain/entities/donation.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final User user;
  final DonationsState? donationsState;

  const ProfileLoaded(this.user, {this.donationsState});

  @override
  List<Object?> get props => [user, donationsState];
}

class ProfileUpdating extends ProfileState {
  final User currentUser;

  const ProfileUpdating(this.currentUser);

  @override
  List<Object?> get props => [currentUser];
}

class ProfileUpdateSuccess extends ProfileState {
  final User user;

  const ProfileUpdateSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileActivitiesLoading extends ProfileState {
  const ProfileActivitiesLoading();
}

class ProfileActivitiesLoaded extends ProfileState {
  final List<Donation> activities;
  final String? activeFilter;
  final int currentPage;
  final int totalCount;
  final bool isLoadingMore;
  final bool hasReachedMax;

  const ProfileActivitiesLoaded(
    this.activities, {
    this.activeFilter,
    this.currentPage = 1,
    this.totalCount = 0,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [
    activities,
    activeFilter,
    currentPage,
    totalCount,
    isLoadingMore,
    hasReachedMax,
  ];
}

class ProfileActivitiesError extends ProfileState {
  final String message;

  const ProfileActivitiesError(this.message);

  @override
  List<Object?> get props => [message];
}
