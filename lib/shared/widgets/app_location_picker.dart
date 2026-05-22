import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../core/app_icons.dart';
import '../../core/map/map_config.dart';
import '../../core/permissions/permission_request_coordinator.dart';
import '../../core/theme/app_colors.dart';
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

class _AppLocationPickerState extends State<AppLocationPicker> {
  MapLibreMapController? _mapController;
  late CameraPosition _currentCamera;
  bool _locating = false;

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
  }

  Future<void> _goToUserLocation() async {
    final l10n = AppLocalizations.of(context);

    setState(() {
      _locating = true;
    });

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
        setState(() {
          _locating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.addDonationLocationSubtitle,
          style: TextStyle(fontSize: 13.sp, color: AppColors.textSecondary),
        ),
        SizedBox(height: 10.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: SizedBox(
            height: 220.h,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                MapLibreMap(
                  styleString: MapConfig.styleUrl,
                  initialCameraPosition: _currentCamera,
                  trackCameraPosition: true,
                  onMapCreated: (controller) {
                    _mapController = controller;
                    controller.addListener(() {
                      _currentCamera =
                          controller.cameraPosition ?? _currentCamera;
                    });
                  },
                  onCameraIdle: () async {
                    final cameraPosition = _mapController?.cameraPosition;
                    if (cameraPosition != null) {
                      _currentCamera = cameraPosition;
                    }
                  },
                  compassEnabled: false,
                  attributionButtonMargins: Point<double>(12.w, 12.h),
                  myLocationEnabled: true,
                  myLocationTrackingMode: MyLocationTrackingMode.none,
                ),
                IgnorePointer(
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      AppIcons.locationPin,
                      size: 24.sp,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                Positioned(
                  right: 10.w,
                  bottom: 10.h,
                  child: FloatingActionButton.small(
                    heroTag: null,
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    onPressed: _locating ? null : _goToUserLocation,
                    child: _locating
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
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
          l10n.addDonationLocationInstruction,
          style: TextStyle(fontSize: 12.sp, color: AppColors.textTertiary),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
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
