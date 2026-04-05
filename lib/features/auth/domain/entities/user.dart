import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? role;
  final String? description;
  final bool isMailVerified;
  final int reputationScore;
  final String? locationId;
  final Map<String, dynamic>? location;
  final String? avatarUrl;

  const User({
    required this.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.role,
    this.description,
    this.isMailVerified = false,
    this.reputationScore = 0,
    this.locationId,
    this.location,
    this.avatarUrl,
  });

  bool get isAdmin => role?.toLowerCase() == 'admin';

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? role,
    String? description,
    bool? isMailVerified,
    int? reputationScore,
    String? locationId,
    Map<String, dynamic>? location,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      description: description ?? this.description,
      isMailVerified: isMailVerified ?? this.isMailVerified,
      reputationScore: reputationScore ?? this.reputationScore,
      locationId: locationId ?? this.locationId,
      location: location ?? this.location,
      avatarUrl: avatarUrl ?? this.avatarUrl,
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
    isMailVerified,
    reputationScore,
    locationId,
    location,
    avatarUrl,
  ];
}
