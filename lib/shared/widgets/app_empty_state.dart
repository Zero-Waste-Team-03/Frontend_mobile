import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_icons.dart';
import '../../core/theme/app_colors.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String description;

  const AppEmptyState({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(
                AppIcons.search,
                color: colors.textSecondary,
                size: 28.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
