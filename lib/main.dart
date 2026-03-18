import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/router/app_router.dart';
import 'core/di/injection.dart';

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
    return MaterialApp.router(
      title: "Gasp'Zero",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
