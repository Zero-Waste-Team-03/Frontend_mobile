import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/app_icons.dart';
import '../../../../shared/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/notification_button.dart';
import '../bloc/donations_bloc.dart';
import '../bloc/donations_event.dart';
import '../bloc/donations_state.dart';
import '../../domain/entities/donation.dart';
import '../../domain/entities/category.dart';

class DonationsListPage extends StatefulWidget {
  const DonationsListPage({super.key});

  @override
  State<DonationsListPage> createState() => _DonationsListPageState();
}

class _DonationsListPageState extends State<DonationsListPage> {
  List<Donation> _donations = [];
  String _selectedCategory = 'All';
  String? _selectedCategoryId;
  LatLng? _currentPosition;
  
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _searchDebounce;
  String? _lastProcessedQuery;

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && mounted) {
      final state = context.read<DonationsBloc>().state;
      if (state is DonationsLoaded && state.hasNextPage) {
        context.read<DonationsBloc>().add(
          LoadDonationsEvent(
            categoryId: _selectedCategoryId,
            searchQuery: _searchController.text,
            latitude: _currentPosition?.latitude,
            longitude: _currentPosition?.longitude,
            append: true,
          ),
        );
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> _determinePosition() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    try {
      final routerState = GoRouterState.of(context);
      final currentFocusQuery = routerState.uri.queryParameters['focus'];
      if (currentFocusQuery != _lastProcessedQuery) {
        _lastProcessedQuery = currentFocusQuery;
        if (currentFocusQuery == 'true') {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_searchFocusNode.hasFocus) {
              _searchFocusNode.requestFocus();
            }
          });
        }
      }
    } catch (_) {}

    return BlocProvider(
      create: (context) =>
          getIt<DonationsBloc>()..add(const LoadDonationsEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              SizedBox(height: 16.h),
              BlocBuilder<DonationsBloc, DonationsState>(
                builder: (context, state) {
                  final categories = state is DonationsLoaded
                      ? state.categories
                      : const <Category>[];
                  return _buildCategoryFilters(categories);
                },
              ),
              SizedBox(height: 16.h),
              _buildListMetadata(),
              Expanded(
                child: BlocBuilder<DonationsBloc, DonationsState>(
                  builder: (context, state) {
                    if (state is DonationsLoading ||
                        state is DonationsInitial) {
                      return _buildLoadingSkeleton();
                    } else if (state is DonationsLoaded) {
                      _donations = state.donations;
                      if (_donations.isEmpty) {
                        return const Center(child: Text('No donations found.'));
                      }
                      return _buildDonationsList();
                    } else if (state is DonationsError) {
                      return Center(child: Text('Error: ${state.message}'));
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

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Browse donations',
            style: TextStyle(
              fontSize: AppDimensions.appBarTitleSize.sp,
              fontWeight: FontWeight.w700,
              color: AuthColors.primary,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.volunteer_activism_outlined,
                  color: AuthColors.primary,
                  size: AppDimensions.iconSize.sp,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: AuthColors.lightGrayBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  context.push('/my-reservations');
                },
              ),
              NotificationButton(
                backgroundColor: AuthColors.lightGrayBackground,
                iconColor: AuthColors.primary,
                iconSize: AppDimensions.iconSize.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Hero(
        tag: 'search_bar',
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              onChanged: (value) {
                _searchDebounce?.cancel();
                _searchDebounce = Timer(const Duration(milliseconds: 300), () {
                  if (mounted) {
                    setState(() {
                      _selectedCategory = 'All';
                      _selectedCategoryId = null;
                    });
                    context.read<DonationsBloc>().add(
                      LoadDonationsEvent(searchQuery: value),
                    );
                  }
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search donations...',
                prefixIcon: Icon(AppIcons.search),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryFilters(List<Category> categories) {
    final labels = ['All', ...categories.map((c) => c.name)];
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index) {
          final category = labels[index];
          final isSelected = category == _selectedCategory;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                  _selectedCategoryId = index == 0
                      ? null
                      : categories[index - 1].id;
                });
                context.read<DonationsBloc>().add(
                  LoadDonationsEvent(categoryId: _selectedCategoryId),
                );
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AuthColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? AuthColors.primary
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF4A5550),
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListMetadata() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_donations.length} donations nearby',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
          // Row(
          //   children: [
          //     Icon(Icons.sort_rounded, size: 16.sp, color: AuthColors.primary),
          //     SizedBox(width: 4.w),
          //     Text(
          //       'Nearest',
          //       style: TextStyle(
          //         fontSize: 13.sp,
          //         color: AuthColors.primary,
          //         fontWeight: FontWeight.w600,
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  Widget _buildDonationsList() {
    return BlocBuilder<DonationsBloc, DonationsState>(
      builder: (context, state) {
        final hasNextPage = state is DonationsLoaded ? state.hasNextPage : false;
        
        return RefreshIndicator(
          onRefresh: () async {
            if (!mounted) return;
            context.read<DonationsBloc>().add(
              LoadDonationsEvent(
                categoryId: _selectedCategoryId,
                searchQuery: _searchController.text,
                latitude: _currentPosition?.latitude,
                longitude: _currentPosition?.longitude,
              ),
            );
            await Future.delayed(const Duration(milliseconds: 500));
          },
          color: AuthColors.primary,
          backgroundColor: Colors.white,
          child: ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 80.h),
            itemCount: hasNextPage ? _donations.length + 1 : _donations.length,
            itemBuilder: (context, index) {
              if (index >= _donations.length) {
                return _buildPaginationLoadingIndicator();
              }
              final donation = _donations[index];
              return _buildDonationCard(donation, index);
            },
          ),
        );
      },
    );
  }

  Widget _buildPaginationLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Center(
        child: SizedBox(
          width: 24.w,
          height: 24.w,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AuthColors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildDonationCard(Donation donation, int index) {
    String distanceStr = 'Distance unknown';
    if (_currentPosition != null &&
        donation.latitude != null &&
        donation.longitude != null) {
      final distanceInMeters = const Distance().as(
        LengthUnit.Meter,
        _currentPosition!,
        LatLng(donation.latitude!, donation.longitude!),
      );
      if (distanceInMeters < 1000) {
        distanceStr = '${distanceInMeters.round()} m away';
      } else {
        distanceStr = '${(distanceInMeters / 1000).toStringAsFixed(1)} km away';
      }
    }

    // Determine condition tag colors
    Color tagBgColor;
    Color tagTextColor;
    if (donation.condition.toUpperCase() == 'DRY') {
      tagBgColor = const Color(0xFFFFF0E6);
      tagTextColor = const Color(0xFFE87C3E);
    } else if (donation.condition.toUpperCase() == 'FRESH') {
      tagBgColor = const Color(0xFFE6F7ED);
      tagTextColor = const Color(0xFF2D6C50);
    } else {
      tagBgColor = const Color(0xFFE6F0FF);
      tagTextColor = const Color(0xFF3B82F6);
    }

    return GestureDetector(
      onTap: () {
        context.push('/donation-details', extra: donation);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'donation_img_${donation.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: donation.imageUrl,
                    width: 76.w,
                    height: 76.w,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: Colors.grey[200]),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.error, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            donation.title,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF131615),
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: tagBgColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            donation.condition.toUpperCase(),
                            style: TextStyle(
                              fontSize: 9.sp,
                              color: tagTextColor,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: const Color(0xFF64748B),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          distanceStr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
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

  Widget _buildLoadingSkeleton() {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 80.h),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            height: 100.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        );
      },
    );
  }
}
