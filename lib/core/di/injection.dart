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
  // â”€â”€ Secure Storage â”€â”€
  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  // â”€â”€ Local Data Source (needs storage, registered early for interceptor) â”€â”€
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(getIt()));

  // â”€â”€ Dio with Auth Interceptor â”€â”€
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

    // Auth interceptor â€” attaches Bearer token & handles 401 refresh
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

  // â”€â”€ Remote Data Source â”€â”€
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(getIt()));

  // â”€â”€ Repository â”€â”€
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));

  // â”€â”€ BLoC â”€â”€
  getIt.registerLazySingleton(() => AuthBloc(authRepository: getIt()));
}
