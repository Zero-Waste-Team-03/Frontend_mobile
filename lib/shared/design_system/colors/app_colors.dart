import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette
  static const Color primary = Color(0xFF2D6C50);
  static const Color primaryDark = Color(0xFF4ADE80); // Example dark variant

  static const Color secondary = Color(0xFF334155);
  static const Color secondaryDark = Color(0xFF94A3B8); // Example dark variant

  static const Color background = Color(0xFFF6F7F7);
  static const Color backgroundDark = Color(0xFF121212); // Example dark variant

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E); // Example dark variant

  static const Color error = Color(0xFFB3261E);
  static const Color errorDark = Color(0xFFCF6679); // Example dark variant

  // On colors (for text/icons on top of primary colors)
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryDark = Color(0xFF121212);

  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFF121212);

  static const Color onBackground = Color(0xFF131615);
  static const Color onBackgroundDark = Color(0xFFE0E0E0);

  static const Color onSurface = Color(0xFF131615);
  static const Color onSurfaceDark = Color(0xFFE0E0E0);

  // Text palette
  static const Color textPrimary = Color(0xFF131615);
  static const Color textPrimaryDark = Color(0xFFE0E0E0);

  static const Color textSecondary = Color(0xFF4A5550);
  static const Color textSecondaryDark = Color(0xFFAAAAAA);

  static const Color textTertiary = Color(0xFF64748B);
  static const Color textTertiaryDark = Color(0xFF888888);

  static const Color textMuted = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF666666);

  // Border & Divider
  static const Color border = Color(0xFFDDDFE1);
  static const Color borderDark = Color(0xFF333333);

  static const Color divider = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF2C2C2C);

  // Specific feature colors
  static const Color statusActiveBackground = Color(0xFFD1FAE5);
  static const Color statusActiveText = Color(0xFF065F46);
  static const Color statusReservedBackground = Color(0xFFFEF3C7);
  static const Color statusReservedText = Color(0xFF92400E);
  static const Color statusCompletedBackground = Color(0xFFD1FAE5);
  static const Color statusCompletedText = Color(0xFF065F46);
  static const Color statusExpiredBackground = Color(0xFFE5E7EB);
  static const Color statusExpiredText = Color(0xFF6B7280);

  // Auth colors specific
  static const Color lightGreenBackground = Color(0xFFDFF4F0);
  static const Color iconsColor = Color.fromARGB(51, 28, 95, 65);
  static const Color lightGrayBackground = Color(0xFFF0F1F2);
  static const Color statBackground = Color(0xFFF5F5F5);

  // Google specific colors
  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color googleRed = Color(0xFFEA4335);
}
