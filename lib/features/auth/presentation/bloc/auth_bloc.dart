import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 2,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthSignUpRequested>(_onAuthSignUpRequested);
    on<AuthVerifyOtpRequested>(_onAuthVerifyOtpRequested);
    on<AuthGoogleLoginRequested>(_onAuthGoogleLoginRequested);
    on<AuthForgotPasswordRequested>(_onAuthForgotPasswordRequested);
    on<AuthResetPasswordRequested>(_onAuthResetPasswordRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }

  void _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.getCurrentUser();
    result.fold(
      (failure) => emit(AuthError(failure.message)), // Or handle silently
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.login(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (response) => emit(AuthSuccess(response.user)),
    );
  }

  void _onAuthSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.sendOtp(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthOtpSentSuccess()),
    );
  }

  void _onAuthVerifyOtpRequested(
    AuthVerifyOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final displayName = '${event.firstName} ${event.lastName}'.trim();
    final registerResult = await authRepository.register(
      displayName: displayName,
      email: event.email,
      phoneNumber: event.phoneNumber ?? '',
      password: event.password,
      confirmPassword: event.confirmPassword,
      otp: event.otp,
      city: event.location,
    );
    await registerResult.fold(
      (failure) async => emit(AuthError(failure.message)),
      (_) async {
        // Registration successful, now auto-login to get tokens
        final loginResult = await authRepository.login(
          event.email,
          event.password,
        );
        loginResult.fold(
          (failure) => emit(AuthError(failure.message)),
          (response) => emit(AuthSuccess(response.user)),
        );
      },
    );
  }

  void _onAuthGoogleLoginRequested(
    AuthGoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    _logger.i('ðŸŸ¡ [AuthBloc] Google OAuth requested');
    final result = await authRepository.googleSignIn();
    result.fold(
      (failure) {
        _logger.e('ðŸ”´ [AuthBloc] Google OAuth failed: ${failure.message}');
        emit(AuthError(failure.message));
      },
      (response) {
        _logger.i('ðŸŸ¢ [AuthBloc] Emitting AuthSuccess from Google OAuth');
        emit(AuthSuccess(response.user));
      },
    );
  }

  void _onAuthForgotPasswordRequested(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.forgotPassword(event.email);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthForgotPasswordSuccess()),
    );
  }

  void _onAuthResetPasswordRequested(
    AuthResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.resetPassword(
      event.token,
      event.newPassword,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthResetPasswordSuccess()),
    );
  }
}
