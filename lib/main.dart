import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/router/app_router.dart';
import 'core/di/injection.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint(".env file not found, continuing without it.");
  }

  // Setup Dependency Injection initialized by injectable
  configureDependencies();

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
        return MaterialApp.router(
          title: "Gasp'Zero",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: const Color(0xFF2D6C50),
            textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF2D6C50),
              foregroundColor: Colors.white,
            ),
          ),
          builder: (context, child) {
            return BlocProvider.value(
              value: getIt<AuthBloc>(),
              child: BlocListener<AuthBloc, AuthState>(
                listenWhen: (previous, current) => current is AuthSuccess,
                listener: (context, state) {
                  appRouter.go('/home');
                },
                child: child ?? const SizedBox.shrink(),
              ),
            );
          },
          routerConfig: appRouter,
        );
      },
    );
  }
}
