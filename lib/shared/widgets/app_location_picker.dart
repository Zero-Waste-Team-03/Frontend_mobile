import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../core/app_icons.dart';
import '../../core/map/map_config.dart';
import '../../core/permissions/permission_request_coordinator.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/theme_cubit.dart';
import '../../l10n/app_localizations.dart';

class AppLocationPicker extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;
  final ValueChanged<LatLng> onLocationConfirmed;

  const AppLocationPicker({
    super.key,
    required this.initialLatitude,
    required this.initialLongitude,
    required this.onLocationConfirmed,
  });

  @override
  State<AppLocationPicker> createState() => _AppLocationPickerState();
}

class _AppLocationPickerState extends State<AppLocationPicker>
    with SingleTickerProviderStateMixin {
  MapLibreMapController? _mapController;
  late CameraPosition _currentCamera;
  late String _currentStyleUrl;
  late StreamSubscription<ThemeMode> _themeSubscription;
  bool _locating = false;
  bool _isMapMoving = false;
  String? _currentAddress;
  bool _isLoadingAddress = false;

  late AnimationController _pinAnimController;
  late Animation<double> _pinScaleAnimation;
  late Animation<double> _pinShadowAnimation;

  Timer? _addressDebounce;

  @override
  void initState() {
    super.initState();
    final hasInitial =
        widget.initialLatitude != null && widget.initialLongitude != null;
    _currentCamera = MapConfig.cameraPosition(
      target: hasInitial
          ? LatLng(widget.initialLatitude!, widget.initialLongitude!)
          : MapConfig.defaultTarget,
      zoom: hasInitial ? 14 : MapConfig.defaultZoom,
    );
    _currentStyleUrl = MapConfig.styleUrl;

    _pinAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _pinScaleAnimation = Tween<double>(begin: 1.0, end: 1.18).animate(
      CurvedAnimation(
        parent: _pinAnimController,
        curve: Curves.easeInOut,
      ),
    );
    _pinShadowAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(
        parent: _pinAnimController,
        curve: Curves.easeInOut,
      ),
    );

    if (hasInitial) {
      _reverseGeocodeCurrentPosition();
    }
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
    _themeSubscription.cancel();
    _pinAnimController.dispose();
    _addressDebounce?.cancel();
    super.dispose();
  }

  Future<void> _reverseGeocodeCurrentPosition() async {
    if (_isLoadingAddress) return;
    setState(() => _isLoadingAddress = true);
    try {
      final target = _currentCamera.target;
      final placemarks = await placemarkFromCoordinates(
        target.latitude,
        target.longitude,
      );
      if (!mounted) return;
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = <String>[
          if (p.street != null && p.street!.isNotEmpty) p.street!,
          if (p.locality != null && p.locality!.isNotEmpty) p.locality!,
          if (p.country != null && p.country!.isNotEmpty) p.country!,
        ];
        setState(() => _currentAddress = parts.isNotEmpty ? parts.join(', ') : null);
      }
    } catch (_) {
      if (mounted) setState(() => _currentAddress = null);
    } finally {
      if (mounted) setState(() => _isLoadingAddress = false);
    }
  }

  void _onCameraChanged() {
    if (!_isMapMoving) {
      setState(() => _isMapMoving = true);
      _pinAnimController.forward();
    }
    _addressDebounce?.cancel();
    _addressDebounce = Timer(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      setState(() => _isMapMoving = false);
      _pinAnimController.reverse();
      final cameraPosition = _mapController?.cameraPosition;
      if (cameraPosition != null) {
        _currentCamera = cameraPosition;
        _reverseGeocodeCurrentPosition();
      }
    });
  }

  Future<void> _goToUserLocation() async {
    final l10n = AppLocalizations.of(context);

    setState(() => _locating = true);

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await PermissionRequestCoordinator.runLocationRequest(
          Geolocator.requestPermission,
        );
      }

      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.mapLocationPermissionDenied)),
          );
        }
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.mapLocationPermissionDeniedForever)),
          );
        }
        return;
      }

      final position = await Geolocator.getCurrentPosition();
      final camera = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 15,
      );
      _currentCamera = camera;
      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(camera),
      );
    } finally {
      if (mounted) {
        setState(() => _locating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
        Text(
          l10n.addDonationLocationSubtitle,
          style: TextStyle(fontSize: 13.sp, color: colors.textSecondary),
        ),
        SizedBox(height: 10.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: SizedBox(
            height: 280.h,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                MapLibreMap(
                  styleString: _currentStyleUrl,
                  initialCameraPosition: _currentCamera,
                  trackCameraPosition: true,
                  onMapCreated: (controller) {
                    _mapController = controller;
                    controller.addListener(_onCameraChanged);
                  },
                  compassEnabled: false,
                  attributionButtonMargins: Point<double>(12.w, 12.h),
                  myLocationEnabled: true,
                  myLocationTrackingMode: MyLocationTrackingMode.none,
                ),
                AnimatedBuilder(
                  animation: _pinAnimController,
                  builder: (context, child) {
                    final scale = _pinScaleAnimation.value;
                    final shadowScale = _pinShadowAnimation.value;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.scale(
                          scale: scale,
                          child: Container(
                            width: 48.w,
                            height: 48.w,
                            decoration: BoxDecoration(
                              color: colors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: colors.primary.withValues(alpha: 0.3),
                                  blurRadius: 8 * shadowScale,
                                  spreadRadius: 1 * (shadowScale - 1) + 1,
                                  offset: Offset(0, 2 * shadowScale),
                                ),
                              ],
                            ),
                            child: Icon(
                              AppIcons.locationPin,
                              size: 26.sp,
                              color: colors.onPrimary,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _isMapMoving ? 0.0 : 0.8,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            width: 6.w,
                            height: 6.w,
                            decoration: BoxDecoration(
                              color: colors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: colors.primary.withValues(alpha: 0.5),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                if (_isLoadingAddress)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 12.w,
                            height: 12.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              color: colors.primary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              'Getting address...',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: colors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (_currentAddress != null && !_isMapMoving && !_isLoadingAddress)
                  Positioned(
                    top: 8.h,
                    left: 8.w,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: colors.surface.withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            AppIcons.location,
                            size: 14.sp,
                            color: colors.primary,
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: Text(
                              _currentAddress!,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: colors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Positioned(
                  right: 10.w,
                  bottom: 10.h,
                  child: FloatingActionButton.small(
                    heroTag: null,
                    backgroundColor: colors.surface,
                    foregroundColor: colors.primary,
                    onPressed: _locating ? null : _goToUserLocation,
                    child: _locating
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: colors.primary,
                            ),
                          )
                        : Icon(AppIcons.currentLocation, size: 18.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          '${_currentCamera.target.latitude.toStringAsFixed(4)}, ${_currentCamera.target.longitude.toStringAsFixed(4)}',
          style: TextStyle(
            fontSize: 11.sp,
            color: colors.textMuted,
            fontFamily: 'monospace',
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          l10n.addDonationLocationInstruction,
          style: TextStyle(fontSize: 12.sp, color: colors.textTertiary),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.primary,
              foregroundColor: colors.onPrimary,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: () {
              widget.onLocationConfirmed(_currentCamera.target);
            },
            icon: Icon(AppIcons.check, size: 18.sp),
            label: Text(l10n.addDonationLocationConfirm),
          ),
        ),
      ],
    );
  }
}
