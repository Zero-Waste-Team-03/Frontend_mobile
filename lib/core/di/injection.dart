import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../env.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/auth_interceptor.dart';
import '../../features/auth/data/sources/auth_local_data_source.dart';
import '../../features/auth/data/sources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/donations/data/sources/donation_remote_data_source.dart';
import '../../features/donations/data/repositories/donation_repository_impl.dart';
import '../../features/donations/domain/repositories/donation_repository.dart';
import '../../features/donations/presentation/bloc/donations_bloc.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // ── Secure Storage ──
  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  // ── SharedPreferences (async - initialize first) ──
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // ── Local Data Source (needs storage, registered early for interceptor) ──
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt(), getIt()),
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
      AuthInterceptor(localDataSource: getIt<AuthLocalDataSource>(), dio: dio),
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
    () => AuthRemoteDataSourceImpl(getIt()),
  );

  // ── Repository ──
  getIt.registerLazySingleton<AuthRepository>(
    () =>
        AuthRepositoryImpl(remoteDataSource: getIt(), localDataSource: getIt()),
  );

  // ── Profile Repository ──
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(authRepository: getIt()),
  );

  // ── BLoC ──
  getIt.registerFactory(() => AuthBloc(authRepository: getIt()));

  // ── Profile BLoC ──
  getIt.registerFactory(() => ProfileBloc(profileRepository: getIt()));

  // ── Donations ──
  getIt.registerLazySingleton<DonationRemoteDataSource>(
      () => DonationRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<DonationRepository>(
      () => DonationRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerFactory(() => DonationsBloc(donationRepository: getIt()));
}
