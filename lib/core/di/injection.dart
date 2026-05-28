import 'package:gaspzero/features/notification/presentation/bloc/notification_stats_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart';
import 'package:uuid/uuid.dart';
import '../env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/auth_interceptor.dart';
import '../graphql/client.dart';
import '../device/device_id_provider.dart';
import '../graphql/graphql_request_executor.dart';
import '../../features/auth/data/sources/auth_local_data_source.dart';
import '../../features/auth/data/sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/data/datasources/profile_activities_remote_data_source.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/data/datasources/verification_remote_data_source.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import '../../features/profile/presentation/bloc/verification/verification_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/chat/data/sources/chat_socket_service.dart';
import '../../features/chat/data/sources/chat_remote_data_source.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/presentation/bloc/chat_bloc.dart';

import '../../features/donations/data/sources/donation_remote_data_source.dart';
import '../../features/donations/data/repositories/donation_repository_impl.dart';
import '../../features/donations/domain/repositories/donation_repository.dart';
import '../../features/donations/presentation/bloc/donations_bloc.dart';
import '../../features/favorites/data/datasources/favorites_remote_data_source.dart';
import '../../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../../features/favorites/domain/repositories/favorites_repository.dart';
import '../../features/favorites/presentation/bloc/favorites_bloc.dart';

import '../../features/reservation/data/repositories/reservation_repository_impl.dart';
import '../../features/reservation/domain/repositories/reservation_repository.dart';
import '../../features/reservation/domain/usecases/create_reservation_usecase.dart';
import '../../features/reservation/domain/usecases/get_user_donations_usecase.dart';
import '../../features/reservation/domain/usecases/get_user_reservations_usecase.dart';
import '../../features/reservation/presentation/bloc/reservation_bloc.dart';
import '../../features/reservation/data/datasources/reservation_remote_data_source.dart';

import '../../features/notification/data/sources/notification_remote_data_source.dart';
import '../../features/notification/data/repositories/notification_repository_impl.dart';
import '../../features/notification/domain/repositories/notification_repository.dart';
import '../../features/notification/domain/usecases/notification_usecases.dart';
import '../../features/notification/presentation/bloc/notification_bloc.dart';
import '../../features/notification/data/sources/fcm_token_remote_data_source.dart';
import '../../features/notification/data/sources/fcm_token_local_data_source.dart';
import '../../features/notification/data/repositories/fcm_token_repository_impl.dart';
import '../../features/notification/domain/repositories/fcm_token_repository.dart';
import '../../features/notification/domain/usecases/fcm_token_usecases.dart';
import '../../features/notification/data/services/fcm_manager.dart';
import '../../features/leaderboard/data/datasources/leaderboard_remote_data_source.dart';
import '../../features/leaderboard/data/repositories/leaderboard_repository_impl.dart';
import '../../features/leaderboard/domain/repositories/leaderboard_repository.dart';
import '../../features/leaderboard/domain/usecases/get_current_user_leaderboard_usecase.dart';
import '../../features/leaderboard/domain/usecases/get_leaderboard_usecase.dart';
import '../../features/leaderboard/presentation/bloc/leaderboard_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // ── Secure Storage ──
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => const Uuid());
  getIt.registerLazySingleton<DeviceIdProvider>(
    () => DeviceIdProvider(getIt<FlutterSecureStorage>(), getIt<Uuid>()),
  );
  getIt.registerLazySingleton<GraphqlRequestExecutor>(
    () => GraphqlRequestExecutor(getIt<DeviceIdProvider>()),
  );

  // ── SharedPreferences (async - initialize first) ──
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // ── Local Data Source (needs storage, registered early for interceptor) ──
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton<GraphQLClientFactory>(
    () => GraphQLClientFactory(
      getIt<AuthLocalDataSource>(),
      getIt<DeviceIdProvider>(),
    ),
  );
  getIt.registerLazySingleton<Client>(
    () => getIt<GraphQLClientFactory>().create(),
  );

  // â”€â”€ Dio with Auth Interceptor â”€â”€
  getIt.registerLazySingleton(() {
    final baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.gaspzero.qzz.io/',
    );

    // Check Env if using dotenv
    final envBaseUrl = Env.get('API_BASE_URL') ?? baseUrl;

    final dio = Dio(
      BaseOptions(
        baseUrl: envBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Auth interceptor â€” attaches Bearer token & handles 401 refresh
    dio.interceptors.add(
      AuthInterceptor(
        localDataSource: getIt<AuthLocalDataSource>(),
        dio: dio,
        ferryClient: getIt<Client>(),
      ),
    );

    // Logging interceptor (keep last so it logs the final request)
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ),
    );

    return dio;
  });

  // â”€â”€ Remote Data Source â”€â”€
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt(), getIt(), getIt(), getIt()),
  );

  // ── Repository ──
  getIt.registerLazySingleton<AuthRepository>(
    () =>
        AuthRepositoryImpl(remoteDataSource: getIt(), localDataSource: getIt()),
  );

  // ── Profile Repository ──
  getIt.registerLazySingleton<ProfileActivitiesRemoteDataSource>(
    () => ProfileActivitiesRemoteDataSourceImpl(getIt<Client>(), getIt()),
  );

  getIt.registerLazySingleton<VerificationRemoteDataSource>(
    () => VerificationRemoteDataSourceImpl(getIt<Client>(), getIt()),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      authRepository: getIt(),
      profileActivitiesRemoteDataSource: getIt(),
      verificationRemoteDataSource: getIt(),
    ),
  );

  // ── BLoC ──
  getIt.registerFactory(() => AuthBloc(authRepository: getIt()));

  // ── Profile BLoC ──
  getIt.registerFactory(() => ProfileBloc(profileRepository: getIt()));

  // ── Verification BLoC ──
  getIt.registerFactory(() => VerificationBloc(profileRepository: getIt()));

  // ── Donations ──
  getIt.registerLazySingleton<DonationRemoteDataSource>(
    () => DonationRemoteDataSourceImpl(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<DonationRepository>(
    () => DonationRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerFactory(() => DonationsBloc(donationRepository: getIt()));

  // ── Favorites ──
  getIt.registerLazySingleton<FavoritesRemoteDataSource>(
    () => FavoritesRemoteDataSourceImpl(getIt<Client>(), getIt()),
  );
  getIt.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerFactory(() => FavoritesBloc(favoritesRepository: getIt()));

  // ── Reservation ──
  getIt.registerLazySingleton<ReservationRemoteDataSource>(
    () => ReservationRemoteDataSourceImpl(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpl(
      remoteDataSource: getIt(),
      donationRemoteDataSource: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetUserDonationsUseCase>(
    () => GetUserDonationsUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetUserReservationsUseCase>(
    () => GetUserReservationsUseCase(getIt()),
  );
  getIt.registerLazySingleton<CreateReservationUseCase>(
    () => CreateReservationUseCase(getIt()),
  );
  getIt.registerFactory(
    () => ReservationBloc(
      getUserDonationsUseCase: getIt(),
      getUserReservationsUseCase: getIt(),
      createReservationUseCase: getIt(),
      repository: getIt(),
    ),
  );

  // ── Chat ──
  getIt.registerLazySingleton<ChatSocketService>(
    () => ChatSocketService(getIt()),
  );
  getIt.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(getIt(), getIt(), getIt()),
  );
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(getIt()),
  );
  getIt.registerFactory(
    () => ChatBloc(chatRepository: getIt(), ferryClient: getIt()),
  );

  // ── Notification ──
  getIt.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<MarkAllNotificationsAsReadUseCase>(
    () => MarkAllNotificationsAsReadUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<MarkNotificationsAsReadUseCase>(
    () => MarkNotificationsAsReadUseCase(repository: getIt()),
  );
  getIt.registerLazySingleton<DeleteNotificationUseCase>(
    () => DeleteNotificationUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<GetNotificationStatsUseCase>(
    () => GetNotificationStatsUseCase(repository: getIt()),
  );

  getIt.registerLazySingleton<FcmTokenRemoteDataSource>(
    () => FcmTokenRemoteDataSourceImpl(getIt(), getIt()),
  );

  getIt.registerLazySingleton<FcmTokenLocalDataSource>(
    () => FcmTokenLocalDataSourceImpl(getIt()),
  );

  getIt.registerLazySingleton<FcmTokenRepository>(
    () => FcmTokenRepositoryImpl(getIt(), getIt()),
  );

  getIt.registerSingleton<RegisterFcmTokenUseCase>(
    RegisterFcmTokenUseCase(getIt()),
  );

  getIt.registerSingleton<GetFcmTokenUseCase>(GetFcmTokenUseCase(getIt()));

  getIt.registerSingleton<CheckFcmTokenRegistrationUseCase>(
    CheckFcmTokenRegistrationUseCase(getIt()),
  );

  getIt.registerSingleton<DeleteFcmTokenUseCase>(
    DeleteFcmTokenUseCase(getIt()),
  );

  getIt.registerSingleton<GetLastTokenRegistrationTimeUseCase>(
    GetLastTokenRegistrationTimeUseCase(getIt()),
  );

  getIt.registerLazySingleton<FcmManager>(() => FcmManager());

  getIt.registerFactory(() {
    // Try to get FcmManager, but provide null if Firebase isn't configured
    FcmManager? fcmManager;
    try {
      fcmManager = getIt<FcmManager>();
    } catch (e) {
      print('⚠️ FcmManager not available (Firebase not configured)');
    }

    return NotificationBloc(
      getNotificationsUseCase: getIt(),
      markAllNotificationsAsReadUseCase: getIt(),
      markNotificationsAsReadUseCase: getIt(),
      deleteNotificationUseCase: getIt(),
      registerFcmTokenUseCase: getIt(),
      getFcmTokenUseCase: getIt(),
      checkFcmTokenRegistrationUseCase: getIt(),
      deleteFcmTokenUseCase: getIt(),
      getLastTokenRegistrationTimeUseCase: getIt(),
      fcmManager: fcmManager,
    );
  });

  getIt.registerLazySingleton<NotificationStatsBloc>(
    () => NotificationStatsBloc(getNotificationStatsUseCase: getIt()),
  );

  // ── Leaderboard ──
  getIt.registerLazySingleton<LeaderboardRemoteDataSource>(
    () => LeaderboardRemoteDataSourceImpl(getIt(), getIt()),
  );
  getIt.registerLazySingleton<LeaderboardRepository>(
    () => LeaderboardRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<GetLeaderboardUseCase>(
    () => GetLeaderboardUseCase(getIt()),
  );
  getIt.registerLazySingleton<GetCurrentUserLeaderboardUseCase>(
    () => GetCurrentUserLeaderboardUseCase(getIt()),
  );
  getIt.registerFactory(
    () => LeaderboardBloc(
      getLeaderboardUseCase: getIt(),
      getCurrentUserLeaderboardUseCase: getIt(),
    ),
  );
}
