import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/intro_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_flow_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/donations/presentation/pages/donations_home_page.dart';
import '../../features/donations/presentation/pages/donation_details_page.dart';
import '../../features/donations/domain/entities/donation.dart';
import '../../features/donations/presentation/pages/donations_list_page.dart';
import '../../features/donations/presentation/bloc/donations_bloc.dart';
import '../../features/donations/presentation/bloc/donations_event.dart';
import '../../features/chat/presentation/pages/chat_placeholder_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/donations/presentation/pages/add_donation_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/profile/presentation/bloc/profile_event.dart';
import '../../features/reservation/presentation/pages/my_activities_page.dart';
import '../../features/reservation/presentation/pages/my_reservations_page.dart';
import '../../features/reservation/presentation/pages/donation_details_full_page.dart';
import '../../features/reservation/presentation/pages/reservation_details_page.dart';
import '../../features/reservation/presentation/bloc/reservation_bloc.dart';
import '../../features/notification/presentation/pages/notifications_page.dart';
import '../../features/notification/presentation/bloc/notification_bloc.dart';
import '../../shared/widgets/main_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // â”€â”€ Auth routes (no bottom nav) â”€â”€
    GoRoute(path: '/', builder: (context, state) => const IntroPage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterFlowPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/donation-details',
      builder: (context, state) {
        final donation = state.extra as Donation;
        return DonationDetailsPage(donation: donation);
      },
    ),
    GoRoute(
      path: '/add-donation',
      builder: (context, state) {
        return BlocProvider(
          create: (context) =>
              getIt<DonationsBloc>()..add(const LoadDonationsEvent()),
          child: const AddDonationPage(),
        );
      },
    ),
    GoRoute(
      path: '/donation-details-full',
      builder: (context, state) {
        final donation = state.extra as Donation;
        return BlocProvider(
          create: (context) => getIt<ReservationBloc>(),
          child: DonationDetailsFullPage(donation: donation),
        );
      },
    ),
    GoRoute(
      path: '/my-activities',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => getIt<ReservationBloc>(),
          child: const MyActivitiesPage(),
        );
      },
    ),
    GoRoute(
      path: '/my-reservations',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => getIt<ReservationBloc>(),
          child: const MyReservationsPage(),
        );
      },
    ),
    GoRoute(
      path: '/reservation-details',
      builder: (context, state) {
        final reservationId = state.extra as String;
        return BlocProvider(
          create: (context) => getIt<ReservationBloc>(),
          child: ReservationDetailsPage(reservationId: reservationId),
        );
      },
    ),
    GoRoute(
      path: '/notifications',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => getIt<NotificationBloc>(),
          child: const NotificationsPage(),
        );
      },
    ),
    // â”€â”€ Main app routes (with bottom nav) â”€â”€
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0 â€” Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const DonationsHomePage(),
            ),
          ],
        ),
        // Tab 1 â€” Browse
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/browse',
              builder: (context, state) => const DonationsListPage(),
            ),
          ],
        ),
        // Tab 2 â€” Chat
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/chat',
              builder: (context, state) => const ChatPlaceholderPage(),
            ),
          ],
        ),
        // Tab 3 â€” Profile
        StatefulShellBranch(
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                return BlocProvider(
                  create: (context) =>
                      getIt<ProfileBloc>()..add(const ProfileLoadRequested()),
                  child: child,
                );
              },
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (context, state) => const ProfilePage(),
                  routes: [
                    GoRoute(
                      path: 'edit',
                      builder: (context, state) => const EditProfilePage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
