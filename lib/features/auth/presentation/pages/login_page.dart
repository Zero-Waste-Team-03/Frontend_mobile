import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _onLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      context.read<AuthBloc>().add(AuthLoginRequested(email, password));
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
          "Log In",
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
          if (state is AuthSuccess) {
            context.go('/home');
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
                  SizedBox(height: 20.h),
                  Text(
                    "Welcome Back",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: AppDimensions.titleSize.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                      color: AuthColors.headingText,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  Text(
                    "Log in to join the Gasp'Zero community",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: AppDimensions.buttonTextSize.sp,
                      fontWeight: FontWeight.w400,
                      color: AuthColors.subText,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  
                  // Form
                  _buildLabel('Email'),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  _buildTextField(_emailController, 'Enter your email', false),
                  SizedBox(height: AppDimensions.paddingLarge.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildLabel('Password'),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: AuthColors.headingText,
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  _buildTextField(_passwordController, 'Enter your password', true),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  Text(
                    "Must be at least 8 characters long.",
                    style: TextStyle(color: AuthColors.subText, fontSize: 11.sp),
                  ),
                  SizedBox(height: 48.h),

                  ElevatedButton(
                    onPressed: isLoading ? null : _onLogin,
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
                        : Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: AppDimensions.primaryButtonTextSize.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.015 * AppDimensions.primaryButtonTextSize.sp,
                            ),
                          ),
                  ),
                  SizedBox(height: AppDimensions.paddingLarge.h),
                  
                  Row(
                    children: [
                      const Expanded(child: Divider(color: AuthColors.inputBorder)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium.w),
                        child: Text("Or continue with", style: TextStyle(color: AuthColors.subText, fontSize: AppDimensions.captionSize.sp)),
                      ),
                      const Expanded(child: Divider(color: AuthColors.inputBorder)),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingLarge.h),
                  
                  OutlinedButton.icon(
                    onPressed: isLoading ? null : () {},
                    icon: Icon(Icons.g_mobiledata, size: AppDimensions.headingSize.sp),
                    label: Text(
                      'Google',
                      style: TextStyle(
                        fontSize: AppDimensions.buttonTextSize.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(double.infinity, 56.h),
                      foregroundColor: AuthColors.headingText,
                      side: const BorderSide(color: AuthColors.inputBorder),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.r)),
                    ),
                  ),
                  
                  SizedBox(height: 48.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? ", style: TextStyle(color: AuthColors.subText, fontSize: AppDimensions.bodySize.sp)),
                      GestureDetector(
                        onTap: () => context.push('/register'),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: AuthColors.primary, fontWeight: FontWeight.bold, fontSize: AppDimensions.bodySize.sp),
                        ),
                      ),
                    ],
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
