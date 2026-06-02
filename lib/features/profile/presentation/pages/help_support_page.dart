import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/theme/app_colors.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  static const String _supportEmail = 'support@gaspzero.app';
  static const String _supportPhone = '+1 555 014 2400';

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: colors.primary,
            size: AppDimensions.iconSize.sp,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Help & Support',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: colors.primary,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge.w,
            vertical: AppDimensions.paddingMedium.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary.withValues(alpha: 0.95),
                      colors.primary.withValues(alpha: 0.78),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusExtraLarge.r,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 52.w,
                      height: 52.w,
                      decoration: BoxDecoration(
                        color: colors.onPrimary.withValues(alpha: 0.16),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.support_agent_rounded,
                        color: colors.onPrimary,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'We are here to help',
                            style: TextStyle(
                              fontSize: AppDimensions.titleSize.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.onPrimary,
                              fontFamily: AppFonts.primaryFont,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Find quick answers below or reach the team directly if something needs attention.',
                            style: TextStyle(
                              fontSize: AppDimensions.bodySize.sp,
                              height: 1.4,
                              color: colors.onPrimary.withValues(alpha: 0.92),
                              fontFamily: AppFonts.primaryFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Quick Contact',
                style: TextStyle(
                  fontSize: AppDimensions.captionSize.sp,
                  fontWeight: FontWeight.w600,
                  color: colors.headingText,
                  letterSpacing: 0.5,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
              SizedBox(height: 12.h),
              _SupportActionCard(
                icon: Icons.email_rounded,
                iconColor: colors.primary,
                title: 'Email support',
                description: _supportEmail,
                accentColor: colors.primary.withValues(alpha: 0.08),
                onTap: () => _launchExternal(
                  'mailto:$_supportEmail?subject=GaspZero%20Support%20Request',
                ),
              ),
              SizedBox(height: 12.h),
              _SupportActionCard(
                icon: Icons.call_rounded,
                iconColor: colors.statusActiveText,
                title: 'Call support',
                description: _supportPhone,
                accentColor: colors.statusActiveBackground,
                onTap: () => _launchExternal(
                  Uri(
                    scheme: 'tel',
                    path: _supportPhone.replaceAll(' ', ''),
                  ).toString(),
                ),
              ),
              SizedBox(height: 12.h),
              _SupportActionCard(
                icon: Icons.schedule_rounded,
                iconColor: colors.textSecondary,
                title: 'Typical response time',
                description: 'Within 24 hours on business days',
                accentColor: colors.lightGrayBackground,
                onTap: null,
              ),
              SizedBox(height: 24.h),
              Text(
                'FAQ',
                style: TextStyle(
                  fontSize: AppDimensions.captionSize.sp,
                  fontWeight: FontWeight.w600,
                  color: colors.headingText,
                  letterSpacing: 0.5,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
              SizedBox(height: 12.h),
              _FaqItem(
                question: 'How do I update my profile?',
                answer:
                    'Open Profile, tap Edit Account Info, and save your changes. Some fields may depend on what the backend currently supports.',
              ),
              SizedBox(height: 12.h),
              _FaqItem(
                question: 'How do notifications work?',
                answer:
                    'Notifications can be managed from Settings. Push alerts and donation updates can be toggled separately.',
              ),
              SizedBox(height: 12.h),
              _FaqItem(
                question: "Why can't I find a donation or reservation?",
                answer:
                    'Refresh the page first. If the item still does not appear, the donation may have expired, been reserved, or be hidden by a filter.',
              ),
              SizedBox(height: 12.h),
              _FaqItem(
                question: 'How do I report a bug?',
                answer:
                    'Use the email shortcut above and include a screenshot, device model, and the steps you took before the issue happened.',
              ),
              SizedBox(height: 24.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.w),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusLarge.r,
                  ),
                  border: Border.all(color: colors.buttonBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Need more help?',
                      style: TextStyle(
                        fontSize: AppDimensions.buttonTextSize.sp,
                        fontWeight: FontWeight.w700,
                        color: colors.headingText,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Send the team a message and mention the screen you were on. That usually gets you the fastest answer.',
                      style: TextStyle(
                        fontSize: AppDimensions.bodySize.sp,
                        height: 1.4,
                        color: colors.subText,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                    SizedBox(height: 14.h),
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton.icon(
                        onPressed: () => _launchExternal(
                          'mailto:$_supportEmail?subject=GaspZero%20Support%20Request',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusLarge.r,
                            ),
                          ),
                        ),
                        icon: Icon(
                          Icons.message_rounded,
                          size: AppDimensions.iconSize.sp,
                          color: colors.onPrimary,
                        ),
                        label: Text(
                          'Contact support',
                          style: TextStyle(
                            fontSize: AppDimensions.buttonTextSize.sp,
                            fontWeight: FontWeight.w600,
                            color: colors.onPrimary,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchExternal(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class _SupportActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final Color accentColor;
  final VoidCallback? onTap;

  const _SupportActionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusLarge.r,
            ),
            border: Border.all(color: colors.buttonBorder),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: accentColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(icon, color: iconColor, size: 22.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: AppDimensions.buttonTextSize.sp,
                        fontWeight: FontWeight.w700,
                        color: colors.headingText,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: AppDimensions.bodySize.sp,
                        color: colors.subText,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.subText,
                  size: AppDimensions.iconSize.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
        border: Border.all(color: colors.buttonBorder),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        childrenPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
        iconColor: colors.primary,
        collapsedIconColor: colors.subText,
        title: Text(
          question,
          style: TextStyle(
            fontSize: AppDimensions.bodySize.sp,
            fontWeight: FontWeight.w600,
            color: colors.headingText,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
        children: [
          Text(
            answer,
            style: TextStyle(
              fontSize: AppDimensions.bodySize.sp,
              height: 1.5,
              color: colors.subText,
              fontFamily: AppFonts.primaryFont,
            ),
          ),
        ],
      ),
    );
  }
}
