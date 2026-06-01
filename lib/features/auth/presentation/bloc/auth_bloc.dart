import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:gaspzero/features/notification/data/services/fcm_initialization_service.dart';
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
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthResetRequested>(_onAuthResetRequested);
  }

  void _onAuthResetRequested(
    AuthResetRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthInitial());
  }

  void _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthChecking());
    final result = await authRepository.getCurrentUser();
    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await authRepository.login(event.email, event.password);
    result.fold((failure) => emit(AuthError(failure.message)), (
      response,
    ) async {
      emit(AuthSuccess(response.user));
    });
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
      zipCode: event.zipCode,
      latitude: event.latitude,
      longitude: event.longitude,
      neighborhood: event.neighborhood,
    );
    await registerResult.fold(
      (failure) async => emit(AuthError(failure.message)),
      (_) async {
        // Registration successful, now auto-login to get tokens
        final loginResult = await authRepository.login(
          event.email,
          event.password,
        );
        loginResult.fold((failure) => emit(AuthError(failure.message)), (
          response,
        ) async {
          emit(AuthSuccess(response.user));
        });
      },
    );
  }

  void _onAuthGoogleLoginRequested(
    AuthGoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    _logger.i('🟡 [AuthBloc] Google OAuth requested');
    final result = await authRepository.googleSignIn();
    result.fold(
      (failure) {
        _logger.e('🔴 [AuthBloc] Google OAuth failed: ${failure.message}');
        // Reset state immediately on failure
        emit(AuthError(failure.message));
        emit(AuthInitial());
      },
      (response) {
        _logger.i('🟢 [AuthBloc] Emitting AuthSuccess from Google OAuth');
        FcmInitializationService.initializeAfterLogin();
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
      (failure) => emit(AuthResetPasswordSuccess()), // Or just stay on success
      (_) => emit(AuthResetPasswordSuccess()),
    );
  }

  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    _logger.i('[AuthBloc] Logout requested, clearing session');
    await authRepository.logout();
    emit(AuthUnauthenticated());
  }
}
