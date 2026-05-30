import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final String label;

  const StatusBadge({super.key, required this.status, required this.label});

  Color _getBackgroundColor(ThemeColors colors) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
      case 'PUBLISHED':
        return colors.primary.withValues(alpha: 0.08);
      case 'RESERVED':
        return colors.primary.withValues(alpha: 0.12);
      case 'COMPLETED':
        return colors.lightGreenBackground;
      case 'EXPIRED':
      case 'DRAFT':
        return colors.error.withValues(alpha: 0.08);
      default:
        return colors.error.withValues(alpha: 0.08);
    }
  }

  Color _getTextColor(ThemeColors colors) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
      case 'PUBLISHED':
        return colors.primary;
      case 'RESERVED':
        return colors.primary;
      case 'COMPLETED':
        return colors.primary;
      case 'EXPIRED':
      case 'DRAFT':
        return colors.error;
      default:
        return colors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium.w,
        vertical: AppDimensions.paddingSmall.h,
      ),
      decoration: BoxDecoration(
        color: _getBackgroundColor(colors),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppDimensions.bodySize.sp,
          fontWeight: FontWeight.w600,
          color: _getTextColor(colors),
          fontFamily: AppFonts.primaryFont,
        ),
      ),
    );
  }
}
