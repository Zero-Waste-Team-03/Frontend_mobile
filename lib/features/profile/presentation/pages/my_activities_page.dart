import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/loading_skeleton.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../../../reservation/presentation/widgets/donation_card.dart';
import '../../../reservation/presentation/widgets/status_filter_chip.dart';

class MyActivitiesPage extends StatefulWidget {
  const MyActivitiesPage({super.key});

  @override
  State<MyActivitiesPage> createState() => _MyActivitiesPageState();
}

class _MyActivitiesPageState extends State<MyActivitiesPage> {
  late ScrollController _scrollController;
  static const int _pageSize = 10;
  String? _selectedFilter;
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<ProfileBloc>().add(
      const ProfileActivitiesLoadRequested(page: 1, limit: _pageSize),
    );
  }

  void _onScroll() {
    final currentState = context.read<ProfileBloc>().state;
    if (currentState is! ProfileActivitiesLoaded) {
      return;
    }

    if (_scrollController.position.extentAfter < 500 &&
        !currentState.isLoadingMore &&
        !currentState.hasReachedMax) {
      context.read<ProfileBloc>().add(
        const ProfileActivitiesLoadMoreRequested(limit: _pageSize),
      );
    }
  }

  Future<void> _onRefresh() async {
    _refreshCompleter = Completer<void>();
    context.read<ProfileBloc>().add(
      ProfileActivitiesLoadRequested(
        page: 1,
        limit: _pageSize,
        statusFilter: _selectedFilter,
      ),
    );
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
          'My Activities',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: AuthColors.primary,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileActivitiesLoaded) {
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
                          context.read<ProfileBloc>().add(
                            const ProfileActivitiesFilterRequested(null),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Active',
                        isSelected: _selectedFilter == 'PUBLISHED',
                        onTap: () {
                          setState(() => _selectedFilter = 'PUBLISHED');
                          context.read<ProfileBloc>().add(
                            const ProfileActivitiesFilterRequested('PUBLISHED'),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Reserved',
                        isSelected: _selectedFilter == 'RESERVED',
                        onTap: () {
                          setState(() => _selectedFilter = 'RESERVED');
                          context.read<ProfileBloc>().add(
                            const ProfileActivitiesFilterRequested('RESERVED'),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Completed',
                        isSelected: _selectedFilter == 'COMPLETED',
                        onTap: () {
                          setState(() => _selectedFilter = 'COMPLETED');
                          context.read<ProfileBloc>().add(
                            const ProfileActivitiesFilterRequested('COMPLETED'),
                          );
                        },
                      ),
                      SizedBox(width: AppDimensions.paddingSmall.w),
                      StatusFilterChip(
                        label: 'Expired',
                        isSelected: _selectedFilter == 'EXPIRED',
                        onTap: () {
                          setState(() => _selectedFilter = 'EXPIRED');
                          context.read<ProfileBloc>().add(
                            const ProfileActivitiesFilterRequested('EXPIRED'),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Donations List
              Expanded(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileActivitiesLoaded &&
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

                    if (state is ProfileActivitiesError &&
                        _refreshCompleter != null &&
                        !_refreshCompleter!.isCompleted) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (_refreshCompleter != null &&
                            !_refreshCompleter!.isCompleted) {
                          _refreshCompleter!.complete();
                        }
                      });
                    }

                    if (state is ProfileActivitiesLoading) {
                      return const LoadingSkeleton(itemCount: 6);
                    }

                    if (state is ProfileActivitiesError) {
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
                            SizedBox(height: AppDimensions.paddingMedium.h),
                            ElevatedButton.icon(
                              onPressed: _onRefresh,
                              icon: Icon(Icons.refresh_rounded, size: 18.sp),
                              label: const Text('Retry'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AuthColors.primary,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state is ProfileActivitiesLoaded) {
                      if (state.activities.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: _onRefresh,
                          color: AuthColors.primary,
                          backgroundColor: AuthColors.background,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              SizedBox(height: 120.h),
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.inventory_2_outlined,
                                      size: 48.sp,
                                      color: AuthColors.inputText,
                                    ),
                                    SizedBox(
                                      height: AppDimensions.paddingMedium.h,
                                    ),
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
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                              state.activities.length +
                              (state.isLoadingMore ? 1 : 0),
                          padding: EdgeInsets.only(
                            bottom: AppDimensions.paddingMedium.h,
                          ),
                          itemBuilder: (context, index) {
                            if (index == state.activities.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppDimensions.paddingMedium.h,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AuthColors.primary,
                                  ),
                                ),
                              );
                            }

                            final donation = state.activities[index];
                            return DonationCard(
                              donation: donation,
                              onTap: () {
                                context.push(
                                  '/donation-details-full',
                                  extra: donation,
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
