import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? role;

  const UserModel({
    required this.id,
    this.email,
    this.name,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      name: json['displayName'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': name,
      'role': role,
    };
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      role: role,
    );
  }

  @override
  List<Object?> get props => [id, email, name, role];
}
