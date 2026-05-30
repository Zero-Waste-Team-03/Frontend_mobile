import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class SaverAnalyticsPage extends StatelessWidget {
  const SaverAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Saver Analytics',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard(
              'CO2 Saved',
              '0.0 kg',
              Icons.eco_outlined,
              Colors.green,
              context,
            ),
            SizedBox(height: 16.h),
            _buildStatCard(
              'Meals Shared',
              '0',
              Icons.restaurant_outlined,
              Colors.orange,
              context,
            ),
            SizedBox(height: 16.h),
            _buildStatCard(
              'Money Saved',
              '\$0.00',
              Icons.savings_outlined,
              Colors.blue,
              context,
            ),
            SizedBox(height: 32.h),
            Text(
              'Activity Overview',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              height: 200.h,
              color: colors.surface,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: colors.divider),
              ),
              child: Center(
                child: Text(
                  'Chart Placeholder',
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    BuildContext context,
  ) {
    final colors =
        context.themeColors; // Use light theme colors for card icons/text
    return Container(
      color: colors.surface,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
