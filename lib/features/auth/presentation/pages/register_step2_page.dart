import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class RegisterStep2Page extends StatefulWidget {
  final Map<String, String> formData;
  final VoidCallback onNext;
  final VoidCallback? onOtpSent;

  const RegisterStep2Page({
    super.key,
    required this.formData,
    required this.onNext,
    this.onOtpSent,
  });

  @override
  State<RegisterStep2Page> createState() => _RegisterStep2PageState();
}

class _RegisterStep2PageState extends State<RegisterStep2Page> {
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _phoneController =
        TextEditingController(text: widget.formData['phone'] ?? '');
    _locationController =
        TextEditingController(text: widget.formData['location'] ?? '');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final phone = _phoneController.text.trim();
    final location = _locationController.text.trim();

    if (location.isNotEmpty) {
      if (phone.isNotEmpty) {
        widget.formData['phone'] = phone;
      }
      widget.formData['location'] = location;

      // Dispatch the action to send OTP
      context.read<AuthBloc>().add(
            AuthSignUpRequested(
              firstName: widget.formData['firstName'] ?? '',
              lastName: widget.formData['lastName'] ?? '',
              email: widget.formData['email'] ?? '',
              password: widget.formData['password'] ?? '',
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your city')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSentSuccess) {
          // Move to OTP step via parent callback
          widget.onNext();
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading =
              context.watch<AuthBloc>().state is AuthLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppDimensions.paddingExtraLarge.h),
                Text(
                  "Almost There",
                  style: TextStyle(
                    fontSize: AppDimensions.titleSize.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                    color: AuthColors.headingText,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingLarge.h),
                _buildLabel('Phone Number'),
                SizedBox(height: AppDimensions.paddingSmall.h),
                _buildTextField(_phoneController, 'Enter your phone number (optional)'),
                SizedBox(height: AppDimensions.paddingLarge.h),
                _buildLabel('Location'),
                SizedBox(height: AppDimensions.paddingSmall.h),
                _buildTextField(_locationController, 'Enter your city'),
                SizedBox(height: 48.h),
                ElevatedButton(
                  onPressed: isLoading ? null : _onSubmit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56.h),
                    backgroundColor: AuthColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusLarge.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: AppDimensions.iconSize.w,
                          height: AppDimensions.iconSize.h,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          'Send Verification OTP',
                          style: TextStyle(
                            fontSize: AppDimensions.buttonTextSize.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ],
            ),
          );
        },
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

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      height: AppDimensions.inputHeight.h,
      decoration: BoxDecoration(
        color: AuthColors.inputBackground,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
        border: Border.all(color: AuthColors.inputBorder),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
            color: AuthColors.headingText,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: AuthColors.inputText,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400),
          border: InputBorder.none,
          isDense: false,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium.w,
            vertical: (AppDimensions.inputHeight.h - 20.sp) / 2,
          ),
        ),
      ),
    );
  }
}
