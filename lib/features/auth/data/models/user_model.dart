import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import 'user_settings_model.dart';

class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final String? role;
  final String? description;
  final bool isVerified;
  final int reputationScore;
  final String? locationId;
  final Map<String, dynamic>? location;
  final String? avatarUrl;
  final bool isFoodSaver;
  final UserSettingsModel? settings;

  const UserModel({
    required this.id,
    this.email,
    this.displayName,
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Extract avatar URL from multiple possible locations
    String? avatarUrl;
    String? avatarId;

    // Try nested avatar object: { avatar: { url: "...", id: "..." } }
    if (json['avatar'] is Map<String, dynamic>) {
      final avatarMap = json['avatar'] as Map<String, dynamic>;

      // Get the URL if available
      avatarUrl = avatarMap['url'] as String?;
      // Get the ID for constructing URL if needed
      avatarId = avatarMap['id'] as String?;

      if (avatarUrl != null && avatarUrl.isNotEmpty) {
      } else if (avatarId != null && avatarId.isNotEmpty) {
        // Construct URL from ID if URL is not provided
        avatarUrl = '/api/v1/files/$avatarId';
      } else {}
    } else if (json['avatarUrl'] is String) {
      avatarUrl = json['avatarUrl'] as String?;
    } else if (json['avatar'] is String) {
      avatarUrl = json['avatar'] as String?;
    }

    return UserModel(
      id: (json['id'] ?? '').toString(),
      email: json['email'] as String?,
      displayName: (json['displayName'] ?? json['name']) as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
      description: json['description'] as String?,
      isVerified: (json['isVerified'] as bool?) ?? (json['isMailVerified'] as bool?) ?? false,
      reputationScore: (json['reputationScore'] as num?)?.toInt() ?? 0,
      locationId: json['locationId']?.toString(),
      location: json['location'] as Map<String, dynamic>?,
      avatarUrl: avatarUrl,
      isFoodSaver: (json['isFoodSaver'] as bool?) ?? false,
      settings: json['settings'] != null
          ? UserSettingsModel.fromJson(json['settings'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'role': role,
      'description': description,
      'isVerified': isVerified,
      'reputationScore': reputationScore,
      'locationId': locationId,
      'location': location,
      'avatarUrl': avatarUrl,
      'isFoodSaver': isFoodSaver,
      'settings': settings?.toJson(),
    };
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: displayName,
      phoneNumber: phoneNumber,
      role: role,
      description: description,
      isVerified: isVerified,
      reputationScore: reputationScore,
      locationId: locationId,
      location: location,
      avatarUrl: avatarUrl,
      isFoodSaver: isFoodSaver,
      settings: settings?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    displayName,
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
