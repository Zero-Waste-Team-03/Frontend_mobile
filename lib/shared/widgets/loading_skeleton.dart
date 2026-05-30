import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

class LoadingSkeleton extends StatelessWidget {
  final int itemCount;

  const LoadingSkeleton({Key? key, this.itemCount = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      itemCount: itemCount,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: colors.surface.withValues(alpha: 0.72),
          highlightColor: colors.surface.withValues(alpha: 0.92),
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: colors.divider),
            ),
            child: Row(
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: colors.lightGrayBackground,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: colors.lightGrayBackground,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: colors.lightGrayBackground,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: colors.lightGrayBackground,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: colors.lightGrayBackground,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
