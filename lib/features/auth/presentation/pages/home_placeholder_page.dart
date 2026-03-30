import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../auth/data/sources/auth_local_data_source.dart';
import '../../../auth/presentation/pages/auth_colors.dart';

class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

  Future<void> _logout(BuildContext context) async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: AuthColors.subText),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red.shade600),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // Clear stored tokens
      try {
        final localDataSource = getIt<AuthLocalDataSource>();
        await localDataSource.clearTokens();
      } catch (_) {}

      // Navigate back to intro/login
      if (context.mounted) {
        context.go('/');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      appBar: AppBar(
        backgroundColor: AuthColors.primary,
        elevation: 0,
        title: Text(
          "Gasp'Zero",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          // Temporary logout button
          IconButton(
            onPressed: () => _logout(context),
            tooltip: 'Logout',
            icon: Icon(Icons.logout_rounded, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.eco_rounded,
              size: 80.sp,
              color: AuthColors.primary.withOpacity(0.4),
            ),
            SizedBox(height: 24.h),
            Text(
              'Welcome to Gasp\'Zero!',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AuthColors.headingText,
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: Text(
                'Share food, reduce waste, and make a difference in your community.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: AppDimensions.bodySize.sp,
                  color: AuthColors.subText,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            // Temp logout button (large, visible)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.w),
              child: OutlinedButton.icon(
                onPressed: () => _logout(context),
                icon: Icon(Icons.logout_rounded, size: 20.sp),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: AppDimensions.buttonTextSize.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 52.h),
                  foregroundColor: Colors.red.shade600,
                  side: BorderSide(color: Colors.red.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
