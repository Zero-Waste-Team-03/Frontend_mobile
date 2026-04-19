import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
<<<<<<< HEAD
      final size = MediaQuery.sizeOf(context);
      _chatPos = _clampChatPosition(
        Offset(size.width - 72.w, size.height - 180.h),
        size,
      );
=======
      final size = MediaQuery.of(context).size;
      _chatPos = Offset(size.width - 72.w, size.height - 180.h);
>>>>>>> 01394c65b3604ccf61a27fc611323962103e7e87
    }
    return BlocProvider(
      create: (context) =>
          getIt<DonationsBloc>()..add(const LoadDonationsEvent()),
<<<<<<< HEAD
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
=======
      child: Stack(
        children: [
          Scaffold(
            extendBody: true,
            body: widget.navigationShell,
            bottomNavigationBar: ClipRRect(
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 24.0, sigmaY: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    border: Border(
                      top: BorderSide(
                        color: const Color(
                          0xFFF1F5F9,
                        ), // Light border from Figma
                        width: 1,
                      ),
>>>>>>> 01394c65b3604ccf61a27fc611323962103e7e87
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: _NavItem(
                              icon: AppIcons.home,
                              label: 'Home',
                              isSelected:
                                  widget.navigationShell.currentIndex == 0,
                              onTap: () => widget.navigationShell.goBranch(0),
                            ),
                          ),
                          Expanded(
                            child: _NavItem(
                              icon: AppIcons.search,
                              label: 'Browse',
                              isSelected:
                                  widget.navigationShell.currentIndex == 1,
                              onTap: () => widget.navigationShell.goBranch(1),
                            ),
                          ),
                          Expanded(
                            child: _NavItem(
                              icon: AppIcons.add,
                              label: 'Donate',
                              isSelected: false,
                              onTap: () => context.push('/add-donation'),
                            ),
                          ),
                          Expanded(
                            child: _NavItem(
                              icon: AppIcons.leaderboard,
                              label: 'Leaderboard',
                              isSelected:
                                  widget.navigationShell.currentIndex == 2,
                              onTap: () => widget.navigationShell.goBranch(2),
                            ),
                          ),
                          Expanded(
                            child: _NavItem(
                              icon: AppIcons.profile,
                              label: 'Profile',
                              isSelected:
                                  widget.navigationShell.currentIndex == 3,
                              onTap: () => widget.navigationShell.goBranch(3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
<<<<<<< HEAD
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
=======
                ),
>>>>>>> 01394c65b3604ccf61a27fc611323962103e7e87
              ),
            ),
          ),
          Positioned(
            left: _chatPos.dx,
            top: _chatPos.dy,
            child: Draggable(
              feedback: _buildChatButtonUI(isDragging: true),
              childWhenDragging: const SizedBox.shrink(),
              onDragEnd: (details) {
                setState(() {
                  double dx = details.offset.dx;
                  double dy = details.offset.dy;
                  final screenSize = MediaQuery.of(context).size;
                  if (dx < 0) dx = 0;
                  if (dx > screenSize.width - 64) dx = screenSize.width - 64;
                  if (dy < kToolbarHeight) dy = kToolbarHeight;
                  if (dy > screenSize.height - 100)
                    dy = screenSize.height - 100;
                  _chatPos = Offset(dx, dy);
                });
              },
              child: _buildChatButtonUI(isDragging: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatButtonUI({required bool isDragging}) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
<<<<<<< HEAD
      onTap: () {
        context.push('/chat');
      },
=======
      onTap: () => context.push('/chats'),
>>>>>>> 01394c65b3604ccf61a27fc611323962103e7e87
      child: Material(
        color: colorScheme.surface.withValues(alpha: 0),
        elevation: isDragging ? 10 : 6,
        shape: const CircleBorder(),
        child: Container(
          width: 56.w,
          height: 56.w,
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

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.onSurface.withValues(alpha: 0.7),
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
                letterSpacing: 0.25,
                color: isSelected
                    ? AppColors.primary
                    : AppColors.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
