import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/intro_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_step1_page.dart';
import '../../features/auth/presentation/pages/register_step2_page.dart';
import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/auth/presentation/pages/home_placeholder_page.dart';
import '../di/injection.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) => getIt<AuthBloc>(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const IntroPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterStep1Page(),
        ),
        GoRoute(
          path: '/step2',
          builder: (context, state) {
            final step1Data = state.extra as Map<String, String>? ?? {};
            return RegisterStep2Page(step1Data: step1Data);
          },
        ),
        GoRoute(
          path: '/otp',
          builder: (context, state) {
            final userData = state.extra as Map<String, String>? ?? {};
            return OtpVerificationPage(userData: userData);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePlaceholderPage(),
    ),
  ],
);
