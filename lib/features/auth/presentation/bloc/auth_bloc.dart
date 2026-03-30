import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthVerifyOtpRequested>(_onAuthVerifyOtpRequested);
    on<AuthGoogleLoginRequested>(_onAuthGoogleLoginRequested);
    on<AuthForgotPasswordRequested>(_onAuthForgotPasswordRequested);
    on<AuthResetPasswordRequested>(_onAuthResetPasswordRequested);
  }

  void _onAuthLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.login(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (response) => emit(AuthSuccess(response.user)),
    );
  }

  void _onAuthSignUpRequested(AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.sendOtp(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthOtpSentSuccess()),
    );
  }

  void _onAuthVerifyOtpRequested(AuthVerifyOtpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final displayName = '${event.firstName} ${event.lastName}'.trim();
    final registerResult = await authRepository.register(displayName, event.email, event.password, event.otp);
    await registerResult.fold(
      (failure) async => emit(AuthError(failure.message)),
      (_) async {
        // Registration successful, now auto-login to get tokens
        final loginResult = await authRepository.login(event.email, event.password);
        loginResult.fold(
          (failure) => emit(AuthError(failure.message)),
          (response) => emit(AuthSuccess(response.user)),
        );
      },
    );
  }

  void _onAuthGoogleLoginRequested(AuthGoogleLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.googleSignIn();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (response) => emit(AuthSuccess(response.user)),
    );
  }

  void _onAuthForgotPasswordRequested(AuthForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.forgotPassword(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthForgotPasswordSuccess()),
    );
  }

  void _onAuthResetPasswordRequested(AuthResetPasswordRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await authRepository.resetPassword(event.token, event.newPassword);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthResetPasswordSuccess()),
    );
  }
}
