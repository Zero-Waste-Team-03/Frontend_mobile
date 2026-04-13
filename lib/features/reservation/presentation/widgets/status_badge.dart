import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final String label;

  const StatusBadge({super.key, required this.status, required this.label});

  Color get _backgroundColor {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
      case 'PUBLISHED':
        return AuthColors.statusActiveBackground;
      case 'RESERVED':
        return AuthColors.statusReservedBackground;
      case 'COMPLETED':
        return AuthColors.statusCompletedBackground;
      case 'EXPIRED':
      case 'DRAFT':
        return AuthColors.statusExpiredBackground;
      default:
        return AuthColors.statusExpiredBackground;
    }
  }

  Color get _textColor {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
      case 'PUBLISHED':
        return AuthColors.statusActiveText;
      case 'RESERVED':
        return AuthColors.statusReservedText;
      case 'COMPLETED':
        return AuthColors.statusCompletedText;
      case 'EXPIRED':
      case 'DRAFT':
        return AuthColors.statusExpiredText;
      default:
        return AuthColors.statusExpiredText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium.w,
        vertical: AppDimensions.paddingSmall.h,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppDimensions.bodySize.sp,
          fontWeight: FontWeight.w600,
          color: _textColor,
          fontFamily: AppFonts.primaryFont,
        ),
      ),
    );
  }
}
