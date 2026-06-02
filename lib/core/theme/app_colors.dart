import 'package:flutter/material.dart';

import '../enums/donation_status_value.dart';

class AppColors {
  static const Color primary = Color(0xFF2D6C50);
  static const Color secondary = Color(0xFF334155);

  static const Color background = Color(0xFFF6F7F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFB3261E);

  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF131615);
  static const Color onSurface = Color(0xFF131615);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color textPrimary = Color(0xFF131615);
  static const Color textSecondary = Color(0xFF4A5550);
  static const Color textTertiary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  static const Color border = Color(0xFFDDDFE1);
  static const Color divider = Color(0xFFE2E8F0);

  static const Color statusActiveBackground = Color(0xFFD1FAE5);
  static const Color statusActiveText = Color(0xFF065F46);

  static const Color statusReservedBackground = Color(0xFFFEF3C7);
  static const Color statusReservedText = Color(0xFF92400E);

  static const Color statusCompletedBackground = Color(0xFFD1FAE5);
  static const Color statusCompletedText = Color(0xFF065F46);

  static const Color statusExpiredBackground = Color(0xFFE5E7EB);
  static const Color statusExpiredText = Color(0xFF6B7280);

  static const Map<DonationStatusValue, Color> donationStatusBadgeBackground = {
    DonationStatusValue.draft: Color(0xFFE2E8F0),
    DonationStatusValue.published: Color(0xFFD1FAE5),
    DonationStatusValue.reserved: Color(0xFFFEF3C7),
    DonationStatusValue.completed: Color(0xFFDBEAFE),
    DonationStatusValue.expired: Color(0xFFE5E7EB),
    DonationStatusValue.pendingApproval: Color(0xFFFEF3C7),
    DonationStatusValue.rejected: Color(0xFFFFDAD6),
    DonationStatusValue.unknown: Color(0xFFF1F5F9),
  };

  static const Map<DonationStatusValue, Color> donationStatusBadgeText = {
    DonationStatusValue.draft: Color(0xFF475569),
    DonationStatusValue.published: Color(0xFF065F46),
    DonationStatusValue.reserved: Color(0xFF92400E),
    DonationStatusValue.completed: Color(0xFF1D4ED8),
    DonationStatusValue.expired: Color(0xFF6B7280),
    DonationStatusValue.pendingApproval: Color(0xFFD97706),
    DonationStatusValue.rejected: Color(0xFFBA1A1A),
    DonationStatusValue.unknown: Color(0xFF334155),
  };

  static const Color notificationAlertBackground = Color(0xFFFFA500);
  static const Color notificationAlertLight = Color(0xFFFFF5E6);

  static const Color notificationConfirmationBackground = Color(0xFFD1FAE5);

  static const Color notificationDonationBackground = Color(0xFFD1FAE5);

  static const Color notificationImpactBackground = Color(0xFFD1FAE5);

  static const Color notificationUnreadIndicator = Color(0xFF2D6C50);

  static const Color notificationCardBorder = Color(0xFFE2E8F0);

  static const Color notificationCardUnreadBackground = Color(0xFFF5F7F6);

  static const Color googleBlue = Color(0xFF4285F4);
  static const Color googleGreen = Color(0xFF34A853);
  static const Color googleYellow = Color(0xFFFBBC05);
  static const Color googleRed = Color(0xFFEA4335);

  static const Color transparent = Colors.transparent;  
}

class AuthColors {
  static const Color background = AppColors.background;
  static const Color primary = AppColors.primary;

  static const Color headingText = AppColors.textPrimary;
  static const Color subText = AppColors.textSecondary;
  static const Color labelText = AppColors.secondary;

  static const Color inputBackground = AppColors.surface;
  static const Color inputBorder = AppColors.border;
  static const Color inputText = AppColors.textMuted;

  static const Color iconsColor = Color.fromARGB(51, 28, 95, 65);

  static const Color lightGreenBackground = Color(0xFFDFF4F0);

  static const Color badgeBackground = AppColors.primary;

  static const Color dividerColor = AppColors.divider;

  static const Color lightGreenText = AppColors.textSecondary;

  static const Color lightGrayBackground = Color(0xFFF0F1F2);

  static const Color buttonBorder = AppColors.border;

  static const Color statBackground = Color(0xFFF5F5F5);

  static const Color statusActiveBackground = AppColors.statusActiveBackground;

  static const Color statusActiveText = AppColors.statusActiveText;

  static const Color statusReservedBackground =
      AppColors.statusReservedBackground;

  static const Color statusReservedText = AppColors.statusReservedText;

  static const Color statusCompletedBackground =
      AppColors.statusCompletedBackground;

  static const Color statusCompletedText = AppColors.statusCompletedText;

  static const Color statusExpiredBackground =
      AppColors.statusExpiredBackground;

  static const Color statusExpiredText = AppColors.statusExpiredText;
}

class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double screenHorizontal = 24;
  static const double screenVertical = 16;
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

  static const double headingSize = 32.0;
  static const double titleSize = 30.0;
  static const double appBarTitleSize = 20.0;
  static const double subtitleSize = 18.0;

  static const double primaryButtonTextSize = 18.0;
  static const double buttonTextSize = 16.0;

  static const double bodySize = 14.0;
  static const double captionSize = 12.0;

  static const double logoTextSize = 24.0;
  static const double logoIconSize = 32.0;

  static const double iconSize = 24.0;

  static const double inputHeight = 48.0;
  static const double inputMinHeight = 8.0;

  static const double leaderboardTogglePadding = 4.0;
  static const double leaderboardToggleHeight = 46.0;
  static const double leaderboardToggleRadius = 22.0;

  static const double leaderboardToggleSegmentRadius = 18.0;

  static const double leaderboardToggleFontSize = 16.0;

  static const double leaderboardTopAvatarSecondarySize = 62.0;

  static const double leaderboardTopAvatarPrimarySize = 86.0;

  static const double leaderboardTopBadgeFontSize = 14.0;
  static const double leaderboardTopNameFontSize = 20.0;

  static const double leaderboardTopWeightFontSize = 14.0;

  static const double leaderboardCardHorizontalPadding = 14.0;

  static const double leaderboardCardVerticalPadding = 10.0;

  static const double leaderboardCardRadius = 24.0;

  static const double leaderboardRankWidth = 40.0;

  static const double leaderboardAvatarRadius = 20.0;

  static const double leaderboardCardNameFontSize = 16.0;

  static const double leaderboardCardSubTextSize = 12.0;

  static const double leaderboardPointsFontSize = 17.0;

  static const double leaderboardPointsLabelFontSize = 11.0;
}

class AppFonts {
  static const String primaryFont = 'Inter';
}

class AppDarkColors {
  static const Color primary = AppColors.primary;
  static const Color secondary = AppColors.secondary;

  static const Color background = Color(0xFF06100E);
  static const Color surface = Color.fromARGB(255, 16, 29, 27);
  static const Color error = AppColors.error;
  static const Color onError = AppColors.onError;

  static const Color onPrimary = AppColors.onPrimary;
  static const Color onSecondary = AppColors.onSecondary;
  static const Color onBackground = AppColors.surface;
  static const Color onSurface = AppColors.surface;

  static const Color textPrimary = Color(0xFFF5F7F6);
  static const Color textSecondary = Color(0xFFB8CCC6);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFFAAB7B2);

  static const Color border = Color(0xFF22312C);
  static const Color divider = Color(0xFF1A2A27);

  static const Color statusActiveBackground = Color(0xFF063E2E);
  static const Color statusActiveText = Color(0xFFD1FAE5);

  static const Color statusReservedBackground = Color(0xFF5A3C00);
  static const Color statusReservedText = Color(0xFFFFF7E5);

  static const Color statusCompletedBackground = Color(0xFF0B2A66);
  static const Color statusCompletedText = Color(0xFFDBEAFE);

  static const Color statusExpiredBackground = Color(0xFF111827);
  static const Color statusExpiredText = Color(0xFF9CA3AF);

  static const Map<DonationStatusValue, Color> donationStatusBadgeBackground =
      AppColors.donationStatusBadgeBackground;

  static const Map<DonationStatusValue, Color> donationStatusBadgeText =
      AppColors.donationStatusBadgeText;

  static const Color notificationAlertBackground =
      AppColors.notificationAlertBackground;
  static const Color notificationAlertLight = AppColors.notificationAlertLight;

  static const Color notificationConfirmationBackground =
      AppColors.notificationConfirmationBackground;
  static const Color notificationDonationBackground =
      AppColors.notificationDonationBackground;
  static const Color notificationImpactBackground =
      AppColors.notificationImpactBackground;

  static const Color notificationUnreadIndicator =
      AppColors.notificationUnreadIndicator;
  static const Color notificationCardBorder = AppColors.notificationCardBorder;
  static const Color notificationCardUnreadBackground =
      AppColors.notificationCardUnreadBackground;

  static const Color transparent = AppColors.transparent;    
}

/// Helper class to get theme-aware colors based on the current brightness.
/// Use [ThemeColors.of(context)] to get colors that respond to theme changes.
class ThemeColors {
  final Brightness brightness;

  ThemeColors(this.brightness);

  factory ThemeColors.of(BuildContext context) {
    return ThemeColors(Theme.of(context).brightness);
  }

  bool get isDark => brightness == Brightness.dark;

  Color get primary => AppColors.primary;
  Color get secondary => isDark ? AppColors.secondary : AppColors.secondary;

  Color get background =>
      isDark ? AppDarkColors.background : AppColors.background;
  Color get surface => isDark ? AppDarkColors.surface : AppColors.surface;
  Color get error => isDark ? AppDarkColors.error : AppColors.error;

  Color get onPrimary => isDark ? AppDarkColors.onPrimary : AppColors.onPrimary;
  Color get onSecondary =>
      isDark ? AppDarkColors.onSecondary : AppColors.onSecondary;
  Color get onBackground =>
      isDark ? AppDarkColors.onBackground : AppColors.onBackground;
  Color get onSurface => isDark ? AppDarkColors.onSurface : AppColors.onSurface;
  Color get onError => isDark ? AppDarkColors.onError : AppColors.onError;

  Color get textPrimary =>
      isDark ? AppDarkColors.textPrimary : AppColors.textPrimary;
  Color get textSecondary =>
      isDark ? AppDarkColors.textSecondary : AppColors.textSecondary;
  Color get textTertiary =>
      isDark ? AppDarkColors.textTertiary : AppColors.textTertiary;
  Color get textMuted => isDark ? AppDarkColors.textMuted : AppColors.textMuted;

  Color get border => isDark ? AppDarkColors.border : AppColors.border;
  Color get divider => isDark ? AppDarkColors.divider : AppColors.divider;

  // Auth-specific color mappings for backward compatibility
  Color get headingText => textPrimary;
  Color get subText => textSecondary;
  Color get labelText => secondary;
  Color get inputBackground => surface;
  Color get inputBorder => border;
  Color get inputText => textMuted;
  Color get lightGreenBackground =>
      isDark ? Color(0xFF1A3F32) : Color(0xFFDFF4F0);
  Color get badgeBackground => primary;
  Color get dividerColor => divider;
  Color get lightGreenText => textSecondary;
  Color get lightGrayBackground =>
      isDark ? Color(0xFF1A1F1D) : Color(0xFFF0F1F2);
  Color get buttonBorder => border;
  Color get statBackground => isDark ? Color(0xFF1A1F1D) : Color(0xFFF5F5F5);
  Color get iconsColor => primary;

  Color get statusActiveBackground => isDark
      ? AppDarkColors.statusActiveBackground
      : AppColors.statusActiveBackground;
  Color get statusActiveText =>
      isDark ? AppDarkColors.statusActiveText : AppColors.statusActiveText;
  Color get statusReservedBackground => isDark
      ? AppDarkColors.statusReservedBackground
      : AppColors.statusReservedBackground;
  Color get statusReservedText =>
      isDark ? AppDarkColors.statusReservedText : AppColors.statusReservedText;
  Color get statusCompletedBackground => isDark
      ? AppDarkColors.statusCompletedBackground
      : AppColors.statusCompletedBackground;
  Color get statusCompletedText => isDark
      ? AppDarkColors.statusCompletedText
      : AppColors.statusCompletedText;
  Color get statusExpiredBackground => isDark
      ? AppDarkColors.statusExpiredBackground
      : AppColors.statusExpiredBackground;
  Color get statusExpiredText =>
      isDark ? AppDarkColors.statusExpiredText : AppColors.statusExpiredText;
}

/// Extension on BuildContext for easy access to theme colors.
extension ThemeColorsExtension on BuildContext {
  ThemeColors get themeColors => ThemeColors.of(this);
}
