import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _linkSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendResetLink() {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text.trim();
    context.read<AuthBloc>().add(AuthForgotPasswordRequested(email));
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
          "Forgot Password",
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
          if (state is AuthForgotPasswordSuccess) {
            setState(() => _linkSent = true);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          // â”€â”€ Success view â€” link has been sent â”€â”€
          if (_linkSent) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
                child: Column(
                  children: [
                    SizedBox(height: 60.h),
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: AuthColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.mark_email_read_rounded,
                        size: 40.sp,
                        color: AuthColors.primary,
                      ),
                    ),
                    SizedBox(height: 32.h),
                    Text(
                      "Check Your Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppDimensions.titleSize.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                        color: AuthColors.headingText,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "We've sent a password reset link to\n${_emailController.text.trim()}\n\nPlease check your inbox and follow the link to reset your password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: AppDimensions.bodySize.sp,
                          fontWeight: FontWeight.w400,
                          color: AuthColors.subText,
                          height: 1.6,
                        ),
                      ),
                    ),
                    SizedBox(height: 48.h),

                    // Resend link button
                    OutlinedButton(
                      onPressed: isLoading ? null : _onSendResetLink,
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(double.infinity, 56.h),
                        foregroundColor: AuthColors.primary,
                        side: const BorderSide(color: AuthColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
                        ),
                      ),
                      child: isLoading
                          ? SizedBox(
                              width: AppDimensions.iconSize.w,
                              height: AppDimensions.iconSize.h,
                              child: const CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              'Resend Link',
                              style: TextStyle(
                                fontSize: AppDimensions.primaryButtonTextSize.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    SizedBox(height: AppDimensions.paddingLarge.h),

                    // Back to login
                    ElevatedButton(
                      onPressed: () => context.go('/login'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 56.h),
                        backgroundColor: AuthColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Back to Sign In',
                        style: TextStyle(
                          fontSize: AppDimensions.primaryButtonTextSize.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.015 * AppDimensions.primaryButtonTextSize.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // â”€â”€ Email entry view â”€â”€
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  SizedBox(height: 20.h),
                  Text(
                    "Forgot Password",
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
                    "Enter your email address and we'll send you a\nlink to reset your password.",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: AppDimensions.buttonTextSize.sp,
                      fontWeight: FontWeight.w400,
                      color: AuthColors.subText,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 48.h),

                  // Email field
                  _buildLabel('Email'),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  _buildTextField(_emailController, 'jane.doe@example.com', validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v)) return 'Invalid email address';
                    return null;
                  }),
                  
                  // Spacer to push button to bottom area
                  SizedBox(height: 220.h),

                  // Send Reset Link button
                  ElevatedButton(
                    onPressed: isLoading ? null : _onSendResetLink,
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
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Send Reset Link',
                                style: TextStyle(
                                  fontSize: AppDimensions.primaryButtonTextSize.sp,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.015 * AppDimensions.primaryButtonTextSize.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(Icons.send_rounded, size: 20.sp),
                            ],
                          ),
                  ),
                  SizedBox(height: AppDimensions.paddingLarge.h),

                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember your password? ",
                        style: TextStyle(color: AuthColors.subText, fontSize: AppDimensions.bodySize.sp),
                      ),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: AuthColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.bodySize.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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

  OutlineInputBorder _getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: TextStyle(color: AuthColors.headingText, fontSize: 16.sp, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AuthColors.inputText, fontSize: 16.sp, fontWeight: FontWeight.w400),
        filled: true,
        fillColor: AuthColors.inputBackground,
        isDense: false,
        contentPadding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium.w, vertical: (AppDimensions.inputHeight.h - 20.sp) / 2),
        border: _getBorder(AuthColors.inputBorder),
        enabledBorder: _getBorder(AuthColors.inputBorder),
        focusedBorder: _getBorder(AuthColors.primary),
        errorBorder: _getBorder(Colors.red),
        focusedErrorBorder: _getBorder(Colors.red),
      ),
    );
  }
}
