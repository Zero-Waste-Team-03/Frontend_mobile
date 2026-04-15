import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/features/auth/data/models/user_model.dart';
import '../../../../shared/theme/app_colors.dart';

class UserContactCard extends StatelessWidget {
  final UserModel user;
  final String title;
  final VoidCallback? onChatPressed;
  final VoidCallback? onCallPressed;

  const UserContactCard({
    super.key,
    required this.user,
    required this.title,
    this.onChatPressed,
    this.onCallPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
        border: Border.all(color: AuthColors.dividerColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: AppDimensions.bodySize.sp,
              fontWeight: FontWeight.w600,
              color: AuthColors.labelText,
              fontFamily: AppFonts.primaryFont,
            ),
          ),
          SizedBox(height: AppDimensions.paddingMedium.h),

          // User Info
          Row(
            children: [
              // Avatar
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AuthColors.lightGrayBackground,
                  image: user.avatarUrl != null && user.avatarUrl!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(user.avatarUrl!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: user.avatarUrl == null || user.avatarUrl!.isEmpty
                    ? Icon(
                        Icons.person,
                        color: AuthColors.inputText,
                        size: 24.sp,
                      )
                    : null,
              ),
              SizedBox(width: AppDimensions.paddingMedium.w),

              // User Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.displayName ?? 'Unknown User',
                      style: TextStyle(
                        fontSize: AppDimensions.bodySize.sp,
                        fontWeight: FontWeight.w600,
                        color: AuthColors.headingText,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      user.phoneNumber ?? 'No phone number',
                      style: TextStyle(
                        fontSize: AppDimensions.captionSize.sp,
                        color: AuthColors.subText,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingMedium.h),

          // Action Buttons
          Row(
            children: [
              if (onCallPressed != null)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onCallPressed,
                    icon: Icon(Icons.call, size: 18.sp),
                    label: Text(
                      'Call',
                      style: TextStyle(fontSize: AppDimensions.bodySize.sp),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AuthColors.primary, width: 1.5),
                      foregroundColor: AuthColors.primary,
                    ),
                  ),
                ),
              if (onChatPressed != null)
                SizedBox(width: AppDimensions.paddingMedium.w),
              if (onChatPressed != null)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onChatPressed,
                    icon: Icon(Icons.chat, size: 18.sp),
                    label: Text(
                      'Chat',
                      style: TextStyle(fontSize: AppDimensions.bodySize.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AuthColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
