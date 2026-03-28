import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class OtpVerificationPage extends StatefulWidget {
  final Map<String, String> userData;
  
  const OtpVerificationPage({super.key, required this.userData});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  
  Timer? _timer;
  int _timeLeft = 55;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() => _timeLeft = 55);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() => _timeLeft--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onVerify() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 6) {
      context.read<AuthBloc>().add(
        AuthVerifyOtpRequested(
          firstName: widget.userData['firstName'] ?? '',
          lastName: widget.userData['lastName'] ?? '',
          email: widget.userData['email'] ?? '',
          password: widget.userData['password'] ?? '',
          otp: otp,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit code')),
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
          final email = widget.userData['email'] ?? 'your email';

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Registration Progress", style: TextStyle(color: AuthColors.headingText, fontWeight: FontWeight.w600, fontSize: 16.sp)),
                      Text("Step 3 of 3", style: TextStyle(color: AuthColors.primary, fontWeight: FontWeight.w700, fontSize: 14.sp)),
                    ],
                  ),
                  SizedBox(height: AppDimensions.paddingMedium.h),
                  LinearProgressIndicator(
                    value: 1.0,
                    backgroundColor: AuthColors.primary.withOpacity(0.2),
                    color: AuthColors.primary,
                    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium.r),
                    minHeight: 10.h,
                  ),
                  SizedBox(height: 48.h),
                  
                  Text(
                    "Verify your email",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: AppDimensions.headingSize.sp, 
                      fontWeight: FontWeight.w700, 
                      letterSpacing: -0.025 * AppDimensions.headingSize.sp,
                      color: AuthColors.headingText
                    )
                  ),
                  SizedBox(height: AppDimensions.paddingSmall.h),
                  Text(
                    "We've sent a 6-digit code to\n$email",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: AuthColors.primary.withOpacity(0.7), height: 1.625),
                  ),
                  SizedBox(height: AppDimensions.paddingExtraLarge.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 44.w,
                        height: 56.h,
                        child: TextField(
                          controller: _otpControllers[index],
                          maxLength: 1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: AuthColors.headingText),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            counterText: "",
                            filled: true,
                            fillColor: AuthColors.primary.withOpacity(0.05),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
                              borderSide: BorderSide(color: AuthColors.primary.withOpacity(0.2)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
                              borderSide: BorderSide(color: AuthColors.primary.withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
                              borderSide: const BorderSide(color: AuthColors.primary, width: 2),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 5) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  
                  SizedBox(height: AppDimensions.paddingExtraLarge.h),
                  _timeLeft > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.timer, color: AuthColors.primary, size: 20.sp),
                            SizedBox(width: AppDimensions.paddingSmall.w),
                            Text(
                              "Resend code in 0:${_timeLeft.toString().padLeft(2, '0')}",
                              style: TextStyle(color: AuthColors.primary, fontWeight: FontWeight.bold, fontSize: AppDimensions.bodySize.sp),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive the code?",
                              style: TextStyle(color: AuthColors.subText, fontSize: AppDimensions.bodySize.sp),
                            ),
                            TextButton(
                              onPressed: isLoading ? null : () {
                                context.read<AuthBloc>().add(
                                  AuthSignUpRequested(
                                    firstName: widget.userData['firstName'] ?? '',
                                    lastName: widget.userData['lastName'] ?? '',
                                    email: widget.userData['email'] ?? '',
                                    password: widget.userData['password'] ?? '',
                                  ),
                                );
                                _startTimer();
                              },
                              child: Text(
                                "Resend code",
                                style: TextStyle(color: AuthColors.primary, decoration: TextDecoration.underline, fontSize: AppDimensions.bodySize.sp),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(height: 48.h),

                  ElevatedButton(
                    onPressed: isLoading ? null : _onVerify,
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
                        : Text('Verify & Continue', style: TextStyle(
                            fontSize: AppDimensions.buttonTextSize.sp, 
                            fontWeight: FontWeight.w700,
                          )),
                  ),
                  SizedBox(height: AppDimensions.paddingMedium.h),
                  Center(
                    child: Text(
                      "By continuing, you agree to Gasp'Zero's Terms of\nService and Privacy Policy.",
                      style: TextStyle(
                        color: AuthColors.primary.withOpacity(0.6), 
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.33,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
