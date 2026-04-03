import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

class ProfilePlaceholderPage extends StatelessWidget {
  const ProfilePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_rounded, size: 64.sp, color: AuthColors.primary.withValues(alpha: 0.5)),
            SizedBox(height: 16.h),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: AppDimensions.titleSize.sp,
                fontWeight: FontWeight.bold,
                color: AuthColors.headingText,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Coming soon',
              style: TextStyle(
                fontSize: AppDimensions.bodySize.sp,
                color: AuthColors.subText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
