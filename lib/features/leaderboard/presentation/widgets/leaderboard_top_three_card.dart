import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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

    final shimmerBase = const Color(0xFFDDE2E8);
    final shimmerHighlight = const Color(0xFFF4F6F8);

    return Shimmer.fromColors(
      baseColor: shimmerBase,
      highlightColor: shimmerHighlight,
      period: const Duration(milliseconds: 1200),
      child: Container(
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
    ));
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

    final hasAvatar = _hasValidAvatarUrl(entry!.avatarUrl);

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
          ),
          clipBehavior: Clip.antiAlias,
          child: hasAvatar
              ? Image.network(
                  entry!.avatarUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _buildFallbackAvatar(),
                )
              : _buildFallbackAvatar(),
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
          entry!.name.isNotEmpty ? entry!.name : 'Unknown user',
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

  Widget _buildFallbackAvatar() {
    return Container(
      color: AppColors.surface,
      child: const Center(
        child: Icon(Icons.person_rounded, color: AppColors.textMuted, size: 30),
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

class LeaderboardTopThreeSkeleton extends StatelessWidget {
  const LeaderboardTopThreeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final double avatarPrimary =
        shared_theme.AppDimensions.leaderboardTopAvatarPrimarySize;
    final double avatarSecondary =
        shared_theme.AppDimensions.leaderboardTopAvatarSecondarySize;

    Widget _placeholder(double size) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
      );
    }

    Widget _bar(double width, double height) {
      return Container(
        width: width,
        height: height,
        color: AppColors.surface.withValues(alpha: 0.75),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      color: AppColors.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _placeholder(avatarSecondary),
              const SizedBox(height: 8),
              _bar(avatarSecondary * 0.9, 12),
              const SizedBox(height: 6),
              _bar(avatarSecondary * 0.6, 10),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _placeholder(avatarPrimary),
              const SizedBox(height: 8),
              _bar(avatarPrimary * 0.9, 12),
              const SizedBox(height: 6),
              _bar(avatarPrimary * 0.6, 10),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _placeholder(avatarSecondary),
              const SizedBox(height: 8),
              _bar(avatarSecondary * 0.9, 12),
              const SizedBox(height: 6),
              _bar(avatarSecondary * 0.6, 10),
            ],
          ),
        ],
      ),
    );
  }
}
