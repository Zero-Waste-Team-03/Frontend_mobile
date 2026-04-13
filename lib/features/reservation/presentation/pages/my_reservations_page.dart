import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../bloc/reservation_bloc.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_state.dart';
import '../widgets/donation_card.dart';
import '../widgets/status_filter_chip.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../../core/di/injection.dart';

class MyReservationsPage extends StatefulWidget {
  const MyReservationsPage({super.key});

  @override
  State<MyReservationsPage> createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage> {
  String? _selectedFilter;
  late String _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    final authRepository = getIt<AuthRepository>();
    final result = await authRepository.getCachedUser();
    result.fold(
      (failure) {
        _currentUserId = 'user-1';
        _fetchReservations();
      },
      (user) {
        _currentUserId = user.id;
        _fetchReservations();
      },
    );
  }

  void _fetchReservations() {
    context.read<ReservationBloc>().add(
      FetchUserReservationsEvent(_currentUserId, statusFilter: _selectedFilter),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      appBar: AppBar(
        backgroundColor: AuthColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AuthColors.headingText),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Reservations',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: AuthColors.headingText,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocListener<ReservationBloc, ReservationState>(
          listener: (context, state) {
            if (state is UserReservationsLoaded) {
              _selectedFilter = state.activeFilter;
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Chips
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium.w,
                  vertical: AppDimensions.paddingMedium.h,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      StatusFilterChip(
                        label: 'All',
                        isSelected:
                            _selectedFilter == null || _selectedFilter!.isEmpty,
                        onTap: () {
                          setState(() => _selectedFilter = null);
                          context.read<ReservationBloc>().add(
                            const FilterReservationsEvent(null),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Reserved',
                        isSelected: _selectedFilter == 'RESERVED',
                        onTap: () {
                          setState(() => _selectedFilter = 'RESERVED');
                          context.read<ReservationBloc>().add(
                            const FilterReservationsEvent('RESERVED'),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Completed',
                        isSelected: _selectedFilter == 'COMPLETED',
                        onTap: () {
                          setState(() => _selectedFilter = 'COMPLETED');
                          context.read<ReservationBloc>().add(
                            const FilterReservationsEvent('COMPLETED'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Reservations List
              Expanded(
                child: BlocBuilder<ReservationBloc, ReservationState>(
                  builder: (context, state) {
                    if (state is UserReservationsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AuthColors.primary,
                        ),
                      );
                    }

                    if (state is UserReservationsError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 48.sp,
                              color: Colors.red,
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),
                            Text(
                              'Error loading reservations',
                              style: TextStyle(
                                fontSize: AppDimensions.bodySize.sp,
                                color: AuthColors.headingText,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is UserReservationsLoaded) {
                      if (state.reservations.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_basket_outlined,
                                size: 48.sp,
                                color: AuthColors.inputText,
                              ),
                              SizedBox(height: AppDimensions.paddingMedium.h),
                              Text(
                                'No reservations yet',
                                style: TextStyle(
                                  fontSize: AppDimensions.bodySize.sp,
                                  color: AuthColors.subText,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: state.reservations.length,
                        padding: EdgeInsets.only(
                          bottom: AppDimensions.paddingMedium.h,
                        ),
                        itemBuilder: (context, index) {
                          final donation = state.reservations[index];
                          return DonationCard(
                            donation: donation,
                            onTap: () {
                              // Navigate to reservation details
                              context.push(
                                '/reservation-details',
                                extra: donation.id,
                              );
                            },
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
