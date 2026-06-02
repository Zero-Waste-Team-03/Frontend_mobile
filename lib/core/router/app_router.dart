import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:gaspzero/features/leaderboard/presentation/pages/leaderboard_page.dart';
import 'package:gaspzero/features/leaderboard/presentation/bloc/leaderboard_bloc.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/intro_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_flow_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/chat/presentation/pages/archived_chats_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/chat/presentation/pages/chats_list_page.dart';
import '../../features/donations/domain/entities/donation.dart';
import '../../features/donations/presentation/bloc/donations_bloc.dart';
import '../../features/donations/presentation/bloc/donations_event.dart';
import '../../features/donations/presentation/pages/update_delete_donation_page.dart';
import '../../features/profile/presentation/pages/my_activities_page.dart';
import '../../features/donations/presentation/pages/add_donation_page.dart';
import '../../features/donations/presentation/pages/donation_details_page.dart';
import '../../features/donations/presentation/pages/donations_home_page.dart';
import '../../features/donations/presentation/pages/donations_list_page.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/notification/presentation/bloc/notification_bloc.dart';
import '../../features/notification/presentation/pages/notifications_page.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/profile/presentation/bloc/profile_event.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../features/profile/presentation/pages/help_support_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/saver_analytics_page.dart';
import '../../features/profile/presentation/pages/verification_requests_page.dart';
import '../../features/profile/presentation/pages/find_verifier_page.dart';
import '../../features/donations/presentation/pages/my_listings_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/reservation/presentation/bloc/reservation_bloc.dart';
import '../../features/reservation/presentation/pages/donation_details_full_page.dart';
import '../../features/reservation/presentation/pages/my_reservations_page.dart';
import '../../features/reservation/presentation/pages/reservation_details_page.dart';
import '../../shared/widgets/main_shell.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
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
      path: AppRoutes.donationDetails,
      builder: (context, state) {
        final donation = state.extra as Donation;
        return DonationDetailsPage(donation: donation);
      },
    ),
    GoRoute(
      path: AppRoutes.updateDonation,
      builder: (context, state) {
        final donation = state.extra as Donation;
        return BlocProvider(
          create: (context) => getIt<DonationsBloc>(),
          child: UpdateDeleteDonationPage(donation: donation),
        );
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
          create: (context) => getIt<ProfileBloc>(),
          child: const MyActivitiesPage(),
        );
      },
    ),
    GoRoute(
      path: '/favorites',
      builder: (context, state) {
        return BlocProvider(
          create: (context) => getIt<FavoritesBloc>(),
          child: const FavoritesPage(),
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

    GoRoute(
      path: '/chat',
      builder: (context, state) {
        final extra = state.extra;
        String? reservationId;
        String? conversationId;

        if (extra is String) {
          reservationId = extra;
        } else if (extra is Map) {
          final extraMap = Map<String, dynamic>.from(extra);
          reservationId = extraMap['reservationId'] as String?;
          conversationId = extraMap['conversationId'] as String?;
        }

        if (reservationId == null && conversationId == null) {
          return const Scaffold(body: Center(child: Text('Invalid chat')));
        }
        return ChatPage(
          reservationId: reservationId,
          conversationId: conversationId,
        );
      },
    ),
    GoRoute(path: '/chats', builder: (context, state) => const ChatsListPage()),
    GoRoute(
      path: '/archived-chats',
      builder: (context, state) => const ArchivedChatsPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShell(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const DonationsHomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/browse',
              builder: (context, state) => const DonationsListPage(),
            ),
          ],
        ),
        // Tab 2 â€” Leaderboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/leaderboard',
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => getIt<LeaderboardBloc>(),
                  child: const LeaderboardPage(),
                );
              },
            ),
          ],
        ),
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
                    GoRoute(
                      path: 'settings',
                      builder: (context, state) => const SettingsPage(),
                    ),
                    GoRoute(
                      path: 'help-support',
                      builder: (context, state) => const HelpSupportPage(),
                    ),
                    GoRoute(
                      path: 'my-listings',
                      builder: (context, state) => const MyListingsPage(),
                    ),
                    GoRoute(
                      path: 'saver-analytics',
                      builder: (context, state) => const SaverAnalyticsPage(),
                    ),
                    GoRoute(
                      path: 'verification-requests',
                      builder: (context, state) =>
                          const VerificationRequestsPage(),
                    ),
                    GoRoute(
                      path: 'find-verifier',
                      builder: (context, state) => const FindVerifierPage(),
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
