import 'package:cached_network_image/cached_network_image.dart';
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
    final colors = context.themeColors;
    final rankMap = {for (final entry in topThree) entry.rank: entry};

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      color: colors.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: _TopRankAvatar(
              entry: rankMap[2],
              borderColor: Color(0xFFC0C0C0),
              badgeColor: Color(0xFFC0C0C0),
              avatarSize:
                  shared_theme.AppDimensions.leaderboardTopAvatarSecondarySize,
              lift: -8,
            ),
          ),
          Expanded(
            child: _TopRankAvatar(
              entry: rankMap[1],
              borderColor: Color(0xFFFFD700),
              badgeColor: Color(0xFFFFD700),
              avatarSize:
                  shared_theme.AppDimensions.leaderboardTopAvatarPrimarySize *
                  1.08,
              crowned: true,
              lift: -20,
            ),
          ),
          Expanded(
            child: _TopRankAvatar(
              entry: rankMap[3],
              borderColor: Color(0xFFCD7F32), // bronze
              badgeColor: Color(0xFFCD7F32),
              avatarSize:
                  shared_theme.AppDimensions.leaderboardTopAvatarSecondarySize,
              lift: -8,
            ),
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
  final double lift;

  const _TopRankAvatar({
    required this.entry,
    required this.borderColor,
    required this.badgeColor,
    required this.avatarSize,
    this.crowned = false,
    this.lift = -8,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final currentEntry = entry;
    if (currentEntry == null) {
      return const SizedBox.shrink();
    }
    final hasAvatar = _hasValidAvatarUrl(currentEntry.avatarUrl);

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final avatarLimit = (maxWidth * 0.72).clamp(42.0, avatarSize);
        final textWidth = (maxWidth * 0.95).clamp(56.0, maxWidth);

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (crowned) const SizedBox(height: 2),

            if (crowned)
              Icon(Icons.workspace_premium, color: borderColor, size: 24),

            SizedBox(height: crowned ? 8 : 0),

            Transform.translate(
              offset: Offset(0, lift),
              child: Container(
                width: avatarLimit + 10,
                height: avatarLimit + 10,
                alignment: Alignment.center,
                child: Container(
                  width: avatarLimit,
                  height: avatarLimit,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.surface,
                    border: Border.all(
                      color: borderColor,
                      width: crowned ? 4.5 : 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: hasAvatar
                      ? CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            currentEntry.avatarUrl,
                          ),
                          foregroundColor: Colors.white,
                          onBackgroundImageError: (_, __) {},
                          child: currentEntry.avatarUrl.isEmpty
                              ? _buildFallbackAvatar(context)
                              : null,
                        )
                      : _buildFallbackAvatar(context),
                ),
              ),
            ),

            Transform.translate(
              offset: Offset(0, lift / 2),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colors.surface, width: 2),
                ),
                child: Text(
                  currentEntry.rank.toString(),
                  style: AppTextStyles.titleMedium.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize:
                        shared_theme.AppDimensions.leaderboardTopBadgeFontSize,
                  ),
                ),
              ),
            ),

            SizedBox(height: 30),

            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, 2 * lift),
                child: SizedBox(
                  width: textWidth,
                  child: Text(
                    currentEntry.name.isNotEmpty
                        ? currentEntry.name
                                      .trim()
                                      .split(RegExp(r'\s+'))
                                      .length >=
                                  2
                              ? "${currentEntry.name.trim().split(RegExp(r'\s+')).first} ${currentEntry.name.trim().split(RegExp(r'\s+')).last[0].toUpperCase()}."
                              : currentEntry.name
                                    .trim()
                                    .split(RegExp(r'\s+'))
                                    .first
                        : 'Unknown user',
                    maxLines: 1,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.visible,
                    style: AppTextStyles.headlineMedium.copyWith(
                      fontSize:
                          shared_theme.AppDimensions.leaderboardTopNameFontSize,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 4),

            Transform.translate(
              offset: Offset(0, 2 * lift),

              child: Text(
                '${_formatPoints(currentEntry.points)} points',
                style: AppTextStyles.titleMedium.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: shared_theme.AppDimensions.bodySize,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFallbackAvatar(BuildContext context) {
    final colors = context.themeColors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CircleAvatar(
      backgroundImage: AssetImage(
        isDark
            ? 'assets/images/default_avatar_dark.png'
            : 'assets/images/default_avatar.png',
      ),
      backgroundColor: colors.surface,
    );
  }

  bool _hasValidAvatarUrl(String value) {
    if (value.trim().isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(value);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  String _formatPoints(int value) {
    final s = value.toString();
    return s.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
  }
}

class LeaderboardTopThreeSkeleton extends StatelessWidget {
  const LeaderboardTopThreeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final double avatarPrimary =
        shared_theme.AppDimensions.leaderboardTopAvatarPrimarySize;
    final double avatarSecondary =
        shared_theme.AppDimensions.leaderboardTopAvatarSecondarySize;

    Widget _placeholder(double size) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colors.surface.withValues(alpha: 0.8),
          shape: BoxShape.circle,
        ),
      );
    }

    Widget _bar(double width, double height) {
      return Container(
        width: width,
        height: height,
        color: colors.surface.withValues(alpha: 0.75),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
      color: colors.background,
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
