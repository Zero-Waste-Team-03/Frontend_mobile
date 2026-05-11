import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/theme/app_colors.dart' as shared_theme;
import '../../../../shared/widgets/notification_button.dart';
import '../../domain/entities/leaderboard_period.dart';
import '../bloc/leaderboard_bloc.dart';
import '../bloc/leaderboard_event.dart';
import '../bloc/leaderboard_state.dart';
import '../widgets/leaderboard_top_three_card.dart';
import '../widgets/leaderboard_user_card.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late ScrollController _scrollController;
  static const int _pageSize = 10;
  static const double _chatButtonSize = 56;
  static const double _chatHorizontalMargin = 12;
  static const double _chatTopLimit = 118;
  static const double _chatBottomPaddingNoCard = 92;
  static const double _chatBottomPaddingWithCard = 186;

  Offset _chatPos = Offset.zero;
  bool _chatInitialized = false;
  final GlobalKey _stackKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<LeaderboardBloc>().add(
      const FetchLeaderboardEvent(period: LeaderboardPeriod.monthly),
    );
  }

  void _onScroll() {
    final state = context.read<LeaderboardBloc>().state;
    if (state is! LeaderboardLoaded) {
      return;
    }

    if (_scrollController.position.extentAfter < 320 &&
        !state.isLoadingMore &&
        !state.hasReachedMax) {
      context.read<LeaderboardBloc>().add(
        const LoadMoreLeaderboardEvent(limit: _pageSize),
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stackSize = Size(constraints.maxWidth, constraints.maxHeight);
            final blocState = context.watch<LeaderboardBloc>().state;
            final hasCurrentUserCard =
                blocState is LeaderboardLoaded && blocState.currentUser != null;

            final resolvedChatPos = _chatInitialized
                ? _clampChatPosition(
                    _chatPos,
                    size: stackSize,
                    hasCurrentUserCard: hasCurrentUserCard,
                  )
                : _initialChatPosition(
                    size: stackSize,
                    hasCurrentUserCard: hasCurrentUserCard,
                  );

            if (!_chatInitialized) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  _chatPos = resolvedChatPos;
                  _chatInitialized = true;
                });
              });
            }

            return Stack(
              key: _stackKey,
              children: [
                BlocBuilder<LeaderboardBloc, LeaderboardState>(
                  builder: (context, state) {
                    final period = state is LeaderboardLoaded
                        ? state.period
                        : LeaderboardPeriod.monthly;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Community Leaderboard',
                                  style: AppTextStyles.headlineMedium.copyWith(
                                    fontSize: shared_theme
                                        .AppDimensions
                                        .appBarTitleSize,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              NotificationButton(
                                backgroundColor: AppColors.divider.withValues(
                                  alpha: 0.45,
                                ),
                                iconColor: AppColors.primary,
                                iconSize: shared_theme.AppDimensions.iconSize,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
                          child: _PeriodToggle(
                            period: period,
                            onChanged: (newPeriod) {
                              context.read<LeaderboardBloc>().add(
                                ChangeLeaderboardPeriodEvent(newPeriod),
                              );
                            },
                          ),
                        ),
                        Expanded(child: _buildBody(state)),
                      ],
                    );
                  },
                ),
                Positioned(
                  left: resolvedChatPos.dx,
                  top: resolvedChatPos.dy,
                  child: Draggable(
                    feedback: _buildFloatingChatButton(isDragging: true),
                    childWhenDragging: const SizedBox.shrink(),
                    onDragEnd: (details) {
                      setState(() {
                        final stackBox =
                            _stackKey.currentContext?.findRenderObject()
                                as RenderBox?;
                        final localOffset =
                            stackBox?.globalToLocal(details.offset) ??
                            details.offset;
                        final size =
                            stackBox?.size ?? MediaQuery.sizeOf(context);
                        final hasCurrentUser =
                            context.read<LeaderboardBloc>().state
                                is LeaderboardLoaded &&
                            (context.read<LeaderboardBloc>().state
                                        as LeaderboardLoaded)
                                    .currentUser !=
                                null;

                        _chatPos = _clampChatPosition(
                          Offset(localOffset.dx, localOffset.dy),
                          size: size,
                          hasCurrentUserCard: hasCurrentUser,
                        );
                      });
                    },
                    child: _buildFloatingChatButton(isDragging: false),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(LeaderboardState state) {
    if (state is LeaderboardLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is LeaderboardError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 42,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: 10),
            Text(state.message, style: AppTextStyles.bodyLarge),
          ],
        ),
      );
    }

    if (state is! LeaderboardLoaded) {
      return const SizedBox.shrink();
    }

    final hasCurrentUser = state.currentUser != null;
    final itemCount =
        1 + state.remainingRanks.length + (state.isLoadingMore ? 1 : 0);

    return Stack(
      children: [
        ListView.separated(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 170),
          itemCount: itemCount,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return LeaderboardTopThreeCard(topThree: state.topThree);
            }

            final listIndex = index - 1;
            if (listIndex < state.remainingRanks.length) {
              return LeaderboardUserCard(
                entry: state.remainingRanks[listIndex],
              );
            }

            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          },
        ),
        if (hasCurrentUser)
          Positioned(
            left: 16,
            right: 16,
            bottom: 10,
            child: LeaderboardUserCard(
              entry: state.currentUser!,
              highlighted: true,
            ),
          ),
      ],
    );
  }

  Widget _buildFloatingChatButton({required bool isDragging}) {
    return GestureDetector(
      onTap: () => context.go('/chat'),
      child: Material(
        color: Colors.transparent,
        elevation: isDragging ? 10 : 6,
        shape: const CircleBorder(),
        child: Container(
          width: _chatButtonSize,
          height: _chatButtonSize,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }

  Offset _clampChatPosition(
    Offset raw, {
    required Size size,
    required bool hasCurrentUserCard,
  }) {
    final maxX = size.width - _chatButtonSize - _chatHorizontalMargin;
    final maxY =
        size.height -
        (hasCurrentUserCard
            ? _chatBottomPaddingWithCard
            : _chatBottomPaddingNoCard);

    final dx = raw.dx.clamp(_chatHorizontalMargin, maxX);
    final dy = raw.dy.clamp(_chatTopLimit, maxY);
    return Offset(dx, dy);
  }

  Offset _initialChatPosition({
    required Size size,
    required bool hasCurrentUserCard,
  }) {
    final maxX = size.width - _chatButtonSize - _chatHorizontalMargin;
    final maxY =
        size.height -
        (hasCurrentUserCard
            ? _chatBottomPaddingWithCard
            : _chatBottomPaddingNoCard);

    // Keep initial button in an obvious free zone: right side, mid vertical range.
    final candidate = Offset(maxX, (maxY + _chatTopLimit) / 2);
    return _clampChatPosition(
      candidate,
      size: size,
      hasCurrentUserCard: hasCurrentUserCard,
    );
  }
}

class _PeriodToggle extends StatelessWidget {
  final LeaderboardPeriod period;
  final ValueChanged<LeaderboardPeriod> onChanged;

  const _PeriodToggle({required this.period, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final monthlySelected = period == LeaderboardPeriod.monthly;

    return Container(
      padding: const EdgeInsets.all(
        shared_theme.AppDimensions.leaderboardTogglePadding,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFDCE3E0),
        borderRadius: BorderRadius.circular(
          shared_theme.AppDimensions.leaderboardToggleRadius,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegmentButton(
              label: 'Monthly',
              selected: monthlySelected,
              onTap: () => onChanged(LeaderboardPeriod.monthly),
            ),
          ),
          Expanded(
            child: _SegmentButton(
              label: 'All Time',
              selected: !monthlySelected,
              onTap: () => onChanged(LeaderboardPeriod.allTime),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: shared_theme.AppDimensions.leaderboardToggleHeight,
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(
            shared_theme.AppDimensions.leaderboardToggleSegmentRadius,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.headlineMedium.copyWith(
              fontSize: shared_theme.AppDimensions.leaderboardToggleFontSize,
              color: selected ? AppColors.onPrimary : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
