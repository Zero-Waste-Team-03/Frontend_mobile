import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DonationCardSkeleton extends StatelessWidget {
  final bool featured;

  const DonationCardSkeleton({super.key, this.featured = false});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE5E7EB),
      highlightColor: const Color(0xFFF3F4F6),
      child: Container(
        width: featured ? 300.w : double.infinity,
        margin: EdgeInsets.only(bottom: 12.h, right: featured ? 12.w : 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: featured
            ? Column(
                children: [
                  Container(
                    height: 112.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18.r),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Column(
                      children: [
                        Container(height: 12.h, color: Colors.white),
                        SizedBox(height: 8.h),
                        Container(height: 10.h, color: Colors.white),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 12.h, color: Colors.white),
                          SizedBox(height: 8.h),
                          Container(height: 10.h, color: Colors.white),
                          SizedBox(height: 10.h),
                          Container(
                            height: 10.h,
                            width: 120.w,
                            color: Colors.white,
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
