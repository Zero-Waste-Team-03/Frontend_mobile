import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _onRefresh() async {
    context.read<ProfileBloc>().add(const ProfileRefreshRequested());
    // Wait for the refresh to complete
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          // Auto-refresh after avatar update
          Future.delayed(const Duration(milliseconds: 500), _onRefresh);
        } else if (state is ProfileError && state is! ProfileUpdating) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AuthColors.background,
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading && state is! ProfileUpdating) {
                return Center(
                  child: CircularProgressIndicator(color: AuthColors.primary),
                );
              }

              if (state is ProfileError && state is! ProfileUpdating) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        size: 64.sp,
                        color: Colors.red,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Error loading profile',
                        style: TextStyle(
                          fontSize: AppDimensions.titleSize.sp,
                          fontWeight: FontWeight.bold,
                          color: AuthColors.headingText,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppDimensions.bodySize.sp,
                          color: AuthColors.subText,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<ProfileBloc>().add(
                            const ProfileRefreshRequested(),
                          );
                        },
                        icon: const Icon(Icons.refresh_rounded),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              // Get user data from state
              final user = state is ProfileLoaded
                  ? state.user
                  : (state is ProfileUpdating
                        ? state.currentUser
                        : (state is ProfileUpdateSuccess ? state.user : null));
              final isUpdating = state is ProfileUpdating;

              if (user == null) {
                return Center(
                  child: Text(
                    'No user data available',
                    style: TextStyle(
                      fontSize: AppDimensions.bodySize.sp,
                      color: AuthColors.subText,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: _onRefresh,
                color: AuthColors.primary,
                backgroundColor: AuthColors.background,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Header with profile title and bell icon
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge.w,
                          vertical: AppDimensions.paddingMedium.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: AppDimensions.appBarTitleSize.sp,
                                fontWeight: FontWeight.bold,
                                color: AuthColors.primary,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notifications_none_rounded,
                                color: AuthColors.primary,
                                size: AppDimensions.iconSize.sp,
                              ),
                              style: IconButton.styleFrom(
                                backgroundColor: AuthColors.lightGrayBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              onPressed: () {
                                context.push('/notifications');
                              },
                            ),
                          ],
                        ),
                      ),

                      // User Avatar and Name Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingLarge.h,
                        ),
                        child: Column(
                          children: [
                            // Avatar with verification badge and camera button for editing
                            Stack(
                              children: [
                                Container(
                                  width: 120.w,
                                  height: 120.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AuthColors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                  ),
                                  child:
                                      user.avatarUrl != null &&
                                          user.avatarUrl!.isNotEmpty
                                      ? ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: user.avatarUrl!,
                                            key: ValueKey(user.avatarUrl),
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      color: AuthColors.primary,
                                                    ),
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return Center(
                                                child: Text(
                                                  _getInitials(user.name),
                                                  style: TextStyle(
                                                    fontSize: 48.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AuthColors.primary,
                                                    fontFamily:
                                                        AppFonts.primaryFont,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Center(
                                          child: Text(
                                            _getInitials(user.name),
                                            style: TextStyle(
                                              fontSize: 48.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AuthColors.primary,
                                              fontFamily: AppFonts.primaryFont,
                                            ),
                                          ),
                                        ),
                                ),
                                // Verification badge
                                if (user.isMailVerified)
                                  Positioned(
                                    bottom: 4.w,
                                    right: 4.w,
                                    child: Container(
                                      width: 28.w,
                                      height: 28.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AuthColors.primary,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.w,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                    ),
                                  ),
                                // Camera button for updating avatar
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: isUpdating
                                        ? null
                                        : () => _pickAndUploadAvatar(context),
                                    child: Container(
                                      width: 36.w,
                                      height: 36.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AuthColors.primary,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2.w,
                                        ),
                                      ),
                                      child: isUpdating
                                          ? SizedBox(
                                              width: 16.w,
                                              height: 16.w,
                                              child:
                                                  const CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                          Color
                                                        >(Colors.white),
                                                  ),
                                            )
                                          : Icon(
                                              Icons.edit_rounded,
                                              color: Colors.white,
                                              size: 20.sp,
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),

                            // User Name
                            Center(
                              child: Text(
                                user.name ?? 'N/A',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppDimensions.titleSize.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AuthColors.headingText,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingSmall.h),

                            // Email
                            Text(
                              user.email ?? 'N/A',
                              style: TextStyle(
                                fontSize: AppDimensions.bodySize.sp,
                                fontWeight: FontWeight.w400,
                                color: AuthColors.primary,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),

                            // Status Badge with leaf icon
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingSmall.w,
                                vertical: 5.h,
                              ),
                              decoration: BoxDecoration(
                                color: AuthColors.primary,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusExtraLarge.r,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.eco_outlined,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    'ACTIVE FOOD SAVER',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: AppFonts.primaryFont,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),

                            SizedBox(
                              width: 140.w,
                              height: 32.h,
                              child: ElevatedButton(
                                onPressed: isUpdating
                                    ? null
                                    : () {
                                        context.push('/profile/edit');
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      AuthColors.lightGreenBackground,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.paddingSmall.w,
                                    vertical: 6.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.borderRadiusLarge.r,
                                    ),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Edit Account Info',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AuthColors.primary,
                                    fontFamily: AppFonts.primaryFont,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Stats Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge.w,
                          vertical: AppDimensions.paddingLarge.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _StatCard(
                              value:
                                  'N/A', // TODO: Replace with actual saved items count
                              label: 'SAVED ITEMS',
                            ),
                            Container(
                              width: 1.w,
                              height: 60.h,
                              color: AuthColors.inputBorder,
                            ),
                            _StatCard(
                              value:
                                  'N/A', // TODO: Replace with actual donations count
                              label: 'DONATIONS',
                            ),
                            Container(
                              width: 1.w,
                              height: 60.h,
                              color: AuthColors.inputBorder,
                            ),
                            _StatCard(
                              value: '${user.reputationScore}',
                              label: 'IMPACT PTS',
                            ),
                          ],
                        ),
                      ),
                      // Activity Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingLarge.w,
                              vertical: AppDimensions.paddingLarge.h,
                            ),
                            child: Text(
                              'ACTIVITY',
                              style: TextStyle(
                                fontSize: AppDimensions.captionSize.sp,
                                fontWeight: FontWeight.w600,
                                color: AuthColors.labelText,
                                fontFamily: AppFonts.primaryFont,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              context.push('/my-activities');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLarge.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusLarge.r,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AuthColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.history_rounded,
                                        color: AuthColors.primary,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.paddingMedium.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Activity History',
                                          style: TextStyle(
                                            fontSize: AppDimensions.bodySize.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AuthColors.headingText,
                                            fontFamily: AppFonts.primaryFont,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          'View your past donations',
                                          style: TextStyle(
                                            fontSize:
                                                AppDimensions.captionSize.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AuthColors.subText,
                                            fontFamily: AppFonts.primaryFont,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: AuthColors.subText,
                                    size: AppDimensions.iconSize.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.paddingMedium.h),

                          GestureDetector(
                            onTap: () {
                              context.push('/favorites');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLarge.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusLarge.r,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.withValues(alpha: 0.12),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.favorite_rounded,
                                        color: Colors.redAccent,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppDimensions.paddingMedium.w,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Favorite Donations',
                                          style: TextStyle(
                                            fontSize: AppDimensions.bodySize.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AuthColors.headingText,
                                            fontFamily: AppFonts.primaryFont,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          'Manage your liked donation list',
                                          style: TextStyle(
                                            fontSize:
                                                AppDimensions.captionSize.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AuthColors.subText,
                                            fontFamily: AppFonts.primaryFont,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right_rounded,
                                    color: AuthColors.subText,
                                    size: AppDimensions.iconSize.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.paddingMedium.h),
                        ],
                      ),

                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Preferences and Buttons Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PREFERENCES',
                              style: TextStyle(
                                fontSize: AppDimensions.captionSize.sp,
                                fontWeight: FontWeight.w600,
                                color: AuthColors.labelText,
                                letterSpacing: 0.5,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusLarge.r,
                                ),
                              ),
                              child: Column(
                                children: [
                                  _PreferenceTile(
                                    icon: Icons.notifications_rounded,
                                    title: 'Notifications',
                                    trailing: Switch(
                                      value: true,
                                      onChanged: (_) {
                                        // TODO: Handle notification preference
                                      },
                                      activeThumbColor: AuthColors.primary,
                                    ),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    color: AuthColors.dividerColor,
                                  ),
                                  _PreferenceTile(
                                    icon: Icons.lock_rounded,
                                    title: 'Privacy Settings',
                                    trailing: Icon(
                                      Icons.chevron_right_rounded,
                                      color: AuthColors.subText,
                                      size: AppDimensions.iconSize.sp,
                                    ),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    color: AuthColors.dividerColor,
                                  ),
                                  _PreferenceTile(
                                    icon: Icons.help_rounded,
                                    title: 'Help & Support',
                                    trailing: Icon(
                                      Icons.chevron_right_rounded,
                                      color: AuthColors.subText,
                                      size: AppDimensions.iconSize.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: AppDimensions.paddingLarge.h),

                            SizedBox(height: AppDimensions.paddingMedium.h),

                            // Logout Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.logout_rounded,
                                  size: AppDimensions.iconSize.sp,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  final repo = getIt<AuthRepository>();
                                  await repo.logout();
                                  if (context.mounted) {
                                    context.go('/login');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AuthColors.background,
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.borderRadiusLarge.r,
                                    ),
                                    side: BorderSide(
                                      color: AuthColors.buttonBorder,
                                      width: 1.5.w,
                                    ),
                                  ),
                                ),
                                label: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: AppDimensions.bodySize.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
                                    fontFamily: AppFonts.primaryFont,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: AppDimensions.paddingLarge.h),

                            // Footer
                            Center(
                              child: Text(
                                'GaspZero v2.4.0 • Eco-friendly Living',
                                style: TextStyle(
                                  fontSize: AppDimensions.captionSize.sp,
                                  color: AuthColors.subText,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                            ),

                            SizedBox(height: AppDimensions.paddingLarge.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return 'US';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0].substring(0, min(2, parts[0].length)).toUpperCase();
  }

  Future<void> _pickAndUploadAvatar(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        if (mounted) {
          context.read<ProfileBloc>().add(
            ProfileAvatarUploadRequested(filePath: image.path),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall.w,
          vertical: AppDimensions.paddingMedium.h,
        ),
        decoration: BoxDecoration(
          color: AuthColors.statBackground,
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusMedium.r,
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: AppDimensions.titleSize.sp,
                fontWeight: FontWeight.w700,
                color: AuthColors.primary,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: AppDimensions.captionSize.sp,
                fontWeight: FontWeight.w600,
                color: AuthColors.labelText,
                height: 1.2,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PreferenceTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget trailing;

  const _PreferenceTile({
    required this.icon,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium.w,
        vertical: 12.h,
      ),
      leading: Icon(
        icon,
        color: AuthColors.primary,
        size: AppDimensions.iconSize.sp,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppDimensions.buttonTextSize.sp,
          fontWeight: FontWeight.w500,
          color: AuthColors.headingText,
          fontFamily: AppFonts.primaryFont,
        ),
      ),
      trailing: trailing,
    );
  }
}
