import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/loading_skeleton.dart';
import '../../../donations/domain/entities/donation.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_event.dart';
import '../bloc/favorites_state.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  static const int _pageSize = 10;

  late final ScrollController _scrollController;
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    context.read<FavoritesBloc>().add(
      const LoadFavoritesEvent(page: 1, limit: _pageSize),
    );
  }

  void _onScroll() {
    final state = context.read<FavoritesBloc>().state;
    if (state is! FavoritesLoaded) {
      return;
    }

    if (_scrollController.position.extentAfter < 400 &&
        !state.isLoadingMore &&
        !state.hasReachedMax) {
      context.read<FavoritesBloc>().add(const LoadMoreFavoritesEvent());
    }
  }

  Future<void> _onRefresh() async {
    _refreshCompleter = Completer<void>();
    context.read<FavoritesBloc>().add(
      const RefreshFavoritesEvent(limit: _pageSize),
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
          icon: Icon(Icons.arrow_back, color: AuthColors.headingText),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Favorites',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: AuthColors.headingText,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoaded &&
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

          if (state is FavoritesError &&
              _refreshCompleter != null &&
              !_refreshCompleter!.isCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_refreshCompleter != null &&
                  !_refreshCompleter!.isCompleted) {
                _refreshCompleter!.complete();
              }
            });
          }

          if (state is FavoritesLoading) {
            return const LoadingSkeleton(itemCount: 6);
          }

          if (state is FavoritesError) {
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
                    'Failed to load favorites',
                    style: TextStyle(
                      fontSize: AppDimensions.bodySize.sp,
                      fontWeight: FontWeight.w600,
                      color: AuthColors.headingText,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<FavoritesBloc>().add(
                        const LoadFavoritesEvent(page: 1, limit: _pageSize),
                      );
                    },
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

          if (state is FavoritesLoaded) {
            if (state.donations.isEmpty) {
              return RefreshIndicator(
                onRefresh: _onRefresh,
                color: AuthColors.primary,
                backgroundColor: AuthColors.background,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    SizedBox(height: 140.h),
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 52.sp,
                            color: AuthColors.inputText,
                          ),
                          SizedBox(height: AppDimensions.paddingMedium.h),
                          Text(
                            'No favorite donations yet',
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
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium.w,
                  vertical: AppDimensions.paddingMedium.h,
                ),
                itemCount:
                    state.donations.length + (state.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == state.donations.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AuthColors.primary,
                        ),
                      ),
                    );
                  }

                  final donation = state.donations[index];
                  return _FavoriteDonationTile(
                    donation: donation,
                    onTap: () {
                      context.push('/donation-details', extra: donation);
                    },
                    onToggleFavorite: () {
                      context.read<FavoritesBloc>().add(
                        ToggleFavoriteEvent(
                          donationId: donation.id,
                          isCurrentlyLiked: donation.isLikedByMe ?? true,
                        ),
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
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _FavoriteDonationTile extends StatelessWidget {
  const _FavoriteDonationTile({
    required this.donation,
    required this.onTap,
    required this.onToggleFavorite,
  });

  final Donation donation;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium.r),
      child: Container(
        margin: EdgeInsets.only(bottom: AppDimensions.paddingMedium.h),
        padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusMedium.r,
          ),
          border: Border.all(color: AuthColors.dividerColor),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                AppDimensions.borderRadiusMedium.r,
              ),
              child: CachedNetworkImage(
                imageUrl: donation.imageUrl,
                width: 72.w,
                height: 72.w,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  width: 72.w,
                  height: 72.w,
                  color: AuthColors.lightGrayBackground,
                  child: Icon(
                    Icons.image_not_supported,
                    color: AuthColors.inputText,
                  ),
                ),
              ),
            ),
            SizedBox(width: AppDimensions.paddingMedium.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donation.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppDimensions.bodySize.sp,
                      fontWeight: FontWeight.w700,
                      color: AuthColors.headingText,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    donation.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppDimensions.captionSize.sp,
                      color: AuthColors.subText,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onToggleFavorite,
              icon: Icon(
                Icons.favorite_rounded,
                color: Colors.redAccent,
                size: 22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
