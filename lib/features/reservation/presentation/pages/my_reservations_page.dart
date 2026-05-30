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
import '../../domain/entities/reservation.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../../core/di/injection.dart';

class MyReservationsPage extends StatefulWidget {
  const MyReservationsPage({super.key});

  @override
  State<MyReservationsPage> createState() => _MyReservationsPageState();
}

class _MyReservationsPageState extends State<MyReservationsPage> {
  static const int _pageSize = 20;
  String _selectedRoleFilter = 'BENEFICIARY';
  String _selectedStatusGroup = 'ALL';
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
          roleFilter: _selectedRoleFilter,
          statusFilter: _statusFilterForApi(),
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
        roleFilter: _selectedRoleFilter,
        statusFilter: _statusFilterForApi(),
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
    final colors = context.themeColors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'My Reservations',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: colors.primary,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocListener<ReservationBloc, ReservationState>(
          listener: (context, state) {
            if (state is UserReservationsLoaded) {
              if (state.activeRoleFilter != null) {
                setState(() {
                  _selectedRoleFilter = state.activeRoleFilter!;
                });
              }
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top role switch: My Reservations / My Donations
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium.w,
                  vertical: AppDimensions.paddingSmall.h,
                ),
                child: _buildRoleSwitch(),
              ),

              // Secondary status tabs: All / Active / Past
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium.w,
                  vertical: AppDimensions.paddingSmall.h,
                ),
                child: _buildStatusTabs(),
              ),

              Divider(height: 1.h, color: colors.divider),

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
                              color: colors.error,
                            ),
                            SizedBox(height: AppDimensions.paddingMedium.h),
                            Text(
                              'Error loading reservations',
                              style: TextStyle(
                                fontSize: AppDimensions.bodySize.sp,
                                fontWeight: FontWeight.w600,
                                color: colors.textPrimary,
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
                                  color: colors.textSecondary,
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
                                backgroundColor: colors.primary,
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
                      final filteredReservations = _applyStatusGroupFilter(
                        state.reservations,
                      );

                      if (filteredReservations.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: _onRefresh,
                          color: colors.primary,
                          backgroundColor: colors.background,
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
                                      color: colors.textMuted,
                                    ),
                                    SizedBox(
                                      height: AppDimensions.paddingMedium.h,
                                    ),
                                    Text(
                                      'No reservations found',
                                      style: TextStyle(
                                        fontSize: AppDimensions.bodySize.sp,
                                        color: colors.textSecondary,
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
                        color: colors.primary,
                        backgroundColor: colors.background,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              filteredReservations.length +
                              (state.isLoadingMore ? 1 : 0),
                          padding: EdgeInsets.only(
                            bottom: AppDimensions.paddingMedium.h,
                          ),
                          itemBuilder: (context, index) {
                            if (index == filteredReservations.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: colors.primary,
                                  ),
                                ),
                              );
                            }

                            final reservation = filteredReservations[index];

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

  String? _statusFilterForApi() {
    if (_selectedStatusGroup == 'ALL') return null;
    // The API expects enum names: PENDING, CONFIRMED, COMPLETED, CANCELLED
    return _selectedStatusGroup;
  }

  List<Reservation> _applyStatusGroupFilter(List<Reservation> reservations) {
    // Server-side filtering using ReservationStatus enum; return received list as-is
    return reservations;
  }

  Widget _buildRoleSwitch() {
    final colors = context.themeColors;
    return Container(
      decoration: BoxDecoration(
        color: colors.lightGrayBackground,
        borderRadius: BorderRadius.circular(32.r),
      ),
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          _buildRoleOption(title: 'My Reservations', value: 'BENEFICIARY'),
          _buildRoleOption(title: 'My Donations', value: 'DONOR'),
        ],
      ),
    );
  }

  Widget _buildRoleOption({required String title, required String value}) {
    final colors = context.themeColors;
    final isSelected = _selectedRoleFilter == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (_selectedRoleFilter == value) return;

          setState(() {
            _selectedRoleFilter = value;
          });

          context.read<ReservationBloc>().add(
            FilterReservationsEvent(null, roleFilter: _selectedRoleFilter),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? colors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: colors.textMuted.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: AppDimensions.bodySize.sp,
                fontWeight: FontWeight.w700,
                color: isSelected ? colors.primary : colors.textSecondary,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTabs() {
    return SizedBox(
      height: 44.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildStatusTab('All', 'ALL'),
            _buildStatusTab('Pending', 'PENDING'),
            _buildStatusTab('Confirmed', 'CONFIRMED'),
            _buildStatusTab('Completed', 'COMPLETED'),
            _buildStatusTab('Cancelled', 'CANCELLED'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTab(String title, String value) {
    final colors = context.themeColors;
    final isSelected = _selectedStatusGroup == value;

    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: GestureDetector(
        onTap: () {
          if (_selectedStatusGroup == value) return;

          setState(() {
            _selectedStatusGroup = value;
          });

          // Trigger server-side filtering using the selected enum value
          context.read<ReservationBloc>().add(
            FilterReservationsEvent(
              _statusFilterForApi(),
              roleFilter: _selectedRoleFilter,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected
                ? colors.primary.withValues(alpha: 0.08)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(
              color: isSelected ? colors.primary : colors.divider,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? colors.primary : colors.textSecondary,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
