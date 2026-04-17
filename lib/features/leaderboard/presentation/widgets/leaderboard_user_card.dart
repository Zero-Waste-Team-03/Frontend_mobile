import 'package:flutter/material.dart';

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
            backgroundImage: NetworkImage(entry.avatarUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
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
}
