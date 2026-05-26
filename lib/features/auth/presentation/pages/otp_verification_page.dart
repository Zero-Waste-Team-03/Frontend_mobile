import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class OtpVerificationPage extends StatefulWidget {
  final Map<String, String> userData;
  final VoidCallback? onBack;

  const OtpVerificationPage({super.key, required this.userData, this.onBack});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;
  int _timeLeft = 55;
  bool _hasAutoSubmitted = false;

  @override
  void initState() {
    super.initState();
    _startTimer();

    // Add listeners to each controller for paste detection
    for (int i = 0; i < 6; i++) {
      _otpControllers[i].addListener(() => _onControllerChanged(i));
    }

    // Auto-focus first field after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
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
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onControllerChanged(int index) {
    // Check if all fields are filled for auto-submit
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 6 && !_hasAutoSubmitted) {
      _hasAutoSubmitted = true;
      // Small delay for visual feedback before submitting
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _onVerify();
      });
    } else if (otp.length < 6) {
      _hasAutoSubmitted = false;
    }
    setState(() {}); // Rebuild for visual state changes
  }

  void _onVerify() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 6) {
      // Unfocus all fields
      for (var node in _focusNodes) {
        node.unfocus();
      }
      context.read<AuthBloc>().add(
        AuthVerifyOtpRequested(
          firstName: widget.userData['firstName'] ?? '',
          lastName: widget.userData['lastName'] ?? '',
          email: widget.userData['email'] ?? '',
          phoneNumber: widget.userData['phone'] ?? '',
          password: widget.userData['password'] ?? '',
          confirmPassword: widget.userData['confirmPassword'] ?? '',
          location: widget.userData['location'] ?? '',
          zipCode: widget.userData['zipCode'],
          latitude: double.tryParse(widget.userData['latitude'] ?? ''),
          longitude: double.tryParse(widget.userData['longitude'] ?? ''),
          neighborhood: widget.userData['neighborhood'],
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Navigate handled by parent or router
        } else if (state is AuthError) {
          // Reset auto-submit flag on error so user can retry
          _hasAutoSubmitted = false;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final email = widget.userData['email'] ?? 'your email';

        return SingleChildScrollView(
          padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),
              Text(
                "Verify your email",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: AppDimensions.headingSize.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.025 * AppDimensions.headingSize.sp,
                  color: AuthColors.headingText,
                ),
              ),
              SizedBox(height: AppDimensions.paddingSmall.h),
              Text(
                "We've sent a 6-digit code to\n$email",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AuthColors.primary.withValues(alpha: 0.7),
                  height: 1.625,
                ),
              ),
              SizedBox(height: AppDimensions.paddingExtraLarge.h),

              // OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  final isFilled = _otpControllers[index].text.isNotEmpty;
                  return SizedBox(
                    width: 48.w,
                    height: 56.h,
                    child: KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (event) {
                        if (event is KeyDownEvent &&
                            event.logicalKey == LogicalKeyboardKey.backspace) {
                          if (_otpControllers[index].text.isEmpty &&
                              index > 0) {
                            _otpControllers[index - 1].clear();
                            _focusNodes[index - 1].requestFocus();
                          }
                        }
                      },
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _focusNodes[index],
                        // No maxLength â€” handled by formatter to allow paste interception
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AuthColors.headingText,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          _OtpFieldFormatter(
                            index: index,
                            controllers: _otpControllers,
                            focusNodes: _focusNodes,
                          ),
                        ],
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: isFilled
                              ? AuthColors.primary.withValues(alpha: 0.08)
                              : AuthColors.primary.withValues(alpha: 0.03),
                          contentPadding: EdgeInsets.zero,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusLarge.r,
                            ),
                            borderSide: BorderSide(
                              color: isFilled
                                  ? AuthColors.primary
                                  : AuthColors.primary.withValues(alpha: 0.2),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusLarge.r,
                            ),
                            borderSide: BorderSide(
                              color: isFilled
                                  ? AuthColors.primary.withValues(alpha: 0.6)
                                  : AuthColors.primary.withValues(alpha: 0.2),
                              width: isFilled ? 1.5 : 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusLarge.r,
                            ),
                            borderSide: const BorderSide(
                              color: AuthColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            _focusNodes[index + 1].requestFocus();
                          } else if (value.isEmpty && index > 0) {
                            _focusNodes[index - 1].requestFocus();
                          }
                        },
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: AppDimensions.paddingExtraLarge.h),
              _timeLeft > 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timer,
                          color: AuthColors.primary,
                          size: 20.sp,
                        ),
                        SizedBox(width: AppDimensions.paddingSmall.w),
                        Text(
                          "Resend code in 0:${_timeLeft.toString().padLeft(2, '0')}",
                          style: TextStyle(
                            color: AuthColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: AppDimensions.bodySize.sp,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code?",
                          style: TextStyle(
                            color: AuthColors.subText,
                            fontSize: AppDimensions.bodySize.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () {
                                  context.read<AuthBloc>().add(
                                    AuthSignUpRequested(
                                      firstName:
                                          widget.userData['firstName'] ?? '',
                                      lastName:
                                          widget.userData['lastName'] ?? '',
                                      email: widget.userData['email'] ?? '',
                                      phoneNumber:
                                          widget.userData['phone'] ?? '',
                                      password:
                                          widget.userData['password'] ?? '',
                                    ),
                                  );
                                  _startTimer();
                                  // Clear existing OTP and reset
                                  for (var c in _otpControllers) {
                                    c.clear();
                                  }
                                  _hasAutoSubmitted = false;
                                  _focusNodes[0].requestFocus();
                                },
                          child: Text(
                            "Resend code",
                            style: TextStyle(
                              color: AuthColors.primary,
                              decoration: TextDecoration.underline,
                              fontSize: AppDimensions.bodySize.sp,
                            ),
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
                    : Text(
                        'Verify & Continue',
                        style: TextStyle(
                          fontSize: AppDimensions.buttonTextSize.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
              SizedBox(height: AppDimensions.paddingMedium.h),
              Center(
                child: Text(
                  "By continuing, you agree to Gasp'Zero's Terms of\nService and Privacy Policy.",
                  style: TextStyle(
                    color: AuthColors.primary.withValues(alpha: 0.6),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Custom TextInputFormatter that intercepts paste and distributes
/// digits across all OTP fields starting from the current index.
class _OtpFieldFormatter extends TextInputFormatter {
  final int index;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  _OtpFieldFormatter({
    required this.index,
    required this.controllers,
    required this.focusNodes,
  });

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    // If more than 1 digit arrived, it's a paste â€” distribute across fields
    if (newText.length > 1) {
      // Schedule the distribution after this frame to avoid conflicts
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _distributeDigits(newText);
      });
      // Keep only the first digit in this field for now
      return TextEditingValue(
        text: newText[0],
        selection: const TextSelection.collapsed(offset: 1),
      );
    }

    // Normal single-character input: allow max 1 digit
    if (newText.length <= 1) {
      return newValue;
    }

    return oldValue;
  }

  void _distributeDigits(String digits) {
    for (int i = 0; i < digits.length && (index + i) < 6; i++) {
      controllers[index + i].text = digits[i];
    }

    // Focus the next empty field, or the last filled field
    final filledCount = (index + digits.length).clamp(0, 6);
    if (filledCount < 6) {
      focusNodes[filledCount].requestFocus();
    } else {
      focusNodes[5].requestFocus();
    }
  }
}
