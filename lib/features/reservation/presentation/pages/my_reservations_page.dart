import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../bloc/reservation_bloc.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_state.dart';
import '../widgets/reservation_card.dart';
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

  Future<void> _onRefresh() async {
    _fetchReservations();
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
                        label: 'Pending',
                        isSelected: _selectedFilter == 'PENDING',
                        onTap: () {
                          setState(() => _selectedFilter = 'PENDING');
                          context.read<ReservationBloc>().add(
                            const FilterReservationsEvent('PENDING'),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Confirmed',
                        isSelected: _selectedFilter == 'CONFIRMED',
                        onTap: () {
                          setState(() => _selectedFilter = 'CONFIRMED');
                          context.read<ReservationBloc>().add(
                            const FilterReservationsEvent('CONFIRMED'),
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
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Cancelled',
                        isSelected: _selectedFilter == 'CANCELLED',
                        onTap: () {
                          setState(() => _selectedFilter = 'CANCELLED');
                          context.read<ReservationBloc>().add(
                            const FilterReservationsEvent('CANCELLED'),
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
                              Icons.error_outline_rounded,
                              size: 48.sp,
                              color: Colors.red,
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),
                            Text(
                              'Error loading reservations',
                              style: TextStyle(
                                fontSize: AppDimensions.bodySize.sp,
                                fontWeight: FontWeight.w600,
                                color: AuthColors.headingText,
                                fontFamily: AppFonts.primaryFont,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppDimensions.paddingLarge.w,
                              ),
                              child: Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: AppDimensions.captionSize.sp,
                                  color: AuthColors.subText,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                            ),
                            SizedBox(height: AppDimensions.paddingLarge.h),
                            ElevatedButton.icon(
                              onPressed: _onRefresh,
                              icon: Icon(Icons.refresh_rounded, size: 20.sp),
                              label: Text(
                                'Retry',
                                style: TextStyle(
                                  fontSize: AppDimensions.bodySize.sp,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AuthColors.primary,
                                padding: EdgeInsets.symmetric(
                                  horizontal: AppDimensions.paddingLarge.w,
                                  vertical: 10.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is UserReservationsLoaded) {
                      if (state.reservations.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: _onRefresh,
                          color: AuthColors.primary,
                          backgroundColor: AuthColors.background,
                          child: ListView(
                            children: [
                              SizedBox(height: 100.h),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_basket_outlined,
                                      size: 48.sp,
                                      color: AuthColors.inputText,
                                    ),
                                    SizedBox(
                                      height: AppDimensions.paddingMedium.h,
                                    ),
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
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        color: AuthColors.primary,
                        backgroundColor: AuthColors.background,
                        child: ListView.builder(
                          itemCount: state.reservations
                              .where((r) => r.donation != null)
                              .length,
                          padding: EdgeInsets.only(
                            bottom: AppDimensions.paddingMedium.h,
                          ),
                          itemBuilder: (context, index) {
                            final filteredReservations = state.reservations
                                .where((r) => r.donation != null)
                                .toList();
                            final reservation = filteredReservations[index];

                            return ReservationCard(
                              reservation: reservation,
                              onTap: () {
                                // Navigate to reservation details with reservation ID
                                context.push(
                                  '/reservation-details',
                                  extra: reservation.id,
                                );
                              },
                            );
                          },
                        ),
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
