import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileLoadRequested extends ProfileEvent {
  const ProfileLoadRequested();
}

class ProfileRefreshRequested extends ProfileEvent {
  const ProfileRefreshRequested();
}

class ProfileUpdateRequested extends ProfileEvent {
  final String displayName;
  final String? email;
  final String? phoneNumber;
  final Map<String, dynamic>? location;

  const ProfileUpdateRequested({
    required this.displayName,
    this.email,
    this.phoneNumber,
    this.location,
  });

  @override
  List<Object?> get props => [displayName, email, phoneNumber, location];
}

class ProfileAvatarUploadRequested extends ProfileEvent {
  final String filePath;

  const ProfileAvatarUploadRequested({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class ProfileAvatarUpdateRequested extends ProfileEvent {
  final String avatarAttachmentId;

  const ProfileAvatarUpdateRequested({required this.avatarAttachmentId});

  @override
  List<Object?> get props => [avatarAttachmentId];
}
