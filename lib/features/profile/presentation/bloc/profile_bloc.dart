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
}
