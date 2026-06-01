import 'dart:async';
import 'dart:math';

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
import '../../../../core/permissions/permission_request_coordinator.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/donations_bloc.dart';
import '../bloc/donations_event.dart';
import '../bloc/donations_state.dart';
import '../../domain/entities/donation.dart';
import '../../../../shared/widgets/notification_button.dart';

class DonationsHomePage extends StatefulWidget {
  const DonationsHomePage({super.key});

  @override
  State<DonationsHomePage> createState() => _DonationsHomePageState();
}

class _DonationsHomePageState extends State<DonationsHomePage> {
  final DonationsBloc _donationsBloc = getIt<DonationsBloc>();
  final TextEditingController _searchController = TextEditingController();

  MapLibreMapController? _mapController;
  late String _currentStyleUrl;
  late StreamSubscription<ThemeMode> _themeSubscription;
  CameraPosition _cameraPosition = MapConfig.cameraPosition();
  Timer? _cameraDebounce;
  String _lastMarkerSignature = '';

  List<Donation> _mapDonations = const [];
  bool _loadingCurrentLocation = false;

  @override
  void initState() {
    super.initState();
    _currentStyleUrl = MapConfig.styleUrl; // Default light style
    _determinePosition();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentStyleUrl = _getStyleUrl(context);
    _themeSubscription = context.read<ThemeCubit>().stream.listen((_) {
      _updateMapStyle();
    });
  }

  String _getStyleUrl(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return MapConfig.getStyleUrl(brightness);
  }

  Future<void> _updateMapStyle() async {
    final newUrl = _getStyleUrl(context);
    if (newUrl != _currentStyleUrl) {
      setState(() {
        _currentStyleUrl = newUrl;
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _cameraDebounce?.cancel();
    _themeSubscription.cancel();
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
        permission = await PermissionRequestCoordinator.runLocationRequest(
          Geolocator.requestPermission,
        );
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
    if (_donationsBloc.state is DonationsLoading) return;
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

    print("SYNCING ${donations.length} MARKERS");

    await MapMarkerUtils.registerDonationMarkers(
      donations: donations,
      controller: controller,
      context: context,
      l10n: AppLocalizations.of(context),
    );
  }

  void _selectDonationFromSymbol(Symbol symbol) {
    debugPrint("SYMBOL TAPPED: ${symbol.data}");
    final rawData = symbol.data;
    final donationId = rawData is Map
        ? rawData['donationId']?.toString()
        : null;
    if (donationId == null || donationId.isEmpty) return;
    
    Donation? donation;
    try {
      donation = _mapDonations.firstWhere(
        (item) => item.id == donationId,
      );
    } catch (_) {
      // Fallback if not found in filtered list
    }

    if (donation != null) {
      context.push(AppRoutes.donationDetails, extra: donation);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return BlocProvider.value(
      value: _donationsBloc,
      child: Scaffold(
        backgroundColor: colors.background,
        body: BlocBuilder<DonationsBloc, DonationsState>(
          builder: (context, state) {
            final donations = state is DonationsLoaded
                ? state.donations
                : _mapDonations;
            _mapDonations = _applySearch(donations);

            _scheduleMarkersSync(_mapDonations);

            return Stack(
              children: [
                Positioned.fill(
                    child: MapLibreMap(
                      styleString: _currentStyleUrl,
                      initialCameraPosition: _cameraPosition,
                      trackCameraPosition: true,
                      onMapCreated: (controller) {
                        _mapController = controller;
                        controller.addListener(() {
                          _cameraPosition =
                              controller.cameraPosition ?? _cameraPosition;
                        });
                        // Use onSymbolTapped on the controller
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
                    backgroundColor: colors.surface,
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
                            color: colors.primary,
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
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    final colors = context.themeColors;
    final l10n = AppLocalizations.of(context);

    return Hero(
      tag: 'search_bar',
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
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
          readOnly: true,
          onTap: () {
            context.go('/browse?focus=true');
          },
          decoration: InputDecoration(
            hintText: l10n.browseSearchHint,
            prefixIcon: const Icon(AppIcons.search),
            border: InputBorder.none,
            suffixIcon: const NotificationButton(compact: true),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCard() {
    final colors = context.themeColors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colors.surface,
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
          Icon(AppIcons.explore, color: colors.primary, size: 20.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "No donations found in this area.",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _bottomNavBaseInset(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom + 56.h;
  }

  double _bottomCardOffset(BuildContext context) {
    return _bottomNavBaseInset(context);
  }

  double _fabBottomOffset(BuildContext context) {
    return _bottomNavBaseInset(context) + 84.h;
  }
}
