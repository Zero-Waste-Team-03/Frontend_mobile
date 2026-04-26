import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../../core/app_icons.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/map/map_config.dart';
import '../../../../core/map/map_marker_utils.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/donations_bloc.dart';
import '../bloc/donations_event.dart';
import '../bloc/donations_state.dart';
import '../../domain/entities/donation.dart';

class DonationsHomePage extends StatefulWidget {
  const DonationsHomePage({super.key});

  @override
  State<DonationsHomePage> createState() => _DonationsHomePageState();
}

class _DonationsHomePageState extends State<DonationsHomePage> {
  final DonationsBloc _donationsBloc = getIt<DonationsBloc>();
  final TextEditingController _searchController = TextEditingController();

  MapLibreMapController? _mapController;
  CameraPosition _cameraPosition = MapConfig.cameraPosition();
  Timer? _cameraDebounce;
  String _lastMarkerSignature = '';

  List<Donation> _mapDonations = const [];
  Donation? _selectedDonation;
  bool _loadingCurrentLocation = false;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  void dispose() {
    _cameraDebounce?.cancel();
    _searchController.dispose();
    _donationsBloc.close();
    super.dispose();
  }

  Future<void> _determinePosition() async {
    setState(() {
      _loadingCurrentLocation = true;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _loadInitialDonations();
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _loadInitialDonations();
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      _cameraPosition = MapConfig.cameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15.0,
      );

      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(_cameraPosition),
      );
      _fetchDonationsAround(_cameraPosition.target, radiusKm: 10);
    } catch (_) {
      _loadInitialDonations();
    } finally {
      if (mounted) {
        setState(() {
          _loadingCurrentLocation = false;
        });
      }
    }
  }

  void _loadInitialDonations() {
    _fetchDonationsAround(_cameraPosition.target, radiusKm: 10);
  }

  void _fetchDonationsAround(LatLng center, {double radiusKm = 10}) {
    _donationsBloc.add(
      LoadDonationsEvent(
        searchQuery: _searchController.text,
        latitude: center.latitude,
        longitude: center.longitude,
        radius: radiusKm,
      ),
    );
  }

  List<Donation> _applySearch(List<Donation> donations) {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      return donations;
    }

    return donations
        .where(
          (donation) =>
              donation.title.toLowerCase().contains(query) ||
              donation.description.toLowerCase().contains(query),
        )
        .toList();
  }

  String _markerSignature(List<Donation> donations) {
    final withCoordinates = donations
        .where((d) => d.latitude != null && d.longitude != null)
        .toList();
    return withCoordinates
        .map(
          (d) =>
              '${d.id}_${d.latitude}_${d.longitude}_${d.urgency ?? d.condition}',
        )
        .join('|');
  }

  void _scheduleMarkersSync(List<Donation> donations) {
    final signature = _markerSignature(donations);
    if (signature == _lastMarkerSignature) {
      return;
    }
    _lastMarkerSignature = signature;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _syncMarkers(donations);
    });
  }

  Future<void> _syncMarkers(List<Donation> donations) async {
    final controller = _mapController;
    if (controller == null) return;

    await MapMarkerUtils.registerDonationMarkers(
      donations: donations,
      controller: controller,
      context: context,
      l10n: AppLocalizations.of(context),
    );
  }

  void _selectDonationFromSymbol(Symbol symbol) {
    final rawData = symbol.data;
    final donationId = rawData is Map
        ? rawData['donationId']?.toString()
        : null;
    if (donationId == null || donationId.isEmpty) return;
    if (_mapDonations.isEmpty) return;

    final donation = _mapDonations.firstWhere(
      (item) => item.id == donationId,
      orElse: () => _selectedDonation ?? _mapDonations.first,
    );

    setState(() {
      _selectedDonation = donation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _donationsBloc,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: BlocBuilder<DonationsBloc, DonationsState>(
          builder: (context, state) {
            final donations = state is DonationsLoaded
                ? state.donations
                : const <Donation>[];
            _mapDonations = _applySearch(donations);

            if (_selectedDonation != null &&
                !_mapDonations.any(
                  (element) => element.id == _selectedDonation!.id,
                )) {
              _selectedDonation = null;
            }

            _scheduleMarkersSync(_mapDonations);

            return Stack(
              children: [
                Positioned.fill(
                  child: MapLibreMap(
                    styleString: MapConfig.styleUrl,
                    initialCameraPosition: _cameraPosition,
                    trackCameraPosition: true,
                    onMapCreated: (controller) {
                      _mapController = controller;
                      controller.addListener(() {
                        _cameraPosition =
                            controller.cameraPosition ?? _cameraPosition;
                      });
                      controller.onSymbolTapped.add(_selectDonationFromSymbol);
                    },
                    onStyleLoadedCallback: () {
                      _lastMarkerSignature = '';
                      _syncMarkers(_mapDonations);
                    },
                    onCameraIdle: () {
                      _cameraDebounce?.cancel();
                      _cameraDebounce = Timer(
                        const Duration(milliseconds: 500),
                        () {
                          _fetchDonationsAround(
                            _cameraPosition.target,
                            radiusKm: 10,
                          );
                        },
                      );
                    },
                    myLocationEnabled: true,
                    myLocationTrackingMode: MyLocationTrackingMode.none,
                    compassEnabled: false,
                    attributionButtonMargins: Point<double>(12.w, 12.h),
                  ),
                ),
                Positioned(
                  left: 12.w,
                  right: 12.w,
                  top: MediaQuery.paddingOf(context).top + 8.h,
                  child: _buildSearchBar(),
                ),
                Positioned(
                  right: 16.w,
                  bottom: _fabBottomOffset(context),
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.white,
                    onPressed: _loadingCurrentLocation
                        ? null
                        : _determinePosition,
                    child: _loadingCurrentLocation
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            AppIcons.currentLocation,
                            color: AppColors.primary,
                            size: 18.sp,
                          ),
                  ),
                ),
                Positioned(
                  left: 12.w,
                  right: 12.w,
                  bottom: _bottomCardOffset(context),
                  child: donations.isEmpty
                      ? _buildBottomCard()
                      : const SizedBox.shrink(),
                ),
                if (_selectedDonation != null)
                  Positioned(
                    left: 12.w,
                    right: 12.w,
                    bottom: _selectedCardOffset(context),
                    child: _buildSelectedDonationCard(_selectedDonation!),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    final l10n = AppLocalizations.of(context);

    return Container(
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
      child: TextField(
        controller: _searchController,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: l10n.browseSearchHint,
          prefixIcon: const Icon(AppIcons.search),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(AppIcons.notifications),
            onPressed: () {
              context.push(AppRoutes.notifications);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(AppIcons.explore, color: AppColors.primary, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "No donations found in this area.",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedDonationCard(Donation donation) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.donationDetails, extra: donation);
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: donation.imageUrl,
                width: 58.w,
                height: 58.w,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  width: 58.w,
                  height: 58.w,
                  color: const Color(0xFFE2E8F0),
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
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    donation.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _bottomNavBaseInset(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom + 56.h;
  }

  double _bottomCardOffset(BuildContext context) {
    return _bottomNavBaseInset(context);
  }

  double _selectedCardOffset(BuildContext context) {
    return _bottomNavBaseInset(context);
  }

  double _fabBottomOffset(BuildContext context) {
    final base = _bottomNavBaseInset(context);
    return _selectedDonation == null ? base + 84.h : base + 84.h;
  }
}
