import 'package:equatable/equatable.dart';
import 'user.dart';

class AuthResponse extends Equatable {
  final User? user;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  const AuthResponse({
    this.user,
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  @override
  List<Object?> get props => [user, accessToken, refreshToken, message];
}
