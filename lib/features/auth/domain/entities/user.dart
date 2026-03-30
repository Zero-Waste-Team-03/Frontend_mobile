import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? role;

  const User({
    required this.id,
    this.email,
    this.name,
    this.role,
  });

  bool get isAdmin => role?.toLowerCase() == 'admin';

  @override
  List<Object?> get props => [id, email, name, role];
}
