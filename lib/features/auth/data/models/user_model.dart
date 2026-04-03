import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? role;
  final String? description;
  final bool isMailVerified;
  final int reputationScore;
  final String? locationId;
  final Map<String, dynamic>? location;

  const UserModel({
    required this.id,
    this.email,
    this.displayName,
    this.role,
    this.description,
    this.isMailVerified = false,
    this.reputationScore = 0,
    this.locationId,
    this.location,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      displayName: (json['displayName'] ?? json['name']) as String?,
      role: json['role'] as String?,
      description: json['description'] as String?,
      isMailVerified: (json['isMailVerified'] as bool?) ?? false,
      reputationScore: (json['reputationScore'] as num?)?.toInt() ?? 0,
      locationId: json['locationId']?.toString(),
      location: json['location'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'role': role,
      'description': description,
      'isMailVerified': isMailVerified,
      'reputationScore': reputationScore,
      'locationId': locationId,
      'location': location,
    };
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: displayName,
      role: role,
      description: description,
      isMailVerified: isMailVerified,
      reputationScore: reputationScore,
      locationId: locationId,
      location: location,
    );
  }

  @override
  List<Object?> get props => [id, email, displayName, role, description, isMailVerified, reputationScore, locationId, location];
}
