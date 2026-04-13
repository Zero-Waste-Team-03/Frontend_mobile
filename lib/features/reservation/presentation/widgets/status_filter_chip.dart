import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';
class StatusFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const StatusFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium.w,
          vertical: AppDimensions.paddingSmall.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AuthColors.primary : Colors.white,
          border: Border.all(
            color: isSelected ? AuthColors.primary : AuthColors.dividerColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: AppDimensions.bodySize.sp,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AuthColors.labelText,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
      ),
    );
  }
}
