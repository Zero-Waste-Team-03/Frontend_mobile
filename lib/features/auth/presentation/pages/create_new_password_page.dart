import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class CreateNewPasswordPage extends StatefulWidget {
  final Map<String, String> data;

  const CreateNewPasswordPage({super.key, required this.data});

  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    final newPassword = _newPasswordController.text;

    // The token would come from the reset email deep link
    final token = widget.data['token'] ?? '';
    context.read<AuthBloc>().add(
      AuthResetPasswordRequested(token: token, newPassword: newPassword),
    );
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
          "Create New Password",
          style: TextStyle(
            color: AuthColors.headingText,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
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
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthResetPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password reset successfully! Please log in.'),
              ),
            );
            context.go('/login');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

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
                      "Create New\nPassword",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppDimensions.titleSize.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                        color: AuthColors.headingText,
                        height: 1.25,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingSmall.h),
                    Text(
                      "Your new password must be different\nfrom previous used passwords.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: AppDimensions.buttonTextSize.sp,
                        fontWeight: FontWeight.w400,
                        color: AuthColors.subText,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 48.h),

                    // New Password
                    _buildLabel('New Password'),
                    SizedBox(height: AppDimensions.paddingSmall.h),
                    _buildPasswordField(
                      _newPasswordController,
                      '••••••••',
                      _obscureNewPassword,
                      () => setState(
                        () => _obscureNewPassword = !_obscureNewPassword,
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (!RegExp(
                          r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
                        ).hasMatch(v))
                          return 'Not strong enough';
                        return null;
                      },
                    ),
                    SizedBox(height: AppDimensions.paddingSmall.h),
                    Text(
                      "Must be at least 8 characters with 1 uppercase, 1 lowercase, 1 number, and 1 symbol.",
                      style: TextStyle(
                        color: AuthColors.subText,
                        fontSize: 11.sp,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingLarge.h),

                    // Confirm New Password
                    _buildLabel('Confirm New Password'),
                    SizedBox(height: AppDimensions.paddingSmall.h),
                    _buildPasswordField(
                      _confirmPasswordController,
                      '••••••••',
                      _obscureConfirmPassword,
                      () => setState(
                        () =>
                            _obscureConfirmPassword = !_obscureConfirmPassword,
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (v != _newPasswordController.text)
                          return 'Passwords do not match';
                        return null;
                      },
                    ),

                    SizedBox(height: 120.h),

                    // Log In button
                    ElevatedButton(
                      onPressed: isLoading ? null : _onSubmit,
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
                      child: isLoading
                          ? SizedBox(
                              width: AppDimensions.iconSize.w,
                              height: AppDimensions.iconSize.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontSize:
                                        AppDimensions.primaryButtonTextSize.sp,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing:
                                        0.015 *
                                        AppDimensions.primaryButtonTextSize.sp,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Icon(Icons.arrow_forward, size: 20.sp),
                              ],
                            ),
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

  Widget _buildPasswordField(
    TextEditingController controller,
    String hint,
    bool obscure,
    VoidCallback toggleVisibility, {
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: TextStyle(
        color: AuthColors.headingText,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: AuthColors.inputText,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AuthColors.inputBackground,
        isDense: false,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium.w,
          vertical: (AppDimensions.inputHeight.h - 20.sp) / 2,
        ),
        border: _getBorder(AuthColors.inputBorder),
        enabledBorder: _getBorder(AuthColors.inputBorder),
        focusedBorder: _getBorder(AuthColors.primary),
        errorBorder: _getBorder(Colors.red),
        focusedErrorBorder: _getBorder(Colors.red),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: AuthColors.inputText,
            size: AppDimensions.iconSize.sp,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }
}
