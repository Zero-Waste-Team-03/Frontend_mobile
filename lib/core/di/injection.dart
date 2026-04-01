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

final getIt = GetIt.instance;

void configureDependencies() {
  // ── Secure Storage ──
  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  // ── Local Data Source (needs storage, registered early for interceptor) ──
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(getIt()));

  // ── Dio with Auth Interceptor ──
  getIt.registerLazySingleton(() {
    final baseUrl = const String.fromEnvironment('API_BASE_URL',
        defaultValue: 'https://api.gaspzero.qzz.io/');

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

    // Auth interceptor — attaches Bearer token & handles 401 refresh
    dio.interceptors.add(AuthInterceptor(
      localDataSource: getIt<AuthLocalDataSource>(),
      dio: dio,
    ));

    // Logging interceptor (keep last so it logs the final request)
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    return dio;
  });

  // ── Remote Data Source ──
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()));

  // ── Repository ──
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));

  // ── BLoC ──
  getIt.registerLazySingleton(() => AuthBloc(authRepository: getIt()));
}
