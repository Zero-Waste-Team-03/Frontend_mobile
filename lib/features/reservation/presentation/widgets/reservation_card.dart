import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../domain/entities/reservation.dart';

class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback onTap;

  const ReservationCard({
    super.key,
    required this.reservation,
    required this.onTap,
  });

  String _getReservationStatusLabel(ReservationStatus status) {
    return status.displayName;
  }

  Color _getReservationStatusBackground(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return const Color(0xFFFFF3CD); // Light yellow
      case ReservationStatus.confirmed:
        return const Color(0xFFD1ECF1); // Light blue
      case ReservationStatus.completed:
        return const Color(0xFFD4EDDA); // Light green
      case ReservationStatus.cancelled:
        return const Color(0xFFF8D7DA); // Light red
    }
  }

  Color _getReservationStatusText(ReservationStatus status) {
    switch (status) {
      case ReservationStatus.pending:
        return const Color(0xFF856404); // Dark yellow
      case ReservationStatus.confirmed:
        return const Color(0xFF0C5460); // Dark blue
      case ReservationStatus.completed:
        return const Color(0xFF155724); // Dark green
      case ReservationStatus.cancelled:
        return const Color(0xFF721C24); // Dark red
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Validate if URL is a valid HTTP(S) URL
  bool _isValidUrl(String url) {
    if (url.isEmpty) {
      return false;
    }
    return url.startsWith('http://') || url.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final donation = reservation.donation;
    final donationTitle = donation?.title ?? 'Donation';
    final imageUrl = donation?.imageUrl ?? '';

    // Debug logging
    print('[ReservationCard] Building card for reservation: ${reservation.id}');
    print('[ReservationCard] Donation ID: ${donation?.id}');
    print('[ReservationCard] Donation Title: $donationTitle');
    print('[ReservationCard] Image URL: $imageUrl');
    print('[ReservationCard] Image URL is valid: ${_isValidUrl(imageUrl)}');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium.w,
          vertical: AppDimensions.paddingSmall.h,
        ),
        padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          border: Border.all(color: AuthColors.dividerColor, width: 1),
        ),
        child: Row(
          children: [
            // Image from mainAttachment URL
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusMedium,
                ),
                color: AuthColors.lightGrayBackground,
              ),
              child: _isValidUrl(imageUrl)
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: AuthColors.primary,
                        ),
                      ),
                      errorWidget: (context, url, error) {
                        print(
                          '[ReservationCard] Image load error for URL "$imageUrl": $error',
                        );
                        return Container(
                          color: AuthColors.lightGrayBackground,
                          child: Icon(
                            Icons.image_not_supported,
                            color: AuthColors.inputText,
                          ),
                        );
                      },
                    )
                  : Icon(
                      Icons.image_not_supported,
                      color: AuthColors.inputText,
                    ),
            ),
            SizedBox(width: AppDimensions.paddingMedium.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Donation Title
                  Text(
                    donationTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppDimensions.subtitleSize.sp,
                      fontWeight: FontWeight.bold,
                      color: AuthColors.headingText,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSmall.h),

                  // Reservation Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14.sp,
                        color: AuthColors.subText,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatDate(reservation.createdAt),
                        style: TextStyle(
                          fontSize: AppDimensions.bodySize.sp,
                          color: AuthColors.subText,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: AppDimensions.paddingSmall.w),

            // Reservation Status Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium.w,
                vertical: AppDimensions.paddingSmall.h,
              ),
              decoration: BoxDecoration(
                color: _getReservationStatusBackground(reservation.status),
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusMedium,
                ),
              ),
              child: Text(
                _getReservationStatusLabel(reservation.status),
                style: TextStyle(
                  fontSize: AppDimensions.bodySize.sp,
                  fontWeight: FontWeight.w600,
                  color: _getReservationStatusText(reservation.status),
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
