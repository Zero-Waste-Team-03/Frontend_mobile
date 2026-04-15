import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (_chatPos == const Offset(300, 500)) {
      final size = MediaQuery.of(context).size;
      _chatPos = Offset(size.width - 72.w, size.height - 180.h);
    }
    return BlocProvider(
      create: (context) =>
          getIt<DonationsBloc>()..add(const LoadDonationsEvent()),
      child: Scaffold(
        body: Stack(
          children: [
            widget.navigationShell,
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
                children: [
                  _NavItem(
                    icon: AppIcons.home,
                    label: 'Home',
                    isSelected: widget.navigationShell.currentIndex == 0,
                    onTap: () => widget.navigationShell.goBranch(0),
                  ),
                  _NavItem(
                    icon: AppIcons.search,
                    label: 'Browse',
                    isSelected: widget.navigationShell.currentIndex == 1,
                    onTap: () => widget.navigationShell.goBranch(1),
                  ),
                  _NavItem(
                    icon: AppIcons.add,
                    label: 'Donate',
                    isSelected: false,
                    onTap: () => context.push('/add-donation'),
                  ),
                  _NavItem(
                    icon: AppIcons.ranks,
                    label: 'Ranks',
                    isSelected: widget.navigationShell.currentIndex == 2,
                    onTap: () => widget.navigationShell.goBranch(2),
                  ),
                  _NavItem(
                    icon: AppIcons.profile,
                    label: 'Profile',
                    isSelected: widget.navigationShell.currentIndex == 3,
                    onTap: () => widget.navigationShell.goBranch(3),
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
      onTap: () => context.push('/chat'),
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
      child: Container(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: 0),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? AuthColors.primary
                    : const Color(0xFF94A3B8),
                size: isSelected ? 26.sp : 24.sp,
              ),
              if (isSelected) ...[
                SizedBox(height: 6.h),
                Container(
                  width: 4.w,
                  height: 4.w,
                  decoration: BoxDecoration(
                    color: AuthColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
