import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

void showReservationPendingDialog(
  BuildContext context, {
  required VoidCallback onDismiss,
  required String donationTitle,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ReservationPendingDialog(
      onDismiss: onDismiss,
      donationTitle: donationTitle,
    ),
  );
}

class ReservationPendingDialog extends StatefulWidget {
  final VoidCallback onDismiss;
  final String donationTitle;

  const ReservationPendingDialog({
    Key? key,
    required this.onDismiss,
    required this.donationTitle,
  }) : super(key: key);

  @override
  State<ReservationPendingDialog> createState() =>
      _ReservationPendingDialogState();
}

class _ReservationPendingDialogState extends State<ReservationPendingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(
                AppDimensions.borderRadiusExtraLarge.r,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Status Icon with animation
                Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.schedule_rounded,
                      size: 40.sp,
                      color: colors.primary,
                    ),
                  ),
                ),
                SizedBox(height: AppDimensions.paddingLarge.h),

                // Title
                Text(
                  'Reservation Pending',
                  style: TextStyle(
                    fontSize: AppDimensions.titleSize.sp,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                    fontFamily: AppFonts.primaryFont,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimensions.paddingMedium.h),

                // Donation Title
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium.w,
                    vertical: AppDimensions.paddingSmall.h,
                  ),
                  decoration: BoxDecoration(
                    color: colors.lightGrayBackground,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusMedium.r,
                    ),
                  ),
                  child: Text(
                    widget.donationTitle,
                    style: TextStyle(
                      fontSize: AppDimensions.buttonTextSize.sp,
                      fontWeight: FontWeight.w600,
                      color: colors.primary,
                      fontFamily: AppFonts.primaryFont,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingLarge.h),

                // Description
                Text(
                  'Your reservation has been submitted successfully!',
                  style: TextStyle(
                    fontSize: AppDimensions.bodySize.sp,
                    color: colors.textSecondary,
                    fontFamily: AppFonts.primaryFont,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: AppDimensions.paddingMedium.h),

                // Key Info Box
                Container(
                  padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusMedium.r,
                    ),
                    border: Border.all(
                      color: colors.primary.withValues(alpha: 0.15),
                      width: 1.5.w,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_rounded,
                            color: colors.primary,
                            size: 20.sp,
                          ),
                          SizedBox(width: AppDimensions.paddingMedium.w),
                          Expanded(
                            child: Text(
                              'Awaiting Donor Confirmation',
                              style: TextStyle(
                                fontSize: AppDimensions.bodySize.sp,
                                fontWeight: FontWeight.w600,
                                color: colors.textPrimary,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      Text(
                        'The donor has 24 hours to confirm your reservation. You\'ll receive a notification once they respond.',
                        style: TextStyle(
                          fontSize: AppDimensions.captionSize.sp,
                          color: colors.textSecondary,
                          fontFamily: AppFonts.primaryFont,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppDimensions.paddingLarge.h),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          widget.onDismiss();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.lightGreenBackground,
                          padding: EdgeInsets.symmetric(
                            vertical: AppDimensions.paddingMedium.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusLarge.r,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Got it!',
                          style: TextStyle(
                            fontSize: AppDimensions.buttonTextSize.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.primary,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
