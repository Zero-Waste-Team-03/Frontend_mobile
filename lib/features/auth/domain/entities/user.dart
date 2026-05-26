import 'package:equatable/equatable.dart';
import 'user_settings.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? role;
  final String? description;
  final bool isVerified;
  final int reputationScore;
  final String? locationId;
  final Map<String, dynamic>? location;
  final String? avatarUrl;
  final bool isFoodSaver;
  final UserSettings? settings;

  const User({
    required this.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.role,
    this.description,
    this.isVerified = false,
    this.reputationScore = 0,
    this.locationId,
    this.location,
    this.avatarUrl,
    this.isFoodSaver = false,
    this.settings,
  });

  bool get isAdmin => role?.toLowerCase() == 'admin';

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? role,
    String? description,
    bool? isVerified,
    int? reputationScore,
    String? locationId,
    Map<String, dynamic>? location,
    String? avatarUrl,
    bool? isFoodSaver,
    UserSettings? settings,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      description: description ?? this.description,
      isVerified: isVerified ?? this.isVerified,
      reputationScore: reputationScore ?? this.reputationScore,
      locationId: locationId ?? this.locationId,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isFoodSaver: isFoodSaver ?? this.isFoodSaver,
      settings: settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    phoneNumber,
    role,
    description,
    isVerified,
    reputationScore,
    locationId,
    location,
    avatarUrl,
    isFoodSaver,
    settings,
  ];
}
