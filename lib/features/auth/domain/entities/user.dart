import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? role;
  final String? description;
  final bool isMailVerified;
  final int reputationScore;
  final String? locationId;
  final Map<String, dynamic>? location;

  const User({
    required this.id,
    this.email,
    this.name,
    this.role,
    this.description,
    this.isMailVerified = false,
    this.reputationScore = 0,
    this.locationId,
    this.location,
  });

  bool get isAdmin => role?.toLowerCase() == 'admin';

  @override
  List<Object?> get props => [id, email, name, role, description, isMailVerified, reputationScore, locationId, location];
}
