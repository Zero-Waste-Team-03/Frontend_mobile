import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import 'package:logger/logger.dart';
import '../../domain/repositories/profile_repository.dart';
import 'profile_event.dart';
import 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  String? _currentActivitiesUserId;
  String? _currentActivitiesFilter;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  ProfileBloc({required this.profileRepository})
    : super(const ProfileInitial()) {
    on<ProfileLoadRequested>(_onProfileLoadRequested);
    on<ProfileRefreshRequested>(_onProfileRefreshRequested);
    on<ProfileUpdateRequested>(_onProfileUpdateRequested);
    on<ProfileAvatarUploadRequested>(_onProfileAvatarUploadRequested);
    on<ProfileAvatarUpdateRequested>(_onProfileAvatarUpdateRequested);
    on<ProfileActivitiesLoadRequested>(_onProfileActivitiesLoadRequested);
    on<ProfileActivitiesFilterRequested>(_onProfileActivitiesFilterRequested);
    on<ProfileActivitiesLoadMoreRequested>(
      _onProfileActivitiesLoadMoreRequested,
    );
  }

  Future<void> _onProfileLoadRequested(
    ProfileLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await profileRepository.getCachedOrRemoteUser();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> _onProfileRefreshRequested(
    ProfileRefreshRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    final result = await profileRepository.getRemoteUser();
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> _onProfileUpdateRequested(
    ProfileUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded) {
      emit(ProfileUpdating(currentState.user));

      final result = await profileRepository.updateUserProfile(
        displayName: event.displayName,
        email: event.email,
        phoneNumber: event.phoneNumber,
        location: event.location,
      );

      result.fold((failure) => emit(ProfileError(failure.message)), (user) {
        // Emit success state first (for UI feedback like snackbar)
        emit(ProfileUpdateSuccess(user));
        // Then emit loaded state with updated user (for displaying the data)
        emit(ProfileLoaded(user));
      });
    }
  }

  Future<void> _onProfileAvatarUploadRequested(
    ProfileAvatarUploadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileLoaded || currentState is ProfileUpdating) {
      final currentUser = currentState is ProfileLoaded
          ? currentState.user
          : (currentState as ProfileUpdating).currentUser;

      emit(ProfileUpdating(currentUser));

      _logger.i('🚀 Starting avatar upload from: ${event.filePath}');

      final file = File(event.filePath);
      final result = await profileRepository.uploadProfileAvatar(file);

      result.fold(
        (failure) {
          _logger.e('❌ Avatar upload failed: ${failure.message}');
          emit(ProfileError(failure.message));
        },
        (avatarId) {
          _logger.i('✅ Avatar uploaded successfully with ID: $avatarId');
          // Automatically update profile with the uploaded avatar ID
          add(ProfileAvatarUpdateRequested(avatarAttachmentId: avatarId));
        },
      );
    }
  }

  Future<void> _onProfileAvatarUpdateRequested(
    ProfileAvatarUpdateRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProfileUpdating) {
      _logger.i('🚀 Starting avatar ID update...');
      final result = await profileRepository.updateProfileWithAvatarId(
        event.avatarAttachmentId,
      );

      result.fold(
        (failure) {
          _logger.e('❌ Avatar update failed: ${failure.message}');
          emit(ProfileError(failure.message));
        },
        (updatedUser) {
          _logger.i('✅ Avatar updated successfully');
          _logger.i('📸 New avatar URL: ${updatedUser.avatarUrl}');

          // Clear the image cache to force fresh load
          if (updatedUser.avatarUrl != null &&
              updatedUser.avatarUrl!.isNotEmpty) {
            _logger.d('🗑️ Clearing image cache for new avatar...');
            imageCache.clear();
            imageCache.clearLiveImages();
            _logger.d('🗑️ Image cache cleared');
          }

          emit(ProfileUpdateSuccess(updatedUser));
          emit(ProfileLoaded(updatedUser));
        },
      );
    }
  }

  Future<void> _onProfileActivitiesLoadRequested(
    ProfileActivitiesLoadRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(const ProfileActivitiesLoading());
    } else if (currentState is ProfileActivitiesLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      emit(
        ProfileActivitiesLoaded(
          currentState.activities,
          activeFilter: currentState.activeFilter,
          currentPage: currentState.currentPage,
          totalCount: currentState.totalCount,
          isLoadingMore: true,
          hasReachedMax: currentState.hasReachedMax,
        ),
      );
    }

    _currentActivitiesFilter = event.statusFilter ?? _currentActivitiesFilter;

    if (_currentActivitiesUserId == null) {
      final userResult = await profileRepository.getCachedOrRemoteUser();
      final userIdResult = userResult.fold<String?>(
        (_) => null,
        (user) => user.id,
      );
      if (userIdResult == null || userIdResult.isEmpty) {
        if (!isFirstPage && currentState is ProfileActivitiesLoaded) {
          emit(
            ProfileActivitiesLoaded(
              currentState.activities,
              activeFilter: currentState.activeFilter,
              currentPage: currentState.currentPage,
              totalCount: currentState.totalCount,
              isLoadingMore: false,
              hasReachedMax: currentState.hasReachedMax,
            ),
          );
        } else {
          emit(const ProfileActivitiesError('Failed to resolve current user'));
        }
        return;
      }
      _currentActivitiesUserId = userIdResult;
    }

    final result = await profileRepository.getUserActivities(
      userId: _currentActivitiesUserId!,
      statusFilter: _currentActivitiesFilter,
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) {
        if (!isFirstPage && currentState is ProfileActivitiesLoaded) {
          emit(
            ProfileActivitiesLoaded(
              currentState.activities,
              activeFilter: currentState.activeFilter,
              currentPage: currentState.currentPage,
              totalCount: currentState.totalCount,
              isLoadingMore: false,
              hasReachedMax: currentState.hasReachedMax,
            ),
          );
        } else {
          emit(ProfileActivitiesError(failure.message));
        }
      },
      (activitiesPage) {
        if (isFirstPage || currentState is! ProfileActivitiesLoaded) {
          emit(
            ProfileActivitiesLoaded(
              activitiesPage.activities,
              activeFilter: _currentActivitiesFilter,
              currentPage: activitiesPage.page,
              totalCount: activitiesPage.totalCount,
              isLoadingMore: false,
              hasReachedMax: !activitiesPage.hasNextPage,
            ),
          );
          return;
        }

        final existingById = {
          for (final donation in currentState.activities) donation.id: donation,
        };
        for (final donation in activitiesPage.activities) {
          existingById[donation.id] = donation;
        }

        emit(
          ProfileActivitiesLoaded(
            existingById.values.toList(),
            activeFilter: _currentActivitiesFilter,
            currentPage: activitiesPage.page,
            totalCount: activitiesPage.totalCount,
            isLoadingMore: false,
            hasReachedMax: !activitiesPage.hasNextPage,
          ),
        );
      },
    );
  }

  Future<void> _onProfileActivitiesFilterRequested(
    ProfileActivitiesFilterRequested event,
    Emitter<ProfileState> emit,
  ) async {
    _currentActivitiesFilter = event.statusFilter;

    add(
      ProfileActivitiesLoadRequested(
        page: 1,
        limit: 10,
        statusFilter: _currentActivitiesFilter,
      ),
    );
  }

  Future<void> _onProfileActivitiesLoadMoreRequested(
    ProfileActivitiesLoadMoreRequested event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProfileActivitiesLoaded) {
      return;
    }

    if (currentState.hasReachedMax || currentState.isLoadingMore) {
      return;
    }

    add(
      ProfileActivitiesLoadRequested(
        page: currentState.currentPage + 1,
        limit: event.limit,
        statusFilter: _currentActivitiesFilter,
      ),
    );
  }
}
