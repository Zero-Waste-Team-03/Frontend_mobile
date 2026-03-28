import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class RegisterStep1Page extends StatefulWidget {
  const RegisterStep1Page({super.key});

  @override
  State<RegisterStep1Page> createState() => _RegisterStep1PageState();
}

class _RegisterStep1PageState extends State<RegisterStep1Page> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _onNext() {
    final fn = _firstNameController.text.trim();
    final ln = _lastNameController.text.trim();
    final em = _emailController.text.trim();
    final pw = _passwordController.text;

    if (fn.isNotEmpty && ln.isNotEmpty && em.isNotEmpty && pw.isNotEmpty) {
      context.push('/step2', extra: {
        'firstName': fn,
        'lastName': ln,
        'email': em,
        'password': pw,
      });
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
          if (state is AuthError) {
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
                      Text("Profile Setup", style: TextStyle(color: AuthColors.headingText, fontWeight: FontWeight.w600, fontSize: 16.sp)),
                      Text("Step 1 of 3", style: TextStyle(color: AuthColors.primary, fontWeight: FontWeight.w700, fontSize: 14.sp)),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingMedium.h),
                  LinearProgressIndicator(
                    value: 0.33,
                    backgroundColor: AuthColors.primary.withOpacity(0.2),
                    color: AuthColors.primary,
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium.r),
                    minHeight: 10.h,
                  ),
                  SizedBox(height: AppDimensions.paddingExtraLarge.h),
                  
                  Text("Join the Community", style: TextStyle(
                    fontSize: AppDimensions.titleSize.sp, 
                    fontWeight: FontWeight.w700, 
                    letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                    color: AuthColors.headingText
                  )),
                  SizedBox(height: AppDimensions.paddingLarge.h),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('First Name'),
                            SizedBox(height: AppDimensions.paddingSmall.h),
                            _buildTextField(_firstNameController, 'Enter first name', false),
                          ],
                        ),
                      ),
                      SizedBox(width: AppDimensions.paddingMedium.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Last Name'),
                            SizedBox(height: AppDimensions.paddingSmall.h),
                            _buildTextField(_lastNameController, 'Enter last name', false),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingLarge.h),
                  
                  _buildLabel('Email'),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  _buildTextField(_emailController, 'Enter your email', false),
                  SizedBox(height: AppDimensions.paddingLarge.h),
                  
                  _buildLabel('Password'),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  _buildTextField(_passwordController, 'Enter your password', true),
                  SizedBox(height: AppDimensions.paddingMedium.h),
                  Text(
                    "Must be at least 8 characters long.",
                    style: TextStyle(color: AuthColors.subText, fontSize: 11.sp),
                  ),
                  SizedBox(height: 48.h),

                  ElevatedButton(
                    onPressed: isLoading ? null : _onNext,
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
                        : Text('Next', style: TextStyle(fontSize: AppDimensions.buttonTextSize.sp, fontWeight: FontWeight.w700)),
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

  Widget _buildTextField(TextEditingController controller, String hint, bool isPassword) {
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
          obscureText: isPassword ? _obscurePassword : false,
          style: TextStyle(color: AuthColors.headingText, fontSize: 16.sp, fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AuthColors.inputText, fontSize: 16.sp, fontWeight: FontWeight.w400),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium.w),
            suffixIcon: isPassword
                ? IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: AuthColors.inputText,
                      size: AppDimensions.iconSize.sp,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
