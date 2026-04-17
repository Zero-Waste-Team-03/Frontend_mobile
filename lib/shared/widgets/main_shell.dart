import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './nav_item.dart';
import '../../core/app_icons.dart';
import '../../shared/theme/app_colors.dart';
import '../../core/di/injection.dart';
import '../../features/donations/presentation/bloc/donations_bloc.dart';
import '../../features/donations/presentation/bloc/donations_event.dart';

/// Main shell widget that wraps authenticated screens with a bottom nav bar.
class MainShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  // Chat button position
  Offset _chatPos = const Offset(300, 500);
  final GlobalKey _stackKey = GlobalKey();
  static const double _chatButtonSize = 56;
  static const double _chatTopLimit = 112;
  static const double _chatBottomLimit = 106;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_chatPos == const Offset(300, 500)) {
      final size = MediaQuery.sizeOf(context);
      _chatPos = _clampChatPosition(
        Offset(size.width - 72.w, size.height - 180.h),
        size,
      );
    }
    return BlocProvider(
      create: (context) =>
          getIt<DonationsBloc>()..add(const LoadDonationsEvent()),
      child: Scaffold(
        body: Stack(
          key: _stackKey,
          children: [
            widget.navigationShell,
            if (widget.navigationShell.currentIndex != 2)
              Positioned(
                left: _chatPos.dx,
                top: _chatPos.dy,
                child: Draggable(
                  feedback: _buildChatButtonUI(isDragging: true),
                  childWhenDragging: const SizedBox.shrink(),
                  onDragEnd: (details) {
                    setState(() {
                      final stackBox =
                          _stackKey.currentContext?.findRenderObject()
                              as RenderBox?;
                      final localOffset =
                          stackBox?.globalToLocal(details.offset) ??
                          details.offset;
                      final size = stackBox?.size ?? MediaQuery.sizeOf(context);
                      _chatPos = _clampChatPosition(
                        Offset(localOffset.dx, localOffset.dy),
                        size,
                      );
                    });
                  },
                  child: _buildChatButtonUI(isDragging: false),
                ),
              ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: AuthColors.headingText.withValues(alpha: 0.06),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 8.w,
                children: [
                  Expanded(
                    child: NavItem(
                      icon: AppIcons.home,
                      label: 'Home',
                      isSelected: widget.navigationShell.currentIndex == 0,
                      onTap: () => widget.navigationShell.goBranch(0),
                    ),
                  ),
                  Expanded(
                    child: NavItem(
                      icon: AppIcons.explore,
                      label: 'Browse',
                      isSelected: widget.navigationShell.currentIndex == 1,
                      onTap: () => widget.navigationShell.goBranch(1),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push('/add-donation'),
                    child: Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: AuthColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AuthColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        AppIcons.add,
                        color: colorScheme.onPrimary,
                        size: 28.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: NavItem(
                      icon: AppIcons.leaderboard,
                      label: 'Ranks',
                      isSelected: widget.navigationShell.currentIndex == 2,
                      onTap: () => widget.navigationShell.goBranch(2),
                    ),
                  ),
                  Expanded(
                    child: NavItem(
                      icon: AppIcons.profile,
                      label: 'Profile',
                      isSelected: widget.navigationShell.currentIndex == 3,
                      onTap: () => widget.navigationShell.goBranch(3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatButtonUI({required bool isDragging}) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        context.push('/chat');
      },
      child: Material(
        color: colorScheme.surface.withValues(alpha: 0),
        elevation: isDragging ? 10 : 6,
        shape: const CircleBorder(),
        child: Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            color: AuthColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AuthColors.primary.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              AppIcons.chat,
              color: colorScheme.onPrimary,
              size: 26.sp,
            ),
          ),
        ),
      ),
    );
  }

  Offset _clampChatPosition(Offset raw, Size size) {
    final maxX = size.width - _chatButtonSize;
    final maxY = size.height - _chatBottomLimit;
    final dx = raw.dx.clamp(0.0, maxX);
    final dy = raw.dy.clamp(_chatTopLimit, maxY);
    return Offset(dx, dy);
  }
}
