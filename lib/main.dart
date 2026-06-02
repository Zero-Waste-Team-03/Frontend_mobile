import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'core/router/app_router.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'features/auth/data/sources/auth_local_data_source.dart';
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
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FcmInitializationService.initializeFcmAfterBuild(context);
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
    // Create ThemeCubit and register it so other blocs can access it via GetIt
    final themeCubit = ThemeCubit(GetIt.I<AuthLocalDataSource>());
    if (!GetIt.I.isRegistered<ThemeCubit>()) {
      GetIt.I.registerSingleton<ThemeCubit>(themeCubit);
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(AuthCheckRequested()),
        ),
        BlocProvider<ThemeCubit>(create: (_) => themeCubit),
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852), // iPhone 14 Pro typical Figma size
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: "Gasp'Zero",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: context.select((ThemeCubit c) => c.state),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (context, child) {
              return BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    // On login, update theme from returned user settings if available
                    try {
                      final appearance = state.user?.settings?.appearance;
                      if (appearance != null) {
                        context.read<ThemeCubit>().setFromAppearance(
                          appearance,
                        );
                      }
                    } catch (_) {}
                    appRouter.go('/home');
                  } else if (state is AuthUnauthenticated) {
                    final router = appRouter;
                    final String location = router.routerDelegate.currentConfiguration.last.matchedLocation;
                    if (location != '/login' && 
                        location != '/register' && 
                        location != '/forgot-password' && 
                        location != '/') {
                      router.go('/');
                    }
                  } else if (state is AuthChecking) {
                    appRouter.go('/splash');
                  }
                },
                child: child ?? const SizedBox.shrink(),
              );
            },
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
