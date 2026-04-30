import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'core/router/app_router.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/notification/data/services/fcm_initialization_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'l10n/app_localizations.dart';

final Logger _logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 3,
    lineLength: 80,
    colors: true,
    printEmojis: false,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _logger.i('🚀 main(): App initialization starting...');

  // Load environment variables from .env
  try {
    await dotenv.load(fileName: ".env");
    _logger.i('✅ main(): .env file loaded');
  } catch (e) {
    _logger.w('⚠️  main(): .env file not found, continuing without it.');
  }

  // Setup Dependency Injection initialized by injectable
  _logger.i('📦 main(): Configuring dependencies...');
  await configureDependencies();
  _logger.i('✅ main(): Dependencies configured');

  // Initialize FCM (Firebase Cloud Messaging)
  _logger.i('🔔 main(): Initializing FCM...');
  try {
    await FcmInitializationService.initializeFcm();
    _logger.i('✅ main(): FCM initialized');
  } catch (e, stackTrace) {
    _logger.e(
      '❌ main(): Error initializing FCM',
      error: e,
      stackTrace: stackTrace,
    );
  }

  _logger.i('🎯 main(): Running app...');
  runApp(const GaspZeroApp());
}

class GaspZeroApp extends StatefulWidget {
  const GaspZeroApp({super.key});

  @override
  State<GaspZeroApp> createState() => _GaspZeroAppState();
}

class _GaspZeroAppState extends State<GaspZeroApp> {
  @override
  void initState() {
    super.initState();
    // Initialize FCM after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _logger.i(
        '🔔 _GaspZeroAppState.initState(): Initializing FCM after first frame...',
      );
      FcmInitializationService.initializeFcmAfterBuild(context);

      // Log FCM status for debugging
      _logger.i('📊 _GaspZeroAppState.initState(): Logging FCM status...');
      FcmInitializationService.logFcmStatus();
    });
  }

  @override
  void dispose() {
    _logger.i('🔌 _GaspZeroAppState.dispose(): Cleaning up FCM...');
    FcmInitializationService.cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852), // iPhone 14 Pro typical Figma size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(AuthCheckRequested()),
          child: MaterialApp.router(
            title: "Gasp'Zero",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              return BlocListener<AuthBloc, AuthState>(
                listenWhen: (previous, current) => current is AuthSuccess,
                listener: (context, state) {
                  appRouter.go('/home');
                },
                child: child ?? const SizedBox.shrink(),
              );
            },
            routerConfig: appRouter,
          ),
        );
      },
    );
  }
}
