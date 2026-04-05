import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import '../../../../shared/theme/app_colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = GetIt.I<ProfileBloc>();
    _profileBloc.add(const ProfileLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileBloc,
      child: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state is ProfileError) {
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
                    child: CircularProgressIndicator(
                      color: AuthColors.primary,
                    ),
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
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: AppDimensions.bodySize.sp,
                            color: AuthColors.subText,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        ElevatedButton.icon(
                          onPressed: () {
                            _profileBloc.add(const ProfileRefreshRequested());
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
                    : (state is ProfileUpdating ? state.currentUser : null);
                final isUpdating = state is ProfileUpdating;

                if (user == null) {
                  return Center(
                    child: Text(
                      'No user data available',
                      style: TextStyle(
                        fontSize: AppDimensions.bodySize.sp,
                        color: AuthColors.subText,
                      ),
                    ),
                  );
                }

                return SingleChildScrollView(
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
                                fontSize: AppDimensions.headingSize.sp,
                                fontWeight: FontWeight.w700,
                                color: AuthColors.headingText,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notifications_rounded,
                                color: AuthColors.primary,
                                size: AppDimensions.iconSize.sp,
                              ),
                              onPressed: () {
                                // TODO: Handle notification tap
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
                            // Avatar with verification mark
                            Stack(
                              children: [
                                Container(
                                  width: 120.w,
                                  height: 120.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AuthColors.primary.withOpacity(0.1),
                                    border: Border.all(
                                      color: AuthColors.primary,
                                      width: 2.w,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _getInitials(user.name),
                                      style: TextStyle(
                                        fontSize: 48.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AuthColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                                // Verification badge
                                if (user.isMailVerified)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
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
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),

                            // User Name
                            Text(
                              user.name ?? 'N/A',
                              style: TextStyle(
                                fontSize: AppDimensions.titleSize.sp,
                                fontWeight: FontWeight.w700,
                                color: AuthColors.headingText,
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingSmall.h),

                            // Email
                            Text(
                              user.email ?? 'N/A',
                              style: TextStyle(
                                fontSize: AppDimensions.bodySize.sp,
                                fontWeight: FontWeight.w400,
                                color: AuthColors.subText,
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),

                            // Status Badge
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingMedium.w,
                                vertical: AppDimensions.paddingSmall.h,
                              ),
                              decoration: BoxDecoration(
                                color: AuthColors.primary,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusExtraLarge.r,
                                ),
                              ),
                              child: Text(
                                '${user.isMailVerified ? '✓' : '○'} ${_getUserRole(user.role)}',
                                style: TextStyle(
                                  fontSize: AppDimensions.captionSize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
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
                              value: 'N/A', // TODO: Replace with actual saved items count
                              label: 'SAVED ITEMS',
                              
                            ),
                            Container(
                              width: 1.w,
                              height: 60.h,
                              color: AuthColors.inputBorder,
                            ),
                            _StatCard(
                              value: 'N/A', // TODO: Replace with actual donations count
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingLarge.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ACTIVITY',
                              style: TextStyle(
                                fontSize: AppDimensions.captionSize.sp,
                                fontWeight: FontWeight.w600,
                                color: AuthColors.labelText,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),
                            Container(
                              padding:
                                  EdgeInsets.all(AppDimensions.paddingMedium.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusLarge.r,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.history_rounded,
                                    color: AuthColors.primary,
                                    size: AppDimensions.iconSize.sp,
                                  ),
                                  SizedBox(
                                      width: AppDimensions.paddingMedium.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Activity History',
                                          style: TextStyle(
                                            fontSize:
                                                AppDimensions.buttonTextSize.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AuthColors.headingText,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          'Last: <PLACEHOLDER_ACTIVITY>',
                                          style: TextStyle(
                                            fontSize: AppDimensions.bodySize.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AuthColors.subText,
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
                          ],
                        ),
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
                                      activeColor: AuthColors.primary,
                                    ),
                                  ),
                                  Divider(
                                    height: 1.h,
                                    color: AuthColors.inputBorder,
                                  ),
                                  _PreferenceTile(
                                    icon: Icons.lock_rounded,
                                    title: 'Privacy Settings',
                                    trailing: Icon(
                                      Icons.chevron_right_rounded,
                                      color: AuthColors.subText,
                                      size: AppDimensions.iconSize.sp,
                                    )
                                  ),
                                  Divider(
                                    height: 1.h,
                                    color: AuthColors.inputBorder,
                                  ),
                                  _PreferenceTile(
                                    icon: Icons.help_rounded,
                                    title: 'Help & Support',
                                    trailing: Icon(
                                      Icons.chevron_right_rounded,
                                      color: AuthColors.subText,
                                      size: AppDimensions.iconSize.sp,
                                    )
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: AppDimensions.paddingLarge.h),

                            // Edit Account Info Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isUpdating
                                    ? null
                                    : () {
                                        context.push('/profile/edit');
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AuthColors.primary,
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.paddingMedium.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.borderRadiusLarge.r,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Edit Account Info',
                                  style: TextStyle(
                                    fontSize: AppDimensions.buttonTextSize.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: AppDimensions.paddingMedium.h),

                            // Logout Button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: Implement logout with confirmation
                                  context.go('/login');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppDimensions.paddingMedium.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.borderRadiusLarge.r,
                                    ),
                                    side: BorderSide(
                                      color: Colors.red,
                                      width: 1.5.w,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: AppDimensions.buttonTextSize.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.red,
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
                                ),
                              ),
                            ),

                            SizedBox(height: AppDimensions.paddingLarge.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
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

  String _getUserRole(String? role) {
    if (role == null || role.isEmpty) return 'COMMUNITY MEMBER';
    return role.toUpperCase();
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      body: SafeArea(
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
                        fontSize: AppDimensions.headingSize.sp,
                        fontWeight: FontWeight.w700,
                        color: AuthColors.headingText,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications_rounded,
                        color: AuthColors.primary,
                        size: AppDimensions.iconSize.sp,
                      ),
                      onPressed: () {
                        // TODO: Handle notification tap
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
                    // Avatar with verification mark
                    Stack(
                      children: [
                        Container(
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AuthColors.primary.withOpacity(0.1),
                            border: Border.all(
                              color: AuthColors.primary,
                              width: 2.w,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'AR',
                              style: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w700,
                                color: AuthColors.primary,
                              ),
                            ),
                          ),
                        ),
                        // Verification badge
                        Positioned(
                          bottom: 0,
                          right: 0,
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
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.paddingMedium.h),

                    // User Name
                    Text(
                      'Alex Rivers',
                      style: TextStyle(
                        fontSize: AppDimensions.titleSize.sp,
                        fontWeight: FontWeight.w700,
                        color: AuthColors.headingText,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingSmall.h),

                    // Email
                    Text(
                      'alex.rivers@gaspzero.app',
                      style: TextStyle(
                        fontSize: AppDimensions.bodySize.sp,
                        fontWeight: FontWeight.w400,
                        color: AuthColors.subText,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingMedium.h),

                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium.w,
                        vertical: AppDimensions.paddingSmall.h,
                      ),
                      decoration: BoxDecoration(
                        color: AuthColors.primary,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusExtraLarge.r,
                        ),
                      ),
                      child: Text(
                        '✓ ACTIVE FOOD SAVER',
                        style: TextStyle(
                          fontSize: AppDimensions.captionSize.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.5,
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
                      value: '24',
                      label: 'SAVED\nITEMS',
                    ),
                    Container(
                      width: 1.w,
                      height: 60.h,
                      color: AuthColors.inputBorder,
                    ),
                    _StatCard(
                      value: '12',
                      label: 'DONATIONS',
                    ),
                    Container(
                      width: 1.w,
                      height: 60.h,
                      color: AuthColors.inputBorder,
                    ),
                    _StatCard(
                      value: '450',
                      label: 'IMPACT PTS',
                    ),
                  ],
                ),
              ),

              // Activity Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ACTIVITY',
                      style: TextStyle(
                        fontSize: AppDimensions.captionSize.sp,
                        fontWeight: FontWeight.w600,
                        color: AuthColors.labelText,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingMedium.h),
                    Container(
                      padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusLarge.r,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            color: AuthColors.primary,
                            size: AppDimensions.iconSize.sp,
                          ),
                          SizedBox(width: AppDimensions.paddingMedium.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Activity History',
                                  style: TextStyle(
                                    fontSize: AppDimensions.buttonTextSize.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AuthColors.headingText,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  'Last: 2kg apples to Community Fridge',
                                  style: TextStyle(
                                    fontSize: AppDimensions.bodySize.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AuthColors.subText,
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
                  ],
                ),
              ),

              SizedBox(height: AppDimensions.paddingLarge.h),

              // Preferences Section
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
                              activeColor: AuthColors.primary,
                            ),
                          ),
                          Divider(
                            height: 1.h,
                            color: AuthColors.inputBorder,
                            indent: 56.w,
                          ),
                          _PreferenceActionTile(
                            icon: Icons.lock_rounded,
                            title: 'Privacy Settings',
                            onTap: () {
                              // TODO: Navigate to privacy settings
                            },
                          ),
                          Divider(
                            height: 1.h,
                            color: AuthColors.inputBorder,
                            indent: 56.w,
                          ),
                          _PreferenceActionTile(
                            icon: Icons.help_rounded,
                            title: 'Help & Support',
                            onTap: () {
                              // TODO: Navigate to help & support
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppDimensions.paddingLarge.h),

              // Edit Account and Logout Buttons
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.push('/profile/edit');
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 56.h),
                        backgroundColor: AuthColors.primary,
                        foregroundColor: Colors.white,
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
                          fontSize: AppDimensions.buttonTextSize.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingMedium.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Handle logout - show confirmation and then navigate to login
                          context.go('/login');
                        },
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: AppDimensions.bodySize.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppDimensions.paddingLarge.h),

              // Footer
              Padding(
                padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
                child: Text(
                  "Gasp'Zero v2.4.0 • Eco-friendly Living",
                  style: TextStyle(
                    fontSize: AppDimensions.captionSize.sp,
                    fontWeight: FontWeight.w400,
                    color: AuthColors.subText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: AppDimensions.titleSize.sp,
              fontWeight: FontWeight.w700,
              color: AuthColors.primary,
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
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferenceActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _PreferenceActionTile({
    required this.icon,
    required this.title,
    required this.onTap,
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
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: AuthColors.subText,
        size: AppDimensions.iconSize.sp,
      ),
      onTap: onTap,
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
        ),
      ),
      trailing: trailing,
    );
  }
}
