import 'package:flutter/material.dart';

class NotificationSpacing {
  NotificationSpacing._();

  // These map to standard spacings but provide local context overrides if ever needed
  static const double itemSpacingSmall = 8.0;
  static const double itemSpacingMedium = 16.0;
  static const double itemSpacingLarge = 24.0;
  static const double separatorSpacing = 12.0;

  static const double cardInternalPadding = 16.0;
}

class NotificationRadius {
  NotificationRadius._();

  static const double badgeRadius = 6.0;
  static const double iconContainerRadius = 17.0;
  static const double filterChipRadius = 5.0;
}

class NotificationColors {
  NotificationColors._();

  // Mapped from previous globals
  static const Color alertBackground = Color(0xFFFFA500);
  static const Color alertLight = Color(0xFFFFF5E6);
  static const Color confirmationBackground = Color(0xFFD1FAE5);
  static const Color donationBackground = Color(0xFFD1FAE5);
  static const Color impactBackground = Color(0xFFD1FAE5);
  static const Color unreadIndicator = Color(0xFF2D6C50);
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color cardUnreadBackground = Color(0xFFF5F7F6);
}
