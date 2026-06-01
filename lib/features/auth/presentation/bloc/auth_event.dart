import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpRequested extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;

  const AuthSignUpRequested({
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    password,
    phoneNumber,
  ];
}

class AuthVerifyOtpRequested extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String password;
  final String confirmPassword;
  final String location;
  final String? zipCode;
  final double? latitude;
  final double? longitude;
  final String? neighborhood;
  final String otp;

  const AuthVerifyOtpRequested({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.location,
    this.zipCode,
    this.latitude,
    this.longitude,
    this.neighborhood,
    required this.otp,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    password,
    confirmPassword,
    location,
    zipCode,
    latitude,
    longitude,
    neighborhood,
    otp,
    phoneNumber,
  ];
}

class AuthGoogleLoginRequested extends AuthEvent {}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;
  const AuthForgotPasswordRequested(this.email);
  @override
  List<Object?> get props => [email];
}

class AuthResetPasswordRequested extends AuthEvent {
  final String token;
  final String newPassword;
  const AuthResetPasswordRequested({
    required this.token,
    required this.newPassword,
  });
  @override
  List<Object?> get props => [token, newPassword];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthResetRequested extends AuthEvent {}
