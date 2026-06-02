import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspzero/features/notification/data/services/fcm_initialization_service.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with WidgetsBindingObserver {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isWaitingForOAuth = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _isWaitingForOAuth) {
      // Give a small delay for deep links to be processed
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        final authBloc = context.read<AuthBloc>();
        if (authBloc.state is AuthLoading) {
          authBloc.add(AuthResetRequested());
        }
        setState(() {
          _isWaitingForOAuth = false;
        });
      });
    }
  }

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isWaitingForOAuth = false;
    });
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    context.read<AuthBloc>().add(AuthLoginRequested(email, password));
  }

  void _onGoogleSignIn() {
    setState(() {
      _isWaitingForOAuth = true;
    });
    context.read<AuthBloc>().add(AuthGoogleLoginRequested());
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Sign In",
          style: TextStyle(
            color: colors.headingText,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colors.headingText,
            size: AppDimensions.iconSize.sp,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess || state is AuthError) {
            setState(() {
              _isWaitingForOAuth = false;
            });
          }
          if (state is AuthSuccess) {
            FcmInitializationService.initializeAfterLogin();
            final user = state.user;
            if (user != null) {
              final zipCode = user.location?['zipCode']?.toString();
              if (zipCode == null || zipCode.trim().isEmpty) {
                context.go('/profile/edit');
              } else if (!user.isVerified) {
                context.go('/profile/find-verifier?fromLogin=true');
              } else {
                context.go('/home');
              }
            } else {
              context.go('/home');
            }
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isStandardLoading = state is AuthLoading && !_isWaitingForOAuth;

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
                      "Welcome Back",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: AppDimensions.titleSize.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                        color: colors.headingText,
                      ),
                    ),
                    SizedBox(height: AppDimensions.paddingSmall.h),
                    Text(
                      "Log in to join the Gasp'Zero community",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: AppDimensions.buttonTextSize.sp,
                        fontWeight: FontWeight.w400,
                        color: colors.subText,
                      ),
                    ),
                    SizedBox(height: 48.h),

                    // Form
                    _buildLabel(context, 'Email'),
                    SizedBox(height: AppDimensions.paddingSmall.h),
                    _buildTextField(
                      context,
                      _emailController,
                      'jane.doe@example.com',
                      false,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v))
                          return 'Invalid email';
                        return null;
                      },
                    ),
                    SizedBox(height: AppDimensions.paddingLarge.h),
                    _buildLabel(context, 'Password'),
                    SizedBox(height: AppDimensions.paddingSmall.h),
                    _buildTextField(
                      context,
                      _passwordController,
                      'Enter your password',
                      true,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        return null;
                      },
                    ),
                    SizedBox(height: AppDimensions.paddingSmall.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "Must be at least 8 characters with 1 uppercase, 1 lowercase, 1 number, and 1 symbol.",
                            style: TextStyle(
                              color: colors.subText,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/forgot-password'),
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                              color: colors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 48.h),

                    ElevatedButton(
                      onPressed: isStandardLoading ? null : _onLogin,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 56.h),
                        backgroundColor: colors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusLarge.r,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: isStandardLoading
                          ? SizedBox(
                              width: AppDimensions.iconSize.w,
                              height: AppDimensions.iconSize.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize:
                                    AppDimensions.primaryButtonTextSize.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing:
                                    0.015 *
                                    AppDimensions.primaryButtonTextSize.sp,
                              ),
                            ),
                    ),
                    SizedBox(height: AppDimensions.paddingLarge.h),

                    Row(
                      children: [
                        Expanded(child: Divider(color: colors.inputBorder)),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingMedium.w,
                          ),
                          child: Text(
                            "OR CONTINUE WITH",
                            style: TextStyle(
                              color: colors.subText,
                              fontSize: AppDimensions.captionSize.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        Expanded(child: Divider(color: colors.inputBorder)),
                      ],
                    ),
                    SizedBox(height: AppDimensions.paddingLarge.h),

                    OutlinedButton.icon(
                      onPressed: _onGoogleSignIn,
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
                        foregroundColor: colors.headingText,
                        side: BorderSide(color: colors.inputBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 48.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: colors.subText,
                            fontSize: AppDimensions.bodySize.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/register'),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: colors.primary,
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

  Widget _buildLabel(BuildContext context, String text) {
    final colors = context.themeColors;
    return Text(
      text,
      style: TextStyle(
        color: colors.labelText,
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
    BuildContext context,
    TextEditingController controller,
    String hint,
    bool isPassword, {
    String? Function(String?)? validator,
  }) {
    final colors = context.themeColors;
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      keyboardType: isPassword
          ? TextInputType.text
          : TextInputType.emailAddress,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: TextStyle(
        color: colors.headingText,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: colors.inputText,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: colors.inputBackground,
        isDense: false,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium.w,
          vertical: (AppDimensions.inputHeight.h - 20.sp) / 2,
        ),
        border: _getBorder(colors.inputBorder),
        enabledBorder: _getBorder(colors.inputBorder),
        focusedBorder: _getBorder(colors.primary),
        errorBorder: _getBorder(Colors.red),
        focusedErrorBorder: _getBorder(Colors.red),
        suffixIcon: isPassword
            ? IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: colors.inputText,
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
    );
  }
}
