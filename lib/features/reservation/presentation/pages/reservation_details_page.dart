import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/reservation.dart';
import '../bloc/reservation_bloc.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_state.dart';
import '../widgets/reservation_timeline.dart';
import '../widgets/user_contact_card.dart';

class ReservationDetailsPage extends StatefulWidget {
  final String donationId;

  const ReservationDetailsPage({super.key, required this.donationId});

  @override
  State<ReservationDetailsPage> createState() => _ReservationDetailsPageState();
}

class _ReservationDetailsPageState extends State<ReservationDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch reservation details
    context.read<ReservationBloc>().add(
      FetchReservationDetailsEvent('res-${widget.donationId}'),
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
        child: BlocBuilder<ReservationBloc, ReservationState>(
          builder: (context, state) {
            if (state is ReservationDetailsLoading) {
              return Center(
                child: CircularProgressIndicator(color: AuthColors.primary),
              );
            }

            if (state is ReservationDetailsError) {
              return Center(child: Text(state.message));
            }

            if (state is ReservationDetailsLoaded) {
              final reservation = state.reservation;

              return SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Location Card
                    Container(
                      padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
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
                          Container(
                            width: double.infinity,
                            height: 150.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppDimensions.borderRadiusMedium,
                              ),
                              color: AuthColors.lightGrayBackground,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.location_on_outlined,
                                size: 48.sp,
                                color: AuthColors.primary,
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.paddingMedium.h),
                          Text(
                            'Green Grocer Central',
                            style: TextStyle(
                              fontSize: AppDimensions.bodySize.sp,
                              fontWeight: FontWeight.w600,
                              color: AuthColors.headingText,
                              fontFamily: AppFonts.primaryFont,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '123 Eco Avenue, Sustainability District',
                            style: TextStyle(
                              fontSize: AppDimensions.captionSize.sp,
                              color: AuthColors.subText,
                              fontFamily: AppFonts.primaryFont,
                            ),
                          ),
                          SizedBox(height: AppDimensions.paddingMedium.h),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Navigate to maps
                              },
                              icon: Icon(Icons.navigation, size: 18.sp),
                              label: Text(
                                'Get Directions',
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
                    ),
                    SizedBox(height: AppDimensions.paddingLarge.h),

                    // Timeline
                    ReservationTimeline(reservation: reservation),
                    SizedBox(height: AppDimensions.paddingLarge.h),

                    // Donor Contact Card
                    if (reservation.donation?.author != null)
                      UserContactCard(
                        user:
                            reservation.beneficiary ??
                            const User(id: 'user-1', name: 'Marcus'),
                        title: 'Donor',
                        onChatPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Chat feature coming soon'),
                              backgroundColor: AuthColors.primary,
                            ),
                          );
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
    );
  }
}
