import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/features/auth/data/models/user_model.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../../../../core/map/map_config.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../donations/domain/entities/donation.dart';
import '../../domain/entities/reservation.dart';
import '../bloc/reservation_bloc.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_state.dart';
import '../widgets/reservation_timeline.dart';
import '../widgets/user_contact_card.dart';
import 'package:gaspzero/shared/navigator/navigator.dart';

class ReservationDetailsPage extends StatefulWidget {
  final String reservationId;

  const ReservationDetailsPage({super.key, required this.reservationId});

  @override
  State<ReservationDetailsPage> createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  late String _currentStyleUrl;
  late StreamSubscription<ThemeMode> _themeSubscription;

  @override
  void initState() {
    super.initState();
    _currentStyleUrl = MapConfig.styleUrl; // Default light style
    // Fetch reservation details
    context.read<ReservationBloc>().add(
      FetchReservationDetailsEvent(widget.reservationId),
    );
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
    super.dispose();
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    final colors = context.themeColors;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: colors.surface,
          surfaceTintColor: colors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusLarge,
            ),
          ),
          icon: Icon(
            Icons.error_outline_rounded,
            color: colors.error,
            size: 48.sp,
          ),
          title: Text(
            'Error',
            style: TextStyle(
              fontSize: AppDimensions.headingSize.sp,
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
              fontFamily: AppFonts.primaryFont,
            ),
          ),
          content: Text(
            errorMessage,
            style: TextStyle(
              fontSize: AppDimensions.bodySize.sp,
              color: colors.textSecondary,
              fontFamily: AppFonts.primaryFont,
              height: 1.5,
            ),
          ),
          actionsAlignment: MainAxisAlignment.end,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.pop(); // Pop the reservation details page
              },
              style: TextButton.styleFrom(foregroundColor: colors.primary),
              child: Text(
                'Back',
                style: TextStyle(
                  fontSize: AppDimensions.bodySize.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                // Retry fetching reservation
                context.read<ReservationBloc>().add(
                  FetchReservationDetailsEvent(widget.reservationId),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  fontSize: AppDimensions.bodySize.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Collection Status',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: colors.textPrimary,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocListener<ReservationBloc, ReservationState>(
          listener: (context, state) {
            if (state is ReservationDetailsError) {
              _showErrorDialog(context, state.message);
            }
            if (state is ReservationCancellationError) {
              _showErrorDialog(context, state.message);
            }
            if (state is ReservationCancelled) {
              // Pop the page after successful cancellation
              Future.delayed(const Duration(milliseconds: 500), () {
                context.pop();
              });
            }
          },
          child: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
              if (state is ReservationDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(color: colors.primary),
                );
              }

              if (state is ReservationDetailsLoaded) {
                final reservation = state.reservation;
                return SingleChildScrollView(
                  padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location Card
                      if (reservation.donation != null)
                        Container(
                          padding: EdgeInsets.all(
                            AppDimensions.paddingMedium.w,
                          ),
                          decoration: BoxDecoration(
                            color: colors.surface,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusMedium,
                            ),
                            border: Border.all(color: colors.divider),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pickup Location',
                                style: TextStyle(
                                  fontSize: AppDimensions.bodySize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textPrimary,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                              SizedBox(height: AppDimensions.paddingMedium.h),
                              _LocationMapCard(donation: reservation.donation!),
                              SizedBox(height: AppDimensions.paddingMedium.h),
                              Text(
                                reservation.donation!.title,
                                style: TextStyle(
                                  fontSize: AppDimensions.bodySize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textPrimary,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              if (reservation.donation!.latitude != null &&
                                  reservation.donation!.longitude != null)
                                Text(
                                  'Lat ${reservation.donation!.latitude!.toStringAsFixed(3)}, Lng ${reservation.donation!.longitude!.toStringAsFixed(3)}',
                                  style: TextStyle(
                                    fontSize: AppDimensions.captionSize.sp,
                                    color: colors.textSecondary,
                                    fontFamily: AppFonts.primaryFont,
                                  ),
                                ),
                              SizedBox(height: AppDimensions.paddingMedium.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        if (reservation.donation!.latitude !=
                                                null &&
                                            reservation.donation!.longitude !=
                                                null) {
                                          openNavigation(
                                            reservation.donation!.latitude!,
                                            reservation.donation!.longitude!,
                                          );
                                        } else {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Location data not available',
                                              ),
                                              backgroundColor: colors.error,
                                            ),
                                          );
                                        }
                                      },
                                      icon: Icon(Icons.navigation, size: 18.sp),
                                      label: Text(
                                        'Get Directions',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: AppDimensions.bodySize.sp,
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: colors.primary,
                                          width: 1.5,
                                        ),
                                        foregroundColor: colors.primary,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        context.push(
                                          '/donation-details',
                                          extra: reservation.donation,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.info_outline,
                                        size: 18.sp,
                                      ),
                                      label: Text(
                                        'View Donation',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: AppDimensions.bodySize.sp,
                                        ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: colors.primary,
                                          width: 1.5,
                                        ),
                                        foregroundColor: colors.primary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Timeline
                      ReservationTimeline(reservation: reservation),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Donor Contact Card
                      if (reservation.donation != null &&
                          reservation.donation!.authorDetails != null)
                        UserContactCard(
                          user:
                              reservation.donation?.authorDetails ??
                              const UserModel(
                                id: '0',
                                displayName: 'Unknown User',
                                phoneNumber: 'No phone number',
                              ),
                          title: 'Donor',
                          onChatPressed: () {
                            context.push('/chat', extra: reservation.id);
                          },
                          onCallPressed: () {
                            if (reservation.donation != null &&
                                reservation.donation!.authorDetails != null &&
                                reservation
                                        .donation!
                                        .authorDetails!
                                        .phoneNumber !=
                                    null) {
                              callPhoneNumber(
                                reservation
                                    .donation!
                                    .authorDetails!
                                    .phoneNumber!,
                              );
                            }
                          },
                        ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Cancel Button (Only for active reservations)
                      if (reservation.isActive)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Show confirmation dialog before cancelling
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    backgroundColor: colors.surface,
                                    surfaceTintColor: colors.surface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.borderRadiusLarge,
                                      ),
                                    ),
                                    title: Text(
                                      'Cancel Reservation?',
                                      style: TextStyle(
                                        fontSize: AppDimensions.subtitleSize.sp,
                                        fontWeight: FontWeight.w700,
                                        color: colors.headingText,
                                        fontFamily: AppFonts.primaryFont,
                                      ),
                                    ),
                                    content: Text(
                                      'Are you sure you want to cancel this reservation? This action cannot be undone.',
                                      style: TextStyle(
                                        fontSize: AppDimensions.bodySize.sp,
                                        color: colors.textSecondary,
                                        fontFamily: AppFonts.primaryFont,
                                      ),
                                    ),
                                    actionsAlignment: MainAxisAlignment.start,
                                    actions: [
                                      Center(
                                        child: TextButton(
                                          onPressed: () =>
                                              Navigator.pop(dialogContext),
                                          child: Text(
                                            'Keep Reservation',
                                            style: TextStyle(
                                              color: colors.primary,
                                              fontFamily: AppFonts.primaryFont,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(dialogContext);
                                          context.read<ReservationBloc>().add(
                                            CancelReservationEvent(
                                              reservationId: reservation.id,
                                            ),
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: const Text(
                                                'Reservation cancelled',
                                              ),
                                              backgroundColor: colors.primary,
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: colors.error,
                                        ),
                                        child: Text(
                                          'Cancel Reservation',
                                          style: TextStyle(
                                            color: colors.onPrimary,
                                            fontFamily: AppFonts.primaryFont,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.cancel_outlined, size: 20.sp),
                            label: Text(
                              'Cancel Reservation',
                              style: TextStyle(
                                fontSize: AppDimensions.buttonTextSize.sp,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.error.withValues(
                                alpha: 0.12,
                              ),
                              foregroundColor: colors.error,
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimensions.paddingMedium.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Mark as Picked Up Button
                      if (reservation.status == ReservationStatus.confirmed)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.read<ReservationBloc>().add(
                                UpdateReservationStatusEvent(
                                  reservationId: reservation.id,
                                  newStatus: 'PICKED_UP',
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Marked as picked up!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                            icon: Icon(Icons.check_circle, size: 20.sp),
                            label: Text(
                              'Mark as Picked Up',
                              style: TextStyle(
                                fontSize: AppDimensions.buttonTextSize.sp,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colors.primary,
                              foregroundColor: colors.onPrimary,
                              padding: EdgeInsets.symmetric(
                                vertical: AppDimensions.paddingMedium.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadiusLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _LocationMapCard extends StatefulWidget {
  final Donation donation;

  const _LocationMapCard({required this.donation});

  @override
  State<_LocationMapCard> createState() => _LocationMapCardState();
}

class _LocationMapCardState extends State<_LocationMapCard> {
  late String _currentStyleUrl;
  late StreamSubscription<ThemeMode> _themeSubscription;

  @override
  void initState() {
    super.initState();
    _currentStyleUrl = MapConfig.styleUrl; // Default light style
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

  void _updateMapStyle() {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasLocation =
        widget.donation.latitude != null && widget.donation.longitude != null;
    final target = hasLocation
        ? LatLng(widget.donation.latitude!, widget.donation.longitude!)
        : MapConfig.defaultTarget;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        height: 120.h,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            MapLibreMap(
              styleString: _currentStyleUrl,
              initialCameraPosition: MapConfig.cameraPosition(
                target: target,
                zoom: hasLocation ? 14 : MapConfig.defaultZoom,
              ),
              compassEnabled: false,
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              tiltGesturesEnabled: false,
              attributionButtonMargins: Point<double>(12.w, 12.h),
            ),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.location_on,
                color: AuthColors.primary,
                size: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
