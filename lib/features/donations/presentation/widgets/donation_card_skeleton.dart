import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';

class DonationCardSkeleton extends StatelessWidget {
  final bool featured;

  const DonationCardSkeleton({super.key, this.featured = false});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Shimmer.fromColors(
      baseColor: colors.divider,
      highlightColor: colors.background,
      child: Container(
        width: featured ? 300.w : double.infinity,
        margin: EdgeInsets.only(bottom: 12.h, right: featured ? 12.w : 0),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: featured
            ? Column(
                children: [
                  Container(
                    height: 112.h,
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18.r),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      children: [
                        Container(height: 12.h, color: colors.surface),
                        SizedBox(height: 8.h),
                        Container(height: 10.h, color: colors.surface),
                      ],
                    ),
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.all(12.w),
                child: Row(
                  children: [
                    Container(
                      width: 84.w,
                      height: 84.w,
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12.h, color: colors.surface),
                          SizedBox(height: 8.h),
                          Container(height: 10.h, color: colors.surface),
                          SizedBox(height: 10.h),
                          Container(
                            height: 10.h,
                            width: 120.w,
                            color: colors.surface,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
