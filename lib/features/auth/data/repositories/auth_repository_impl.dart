import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import '../../../../core/errors/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../notification/data/services/fcm_manager.dart';
import '../../../notification/domain/usecases/fcm_token_usecases.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_local_data_source.dart';
import '../sources/auth_remote_data_source.dart';

import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  static const String _oauthCallbackScheme = String.fromEnvironment(
    'OAUTH_CALLBACK_SCHEME',
    defaultValue: 'zerowaste',
  );
  static const String _oauthCallbackHost = String.fromEnvironment(
    'OAUTH_CALLBACK_HOST',
    defaultValue: 'oauth-callback',
  );
  final AppLinks _appLinks = AppLinks();
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  Future<Either<Failure, AuthResponse>> login(
    String email,
    String password,
  ) async {
    try {
      final responseModel = await remoteDataSource.login(email, password);

      // Block admin users from using the mobile app
      final user = responseModel.toEntity().user;
      if (user != null && user.isAdmin) {
        return Left(
          ServerFailure(
            'Admin accounts cannot access the mobile app. Please use the web dashboard.',
          ),
        );
      }

      if (responseModel.accessToken != null) {
        _logger.i(
          '🔑 Login Tokens Received:\nAccess: ${responseModel.accessToken}\nRefresh: ${responseModel.refreshToken}',
        );
        await localDataSource.cacheTokens(
          responseModel.accessToken!,
          responseModel.refreshToken,
        );
      }

      // Cache user profile
      if (responseModel.user != null) {
        await localDataSource.cacheUserProfile(responseModel.user!);
      }

      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendOtp(String email) async {
    try {
      await remoteDataSource.sendOtp(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String displayName,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String otp,
    String? city,
    String? country,
    double? latitude,
    double? longitude,
    String? neighborhood,
  }) async {
    try {
      await remoteDataSource.register(
        displayName: displayName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        confirmPassword: confirmPassword,
        otp: otp,
        city: city,
        country: country,
        latitude: latitude,
        longitude: longitude,
        neighborhood: neighborhood,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> oAuthLogin(
    String provider,
    String accessToken,
  ) async {
    try {
      final responseModel = await remoteDataSource.oAuthLogin(
        provider,
        accessToken,
      );

      // Block admin users from using the mobile app
      final user = responseModel.toEntity().user;
      if (user != null && user.isAdmin) {
        return Left(
          ServerFailure(
            'Admin accounts cannot access the mobile app. Please use the web dashboard.',
          ),
        );
      }

      if (responseModel.accessToken != null) {
        await localDataSource.cacheTokens(
          responseModel.accessToken!,
          responseModel.refreshToken,
        );
      }

      // Cache user profile
      if (responseModel.user != null) {
        await localDataSource.cacheUserProfile(responseModel.user!);
      }

      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> googleSignIn() async {
    StreamSubscription<Uri>? sub;
    try {
      final authUrl = remoteDataSource.getOAuthProviderEntryUrl('google');
      _logger.i('[OAuth] Launching sign-in URL: $authUrl');

      final callbackCompleter = Completer<Uri>();

      Future<void> completeIfCallback(Uri? uri, String source) async {
        if (uri == null) return;
        if (!_isOAuthCallback(uri) || callbackCompleter.isCompleted) return;
        _logger.i('â†©ï¸ [OAuth] Callback received from $source: $uri');
        _logger.i('ðŸ§© [OAuth] Callback query params: ${uri.queryParameters}');
        _logger.i('ðŸ§© [OAuth] Callback fragment: ${uri.fragment}');
        callbackCompleter.complete(uri);
      }

      await completeIfCallback(
        await _appLinks.getInitialLink(),
        'initial-link',
      );

      sub = _appLinks.uriLinkStream.listen((uri) {
        completeIfCallback(uri, 'stream');
      });

      final authUri = Uri.parse(authUrl);
      var launched = false;

      try {
        launched = await launchUrl(authUri, mode: LaunchMode.inAppBrowserView);
      } catch (_) {
        launched = false;
      }

      if (!launched) {
        launched = await launchUrl(
          authUri,
          mode: LaunchMode.externalApplication,
        );
      }

      if (!launched) {
        return Left(ServerFailure('Failed to open Google sign-in page.'));
      }

      final callbackUri = await callbackCompleter.future.timeout(
        const Duration(minutes: 3),
        onTimeout: () => throw ServerException('Google sign-in timed out.'),
      );

      final accessToken = _extractToken(
        callbackUri,
        keys: const ['accessToken', 'access_token', 'token'],
      );
      final refreshToken = _extractToken(
        callbackUri,
        keys: const ['refreshToken', 'refresh_token'],
      );
      final error = _extractToken(
        callbackUri,
        keys: const ['error', 'message'],
      );

      if (error != null && error.isNotEmpty) {
        return Left(ServerFailure(error));
      }
      if (accessToken == null || accessToken.isEmpty) {
        _logger.e(
          'âŒ [OAuth] Missing access token in callback URI: $callbackUri',
        );
        return Left(ServerFailure('No access token found in OAuth callback.'));
      }

      _logger.i(
        'ðŸ” [OAuth] Extracted tokens | access: ${_previewToken(accessToken)} | '
        'refresh: ${_previewToken(refreshToken)}',
      );

      await localDataSource.cacheTokens(accessToken, refreshToken);
      _logger.i('ðŸ’¾ [OAuth] Tokens cached in secure storage');
      final userModel = await _getCurrentUserWithRefreshRetry();
      final user = userModel.toEntity();
      _logger.i(
        'ðŸ‘¤ [OAuth] currentUser loaded: id=${user.id} email=${user.email}',
      );

      if (user.isAdmin) {
        await localDataSource.clearTokens();
        return Left(
          ServerFailure(
            'Admin accounts cannot access the mobile app. Please use the web dashboard.',
          ),
        );
      }

      _logger.i('âœ… [OAuth] Returning success to AuthBloc for navigation');
      return Right(
        AuthResponse(
          accessToken: accessToken,
          refreshToken: refreshToken,
          user: user,
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    } finally {
      await sub?.cancel();
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userModel = await _getCurrentUserWithRefreshRetry();
      final user = userModel.toEntity();

      // Block admin users from using the mobile app
      if (user.isAdmin) {
        await localDataSource.clearTokens();
        return Left(
          ServerFailure(
            'Admin accounts cannot access the mobile app. Please use the web dashboard.',
          ),
        );
      }

      // Cache user profile
      await localDataSource.cacheUserProfile(userModel);

      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _clearFcmTokenOnLogout();

      try {
        final access_token = await localDataSource.getAccessToken();
        final refresh_token = await localDataSource.getRefreshToken();
        if (access_token !=null && access_token != '' && refresh_token !=null && refresh_token != '') {
          await remoteDataSource.logout();
        };
      } on ServerException catch (e, stackTrace) {
        _logger.w(
          '⚠️ [AuthRepository] Remote logout failed; continuing with local sign-out: ${e.message}',
          error: e,
          stackTrace: stackTrace,
        );
      } catch (e, stackTrace) {
        _logger.w(
          '⚠️ [AuthRepository] Unexpected remote logout error; continuing with local sign-out',
          error: e,
          stackTrace: stackTrace,
        );
      }

      await localDataSource.clearTokens();
      await localDataSource.clearUserProfile();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changePassword(
    String oldPassword,
    String newPassword, {
    bool logoutFromOtherDevices = false,
  }) async {
    try {
      await remoteDataSource.changePassword(
        oldPassword,
        newPassword,
        logoutFromOtherDevices: logoutFromOtherDevices,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword(String email) async {
    try {
      await remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
    String token,
    String newPassword,
  ) async {
    try {
      await remoteDataSource.resetPassword(token, newPassword);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> refreshTokens() async {
    try {
      final responseModel = await remoteDataSource.refreshTokens();

      final user = responseModel.toEntity().user;
      if (user != null && user.isAdmin) {
        return Left(
          ServerFailure(
            'Admin accounts cannot access the mobile app. Please use the web dashboard.',
          ),
        );
      }

      if (responseModel.accessToken != null) {
        _logger.i(
          '🔄 Refresh Tokens Received:\nAccess: ${responseModel.accessToken}\nRefresh: ${responseModel.refreshToken}',
        );
        await localDataSource.cacheTokens(
          responseModel.accessToken!,
          responseModel.refreshToken,
        );
      }
      return Right(responseModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logoutFromAllDevices() async {
    try {
      await remoteDataSource.logoutFromAllDevices();
      await _clearFcmTokenOnLogout();
      await localDataSource.clearTokens();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await remoteDataSource.deleteAccount();
      await localDataSource.clearTokens();
      await localDataSource.clearUserProfile();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? displayName,
    String? email,
    String? phoneNumber,
    Map<String, dynamic>? location,
    Map<String, dynamic>? settings,
  }) async {
    try {
      final userModel = await remoteDataSource.updateProfile(
        displayName: displayName,
        email: email,
        phoneNumber: phoneNumber,
        location: location,
        settings: settings,
      );

      // Cache the updated user profile
      await localDataSource.cacheUserProfile(userModel);

      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserSettings({
    required bool isPushNotificationsEnabled,
    required bool isNewDonationsAlertsEnabled,
    required bool isUrgentAlertsEnabled,
    required bool isSystemReports,
    required String appearance,
  }) async {
    try {
      final userModel = await remoteDataSource.updateUserSettings(
        isPushNotificationsEnabled: isPushNotificationsEnabled,
        isNewDonationsAlertsEnabled: isNewDonationsAlertsEnabled,
        isUrgentAlertsEnabled: isUrgentAlertsEnabled,
        isSystemReports: isSystemReports,
        appearance: appearance,
      );

      await localDataSource.cacheUserProfile(userModel);

      return Right(userModel.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      final cachedUserModel = await localDataSource.getCachedUserProfile();

      if (cachedUserModel == null) {
        return Left(CacheFailure('No cached user profile found'));
      }

      return Right(cachedUserModel.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<void> _clearFcmTokenOnLogout() async {
    try {
      final fcmManager = GetIt.I<FcmManager>();
      await fcmManager.deleteToken();
    } catch (e, stackTrace) {
      _logger.w(
        '⚠️ [AuthRepository] Unable to delete Firebase Messaging token during logout',
        error: e,
        stackTrace: stackTrace,
      );
    }

    try {
      final deleteFcmTokenUseCase = GetIt.I<DeleteFcmTokenUseCase>();
      final result = await deleteFcmTokenUseCase();
      result.fold(
        (failure) {
          _logger.w(
            '⚠️ [AuthRepository] Unable to clear cached FCM token during logout: ${failure.message}',
          );
        },
        (_) {
          _logger.i(
            '✅ [AuthRepository] Cached FCM token cleared during logout',
          );
        },
      );
    } catch (e, stackTrace) {
      _logger.w(
        '⚠️ [AuthRepository] Unable to clear cached FCM token during logout',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<dynamic> uploadProfileAvatar(File file) async {
    try {
      final result = await remoteDataSource.uploadProfileAvatar(file);
      return result;
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<User> updateProfileWithAvatarId(String avatarAttachmentId) async {
    try {
      final userModel = await remoteDataSource.updateProfileWithAvatarId(
        avatarAttachmentId,
      );

      // Cache the updated user profile
      await localDataSource.cacheUserProfile(userModel);

      return userModel.toEntity();
    } on ServerException {
      rethrow;
    }
  }

  bool _isOAuthCallback(Uri uri) {
    return uri.scheme == _oauthCallbackScheme && uri.host == _oauthCallbackHost;
  }

  String? _extractToken(Uri uri, {required List<String> keys}) {
    final allParams = <String, String>{};
    allParams.addAll(uri.queryParameters);

    if (uri.fragment.isNotEmpty) {
      final fragment = uri.fragment;

      void addFragmentParams(String raw) {
        if (raw.isEmpty || !raw.contains('=')) return;
        try {
          allParams.addAll(Uri.splitQueryString(raw));
        } catch (_) {}
      }

      addFragmentParams(fragment);
      addFragmentParams(
        fragment.startsWith('?') ? fragment.substring(1) : fragment,
      );

      final fragmentQueryIndex = fragment.indexOf('?');
      if (fragmentQueryIndex >= 0 && fragmentQueryIndex + 1 < fragment.length) {
        addFragmentParams(fragment.substring(fragmentQueryIndex + 1));
      }
    }

    for (final key in keys) {
      final value = allParams[key];
      if (value != null && value.isNotEmpty) {
        return Uri.decodeComponent(value);
      }
    }
    return null;
  }

  String _previewToken(String? token) {
    if (token == null || token.isEmpty) return '<none>';
    if (token.length <= 14) return token;
    return '${token.substring(0, 8)}...${token.substring(token.length - 6)}';
  }

  bool _isUnauthorizedMessage(String message) {
    final lower = message.toLowerCase();
    return lower.contains('unauthorized') ||
        lower.contains('unauthenticated') ||
        lower.contains('401');
  }

  Future<dynamic> _refreshAndCacheTokens() async {
    final refreshed = await remoteDataSource.refreshTokens();
    final nextAccessToken = refreshed.accessToken;
    if (nextAccessToken == null || nextAccessToken.isEmpty) {
      throw ServerException('RefreshTokens returned no access token');
    }
    await localDataSource.cacheTokens(nextAccessToken, refreshed.refreshToken);
    _logger.i('🔄 [AuthRepository] Tokens refreshed and cached');
    return refreshed;
  }

  Future<dynamic> _getCurrentUserWithRefreshRetry() async {
    try {
      return await remoteDataSource.getCurrentUser();
    } on ServerException catch (e) {
      if (!_isUnauthorizedMessage(e.message)) {
        rethrow;
      }

      _logger.w(
        '⚠️ [AuthRepository] getCurrentUser unauthorized; trying refreshTokens then retry',
      );

      try {
        await _refreshAndCacheTokens();
        return await remoteDataSource.getCurrentUser();
      } catch (refreshErr) {
        _logger.e('❌ [AuthRepository] Refresh failed, clearing local session');
        await localDataSource.clearTokens();
        await localDataSource.clearUserProfile();
        rethrow;
      }
    }
  }
}
