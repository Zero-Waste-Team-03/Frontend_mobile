import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'Inter';

  // Base font size tokens
  static const double sizeCaption = 12.0;
  static const double sizeBody = 14.0;
  static const double sizeButton = 16.0;
  static const double sizeSubtitle = 18.0;
  static const double sizeTitle = 20.0;
  static const double sizeHeading = 24.0; // aligned with headlineLarge early
  static const double sizeDisplay = 30.0;

  // Re-usable base style
  static const TextStyle _baseStyle = TextStyle(fontFamily: _fontFamily);

  static final TextStyle displayLarge = _baseStyle.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static final TextStyle displayMedium = _baseStyle.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static final TextStyle headlineLarge = _baseStyle.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  static final TextStyle headlineMedium = _baseStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  static final TextStyle titleLarge = _baseStyle.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

  static final TextStyle titleMedium = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static final TextStyle bodyLarge = _baseStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static final TextStyle bodyMedium = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.43,
  );

  static final TextStyle bodySmall = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static final TextStyle labelLarge = _baseStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.43,
  );

  static final TextStyle labelMedium = _baseStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.33,
  );

  static final TextStyle labelSmall = _baseStyle.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );
}
