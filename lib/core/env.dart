import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  /// Load environment from `.env` file. Call before runApp.
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
  }

  static String? get(String key) => dotenv.env[key];
}
