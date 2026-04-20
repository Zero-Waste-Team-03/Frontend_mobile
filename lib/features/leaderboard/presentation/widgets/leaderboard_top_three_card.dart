import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/theme/app_colors.dart' as shared_theme;
import '../../domain/entities/leaderboard_entry.dart';

class LeaderboardTopThreeCard extends StatelessWidget {
  final List<LeaderboardEntry> topThree;

  const LeaderboardTopThreeCard({super.key, required this.topThree});

  @override
  Widget build(BuildContext context) {
    final rankMap = {for (final entry in topThree) entry.rank: entry};

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      color: AppColors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _TopRankAvatar(
            entry: rankMap[2],
            borderColor: const Color(0xFFB8C0D0),
            badgeColor: const Color(0xFF98A2B2),
            avatarSize:
                shared_theme.AppDimensions.leaderboardTopAvatarSecondarySize,
          ),
          _TopRankAvatar(
            entry: rankMap[1],
            borderColor: const Color(0xFFE8B90A),
            badgeColor: const Color(0xFFE8B90A),
            avatarSize:
                shared_theme.AppDimensions.leaderboardTopAvatarPrimarySize,
            crowned: true,
          ),
          _TopRankAvatar(
            entry: rankMap[3],
            borderColor: const Color(0xFFF0B26E),
            badgeColor: const Color(0xFFF29B44),
            avatarSize:
                shared_theme.AppDimensions.leaderboardTopAvatarSecondarySize,
          ),
        ],
      ),
    );
  }
}

class _TopRankAvatar extends StatelessWidget {
  final LeaderboardEntry? entry;
  final Color borderColor;
  final Color badgeColor;
  final double avatarSize;
  final bool crowned;

  const _TopRankAvatar({
    required this.entry,
    required this.borderColor,
    required this.badgeColor,
    required this.avatarSize,
    this.crowned = false,
  });

  @override
  Widget build(BuildContext context) {
    if (entry == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (crowned)
          Icon(Icons.workspace_premium, color: borderColor, size: 24),
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: 4),
            image: DecorationImage(
              image: NetworkImage(entry!.avatarUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 2),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.surface, width: 2),
            ),
            child: Text(
              entry!.rank.toString(),
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w700,
                fontSize:
                    shared_theme.AppDimensions.leaderboardTopBadgeFontSize,
              ),
            ),
          ),
        ),
        Text(
          entry!.name,
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: shared_theme.AppDimensions.leaderboardTopNameFontSize,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '${entry!.kgSaved.toStringAsFixed(1)} kg',
          style: AppTextStyles.titleMedium.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: shared_theme.AppDimensions.leaderboardTopWeightFontSize,
          ),
        ),
      ],
    );
  }
}
