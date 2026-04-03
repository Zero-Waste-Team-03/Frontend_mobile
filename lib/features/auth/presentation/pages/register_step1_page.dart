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
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.formData['firstName'] ?? '');
    _lastNameController =
        TextEditingController(text: widget.formData['lastName'] ?? '');
    _emailController =
        TextEditingController(text: widget.formData['email'] ?? '');
    _passwordController =
        TextEditingController(text: widget.formData['password'] ?? '');
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onNext() {
    final fn = _firstNameController.text.trim();
    final ln = _lastNameController.text.trim();
    final em = _emailController.text.trim();
    final pw = _passwordController.text;

    if (fn.isNotEmpty && ln.isNotEmpty && em.isNotEmpty && pw.isNotEmpty) {
      widget.formData['firstName'] = fn;
      widget.formData['lastName'] = ln;
      widget.formData['email'] = em;
      widget.formData['password'] = pw;
      widget.onNext();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  void _onGoogleSignUp() {
    context.read<AuthBloc>().add(AuthGoogleLoginRequested());
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthBloc>().state is AuthLoading;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
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
                        _firstNameController, 'Enter first name', false),
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
                        _lastNameController, 'Enter last name', false),
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
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
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
                    horizontal: AppDimensions.paddingMedium.w),
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

  Widget _buildTextField(
      TextEditingController controller, String hint, bool isPassword) {
    return Container(
      height: AppDimensions.inputHeight.h,
      decoration: BoxDecoration(
        color: AuthColors.inputBackground,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
        border: Border.all(color: AuthColors.inputBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
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
    );
  }
}
