import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../donations/presentation/widgets/donation_card_utils.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final String label;

  const StatusBadge({super.key, required this.status, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium.w,
        vertical: AppDimensions.paddingSmall.h,
      ),
      decoration: BoxDecoration(
        color: statusBackgroundColor(status, context),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: AppDimensions.bodySize.sp,
          fontWeight: FontWeight.w600,
          color: statusTextColor(status, context),
          fontFamily: AppFonts.primaryFont,
        ),
      ),
    );
  }
}
