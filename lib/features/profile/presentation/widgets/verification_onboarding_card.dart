import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/theme/app_colors.dart';

class VerificationOnboardingCard extends StatelessWidget {
  const VerificationOnboardingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: colors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.onBackground.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color:  colors.background,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: colors.onBackground.withValues(alpha: 0.05),
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: colors.primary,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Text(
                  'Get Verified',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(left: 0.w),
            child: Text(
              'Connect with trusted food savers in your community to get verified and build trust.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: colors.textSecondary,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          _buildStepCard(
            context: context,
            icon: Icons.calendar_today,
            title: 'Find food savers',
            description: 'Search for food savers near you and send them a verification request.',
          ),
          SizedBox(height: 12.h),
          _buildStepCard(
            context: context,
            icon: Icons.verified,
            title: 'Receive verification',
            description: 'Meet with food savers who will confirm your identity and verify your profile.',
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final colors = context.themeColors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 14.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: colors.textSecondary,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
