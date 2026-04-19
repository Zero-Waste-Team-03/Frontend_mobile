import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class RegisterStep1Page extends StatefulWidget {
  final VoidCallback onNext;
  final Map<String, String> formData;

  const RegisterStep1Page({
    super.key,
    required this.onNext,
    required this.formData,
  });

  @override
  State<RegisterStep1Page> createState() => _RegisterStep1PageState();
}

class _RegisterStep1PageState extends State<RegisterStep1Page> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
      text: widget.formData['firstName'] ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.formData['lastName'] ?? '',
    );
    _emailController = TextEditingController(
      text: widget.formData['email'] ?? '',
    );
    _passwordController = TextEditingController(
      text: widget.formData['password'] ?? '',
    );
    _confirmPasswordController = TextEditingController(
      text: widget.formData['password'] ?? '',
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (!_formKey.currentState!.validate()) return;

    widget.formData['firstName'] = _firstNameController.text.trim();
    widget.formData['lastName'] = _lastNameController.text.trim();
    widget.formData['email'] = _emailController.text.trim();
    widget.formData['password'] = _passwordController.text;
    widget.onNext();
  }

  void _onGoogleSignUp() {
    context.read<AuthBloc>().add(AuthGoogleLoginRequested());
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthBloc>().state is AuthLoading;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: AppDimensions.paddingExtraLarge.h),
            Text(
              "Join the Community",
              style: TextStyle(
                fontSize: AppDimensions.titleSize.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                color: AuthColors.headingText,
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('First Name'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildTextField(
                        _firstNameController,
                        'Enter first name',
                        false,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
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
                      _buildTextField(
                        _lastNameController,
                        'Enter last name',
                        false,
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),
            _buildLabel('Email'),
            SizedBox(height: AppDimensions.paddingSmall.h),
            _buildTextField(
              _emailController,
              'Enter your email',
              true,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v))
                  return 'Invalid email';
                return null;
              },
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),
            _buildLabel('Password'),
            SizedBox(height: AppDimensions.paddingSmall.h),
            _buildPasswordField(
              _passwordController,
              'Enter your password',
              _obscurePassword,
              () => setState(() => _obscurePassword = !_obscurePassword),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (!RegExp(
                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
                ).hasMatch(v))
                  return 'Not strong enough';
                return null;
              },
            ),
            SizedBox(height: AppDimensions.paddingMedium.h),
            Text(
              "Must be at least 8 characters with 1 uppercase, 1 lowercase, 1 number, and 1 symbol.",
              style: TextStyle(color: AuthColors.subText, fontSize: 11.sp),
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),
            _buildLabel('Confirm Password'),
            SizedBox(height: AppDimensions.paddingSmall.h),
            _buildPasswordField(
              _confirmPasswordController,
              'Confirm your password',
              _obscureConfirmPassword,
              () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (v != _passwordController.text)
                  return 'Passwords do not match';
                return null;
              },
            ),
            SizedBox(height: 48.h),
            ElevatedButton(
              onPressed: isLoading ? null : _onNext,
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
                'Next',
                style: TextStyle(
                  fontSize: AppDimensions.buttonTextSize.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),
            Row(
              children: [
                const Expanded(child: Divider(color: AuthColors.inputBorder)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium.w,
                  ),
                  child: Text(
                    'OR CONTINUE WITH',
                    style: TextStyle(
                      color: AuthColors.subText,
                      fontSize: AppDimensions.captionSize.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: AuthColors.inputBorder)),
              ],
            ),
            SizedBox(height: AppDimensions.paddingLarge.h),
            OutlinedButton.icon(
              onPressed: isLoading ? null : _onGoogleSignUp,
              icon: SvgPicture.asset(
                'assets/images/google_logo.svg',
                width: 20.sp,
                height: 20.sp,
              ),
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
              ),
            ),
          ],
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

  OutlineInputBorder _getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    bool isEmail, {
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
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
      ),
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
