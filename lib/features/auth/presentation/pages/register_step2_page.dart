import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class RegisterStep2Page extends StatefulWidget {
  final Map<String, String> step1Data;
  const RegisterStep2Page({super.key, required this.step1Data});

  @override
  State<RegisterStep2Page> createState() => _RegisterStep2PageState();
}

class _RegisterStep2PageState extends State<RegisterStep2Page> {
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();

  void _onSubmit() {
    final phone = _phoneController.text.trim();
    final location = _locationController.text.trim();

    if (phone.isNotEmpty && location.isNotEmpty) {
      widget.step1Data['phone'] = phone;
      widget.step1Data['location'] = location;
      
      // Dispatch the action to send OTP NOW, after second form.
      context.read<AuthBloc>().add(
        AuthSignUpRequested(
          firstName: widget.step1Data['firstName'] ?? '',
          lastName: widget.step1Data['lastName'] ?? '',
          email: widget.step1Data['email'] ?? '',
          password: widget.step1Data['password'] ?? '',
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Create Account",
          style: TextStyle(
            color: AuthColors.headingText,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AuthColors.headingText, size: AppDimensions.iconSize.sp),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthOtpSentSuccess) {
            context.push('/otp', extra: widget.step1Data);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Further Details", style: TextStyle(color: AuthColors.headingText, fontWeight: FontWeight.w600, fontSize: 16.sp)),
                      Text("Step 2 of 3", style: TextStyle(color: AuthColors.primary, fontWeight: FontWeight.w700, fontSize: 14.sp)),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingMedium.h),
                  LinearProgressIndicator(
                    value: 0.66,
                    backgroundColor: AuthColors.primary.withOpacity(0.2),
                    color: AuthColors.primary,
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium.r),
                    minHeight: 10.h,
                  ),
                  SizedBox(height: AppDimensions.paddingExtraLarge.h),
                  
                  Text("Almost There", style: TextStyle(
                    fontSize: AppDimensions.titleSize.sp, 
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                    color: AuthColors.headingText
                  )),
                  SizedBox(height: AppDimensions.paddingLarge.h),

                  _buildLabel('Phone Number'),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  _buildTextField(_phoneController, 'Enter your phone number'),
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
                        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
                      ),
                      elevation: 0,
                    ),
                    child: isLoading
                        ? SizedBox(
                            width: AppDimensions.iconSize.w,
                            height: AppDimensions.iconSize.h,
                            child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text('Send Verification OTP', style: TextStyle(fontSize: AppDimensions.buttonTextSize.sp, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
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
      child: Center(
        child: TextField(
          controller: controller,
          style: TextStyle(color: AuthColors.headingText, fontSize: 16.sp, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AuthColors.inputText, fontSize: 16.sp, fontWeight: FontWeight.w400),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium.w),
          ),
        ),
      ),
    );
  }
}
