import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/loading_skeleton.dart';
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
  static const int _pageSize = 20;
  String? _selectedFilter;
  String? _currentUserId;
  late ScrollController _scrollController;
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _loadUserData();
  }

  void _onScroll() {
    final currentState = context.read<ReservationBloc>().state;
    if (currentState is! UserReservationsLoaded) {
      return;
    }

    if (_scrollController.position.extentAfter < 400 &&
        !currentState.isLoadingMore &&
        !currentState.hasReachedMax &&
        _currentUserId != null) {
      context.read<ReservationBloc>().add(
        FetchUserReservationsEvent(
          _currentUserId!,
          statusFilter: _selectedFilter,
          page: currentState.currentPage + 1,
          limit: _pageSize,
        ),
      );
    }
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
    if (_currentUserId == null) {
      return;
    }

    context.read<ReservationBloc>().add(
      FetchUserReservationsEvent(
        _currentUserId!,
        statusFilter: _selectedFilter,
        page: 1,
        limit: _pageSize,
      ),
    );
  }

  Future<void> _onRefresh() async {
    _refreshCompleter = Completer<void>();
    _fetchReservations();
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      appBar: AppBar(
        backgroundColor: AuthColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AuthColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Reservations',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: AuthColors.primary,
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
                    if (state is UserReservationsLoaded &&
                        state.currentPage == 1 &&
                        _refreshCompleter != null &&
                        !_refreshCompleter!.isCompleted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_refreshCompleter != null &&
                            !_refreshCompleter!.isCompleted) {
                          _refreshCompleter!.complete();
                        }
                      });
                    }

                    if (state is UserReservationsError &&
                        _refreshCompleter != null &&
                        !_refreshCompleter!.isCompleted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_refreshCompleter != null &&
                            !_refreshCompleter!.isCompleted) {
                          _refreshCompleter!.complete();
                        }
                      });
                    }

                    if (state is UserReservationsLoading) {
                      return const LoadingSkeleton(itemCount: 6);
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
                          controller: _scrollController,
                          itemCount:
                              state.reservations.length +
                              (state.isLoadingMore ? 1 : 0),
                          padding: EdgeInsets.only(
                            bottom: AppDimensions.paddingMedium.h,
                          ),
                          itemBuilder: (context, index) {
                            if (index == state.reservations.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AuthColors.primary,
                                  ),
                                ),
                              );
                            }

                            final reservation = state.reservations[index];

                            return ReservationCard(
                              reservation: reservation,
                              onTap: () async {
                                // Navigate to reservation details with reservation ID
                                await context.push(
                                  '/reservation-details',
                                  extra: reservation.id,
                                );

                                if (mounted) {
                                  _fetchReservations();
                                }
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
