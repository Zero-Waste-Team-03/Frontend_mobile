import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/theme/app_colors.dart' as shared_theme;
import '../../domain/entities/leaderboard_entry.dart';

class LeaderboardUserCard extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool highlighted;

  const LeaderboardUserCard({
    super.key,
    required this.entry,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final bgColor = highlighted ? colors.primary : colors.background;
    final nameColor = highlighted ? colors.onPrimary : colors.textPrimary;
    final subColor = highlighted
        ? colors.onPrimary.withValues(alpha: 0.85)
        : colors.textTertiary;
    final pointsColor = highlighted ? colors.onPrimary : colors.primary;
    final hasAvatar = _hasValidAvatarUrl(entry.avatarUrl);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxW = constraints.maxWidth;
        // Calculate dynamic width for rank based on number of digits
        final rankDigits = entry.rank.toString().length;
        final rankWidth = _calculateRankWidth(rankDigits);

        // reserve space for rank and points columns
        final rankArea = rankWidth + 8.0;
        final pointsArea = 72.0; // approx width for points column
        final avatarDefault =
            shared_theme.AppDimensions.leaderboardAvatarRadius * 2;
        final availableForAvatarAndText = (maxW - rankArea - pointsArea - 40)
            .clamp(48.0, maxW);
        final avatarSize = (availableForAvatarAndText * 0.22).clamp(
          28.0,
          avatarDefault,
        );

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal:
                shared_theme.AppDimensions.leaderboardCardHorizontalPadding,
            vertical: shared_theme.AppDimensions.leaderboardCardVerticalPadding,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(
              shared_theme.AppDimensions.leaderboardCardRadius,
            ),
            boxShadow: highlighted
                ? [
                    BoxShadow(
                      color: colors.textPrimary.withValues(alpha: 0.14),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              SizedBox(
                width: rankWidth,
                child: Text(
                  '#${entry.rank}',
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontSize: _calculateRankFontSize(rankDigits),
                    color: highlighted
                        ? colors.onPrimary.withValues(alpha: 0.95)
                        : colors.textMuted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // avatar
              SizedBox(
                width: avatarSize,
                height: avatarSize,
                child: CircleAvatar(
                  radius: avatarSize / 2,
                  backgroundColor: colors.surface,
                  backgroundImage: hasAvatar
                      ? CachedNetworkImageProvider(entry.avatarUrl)
                      : null,
                  child: hasAvatar
                      ? null
                      : Icon(
                          Icons.person_rounded,
                          color: colors.textMuted,
                          size: (avatarSize * 0.6).clamp(12.0, 28.0),
                        ),
                ),
              ),
              const SizedBox(width: 10),
              // name + sub
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.name.isNotEmpty ? entry.name : 'Unknown user',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: shared_theme
                            .AppDimensions
                            .leaderboardCardNameFontSize,
                        color: nameColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(Icons.eco_outlined, size: 14, color: subColor),
                        const SizedBox(width: 4),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // points
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 56, maxWidth: 88),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      entry.points.toString(),
                      style: AppTextStyles.headlineMedium.copyWith(
                        color: pointsColor,
                        fontSize: shared_theme
                            .AppDimensions
                            .leaderboardPointsFontSize,
                      ),
                    ),
                    Text(
                      'points',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: subColor,
                        fontSize: shared_theme
                            .AppDimensions
                            .leaderboardPointsLabelFontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  bool _hasValidAvatarUrl(String value) {
    if (value.trim().isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(value);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  /// Calculate dynamic width for rank column based on number of digits
  /// Ensures all digits are visible without ellipsis
  double _calculateRankWidth(int rankDigits) {
    // Base width for '#' symbol + padding
    const baseWidth = 16.0;
    // Approximate width per digit in the font used
    const perDigitWidth = 11.0;

    return baseWidth + (rankDigits * perDigitWidth);
  }

  /// Calculate font size that scales down for larger rank numbers
  /// Keeps text readable while accommodating 3-4 digit ranks
  double _calculateRankFontSize(int rankDigits) {
    final baseSize = shared_theme.AppDimensions.leaderboardCardNameFontSize;

    if (rankDigits <= 2) {
      return baseSize; // Normal size for #1-99
    } else if (rankDigits == 3) {
      return baseSize * 0.85; // Slightly smaller for #100-999
    } else {
      return baseSize * 0.70; // More reduction for #1000+
    }
  }
}

class LeaderboardUserCardSkeleton extends StatelessWidget {
  const LeaderboardUserCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final avatarRadius = shared_theme.AppDimensions.leaderboardAvatarRadius;

    final shimmerBase = colors.surface.withValues(alpha: 0.72);
    final shimmerHighlight = colors.surface.withValues(alpha: 1.0);

    return Shimmer.fromColors(
      baseColor: shimmerBase,
      highlightColor: shimmerHighlight,
      period: const Duration(milliseconds: 1200),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal:
              shared_theme.AppDimensions.leaderboardCardHorizontalPadding,
          vertical: shared_theme.AppDimensions.leaderboardCardVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(
            shared_theme.AppDimensions.leaderboardCardRadius,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: shared_theme.AppDimensions.leaderboardRankWidth,
              child: Container(
                height: 16,
                color: colors.surface.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: avatarRadius * 2,
              height: avatarRadius * 2,
              decoration: BoxDecoration(
                color: colors.surface.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: colors.surface.withValues(alpha: 0.8),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: 120,
                    color: colors.surface.withValues(alpha: 0.75),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 18,
                  width: 48,
                  color: colors.surface.withValues(alpha: 0.8),
                ),
                const SizedBox(height: 6),
                Container(
                  height: 10,
                  width: 36,
                  color: colors.surface.withValues(alpha: 0.75),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
