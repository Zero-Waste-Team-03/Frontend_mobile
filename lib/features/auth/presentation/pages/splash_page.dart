import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'auth_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  // ignore: unused_field
  late Animation<double> _fadeAnimation;
  // ignore: unused_field
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80.w,
                  height: 80.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AuthColors.primary.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                RotationTransition(
                  turns: _controller,
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          AuthColors.primary.withValues(alpha: 0),
                          AuthColors.primary,
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.eco,
                  color: AuthColors.primary,
                  size: 32.sp,
                ),
              ],
            ),
            SizedBox(height: 32.h),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: 0.6 + (0.4 * (1.0 - (0.5 - (0.5 - _controller.value)).abs() * 2)),
                  child: Text(
                    "Gasp'Zero",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800,
                      color: AuthColors.primary,
                      letterSpacing: 8,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
