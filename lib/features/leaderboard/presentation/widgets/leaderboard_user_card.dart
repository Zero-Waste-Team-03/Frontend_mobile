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
    final bgColor = highlighted ? AppColors.primary : AppColors.background;
    final nameColor = highlighted ? AppColors.onPrimary : AppColors.textPrimary;
    final subColor = highlighted
        ? AppColors.onPrimary.withValues(alpha: 0.85)
        : AppColors.textTertiary;
    final pointsColor = highlighted ? AppColors.onPrimary : AppColors.primary;
    final hasAvatar = _hasValidAvatarUrl(entry.avatarUrl);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: shared_theme.AppDimensions.leaderboardCardHorizontalPadding,
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
                  color: AppColors.textPrimary.withValues(alpha: 0.14),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: shared_theme.AppDimensions.leaderboardRankWidth,
            child: Text(
              '#${entry.rank}',
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize:
                    shared_theme.AppDimensions.leaderboardCardNameFontSize,
                color: highlighted
                    ? AppColors.onPrimary.withValues(alpha: 0.95)
                    : AppColors.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: shared_theme.AppDimensions.leaderboardAvatarRadius,
            backgroundColor: AppColors.surface,
            backgroundImage: hasAvatar ? NetworkImage(entry.avatarUrl) : null,
            child: hasAvatar
                ? null
                : Icon(
                    Icons.person_rounded,
                    color: AppColors.textMuted,
                    size: shared_theme.AppDimensions.leaderboardAvatarRadius,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name.isNotEmpty ? entry.name : 'Unknown user',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontSize:
                        shared_theme.AppDimensions.leaderboardCardNameFontSize,
                    color: nameColor,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.eco_outlined, size: 14, color: subColor),
                    const SizedBox(width: 4),
                    Text(
                      '${entry.kgSaved.toStringAsFixed(1)} kg saved',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: subColor,
                        fontSize: shared_theme
                            .AppDimensions
                            .leaderboardCardSubTextSize,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                entry.points.toString(),
                style: AppTextStyles.headlineMedium.copyWith(
                  color: pointsColor,
                  fontSize:
                      shared_theme.AppDimensions.leaderboardPointsFontSize,
                ),
              ),
              Text(
                'points',
                style: AppTextStyles.bodySmall.copyWith(
                  color: subColor,
                  fontSize:
                      shared_theme.AppDimensions.leaderboardPointsLabelFontSize,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _hasValidAvatarUrl(String value) {
    if (value.trim().isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(value);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }
}

class LeaderboardUserCardSkeleton extends StatelessWidget {
  const LeaderboardUserCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final avatarRadius = shared_theme.AppDimensions.leaderboardAvatarRadius;

    final shimmerBase = const Color(0xFFDDE2E8);
    final shimmerHighlight = const Color(0xFFF4F6F8);

    return Shimmer.fromColors(
      baseColor: shimmerBase,
      highlightColor: shimmerHighlight,
      period: const Duration(milliseconds: 1200),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: shared_theme.AppDimensions.leaderboardCardHorizontalPadding,
          vertical: shared_theme.AppDimensions.leaderboardCardVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.background,
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
              color: AppColors.surface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: avatarRadius * 2,
            height: avatarRadius * 2,
            decoration: BoxDecoration(
              color: AppColors.surface.withValues(alpha: 0.8),
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
                  color: AppColors.surface.withValues(alpha: 0.8),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 12,
                  width: 120,
                  color: AppColors.surface.withValues(alpha: 0.75),
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
                color: AppColors.surface.withValues(alpha: 0.8),
              ),
              const SizedBox(height: 6),
              Container(
                height: 10,
                width: 36,
                color: AppColors.surface.withValues(alpha: 0.75),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }
}
