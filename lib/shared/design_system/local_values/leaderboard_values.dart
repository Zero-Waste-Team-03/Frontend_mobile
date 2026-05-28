import 'dart:ui';

class LeaderboardSpacing {
  LeaderboardSpacing._();

  static const double togglePadding = 4.0;
  static const double toggleHeight = 46.0;

  static const double topAvatarSecondarySize = 62.0;
  static const double topAvatarPrimarySize = 86.0;

  static const double cardHorizontalPadding = 14.0;
  static const double cardVerticalPadding = 10.0;
  static const double rankWidth = 40.0;
}

class LeaderboardRadius {
  LeaderboardRadius._();

  static const double toggleRadius = 22.0;
  static const double toggleSegmentRadius = 18.0;
  static const double cardRadius = 24.0;
  static const double avatarRadius = 20.0;
}

class LeaderboardTypography {
  LeaderboardTypography._();

  static const double toggleFontSize = 16.0;
  static const double topBadgeFontSize = 14.0;
  static const double topNameFontSize = 20.0;
  static const double topWeightFontSize = 14.0;

  static const double cardNameFontSize = 16.0;
  static const double cardSubTextSize = 12.0;
  static const double pointsFontSize = 17.0;
  static const double pointsLabelFontSize = 11.0;
}

class LeaderboardColors {
  LeaderboardColors._();

  // Custom local colors specific to leaderboard shimmer
  static const shimmerBase = Color(
    0xFFDDE2E8,
  ); // Might migrate to global if re-used
  static const shimmerHighlight = Color(0xFFF4F6F8);
}
