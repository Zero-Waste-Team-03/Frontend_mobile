import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import '../../domain/entities/user.dart';

final _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 3,
    lineLength: 80,
    colors: true,
    printEmojis: true,
  ),
);

class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final String? role;
  final String? description;
  final bool isMailVerified;
  final int reputationScore;
  final String? locationId;
  final Map<String, dynamic>? location;
  final String? avatarUrl;

  const UserModel({
    required this.id,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.role,
    this.description,
    this.isMailVerified = false,
    this.reputationScore = 0,
    this.locationId,
    this.location,
    this.avatarUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Extract avatar URL from multiple possible locations
    String? avatarUrl;
    String? avatarId;

    _logger.d(
      '🔍 Extracting avatar from JSON. Full JSON keys: ${json.keys.toList()}',
    );
    _logger.d('🔍 Avatar field: ${json['avatar']}');
    _logger.d('🔍 AvatarUrl field: ${json['avatarUrl']}');

    // Try nested avatar object: { avatar: { url: "...", id: "..." } }
    if (json['avatar'] is Map<String, dynamic>) {
      final avatarMap = json['avatar'] as Map<String, dynamic>;
      _logger.d('🔍 Avatar is a Map with keys: ${avatarMap.keys.toList()}');

      // Get the URL if available
      avatarUrl = avatarMap['url'] as String?;
      // Get the ID for constructing URL if needed
      avatarId = avatarMap['id'] as String?;

      if (avatarUrl != null && avatarUrl.isNotEmpty) {
        _logger.i('✅ Avatar URL extracted from nested object: $avatarUrl');
      } else if (avatarId != null && avatarId.isNotEmpty) {
        // Construct URL from ID if URL is not provided
        avatarUrl = '/api/v1/files/$avatarId';
        _logger.i('🔧 Avatar URL constructed from ID: $avatarUrl');
      } else {
        _logger.w('⚠️ Avatar Map found but both URL and ID are null/empty');
      }
    }
    // Try direct avatarUrl field: { avatarUrl: "..." }
    else if (json['avatarUrl'] is String) {
      avatarUrl = json['avatarUrl'] as String?;
      if (avatarUrl != null && avatarUrl.isNotEmpty) {
        _logger.i('✅ Avatar URL extracted from direct field: $avatarUrl');
      } else {
        _logger.w('⚠️ avatarUrl field found but is null/empty');
      }
    }
    // Try avatar as direct string: { avatar: "..." }
    else if (json['avatar'] is String) {
      avatarUrl = json['avatar'] as String?;
      if (avatarUrl != null && avatarUrl.isNotEmpty) {
        _logger.i('✅ Avatar URL extracted from string: $avatarUrl');
      } else {
        _logger.w('⚠️ Avatar string found but is null/empty');
      }
    }

    if (avatarUrl == null || avatarUrl.isEmpty) {
      _logger.w('⚠️ No valid avatar URL found in JSON');
    } else {
      _logger.i('💾 Final avatar URL: $avatarUrl');
    }

    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      displayName: (json['displayName'] ?? json['name']) as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
      description: json['description'] as String?,
      isMailVerified: (json['isMailVerified'] as bool?) ?? false,
      reputationScore: (json['reputationScore'] as num?)?.toInt() ?? 0,
      locationId: json['locationId']?.toString(),
      location: json['location'] as Map<String, dynamic>?,
      avatarUrl: avatarUrl,
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
      'isMailVerified': isMailVerified,
      'reputationScore': reputationScore,
      'locationId': locationId,
      'location': location,
      'avatarUrl': avatarUrl,
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
      isMailVerified: isMailVerified,
      reputationScore: reputationScore,
      locationId: locationId,
      location: location,
      avatarUrl: avatarUrl,
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
    isMailVerified,
    reputationScore,
    locationId,
    location,
    avatarUrl,
  ];
}
