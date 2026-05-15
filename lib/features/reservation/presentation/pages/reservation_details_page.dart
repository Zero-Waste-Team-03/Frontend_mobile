import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/features/auth/data/models/user_model.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../../../../core/map/map_config.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../donations/domain/entities/donation.dart';
import '../../domain/entities/reservation.dart';
import '../bloc/reservation_bloc.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_state.dart';
import '../widgets/reservation_timeline.dart';
import '../widgets/user_contact_card.dart';

class ReservationDetailsPage extends StatefulWidget {
  final String reservationId;

  const ReservationDetailsPage({super.key, required this.reservationId});

  @override
  State<ReservationDetailsPage> createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch reservation details
    context.read<ReservationBloc>().add(
      FetchReservationDetailsEvent(widget.reservationId),
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusLarge,
            ),
          ),
          icon: Icon(
            Icons.error_outline_rounded,
            color: Colors.red,
            size: 48.sp,
          ),
          title: Text(
            'Error',
            style: TextStyle(
              fontSize: AppDimensions.headingSize.sp,
              fontWeight: FontWeight.w600,
              color: AuthColors.headingText,
              fontFamily: AppFonts.primaryFont,
            ),
          ),
          content: Text(
            errorMessage,
            style: TextStyle(
              fontSize: AppDimensions.bodySize.sp,
              color: AuthColors.subText,
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
              style: TextButton.styleFrom(foregroundColor: AuthColors.primary),
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
                backgroundColor: AuthColors.primary,
                foregroundColor: Colors.white,
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
          'Collection Status',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            fontWeight: FontWeight.bold,
            color: AuthColors.headingText,
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
          },
          child: BlocBuilder<ReservationBloc, ReservationState>(
            builder: (context, state) {
              if (state is ReservationDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(color: AuthColors.primary),
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusMedium,
                            ),
                            border: Border.all(color: AuthColors.dividerColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pickup Location',
                                style: TextStyle(
                                  fontSize: AppDimensions.bodySize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AuthColors.labelText,
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
                                  color: AuthColors.headingText,
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
                                    color: AuthColors.subText,
                                    fontFamily: AppFonts.primaryFont,
                                  ),
                                ),
                              SizedBox(height: AppDimensions.paddingMedium.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      onPressed: () {
                                        // Navigate to maps
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
                                          color: AuthColors.primary,
                                          width: 1.5,
                                        ),
                                        foregroundColor: AuthColors.primary,
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
                                          color: AuthColors.primary,
                                          width: 1.5,
                                        ),
                                        foregroundColor: AuthColors.primary,
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Call feature coming soon'),
                                backgroundColor: AuthColors.primary,
                              ),
                            );
                          },
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
                              backgroundColor: AuthColors.primary,
                              foregroundColor: Colors.white,
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

class _LocationMapCard extends StatelessWidget {
  final Donation donation;

  const _LocationMapCard({required this.donation});

  @override
  Widget build(BuildContext context) {
    final hasLocation = donation.latitude != null && donation.longitude != null;
    final target = hasLocation
        ? LatLng(donation.latitude!, donation.longitude!)
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
              styleString: MapConfig.styleUrl,
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
