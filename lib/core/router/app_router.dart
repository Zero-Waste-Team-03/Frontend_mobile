import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/intro_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_flow_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/home_placeholder_page.dart';
import '../../features/map/presentation/pages/map_placeholder_page.dart';
import '../../features/chat/presentation/pages/chat_placeholder_page.dart';
import '../../features/profile/presentation/pages/profile_placeholder_page.dart';
import '../../shared/widgets/main_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // ── Auth routes (no bottom nav) ──
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
      builder: (context, state) => const RegisterFlowPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),

    // ── Main app routes (with bottom nav) ──
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0 — Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePlaceholderPage(),
            ),
          ],
        ),
        // Tab 1 — Map
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/map',
              builder: (context, state) => const MapPlaceholderPage(),
            ),
          ],
        ),
        // Tab 2 — Chat
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) => const ChatPlaceholderPage(),
            ),
          ],
        ),
        // Tab 3 — Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePlaceholderPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
