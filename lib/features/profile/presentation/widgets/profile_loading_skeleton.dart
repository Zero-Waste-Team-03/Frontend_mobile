import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../shared/theme/app_colors.dart';

class ProfileLoadingSkeleton extends StatelessWidget {
  const ProfileLoadingSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
       final colors = context.themeColors;
       return SingleChildScrollView(
         physics: const AlwaysScrollableScrollPhysics(),
         child: Shimmer.fromColors(
           baseColor: colors.inputBackground,
           highlightColor: colors.background,
        child: Column(
          children: [
            // Avatar and Name Section
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                children: [
                  // Avatar placeholder
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      color: colors.inputBackground,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Name placeholder
                  Container(
                    width: 150.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: colors.inputBackground,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Email placeholder
                  Container(
                    width: 180.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: colors.inputBackground,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Status badge placeholder
                  Container(
                    width: 120.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      color: colors.inputBackground,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Edit button placeholder
                  Container(
                    width: 140.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: colors.inputBackground,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ],
              ),
            ),

            // Stats Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 6.w),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: colors.inputBorder),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: colors.inputBackground,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            width: 60.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: colors.inputBackground,
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Activity Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Activity header
                  Container(
                    width: 80.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: colors.inputBackground,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Activity items (2 items)
                  ...List.generate(
                    2,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: colors.inputBorder),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40.w,
                              height: 40.w,
                              decoration: BoxDecoration(
                                color: colors.inputBackground,
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 12.h,
                                    decoration: BoxDecoration(
                                      color: colors.inputBackground,
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: 10.h,
                                    decoration: BoxDecoration(
                                      color: colors.inputBackground,
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Container(
                              width: 20.w,
                              height: 20.w,
                              decoration: BoxDecoration(
                                color: colors.inputBackground,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Preferences Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: colors.inputBackground,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: colors.inputBorder),
                    ),
                    child: Column(
                      children: List.generate(
                        3,
                        (index) => Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                      color: colors.inputBackground,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Container(
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        color: colors.inputBackground,
                                        borderRadius: BorderRadius.circular(
                                          6.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Container(
                                    width: 20.w,
                                    height: 20.w,
                                    decoration: BoxDecoration(
                                      color: colors.inputBackground,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (index < 2)
                              Divider(
                                height: 1.h,
                                color: colors.inputBorder,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16.h),

            // Logout button placeholder
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.infinity,
                height: 44.h,
                decoration: BoxDecoration(
                  color: colors.inputBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Footer text
            Container(
              width: 200.w,
              height: 12.h,
              margin: EdgeInsets.only(bottom: 24.h),
              decoration: BoxDecoration(
                color: colors.inputBackground,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


