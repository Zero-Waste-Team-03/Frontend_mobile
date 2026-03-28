import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  
  @override
  List<Object?> get props => [];
}

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
  
  const AuthSignUpRequested({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
  
  @override
  List<Object?> get props => [firstName, lastName, email, password];
}

class AuthVerifyOtpRequested extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String otp;
  
  const AuthVerifyOtpRequested({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.otp,
  });
  
  @override
  List<Object?> get props => [firstName, lastName, email, password, otp];
}

class AuthGoogleLoginRequested extends AuthEvent {}
