import 'package:cached_network_image/cached_network_image.dart';
import 'dart:async';
import 'dart:math' as math;
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
  String _selectedCategory = 'All';
  String? _selectedCategoryId;
  String? _selectedCondition;
  DateTime? _selectedExpiryDate;
  Donation? _selectedDonation;
  bool _gettingCurrentLocation = false;
  bool _suppressCameraFetch = false;
  LatLng? _lastGestureCameraCenter;
  double? _lastGestureCameraZoom;
  Position? position;

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

  void _fetchDonationsInArea({
    bool append = false,
    LatLng? center,
    double? zoom,
    LatLngBounds? visibleBounds,
  }) {
    if (_currentPosition == null) return;

    final fetchCenter = center ?? _currentPosition!;
    final radiusKm = _calculateFetchRadiusKm(
      center: fetchCenter,
      zoom: zoom,
      visibleBounds: visibleBounds,
    );

    _donationsBloc.add(
      LoadDonationsEvent(
        categoryId: _selectedCategoryId,
        searchQuery: _searchController.text,
        latitude: fetchCenter.latitude,
        longitude: fetchCenter.longitude,
        radius: radiusKm,
        append: append,
      ),
    );
  }

  void _onMapPositionChanged(MapCamera camera, bool hasGesture) {
    if (_suppressCameraFetch) return;

    final previousCenter = _lastGestureCameraCenter;
    final previousZoom = _lastGestureCameraZoom;
    final hasMeaningfulCenterChange =
        previousCenter == null ||
        const Distance().as(LengthUnit.Meter, previousCenter, camera.center) >
            5;
    final hasMeaningfulZoomChange =
        previousZoom == null || (previousZoom - camera.zoom).abs() > 0.01;

    if (!hasMeaningfulCenterChange && !hasMeaningfulZoomChange) return;

    _lastGestureCameraCenter = camera.center;
    _lastGestureCameraZoom = camera.zoom;

    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 600), () {
      if (mounted) {
        _fetchDonationsInArea(
          append: true,
          center: camera.center,
          zoom: camera.zoom,
          visibleBounds: camera.visibleBounds,
        );
      }
    });
  }

  double _calculateFetchRadiusKm({
    required LatLng center,
    double? zoom,
    LatLngBounds? visibleBounds,
  }) {
    final distance = const Distance();

    if (visibleBounds != null) {
      final northEast = LatLng(visibleBounds.north, visibleBounds.east);
      final radiusInMeters = distance.as(LengthUnit.Meter, center, northEast);
      return (radiusInMeters / 1000).clamp(0.5, 300.0).toDouble();
    }

    final effectiveZoom = zoom ?? _mapController.camera.zoom;
    final metersPerPixel =
        156543.03392 *
        (math.cos(center.latitude * math.pi / 180).abs()) /
        math.pow(2, effectiveZoom);
    final approxRadiusInMeters = metersPerPixel * 500;
    return (approxRadiusInMeters / 1000).clamp(0.5, 300.0).toDouble();
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    if (_mapController.camera.center == destLocation &&
        _mapController.camera.zoom == destZoom)
      return;

    _suppressCameraFetch = true;

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
        _suppressCameraFetch = false;
        animationController.dispose();
      }
    });

    animationController.forward();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    setState(() {
      _gettingCurrentLocation = true;
    });

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
      if (position == null) {
        position = await Geolocator.getCurrentPosition();
      }
      if (mounted && position != null) {
        setState(() {
          _currentPosition = LatLng(position!.latitude, position!.longitude);
          _animatedMapMove(_currentPosition!, 14.5);
        });
        _fetchDonationsInArea();
      }
    } catch (e) {
      _setDefaultPosition();
    }
    setState(() {
      _gettingCurrentLocation = false;
      _selectedDonation = null;
    });
  }

  void _setDefaultPosition() {
    if (mounted) {
      setState(() {
        _currentPosition = const LatLng(36.737232, 3.086472);
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
              final categories = state is DonationsLoaded
                  ? state.categories
                  : <Category>[];
              final donations = state is DonationsLoaded
                  ? state.donations
                  : <Donation>[];
              final filteredDonations = _applyLocalFilters(donations);
              final donationsWithLocation = filteredDonations
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
                  Positioned.fill(
                    child: Stack(
                      children: [
                        _buildMap(donationsWithLocation),
                        Positioned(
                          right: 16.w,
                          bottom: 130.h,
                          child: FloatingActionButton(
                            mini: true,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              _determinePosition();
                            },
                            child: _gettingCurrentLocation
                                ? SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: CircularProgressIndicator(
                                      color: AuthColors.primary,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Icon(
                                    Icons.my_location_rounded,
                                    color: AuthColors.primary,
                                    size: 20.sp,
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
                        _buildSearchBar(context, categories),
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

  Widget _buildSearchBar(BuildContext context, List<Category> categories) {
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
                message: 'Filters',
                child: IconButton(
                  onPressed: () => _openFiltersSheet(categories),
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

  List<Donation> _applyLocalFilters(List<Donation> donations) {
    return donations.where((donation) {
      final matchesCondition =
          _selectedCondition == null ||
          donation.condition.toLowerCase() == _selectedCondition;

      final matchesExpiry =
          _selectedExpiryDate == null ||
          (donation.expiryDate != null &&
              _isSameDate(donation.expiryDate!, _selectedExpiryDate!));

      return matchesCondition && matchesExpiry;
    }).toList();
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String _resolveCategoryLabel(String? categoryId, List<Category> categories) {
    if (categoryId == null) return 'All';
    for (final category in categories) {
      if (category.id == categoryId) return category.name;
    }
    return 'All';
  }

  Future<void> _openFiltersSheet(List<Category> categories) async {
    String? tempCategoryId = _selectedCategoryId;
    String? tempCondition = _selectedCondition;
    DateTime? tempExpiryDate = _selectedExpiryDate;

    final applied = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filters',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: AuthColors.headingText,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              tempCategoryId = null;
                              tempCondition = null;
                              tempExpiryDate = null;
                            });
                          },
                          child: const Text('Reset'),
                        ),
                      ],
                    ),
                    SizedBox(height: 14.h),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AuthColors.headingText,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 2.h,
                      children: [
                        ChoiceChip(
                          label: const Text('All'),
                          padding: EdgeInsets.all(8.w),
                          selected: tempCategoryId == null,
                          onSelected: (_) {
                            setModalState(() {
                              tempCategoryId = null;
                            });
                          },
                        ),
                        ...categories.map(
                          (category) => ChoiceChip(
                            label: Text(category.name),
                            padding: EdgeInsets.all(8.w),
                            selected: tempCategoryId == category.id,
                            onSelected: (_) {
                              setModalState(() {
                                tempCategoryId = category.id;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Condition',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AuthColors.headingText,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        _buildConditionButton(
                          label: 'Low',
                          value: 'low',
                          selectedValue: tempCondition,
                          onTap: () {
                            setModalState(() {
                              tempCondition = tempCondition == 'low'
                                  ? null
                                  : 'low';
                            });
                          },
                        ),
                        SizedBox(width: 8.w),
                        _buildConditionButton(
                          label: 'Medium',
                          value: 'medium',
                          selectedValue: tempCondition,
                          onTap: () {
                            setModalState(() {
                              tempCondition = tempCondition == 'medium'
                                  ? null
                                  : 'medium';
                            });
                          },
                        ),
                        SizedBox(width: 8.w),
                        _buildConditionButton(
                          label: 'High',
                          value: 'high',
                          selectedValue: tempCondition,
                          onTap: () {
                            setModalState(() {
                              tempCondition = tempCondition == 'high'
                                  ? null
                                  : 'high';
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Expiry Date',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AuthColors.headingText,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final now = DateTime.now();
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: tempExpiryDate ?? now,
                                firstDate: DateTime(now.year - 1),
                                lastDate: DateTime(now.year + 5),
                              );
                              if (pickedDate != null) {
                                setModalState(() {
                                  tempExpiryDate = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                  );
                                });
                              }
                            },
                            icon: const Icon(Icons.calendar_today_outlined),
                            label: Text(
                              tempExpiryDate == null
                                  ? 'Pick date'
                                  : '${tempExpiryDate!.year}-${tempExpiryDate!.month.toString().padLeft(2, '0')}-${tempExpiryDate!.day.toString().padLeft(2, '0')}',
                            ),
                          ),
                        ),
                        if (tempExpiryDate != null) ...[
                          SizedBox(width: 8.w),
                          IconButton(
                            onPressed: () {
                              setModalState(() {
                                tempExpiryDate = null;
                              });
                            },
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AuthColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: const Text('Apply Filters'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (applied != true || !mounted) return;

    final bool categoryChanged = tempCategoryId != _selectedCategoryId;
    setState(() {
      _selectedCategoryId = tempCategoryId;
      _selectedCategory = _resolveCategoryLabel(
        _selectedCategoryId,
        categories,
      );
      _selectedCondition = tempCondition;
      _selectedExpiryDate = tempExpiryDate;
      _selectedDonation = null;
    });

    if (categoryChanged) {
      _fetchDonationsInArea();
    }
  }

  Widget _buildConditionButton({
    required String label,
    required String value,
    required String? selectedValue,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedValue == value;
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected
              ? AuthColors.primary.withValues(alpha: 0.1)
              : Colors.white,
          side: BorderSide(
            color: isSelected ? AuthColors.primary : const Color(0xFFD7DFDB),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AuthColors.primary : AuthColors.subText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMap(List<Donation> donationsWithLocation) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentPosition ?? LatLng(36.737232, 3.086472),
          initialZoom: 14.5,
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
                return _buildDonationMarker(donation, isSelected);
              }),
              if (_currentPosition != null)
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
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Text(
          'No donation coordinates available for this category.',
          style: TextStyle(fontSize: 13.sp, color: AuthColors.subText),
        ),
      );
    }

    if (_selectedDonation == null) return const SizedBox.shrink();
    final donation = _selectedDonation;
    final distance = _formatDistanceKm(donation!);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24.r),
        onTap: () => context.push('/donation-details', extra: donation),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: donation.imageUrl,
                  width: 80.w,
                  height: 80.w,
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

  Marker _buildDonationMarker(Donation donation, bool isSelected) {
    final markerColor = switch (donation.condition.toLowerCase()) {
      'low' => const Color(0xFF10B981),
      'medium' => const Color(0xFFF59E0B),
      'high' => const Color(0xFFEF4444),
      _ => const Color(0xFF6B7280),
    };
    final markerIcon = switch (donation.condition.toLowerCase()) {
      'low' || 'medium' => Icons.volunteer_activism_rounded,
      'high' => Icons.warning_amber_rounded,
      _ => Icons.help_outline_rounded,
    };
    return Marker(
      point: LatLng(donation.latitude!, donation.longitude!),
      width: 64.w,
      height: 64.w,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedDonation = donation;
          });
          _animatedMapMove(
            LatLng(donation.latitude!, donation.longitude!),
            15.5,
          );
        },
        child: Center(
          child: AnimatedScale(
            scale: isSelected ? 1.6 : 1.0,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutBack,
            child: SizedBox(
              width: 40.w,
              height: 40.w,
              child: Container(
                decoration: BoxDecoration(
                  color: markerColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: markerColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(markerIcon, color: Colors.white, size: 16.sp),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
