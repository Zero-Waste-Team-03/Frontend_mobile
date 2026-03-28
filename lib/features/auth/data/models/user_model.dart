import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? name;

  const UserModel({
    required this.id,
    this.email,
    this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
    );
  }

  @override
  List<Object?> get props => [id, email, name];
}
