import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isPushNotificationsEnabled;
  late bool _isNewDonationsAlertsEnabled;
  late bool _isUrgentAlertsEnabled;
  late bool _isSystemReports;
  late String _appearance;

  @override
  void initState() {
    super.initState();
    _initializeSettings();
  }

  void _initializeSettings() {
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoaded) {
      final settings = profileState.user.settings;
      _isPushNotificationsEnabled =
          settings?.isPushNotificationsEnabled ?? true;
      _isNewDonationsAlertsEnabled =
          settings?.isNewDonationsAlertsEnabled ?? true;
      _isUrgentAlertsEnabled = settings?.isUrgentAlertsEnabled ?? true;
      _isSystemReports = settings?.isSystemReports ?? true;
      _appearance = settings?.appearance ?? 'SYSTEM';
    } else {
      _isPushNotificationsEnabled = true;
      _isNewDonationsAlertsEnabled = true;
      _isUrgentAlertsEnabled = true;
      _isSystemReports = true;
      _appearance = 'SYSTEM';
    }
  }

  void _saveSettings() {
    context.read<ProfileBloc>().add(
      ProfileSettingsUpdateRequested(
        isPushNotificationsEnabled: _isPushNotificationsEnabled,
        isNewDonationsAlertsEnabled: _isNewDonationsAlertsEnabled,
        isUrgentAlertsEnabled: _isUrgentAlertsEnabled,
        isSystemReports: _isSystemReports,
        appearance: _appearance,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Settings updated successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
          _initializeSettings();
        } else if (state is ProfileError && state is! ProfileUpdating) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating settings: ${state.message}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
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
            'Settings',
            style: TextStyle(
              fontSize: AppDimensions.appBarTitleSize.sp,
              fontWeight: FontWeight.bold,
              color: colors.primary,
              fontFamily: AppFonts.primaryFont,
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final isUpdating = state is ProfileUpdating;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge.w,
                  vertical: AppDimensions.paddingMedium.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notifications Section
                    _SectionHeader(title: 'Notifications'),
                    SizedBox(height: AppDimensions.paddingMedium.h),
                    _SettingsTile(
                      icon: Icons.notifications_rounded,
                      title: 'Push Notifications',
                      description: 'Receive push notifications from GaspZero',
                      value: _isPushNotificationsEnabled,
                      onChanged: (value) {
                        setState(() => _isPushNotificationsEnabled = value);
                      },
                      enabled: !isUpdating,
                    ),
                    SizedBox(height: AppDimensions.paddingMedium.h),
                    _SettingsTile(
                      icon: Icons.favorite_rounded,
                      title: 'New Donations Alerts',
                      description:
                          'Get notified about new donation opportunities',
                      value: _isNewDonationsAlertsEnabled,
                      onChanged: (value) {
                        setState(() => _isNewDonationsAlertsEnabled = value);
                      },
                      enabled: !isUpdating,
                    ),
                    SizedBox(height: AppDimensions.paddingMedium.h),
                    _SettingsTile(
                      icon: Icons.priority_high_rounded,
                      title: 'Urgent Alerts',
                      description:
                          'Get notified about urgent and important updates',
                      value: _isUrgentAlertsEnabled,
                      onChanged: (value) {
                        setState(() => _isUrgentAlertsEnabled = value);
                      },
                      enabled: !isUpdating,
                    ),
                    SizedBox(height: AppDimensions.paddingMedium.h),
                    _SettingsTile(
                      icon: Icons.info_rounded,
                      title: 'System Reports',
                      description: 'Receive system and maintenance reports',
                      value: _isSystemReports,
                      onChanged: (value) {
                        setState(() => _isSystemReports = value);
                      },
                      enabled: !isUpdating,
                    ),

                    SizedBox(height: AppDimensions.paddingLarge.h),

                    // Appearance Section
                    _SectionHeader(title: 'Appearance'),
                    SizedBox(height: AppDimensions.paddingMedium.h),
                    _AppearanceSelector(
                      selectedTheme: _appearance,
                      onThemeChanged: (theme) {
                        setState(() => _appearance = theme);
                      },
                      enabled: !isUpdating,
                    ),

                    SizedBox(height: AppDimensions.paddingLarge.h),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: isUpdating ? null : _saveSettings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.primary,
                          disabledBackgroundColor: colors.primary
                              .withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusLarge.r,
                            ),
                          ),
                        ),
                        child: isUpdating
                            ? SizedBox(
                                width: 24.w,
                                height: 24.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.w,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Save Settings',
                                style: TextStyle(
                                  fontSize: AppDimensions.buttonTextSize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: AppDimensions.paddingLarge.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Text(
      title,
      style: TextStyle(
        fontSize: AppDimensions.captionSize.sp,
        fontWeight: FontWeight.w600,
        color: colors.headingText,
        letterSpacing: 0.5,
        fontFamily: AppFonts.primaryFont,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool enabled;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.value,
    required this.onChanged,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium.w,
        vertical: AppDimensions.paddingMedium.h,
      ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
        border: Border.all(color: colors.inputBorder, width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusMedium.r,
                    ),
                  ),
                  child: Icon(icon, color: colors.primary, size: 20.sp),
                ),
                SizedBox(width: AppDimensions.paddingMedium.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: AppDimensions.buttonTextSize.sp,
                          fontWeight: FontWeight.w600,
                          color: colors.headingText,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: AppDimensions.captionSize.sp,
                          fontWeight: FontWeight.w400,
                          color: colors.subText,
                          fontFamily: AppFonts.primaryFont,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppDimensions.paddingMedium.w),
          Switch(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeTrackColor: colors.primary,
            activeThumbColor: Colors.white,
            inactiveThumbColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _AppearanceSelector extends StatelessWidget {
  final String selectedTheme;
  final ValueChanged<String> onThemeChanged;
  final bool enabled;

  const _AppearanceSelector({
    required this.selectedTheme,
    required this.onThemeChanged,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ThemeOption(
          icon: Icons.light_mode_rounded,
          label: 'Light',
          value: 'LIGHT',
          isSelected: selectedTheme == 'LIGHT',
          onSelected: enabled ? () => onThemeChanged('LIGHT') : null,
        ),
        SizedBox(height: AppDimensions.paddingMedium.h),
        _ThemeOption(
          icon: Icons.dark_mode_rounded,
          label: 'Dark',
          value: 'DARK',
          isSelected: selectedTheme == 'DARK',
          onSelected: enabled ? () => onThemeChanged('DARK') : null,
        ),
        SizedBox(height: AppDimensions.paddingMedium.h),
        _ThemeOption(
          icon: Icons.brightness_auto_rounded,
          label: 'System',
          value: 'SYSTEM',
          isSelected: selectedTheme == 'SYSTEM',
          onSelected: enabled ? () => onThemeChanged('SYSTEM') : null,
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isSelected;
  final VoidCallback? onSelected;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.value,
    required this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium.w,
          vertical: AppDimensions.paddingMedium.h,
        ),
        decoration: BoxDecoration(
          color: !isSelected ? colors.background : colors.surface,
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusLarge.r,
          ),
          border: Border.all(
            color: isSelected ? colors.primary : colors.inputBorder,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:  colors.subText,
              size: 24.sp,
            ),
            SizedBox(width: AppDimensions.paddingMedium.w),
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.buttonTextSize.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: colors.headingText,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_rounded, color: colors.primary, size: 20.sp),
          ],
        ),
      ),
    );
  }
}


