import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart' show GoRouterHelper;
import '../../../../shared/theme/app_colors.dart';

class ReservationConfirmedDialog extends StatelessWidget {
  final VoidCallback onDismiss;
  final String donationTitle;
  final String pickupWindow;
  final String expiryAt;
  final String reservation_id;

  const ReservationConfirmedDialog({
    super.key,
    required this.onDismiss,
    this.donationTitle = 'Donation',
    this.pickupWindow = '2 hours',
    required this.expiryAt,
    required this.reservation_id,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Checkmark Icon
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE7EFEC),
                shape: BoxShape.circle,
              ),
              child: Center(
                child:  Icon(
                    Icons.check_circle_outline,
                    color: AppColors.primary,
                    size: 60.sp,
                  ),

              ),
            ),
            SizedBox(height: 24.h),

            // Title
            Text(
              'Reservation Confirmed!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimensions.headingSize,
                fontWeight: FontWeight.w800,
                color: AuthColors.headingText,
                fontFamily: AppFonts.primaryFont,
                height: 1.15,
              ),
            ),
            SizedBox(height: 14.h),

            // Description
            Text(
              'You have $pickupWindow to pick up this\ndonation. Please coordinate with the\ndonor via the chat or provided\ncontact info.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimensions.subtitleSize,
                color: AuthColors.subText,
                fontFamily: AppFonts.primaryFont,
                height: 1.45,
              ),
            ),
            SizedBox(height: 22.h),

            // Timeframe Alert
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F1DF),
                borderRadius: BorderRadius.circular(40.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    color: const Color(0xFFC4680F),
                    size: 20.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Expiring at $expiryAt',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFFC4680F),
                      fontFamily: AppFonts.primaryFont,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 26.h),

            // View Pickup Details Button
            SizedBox(
              width: double.infinity,
              height: 60.h,
              child: ElevatedButton(
                onPressed: () {
                  onDismiss();
                  if (reservation_id != null && reservation_id.isNotEmpty) {
                   context.push(
                                  '/reservation-details',
                                  extra: reservation_id,
                                );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AuthColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.r),
                  ),
                  elevation: 0,
                  
                ),
                child: Text(
                  'View Pickup Details',
                  style: TextStyle(
                    fontSize: 22.sp * 0.88,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
              ),
            ),
            SizedBox(height: 14.h),

            // Dismiss Button
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Dismiss',
                  style: TextStyle(
                    fontSize: 20.sp * 0.88,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF707986),
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
  String pickupWindow = '2 hours',
  String? expiryAt,
  String reservation_id = '',
}) {
  final resolvedExpiryAt =
      expiryAt ?? _formatExpiryAt(DateTime.now().add(const Duration(hours: 2)));

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ReservationConfirmedDialog(
      onDismiss: onDismiss,
      donationTitle: donationTitle,
      pickupWindow: pickupWindow,
      expiryAt: resolvedExpiryAt,
      reservation_id: reservation_id,
    ),
  );
}

String _formatExpiryAt(DateTime dateTime) {
  final hour24 = dateTime.hour;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = hour24 >= 12 ? 'PM' : 'AM';
  final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  return '$hour12:$minute $period';
}
