import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/di/injection.dart';
import '../../../../shared/theme/app_colors.dart';
import '../bloc/donations_bloc.dart';
import '../bloc/donations_event.dart';
import '../bloc/donations_state.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/donation.dart';

class DonationsHomePage extends StatefulWidget {
  const DonationsHomePage({super.key});

  @override
  State<DonationsHomePage> createState() => _DonationsHomePageState();
}

class _DonationsHomePageState extends State<DonationsHomePage>
    with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;
  late final DonationsBloc _donationsBloc;
  LatLng? _currentPosition;
  bool _isLoadingMap = true;
  String _selectedCategory = 'All';
  String? _selectedCategoryId;
  Donation? _selectedDonation;

  @override
  void initState() {
    super.initState();
    _donationsBloc = getIt<DonationsBloc>();
    _donationsBloc.add(const LoadDonationCategoriesEvent());
    _determinePosition();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    _donationsBloc.close();
    super.dispose();
  }

  void _fetchDonationsInArea({bool append = false, LatLng? center}) {
    if (_currentPosition == null) return;

    final fetchCenter = center ?? _currentPosition!;

    _donationsBloc.add(
      LoadDonationsEvent(
        categoryId: _selectedCategoryId,
        searchQuery: _searchController.text,
        latitude: fetchCenter.latitude,
        longitude: fetchCenter.longitude,
        radius: 20.0, // 20 km default visible radius
        append: append,
      ),
    );
  }

  void _onMapPositionChanged(MapCamera camera, bool hasGesture) {
    if (!hasGesture) return;
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      if (mounted) {
        _fetchDonationsInArea(append: true, center: camera.center);
      }
    });
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    if (_mapController.camera.center == destLocation &&
        _mapController.camera.zoom == destZoom)
      return;

    final latTween = Tween<double>(
      begin: _mapController.camera.center.latitude,
      end: destLocation.latitude,
    );
    final lngTween = Tween<double>(
      begin: _mapController.camera.center.longitude,
      end: destLocation.longitude,
    );
    final zoomTween = Tween<double>(
      begin: _mapController.camera.zoom,
      end: destZoom,
    );

    final animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final Animation<double> animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    );

    animationController.addListener(() {
      _mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        animationController.dispose();
      }
    });

    animationController.forward();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setDefaultPosition();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _setDefaultPosition();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _setDefaultPosition();
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _isLoadingMap = false;
        });
        _fetchDonationsInArea();
      }
    } catch (e) {
      _setDefaultPosition();
    }
  }

  void _setDefaultPosition() {
    if (mounted) {
      setState(() {
        _currentPosition = const LatLng(21.4225, 39.8262); // Mecca fallback
        _isLoadingMap = false;
      });
      _fetchDonationsInArea();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _donationsBloc,
      child: Scaffold(
        backgroundColor: AuthColors.background,
        body: Container(
          child: BlocBuilder<DonationsBloc, DonationsState>(
            builder: (context, state) {
              // if (state is DonationsError) {
              //   return Center(
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Text(
              //           'Failed to load map donations',
              //           style: TextStyle(
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.w600,
              //             color: AuthColors.headingText,
              //           ),
              //         ),
              //         SizedBox(height: 6.h),
              //         Text(
              //           state.message,
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             fontSize: 13.sp,
              //             color: AuthColors.subText,
              //           ),
              //         ),
              //         SizedBox(height: 14.h),
              //         ElevatedButton(
              //           onPressed: _fetchDonationsInArea,
              //           child: const Text('Retry'),
              //         ),
              //       ],
              //     ),
              //   );
              // }

              final categories = state is DonationsLoaded
                  ? state.categories
                  : <Category>[];
              final donations = state is DonationsLoaded
                  ? state.donations
                  : <Donation>[];
              final donationsWithLocation = donations
                  .where((d) => d.latitude != null && d.longitude != null)
                  .toList();

              if (_selectedDonation != null &&
                  !donationsWithLocation.any(
                    (d) => d.id == _selectedDonation!.id,
                  )) {
                _selectedDonation = null;
              }

              return Stack(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        _buildMap(donationsWithLocation),
                        Positioned(
                          right: 16.w,
                          bottom: 120.h,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              if (_currentPosition != null) {
                                _animatedMapMove(_currentPosition!, 14.5);
                              }
                            },
                            child: Icon(
                              Icons.my_location,
                              color: AuthColors.primary,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 16.w,
                          right: 16.w,
                          bottom: 16.h,
                          child: _buildBottomCard(donationsWithLocation),
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    bottom: false,
                    child: Column(
                      spacing: 4.h,
                      children: [
                        _buildSearchBar(context),
                        _buildCategoryFilters(context, categories),
                        state is DonationsLoading
                            ? LinearProgressIndicator(
                                color: AuthColors.primary,
                                backgroundColor: AuthColors.primary.withValues(
                                  alpha: 0.3,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    // _selectedDonation = null;
    // _fetchDonationsInArea();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.only(left: 16.0, right: 8.0),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            hintText: 'Search donations...',
            leading: const Icon(Icons.search),
            trailing: <Widget>[
              Tooltip(
                message: 'Filters (coming soon)',
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune_rounded),
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          );
        },
        suggestionsBuilder: (BuildContext context, SearchController controller) {
          return []; // No dynamic suggestions for now, just rely on the search results page
        },
      ),
    );
  }

  Widget _buildCategoryFilters(
    BuildContext context,
    List<Category> categories,
  ) {
    final labels = ['All', ...categories.map((c) => c.name)];
    return SizedBox(
      height: 36.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                  _selectedDonation = null;
                });
                _fetchDonationsInArea();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AuthColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? AuthColors.primary
                        : const Color(0xFFD7DFDB),
                    width: 1,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AuthColors.subText,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMap(List<Donation> donationsWithLocation) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentPosition!,
          initialZoom: 13.2,
          onPositionChanged: _onMapPositionChanged,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              ...donationsWithLocation.map((donation) {
                final isSelected = _selectedDonation?.id == donation.id;
                return Marker(
                  point: LatLng(donation.latitude!, donation.longitude!),
                  width: 48.w,
                  height: 48.w,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDonation = donation;
                      });
                      _animatedMapMove(
                        LatLng(donation.latitude!, donation.longitude!),
                        14.5,
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.all(isSelected ? 8.w : 6.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AuthColors.primary
                                : Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.location_on_rounded,
                            color: isSelected
                                ? Colors.white
                                : AuthColors.primary,
                            size: isSelected ? 24.sp : 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              Marker(
                point: _currentPosition!,
                width: 24.w,
                height: 24.w,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D4ED8),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1D4ED8).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard(List<Donation> donationsWithLocation) {
    if (donationsWithLocation.isEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Text(
          'No donation coordinates available for this category.',
          style: TextStyle(fontSize: 13.sp, color: AuthColors.subText),
        ),
      );
    }

    final donation = _selectedDonation ?? donationsWithLocation.first;
    final distance = _formatDistanceKm(donation);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => context.push('/donation-details', extra: donation),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: CachedNetworkImage(
                  imageUrl: donation.imageUrl,
                  width: 62.w,
                  height: 62.w,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: const Color(0xFFE2E8F0)),
                  errorWidget: (context, url, error) => Container(
                    color: const Color(0xFFE2E8F0),
                    child: const Icon(
                      Icons.image_not_supported_rounded,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      donation.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AuthColors.headingText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      donation.category?.name ?? 'Uncategorized',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AuthColors.subText,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 14.sp,
                          color: AuthColors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          distance,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AuthColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: const Color(0xFF94A3B8),
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDistanceKm(Donation donation) {
    if (_currentPosition == null ||
        donation.latitude == null ||
        donation.longitude == null) {
      return 'Distance unavailable';
    }

    final distanceInMeters = const Distance().as(
      LengthUnit.Meter,
      _currentPosition!,
      LatLng(donation.latitude!, donation.longitude!),
    );

    if (distanceInMeters < 1000) {
      return '${distanceInMeters.round()} m away';
    }

    return '${(distanceInMeters / 1000).toStringAsFixed(1)} km away';
  }
}
