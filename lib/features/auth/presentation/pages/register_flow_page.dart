import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspzero/features/notification/data/services/fcm_initialization_service.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';
import 'register_step1_page.dart';
import 'register_step2_page.dart';
import 'otp_verification_page.dart';

class RegisterFlowPage extends StatefulWidget {
  const RegisterFlowPage({super.key});

  @override
  State<RegisterFlowPage> createState() => _RegisterFlowPageState();
}

class _RegisterFlowPageState extends State<RegisterFlowPage>
    with TickerProviderStateMixin {
  late final PageController _pageController;
  late AnimationController _progressAnimationController;
  late Animation<double> _progressAnimation;

  int _currentStep = 0;
  final Map<String, String> _formData = {};

  // Step labels
  static const List<String> _stepLabels = [
    'Profile Setup',
    'Further Details',
    'Registration Progress',
  ];
  static const List<String> _stepCounters = [
    'Step 1 of 3',
    'Step 2 of 3',
    'Step 3 of 3',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _progressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _progressAnimation = Tween<double>(begin: 0.33, end: 0.33).animate(
      CurvedAnimation(
        parent: _progressAnimationController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  void _goToStep(int step) {
    if (step < 0) {
      context.pop();
      return;
    }
    if (step > 2) return;

    final oldProgress = _getProgressForStep(_currentStep);
    final newProgress = _getProgressForStep(step);

    setState(() => _currentStep = step);

    _progressAnimation = Tween<double>(begin: oldProgress, end: newProgress)
        .animate(
          CurvedAnimation(
            parent: _progressAnimationController,
            curve: Curves.easeInOutCubic,
          ),
        );
    _progressAnimationController.forward(from: 0);

    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  double _getProgressForStep(int step) {
    switch (step) {
      case 0:
        return 0.33;
      case 1:
        return 0.66;
      case 2:
        return 1.0;
      default:
        return 0.33;
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
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Text(
            "Create Account",
            key: const ValueKey('create_account'),
            style: TextStyle(
              color: AuthColors.headingText,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AuthColors.headingText,
            size: AppDimensions.iconSize.sp,
          ),
          onPressed: () {
            if (_currentStep > 0) {
              _goToStep(_currentStep - 1);
            } else {
              context.pop();
            }
          },
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            FcmInitializationService.initializeAfterLogin();
            context.go('/home');
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              // Animated progress header
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingLarge.w,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.3),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            _stepLabels[_currentStep],
                            key: ValueKey('label_$_currentStep'),
                            style: TextStyle(
                              color: AuthColors.headingText,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.3),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: Text(
                            _stepCounters[_currentStep],
                            key: ValueKey('counter_$_currentStep'),
                            style: TextStyle(
                              color: AuthColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.paddingMedium.h),
                    AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusMedium.r,
                          ),
                          child: LinearProgressIndicator(
                            value: _progressAnimation.value,
                            backgroundColor: AuthColors.primary.withValues(
                              alpha: 0.2,
                            ),
                            color: AuthColors.primary,
                            minHeight: 10.h,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              // Page content with cross-fade transitions
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Step 1: Profile Setup
                    RegisterStep1Page(
                      formData: _formData,
                      onNext: () => _goToStep(1),
                    ),

                    // Step 2: Further Details
                    RegisterStep2Page(
                      formData: _formData,
                      onNext: () => _goToStep(2),
                    ),

                    // Step 3: OTP Verification
                    OtpVerificationPage(
                      userData: _formData,
                      onBack: () => _goToStep(1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
