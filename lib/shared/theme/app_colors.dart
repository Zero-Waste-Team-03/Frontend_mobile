import 'package:flutter/material.dart';

class AuthColors {
  static const Color background = Color(0xFFF6F7F7); // Light Gray Background
  static const Color primary = Color(0xFF2D6C50); // Deep Green
  static const Color headingText = Color(
    0xFF131615,
  ); // Dark Slate (Figma #131615)
  static const Color subText = Color(
    0xFF4A5550,
  ); // Medium Slate (Figma #4A5550)
  static const Color labelText = Color(0xFF334155); // Slate
  static const Color inputBackground = Color(0xFFFFFFFF); // White
  static const Color inputBorder = Color(
    0x332D6C50,
  ); // Light Border (Figma rgba(45, 108, 80, 0.2))
  static const Color iconsColor = Color.fromARGB(51, 28, 95, 65);
  static const Color inputText = Color(0xFF94A3B8); // Slate 400
  static const Color lightGreenBackground = Color(
    0xFFDFF4F0,
  ); // Light green for buttons
  static const Color badgeBackground = Color(
    0xFF2D6C50,
  ); // Status badge background
  static const Color dividerColor = Color(0xFFE2E8F0); // Divider color
  static const Color lightGreenText = Color(
    0xFF4A5550,
  ); // Light green text for email
  static const Color lightGrayBackground = Color(
    0xFFF0F1F2,
  ); // Light gray for buttons
  static const Color buttonBorder = Color(0xFFDDDFE1); // Light gray border
  static const Color statBackground = Color(
    0xFFF5F5F5,
  ); // Light background for stats
}

class AppDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;

  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusExtraLarge = 24.0;

  static const double headingSize = 32.0; // "Share Food, Save the Planet."
  static const double titleSize = 30.0; // "Welcome Back" / "Join the Community"
  static const double appBarTitleSize = 20.0;
  static const double subtitleSize = 18.0; // Description texts and Main buttons
  static const double primaryButtonTextSize =
      18.0; // "Sign In" & "Join the Community"
  static const double buttonTextSize = 16.0; // Google "Verify & Continue" sizes
  static const double bodySize = 14.0;
  static const double captionSize = 12.0;
  static const double logoTextSize = 24.0;
  static const double logoIconSize = 32.0;

  static const double iconSize = 24.0;
  static const double inputHeight = 48.0;
  static const double inputMinHeight = 8.0;
}

class AppFonts {
  static const String primaryFont = 'Inter';
}
