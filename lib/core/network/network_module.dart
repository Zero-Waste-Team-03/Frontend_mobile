import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../env.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio {
    final baseUrl = Env.get('API_BASE_URL') ?? 'https://api.gaspzero.qzz.io/';
    
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging, auth tokens, etc.
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));

    return dio;
  }
}
