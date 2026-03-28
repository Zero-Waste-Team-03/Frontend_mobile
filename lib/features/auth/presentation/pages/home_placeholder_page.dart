import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';

class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: Center(
        child: Text(
          'Home Screen Placeholder',
          style: TextStyle(
            fontSize: AppDimensions.titleSize.sp,
            fontWeight: FontWeight.bold,
            color: AuthColors.headingText,
          ),
        ),
      ),
    );
  }
}
