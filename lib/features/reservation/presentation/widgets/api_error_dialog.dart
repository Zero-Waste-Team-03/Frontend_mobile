import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';

void showApiErrorDialog(
  BuildContext context, {
  required String message,
  String? statusCode,
  String? timestamp,
  VoidCallback? onRetry,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ApiErrorDialog(
      message: message,
      statusCode: statusCode,
      timestamp: timestamp,
      onRetry: onRetry,
    ),
  );
}

class ApiErrorDialog extends StatefulWidget {
  final String message;
  final String? statusCode;
  final String? timestamp;
  final VoidCallback? onRetry;

  const ApiErrorDialog({
    Key? key,
    required this.message,
    this.statusCode,
    this.timestamp,
    this.onRetry,
  }) : super(key: key);

  @override
  State<ApiErrorDialog> createState() => _ApiErrorDialogState();
}

class _ApiErrorDialogState extends State<ApiErrorDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: colors.surface,
          elevation: 8,
          contentPadding: EdgeInsets.all(24.w),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Error Icon
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    color: colors.error.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: colors.error,
                      size: 40.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),

                // Error Title
                Text(
                  'Request Failed',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),

                // Error Message
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: colors.error.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colors.error.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    widget.message,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: colors.error,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16.h),

                // Status Code and Timestamp
                if (widget.statusCode != null || widget.timestamp != null)
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: colors.lightGrayBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.statusCode != null)
                              Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(
                                  children: [
                                    Text(
                                      'Status Code: ',
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: colors.textSecondary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.error.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                      child: Text(
                                        widget.statusCode!,
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: colors.error,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (widget.timestamp != null)
                              Row(
                                children: [
                                  Text(
                                    'Time: ',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: colors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      widget.timestamp!,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: colors.textMuted,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.lightGrayBackground,
                          foregroundColor: colors.textPrimary,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Dismiss',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (widget.onRetry != null) ...[
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onRetry?.call();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.error,
                            foregroundColor: colors.onPrimary,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            'Retry',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
