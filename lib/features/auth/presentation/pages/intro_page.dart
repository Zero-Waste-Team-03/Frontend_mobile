import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'auth_colors.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge.w,
            vertical: 40.0.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: AppDimensions.logoIconSize.w,
                    height: AppDimensions.logoIconSize.h,
                    decoration: const BoxDecoration(
                      color: AuthColors.background,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.eco,
                      color: AuthColors.primary,
                      size: AppDimensions.logoIconSize.sp,
                    ),
                  ),
                  SizedBox(width: AppDimensions.paddingSmall.w),
                  Text(
                    "Gasp'Zero",
                    style: TextStyle(
                      fontSize: AppDimensions.logoTextSize.sp,
                      fontWeight: FontWeight.bold,
                      color: AuthColors.primary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "Share Food, Save the\nPlanet.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppDimensions.headingSize.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.025 * AppDimensions.headingSize.sp,
                  color: AuthColors.headingText,
                  height: 1.25,
                ),
              ),
              SizedBox(height: AppDimensions.paddingMedium.h),
              Text(
                "Join the community-driven movement\nto reduce food waste and support those in need.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppDimensions.subtitleSize.sp,
                  fontWeight: FontWeight.w400,
                  color: AuthColors.subText,
                  height: 1.625,
                ),
              ),
              SizedBox(height: 48.h),

              // Action Buttons
              ElevatedButton(
                onPressed: () => context.push('/register'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56.h),
                  backgroundColor: AuthColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusExtraLarge.r,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Join the Community',
                  style: TextStyle(
                    fontSize: AppDimensions.primaryButtonTextSize.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing:
                        0.015 * AppDimensions.primaryButtonTextSize.sp,
                  ),
                ),
              ),
              SizedBox(height: AppDimensions.paddingMedium.h),
              ElevatedButton(
                onPressed: () => context.push('/login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 56.h),
                  backgroundColor: AuthColors.primary.withValues(alpha: 0.1),
                  foregroundColor: AuthColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusExtraLarge.r,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: AppDimensions.primaryButtonTextSize.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing:
                        0.015 * AppDimensions.primaryButtonTextSize.sp,
                  ),
                ),
              ),
              const Spacer(),

              // Footer / App Info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildFeature(Icons.energy_savings_leaf, 'Eco Friendly'),
                  _buildFeature(Icons.people, 'Community'),
                  _buildFeature(Icons.recycling, 'Zero Waste'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: AuthColors.primary, size: AppDimensions.iconSize.sp),
        SizedBox(height: AppDimensions.paddingSmall.h),
        Text(
          text,
          style: TextStyle(
            color: AuthColors.subText,
            fontSize: AppDimensions.captionSize.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
