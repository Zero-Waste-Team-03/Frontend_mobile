import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

class ReservationConfirmedDialog extends StatelessWidget {
  final VoidCallback onDismiss;
  final String donationTitle;
  final String expiryTime;

  const ReservationConfirmedDialog({
    super.key,
    required this.onDismiss,
    this.donationTitle = 'Donation',
    this.expiryTime = '2 hours',
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium.w),
        padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkmark Icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AuthColors.lightGreenBackground,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.check_circle,
                  color: AuthColors.primary,
                  size: 60.sp,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),

            // Title
            Text(
              'Reservation Confirmed!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimensions.titleSize.sp,
                fontWeight: FontWeight.bold,
                color: AuthColors.headingText,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            SizedBox(height: AppDimensions.paddingMedium.h),

            // Description
            Text(
              'You have $expiryTime to pick up this\ndonation. Please coordinate with the\ndonor via the chat or provided\ncontact info.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimensions.bodySize.sp,
                color: AuthColors.subText,
                fontFamily: AppFonts.primaryFont,
                height: 1.5,
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),

            // Timeframe Alert
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium.w,
                vertical: AppDimensions.paddingSmall.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusMedium,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: const Color(0xFF92400E),
                    size: AppDimensions.iconSize.sp,
                  ),
                  SizedBox(width: AppDimensions.paddingSmall.w),
                  Expanded(
                    child: Text(
                      'Expiring in $expiryTime',
                      style: TextStyle(
                        fontSize: AppDimensions.captionSize.sp,
                        color: const Color(0xFF92400E),
                        fontFamily: AppFonts.primaryFont,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),

            // View Pickup Details Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onDismiss();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuthColors.primary,
                  padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingMedium.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusLarge,
                    ),
                  ),
                ),
                child: Text(
                  'View Pickup Details',
                  style: TextStyle(
                    fontSize: AppDimensions.buttonTextSize.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingMedium.h),

            // Dismiss Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Dismiss',
                  style: TextStyle(
                    fontSize: AppDimensions.buttonTextSize.sp,
                    fontWeight: FontWeight.w600,
                    color: AuthColors.subText,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper function to show the dialog
void showReservationConfirmedDialog(
  BuildContext context, {
  required VoidCallback onDismiss,
  String donationTitle = 'Donation',
  String expiryTime = '2 hours',
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ReservationConfirmedDialog(
      onDismiss: onDismiss,
      donationTitle: donationTitle,
      expiryTime: expiryTime,
    ),
  );
}
