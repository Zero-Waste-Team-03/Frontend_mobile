import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _cityController = TextEditingController();
  }

  void _populateFields(dynamic user) {
    _fullNameController.text = user.name ?? '';
    _emailController.text = user.email ?? '';
    _phoneController.text = user.phoneNumber ?? '';
    _cityController.text = user.location?['city'] ?? '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final profileBloc = context.read<ProfileBloc>();
      final currentState = profileBloc.state;
      if (currentState is ProfileLoaded || currentState is ProfileUpdating) {
        final fullName = _fullNameController.text.trim();
        final email = _emailController.text.trim();
        final phone = _phoneController.text.trim();
        final city = _cityController.text.trim();

        profileBloc.add(ProfileUpdateRequested(
          displayName: fullName,
          email: email,
          phoneNumber: phone,
          location: city.isNotEmpty ? {'city': city} : null,
        ));
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
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
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) context.pop();
          });
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: AuthColors.headingText,
              fontSize: AppDimensions.buttonTextSize.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: AuthColors.headingText,
              size: AppDimensions.iconSize.sp,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              // Get user initials for avatar
              String getInitials(String? name) {
                if (name == null || name.isEmpty) return '--';
                final parts = name.split(' ');
                if (parts.length >= 2) {
                  return '${parts[0][0].toUpperCase()}${parts[1][0].toUpperCase()}';
                }
                return name.substring(0, 2).toUpperCase();
              }

              final user = state is ProfileLoaded
                  ? state.user
                  : (state is ProfileUpdating
                      ? state.currentUser
                      : (state is ProfileUpdateSuccess ? state.user : null));
              final isUpdating =
                  state is ProfileUpdating || state is ProfileUpdateSuccess;

              if (!_isInitialized && user != null) {
                _populateFields(user);
                _isInitialized = true;
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Avatar with camera icon
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
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
                                  getInitials(user?.name),
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AuthColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 32.w,
                                height: 32.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AuthColors.primary,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.w,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingExtraLarge.h),

                      // Personal Information Header
                      Text(
                        'PERSONAL INFORMATION',
                        style: TextStyle(
                          fontSize: AppDimensions.captionSize.sp,
                          fontWeight: FontWeight.w600,
                          color: AuthColors.labelText,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingMedium.h),

                      // Full Name Field
                      _buildLabel('Full Name'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildFormField(
                        controller: _fullNameController,
                        hint: 'Enter your full name',
                        validator: _validateRequired,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Email Field with Verified Badge
                      _buildLabel('Email Address'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      Stack(
                        children: [
                          _buildFormField(
                            controller: _emailController,
                            hint: 'Enter your email',
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          if (user?.isMailVerified == true)
                            Positioned(
                              right: 12.w,
                              top: (AppDimensions.inputHeight.h - 20.h) / 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.paddingSmall.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AuthColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  'VERIFIED',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AuthColors.primary,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Phone Number Field
                      _buildLabel('Phone Number'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildFormField(
                        controller: _phoneController,
                        hint: 'Enter your phone number',
                        validator: _validatePhoneNumber,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Primary Location Header
                      Text(
                        'PRIMARY LOCATION',
                        style: TextStyle(
                          fontSize: AppDimensions.captionSize.sp,
                          fontWeight: FontWeight.w600,
                          color: AuthColors.labelText,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingMedium.h),

                      // City Field
                      _buildLabel('City or Zip Code'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildFormField(
                        controller: _cityController,
                        hint: 'Enter your city',
                        validator: _validateRequired,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Save Button
                      ElevatedButton(
                        onPressed: isUpdating ? null : _onSave,
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
                        child: isUpdating
                            ? SizedBox(
                                width: AppDimensions.iconSize.w,
                                height: AppDimensions.iconSize.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: AppDimensions.buttonTextSize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AuthColors.labelText,
        fontWeight: FontWeight.w500,
        fontSize: AppDimensions.bodySize.sp,
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
  }) {
    return Container(
      height: AppDimensions.inputHeight.h,
      decoration: BoxDecoration(
        color: AuthColors.inputBackground,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
        border: Border.all(color: AuthColors.inputBorder),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          color: AuthColors.headingText,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: AuthColors.inputText,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium.w,
            vertical: (AppDimensions.inputHeight.h - 20.sp) / 2,
          ),
          errorStyle: TextStyle(
            fontSize: AppDimensions.captionSize.sp,
            color: Colors.red,
            height: 1.2,
          ),
        ),
      ),
    );
  }
}
