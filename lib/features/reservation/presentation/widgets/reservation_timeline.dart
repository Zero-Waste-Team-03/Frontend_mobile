import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../domain/entities/reservation.dart';

class ReservationTimeline extends StatelessWidget {
  final Reservation reservation;

  const ReservationTimeline({super.key, required this.reservation});

  bool get isReserved => reservation.status == ReservationStatus.confirmed;
  bool get isConfirmed =>
      reservation.status == ReservationStatus.confirmed;
  bool get isPickedUp => reservation.status == ReservationStatus.completed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ORDER PROGRESS',
          style: TextStyle(
            fontSize: AppDimensions.captionSize.sp,
            fontWeight: FontWeight.w700,
            color: AuthColors.labelText,
            fontFamily: AppFonts.primaryFont,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: AppDimensions.paddingMedium.h),

        // Timeline Items
        _TimelineItem(
          title: 'Reserved',
          checked: true,
          time: _formatTime(reservation.createdAt),
          isLast: false,
        ),
        _TimelineItem(
          title: 'Confirmed',
          checked: isConfirmed || isPickedUp,
          time: isConfirmed
              ? _formatTime(reservation.confirmedAt ?? DateTime.now())
              : 'Waiting for your arrival',
          isLast: false,
        ),
        _TimelineItem(
          title: 'Picked up',
          checked: isPickedUp,
          time: isPickedUp
              ? _formatTime(reservation.pickedUpAt ?? DateTime.now())
              : 'Step pending',
          isLast: true,
        ),
      ],
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return 'Done at ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')} PM';
  }
}

enum TimelineStatus { pending, completed }

class _TimelineItem extends StatelessWidget {
  final String title;
  final bool checked;
  final String time;
  final bool isLast;

  const _TimelineItem({
    required this.title,
    required this.checked,
    required this.time,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline dot
        Column(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: checked
                    ? AuthColors.primary
                    : AuthColors.dividerColor,
                border: Border.all(
                  color: checked
                      ? AuthColors.primary
                      : AuthColors.dividerColor,
                  width: 2,
                ),
              ),
              child: checked
                  ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2.w,
                height: 40.h,
                color: AuthColors.dividerColor,
              ),
          ],
        ),
        SizedBox(width: AppDimensions.paddingMedium.w),

        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: AppDimensions.bodySize.sp,
                    fontWeight: FontWeight.w600,
                    color: AuthColors.headingText,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: AppDimensions.captionSize.sp,
                    color: AuthColors.subText,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
