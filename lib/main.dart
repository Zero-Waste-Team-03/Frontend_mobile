import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/router/app_router.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint(".env file not found, continuing without it.");
  }

  // Setup Dependency Injection initialized by injectable
  await configureDependencies();

  runApp(const GaspZeroApp());
}

class GaspZeroApp extends StatelessWidget {
  const GaspZeroApp({super.key});

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
