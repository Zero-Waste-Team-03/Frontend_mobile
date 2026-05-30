import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: colors.primary.withValues(alpha: isSelected ? 0.1 : 0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? colors.primary : colors.textMuted,
                size: 24.sp,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: isSelected ? colors.primary : colors.textMuted,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
