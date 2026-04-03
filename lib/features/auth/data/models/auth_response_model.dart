import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_response.dart';
import 'user_model.dart';

class AuthResponseModel extends Equatable {
  final UserModel? user;
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  const AuthResponseModel({
    this.user,
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: json['user'] != null 
          ? UserModel.fromJson(Map<String, dynamic>.from(json['user'])) 
          : null,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'message': message,
    };
  }

  AuthResponse toEntity() {
    return AuthResponse(
      user: user?.toEntity(),
      accessToken: accessToken,
      refreshToken: refreshToken,
      message: message,
    );
  }

  @override
  List<Object?> get props => [user, accessToken, refreshToken, message];
}
