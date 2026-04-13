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

class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({super.key});

  @override
  State<MyActivitiesPage> createState() => _MyActivitiesPageState();
}

class _MyActivitiesPageState extends State<MyActivitiesPage> {
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
        // Handle error silently, use placeholder
        _currentUserId = 'user-1';
        _fetchDonations();
      },
      (user) {
        _currentUserId = user.id;
        _fetchDonations();
      },
    );
  }

  void _fetchDonations() {
    context.read<ReservationBloc>().add(
      FetchUserDonationsEvent(_currentUserId, statusFilter: _selectedFilter),
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
          'My Activities',
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
            if (state is UserDonationsLoaded) {
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
                            const FilterDonationsEvent(null),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Active',
                        isSelected: _selectedFilter == 'PUBLISHED',
                        onTap: () {
                          setState(() => _selectedFilter = 'PUBLISHED');
                          context.read<ReservationBloc>().add(
                            const FilterDonationsEvent('PUBLISHED'),
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
                            const FilterDonationsEvent('RESERVED'),
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
                            const FilterDonationsEvent('COMPLETED'),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Expired',
                        isSelected: _selectedFilter == 'EXPIRED',
                        onTap: () {
                          setState(() => _selectedFilter = 'EXPIRED');
                          context.read<ReservationBloc>().add(
                            const FilterDonationsEvent('EXPIRED'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Donations List
              Expanded(
                child: BlocBuilder<ReservationBloc, ReservationState>(
                  builder: (context, state) {
                    if (state is UserDonationsLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AuthColors.primary,
                        ),
                      );
                    }

                    if (state is UserDonationsError) {
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
                              'Error loading donations',
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

                    if (state is UserDonationsLoaded) {
                      if (state.donations.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 48.sp,
                                color: AuthColors.inputText,
                              ),
                              SizedBox(height: AppDimensions.paddingMedium.h),
                              Text(
                                'No donations found',
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
                        itemCount: state.donations.length,
                        padding: EdgeInsets.only(
                          bottom: AppDimensions.paddingMedium.h,
                        ),
                        itemBuilder: (context, index) {
                          final donation = state.donations[index];
                          return DonationCard(
                            donation: donation,
                            onTap: () {
                              context.read<ReservationBloc>().add(
                                FetchDonationDetailsEvent(donation.id),
                              );
                              context.push(
                                '/donation-details-full',
                                extra: donation,
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
