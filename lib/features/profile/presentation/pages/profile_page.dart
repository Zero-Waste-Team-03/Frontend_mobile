import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/notification_button.dart';
import '../widgets/profile_loading_skeleton.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';

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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(const ProfileLoadRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
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
        backgroundColor: colors.background,
        body: SafeArea(
          child: Column(
            children: [
              // Header with profile title and bell icon (always shown)
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
                        color: colors.primary,
                        fontFamily: AppFonts.primaryFont,
                      ),
                    ),
                    NotificationButton(
                      backgroundColor: colors.lightGrayBackground,
                      iconColor: colors.primary,
                      iconSize: AppDimensions.iconSize.sp,
                    ),
                  ],
                ),
              ),

              // Content area controlled by state
              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    // Loading
                    if (state is ProfileLoading || state is ProfileInitial) {
                      return const ProfileLoadingSkeleton();
                    }

                    // Error (when not an updating state)
                    if (state is ProfileError && state is! ProfileUpdating) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline_rounded,
                              size: 64.sp,
                              color: colors.error,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'Error loading profile',
                              style: TextStyle(
                                fontSize: AppDimensions.titleSize.sp,
                                fontWeight: FontWeight.bold,
                                color: colors.headingText,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: AppDimensions.bodySize.sp,
                                color: colors.subText,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ProfileBloc>().add(
                                  const ProfileRefreshRequested(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colors.primary,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.refresh_rounded, size: 18.sp),
                                  SizedBox(width: 8.w),
                                  const Text('Retry'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Get user data from state (handle updating state too)
                    final user = state is ProfileLoaded
                        ? state.user
                        : (state is ProfileUpdating
                              ? state.currentUser
                              : (state is ProfileUpdateSuccess
                                    ? state.user
                                    : null));
                    final isUpdating = state is ProfileUpdating;

                    if (user == null) {
                      return Center(
                        child: Text(
                          'No user data available',
                          style: TextStyle(
                            fontSize: AppDimensions.bodySize.sp,
                            color: colors.subText,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                      );
                    }

                    // Main content (same UI as before, header removed)
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      color: colors.primary,
                      backgroundColor: colors.background,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
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
                                          color: colors.primary.withValues(
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
                                                            color:
                                                                colors.primary,
                                                          ),
                                                    );
                                                  },
                                                  errorWidget:
                                                      (context, url, error) {
                                                        return Center(
                                                          child: Text(
                                                            _getInitials(
                                                              user.name,
                                                            ),
                                                            style: TextStyle(
                                                              fontSize: 48.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: colors
                                                                  .primary,
                                                              fontFamily: AppFonts
                                                                  .primaryFont,
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
                                                    color: colors.primary,
                                                    fontFamily:
                                                        AppFonts.primaryFont,
                                                  ),
                                                ),
                                              ),
                                      ),
                                      // Verification badge
                                      if (user.isVerified)
                                        Positioned(
                                          bottom: 4.w,
                                          right: 4.w,
                                          child: Container(
                                            width: 28.w,
                                            height: 28.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colors.primary,
                                              border: Border.all(
                                                color: colors.surface,
                                                width: 2.w,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              color: colors.onPrimary,
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
                                              : () => _pickAndUploadAvatar(
                                                  context,
                                                ),
                                          child: Container(
                                            width: 36.w,
                                            height: 36.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colors.primary,
                                              border: Border.all(
                                                color: colors.surface,
                                                width: 2.w,
                                              ),
                                            ),
                                            child: isUpdating
                                                ? SizedBox(
                                                    width: 16.w,
                                                    height: 16.w,
                                                    child: CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                            Color
                                                          >(colors.onPrimary),
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.edit_rounded,
                                                    color: colors.onPrimary,
                                                    size: 20.sp,
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingMedium.h,
                                  ),

                                  // User Name
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          user.name ?? 'N/A',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize:
                                                AppDimensions.titleSize.sp,
                                            fontWeight: FontWeight.w700,
                                            color: colors.headingText,
                                            fontFamily: AppFonts.primaryFont,
                                          ),
                                        ),
                                        if (user.isVerified) ...[
                                          SizedBox(width: 4.w),
                                          Icon(
                                            Icons.verified_rounded,
                                            color: Colors.blue,
                                            size: 20.sp,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingSmall.h,
                                  ),

                                  // Email
                                  Text(
                                    user.email ?? 'N/A',
                                    style: TextStyle(
                                      fontSize: AppDimensions.bodySize.sp,
                                      fontWeight: FontWeight.w400,
                                      color: colors.subText,
                                      fontFamily: AppFonts.primaryFont,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingMedium.h,
                                  ),

                                  // Status Badge with leaf icon
                                  if (user.isFoodSaver)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            AppDimensions.paddingSmall.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.primary,
                                        borderRadius: BorderRadius.circular(
                                          AppDimensions
                                              .borderRadiusExtraLarge
                                              .r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.eco_outlined,
                                            color: colors.onPrimary,
                                            size: 14.sp,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            'ACTIVE FOOD SAVER',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w700,
                                              color: colors.onPrimary,
                                              fontFamily: AppFonts.primaryFont,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (user.isFoodSaver)
                                    SizedBox(
                                      height: AppDimensions.paddingMedium.h,
                                    ),

                                  if (!user.isVerified) ...[
                                    SizedBox(height: 8.h),
                                    SizedBox(
                                      width: 140.w,
                                      height: 32.h,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.push(
                                            '/profile/find-verifier',
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF2D6C50,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                AppDimensions.paddingSmall.w,
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
                                          'Get Verified',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontFamily: AppFonts.primaryFont,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],

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
                                            colors.lightGreenBackground,
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              AppDimensions.paddingSmall.w,
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
                                          color: colors.textSecondary,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _StatCard(
                                    context: context,
                                    value:
                                        state is ProfileLoaded &&
                                            state.donationsState != null
                                        ? '${state.donationsState!.likedDonations.toInt()}'
                                        : 'N/A',
                                    label: 'LIKED ITEMS',
                                  ),
                                  Container(
                                    width: 10.w,
                                    height: 60.h,
                                    color: colors.background,
                                  ),
                                  _StatCard(
                                    context: context,
                                    value:
                                        state is ProfileLoaded &&
                                            state.donationsState != null
                                        ? '${state.donationsState!.totalDonations.toInt()}'
                                        : 'N/A',
                                    label: 'DONATIONS',
                                  ),
                                  Container(
                                    width: 10.w,
                                    height: 60.h,
                                    color: colors.background,
                                  ),
                                  _StatCard(
                                    context: context,
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
                                      color: colors.headingText,
                                      fontFamily: AppFonts.primaryFont,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),

                                _MenuTile(
                                  context: context,
                                  icon: Icons.history_rounded,
                                  iconColor: colors.primary,
                                  backgroundColor: colors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  title: 'Activity History',
                                  subtitle: 'View your past donations',
                                  onTap: () {
                                    context.push('/my-activities');
                                  },
                                ),
                                SizedBox(height: AppDimensions.paddingMedium.h),

                                _MenuTile(
                                  context: context,
                                  icon: Icons.favorite_rounded,
                                  iconColor: colors.error,
                                  backgroundColor: colors.error.withValues(
                                    alpha: 0.12,
                                  ),
                                  title: 'Favorite Donations',
                                  subtitle: 'Manage your liked donation list',
                                  onTap: () {
                                    context.push('/favorites');
                                  },
                                ),
                                SizedBox(height: AppDimensions.paddingMedium.h),
                              ],
                            ),

                            // Food Saver Section (Conditional)
                            if (user.isFoodSaver) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: AppDimensions.paddingLarge.w,
                                      vertical: AppDimensions.paddingLarge.h,
                                    ),
                                    child: Text(
                                      'FOOD SAVER',
                                      style: TextStyle(
                                        fontSize: AppDimensions.captionSize.sp,
                                        fontWeight: FontWeight.w600,
                                        color: colors.headingText,
                                        fontFamily: AppFonts.primaryFont,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),

                                  _MenuTile(
                                    context: context,
                                    icon: Icons.assignment_ind_rounded,
                                    iconColor: colors.primary,
                                    backgroundColor: colors.primary.withValues(
                                      alpha: 0.1,
                                    ),
                                    title: 'Verification Requests',
                                    subtitle: '',
                                    onTap: () {
                                      context.push(
                                        '/profile/verification-requests',
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingMedium.h,
                                  ),
                                ],
                              ),
                            ],

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
                                      color: colors.headingText,
                                      letterSpacing: 0.5,
                                      fontFamily: AppFonts.primaryFont,
                                    ),
                                  ),
                                  SizedBox(
                                    height: AppDimensions.paddingMedium.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: colors.surface,
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.borderRadiusLarge.r,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        _PreferenceTile(
                                          context: context,
                                          icon: Icons.notifications_rounded,
                                          title: 'Notifications',
                                          trailing: Switch(
                                            value:
                                                user
                                                    .settings
                                                    ?.isPushNotificationsEnabled ??
                                                false,
                                            onChanged: isUpdating
                                                ? null
                                                : (value) {
                                                    context.read<ProfileBloc>().add(
                                                      ProfileSettingsUpdateRequested(
                                                        isPushNotificationsEnabled:
                                                            value,
                                                        isNewDonationsAlertsEnabled:
                                                            user
                                                                .settings
                                                                ?.isNewDonationsAlertsEnabled ??
                                                            true,
                                                        isUrgentAlertsEnabled:
                                                            user
                                                                .settings
                                                                ?.isUrgentAlertsEnabled ??
                                                            true,
                                                        isSystemReports:
                                                            user
                                                                .settings
                                                                ?.isSystemReports ??
                                                            true,
                                                        appearance:
                                                            user
                                                                .settings
                                                                ?.appearance ??
                                                            'SYSTEM',
                                                      ),
                                                    );
                                                  },
                                            activeThumbColor: colors.primary,
                                          ),
                                        ),
                                        Divider(
                                          height: 1.h,
                                          color: colors.dividerColor,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.push('/profile/settings');
                                          },
                                          child: _PreferenceTile(
                                            context: context,
                                            icon: Icons.settings_rounded,
                                            title: 'Settings',
                                            trailing: Icon(
                                              Icons.chevron_right_rounded,
                                              color: colors.subText,
                                              size: AppDimensions.iconSize.sp,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          height: 1.h,
                                          color: colors.dividerColor,
                                        ),
                                        _PreferenceTile(
                                          context: context,
                                          icon: Icons.help_rounded,
                                          title: 'Help & Support',
                                          trailing: Icon(
                                            Icons.chevron_right_rounded,
                                            color: colors.subText,
                                            size: AppDimensions.iconSize.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: AppDimensions.paddingLarge.h,
                                  ),

                                  SizedBox(
                                    height: AppDimensions.paddingMedium.h,
                                  ),

                                  // Logout Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.logout_rounded,
                                        size: AppDimensions.iconSize.sp,
                                        color: colors.error,
                                      ),
                                      onPressed: () {
                                        context.read<AuthBloc>().add(
                                          AuthLogoutRequested(),
                                        );
                                      },

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: colors.background,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12.h,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            AppDimensions.borderRadiusLarge.r,
                                          ),
                                          side: BorderSide(
                                            color: colors.buttonBorder,
                                            width: 1.5.w,
                                          ),
                                        ),
                                      ),
                                      label: Text(
                                        'Logout',
                                        style: TextStyle(
                                          fontSize: AppDimensions.bodySize.sp,
                                          fontWeight: FontWeight.w600,
                                          color: colors.error,
                                          fontFamily: AppFonts.primaryFont,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: AppDimensions.paddingLarge.h,
                                  ),

                                  // Footer
                                  Center(
                                    child: Text(
                                      'GaspZero v2.4.0 • Eco-friendly Living',
                                      style: TextStyle(
                                        fontSize: AppDimensions.captionSize.sp,
                                        color: colors.subText,
                                        fontFamily: AppFonts.primaryFont,
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: AppDimensions.paddingLarge.h,
                                  ),
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
            ],
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

class _MenuTile extends StatelessWidget {
  final BuildContext context;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _MenuTile({
    required this.context,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: colors.lightGrayBackground),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: colors.lightGrayBackground,
              ),
              child: Center(
                child: Icon(icon, color: iconColor, size: 20.sp),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colors.textSecondary,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colors.textPrimary,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final BuildContext context;
  final String value;
  final String label;

  const _StatCard({
    required this.context,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall.w,
          vertical: AppDimensions.paddingMedium.h,
        ),
        decoration: BoxDecoration(
          color: colors.surface,
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
                color: colors.statusActiveText,
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
                color: colors.textSecondary,
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
  final BuildContext context;
  final IconData icon;
  final String title;
  final Widget trailing;

  const _PreferenceTile({
    required this.context,
    required this.icon,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium.w,
        vertical: 12.h,
      ),
      leading: Icon(
        icon,
        color: colors.primary,
        size: AppDimensions.iconSize.sp,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: AppDimensions.buttonTextSize.sp,
          fontWeight: FontWeight.w500,
          color: colors.textSecondary,
          fontFamily: AppFonts.primaryFont,
        ),
      ),
      trailing: trailing,
    );
  }
}

