import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../shared/theme/app_colors.dart';

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
    if (_chatPos == const Offset(300, 500)) {
      final size = MediaQuery.of(context).size;
      _chatPos = Offset(size.width - 72.w, size.height - 180.h);
    }
    return Scaffold(
      body: Stack(
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
                    double dx = details.offset.dx;
                    double dy = details.offset.dy;
                    final screenSize = MediaQuery.of(context).size;
                    if (dx < 0) dx = 0;
                    if (dx > screenSize.width - 64) dx = screenSize.width - 64;
                    if (dy < kToolbarHeight) dy = kToolbarHeight;
                    if (dy > screenSize.height - 100) dy = screenSize.height - 100;
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
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
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
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isSelected: widget.navigationShell.currentIndex == 0,
                  onTap: () => widget.navigationShell.goBranch(0),
                ),
                _NavItem(
                  icon: Icons.search_rounded,
                  label: 'Browse',
                  isSelected: widget.navigationShell.currentIndex == 1,
                  onTap: () => widget.navigationShell.goBranch(1),
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
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                  ),
                ),
                _NavItem(
                  icon: Icons.chat_bubble_rounded,
                  label: 'Chat',
                  isSelected: widget.navigationShell.currentIndex == 2,
                  onTap: () => widget.navigationShell.goBranch(2),
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  isSelected: widget.navigationShell.currentIndex == 3,
                  onTap: () => widget.navigationShell.goBranch(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatButtonUI({required bool isDragging}) {
    return GestureDetector(
      onTap: () {
        widget.navigationShell.goBranch(2);
      },
      child: Material(
        color: Colors.transparent,
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
              Icons.chat_bubble_rounded,
              color: Colors.white,
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
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AuthColors.primary : const Color(0xFF94A3B8),
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color:
                    isSelected ? AuthColors.primary : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
