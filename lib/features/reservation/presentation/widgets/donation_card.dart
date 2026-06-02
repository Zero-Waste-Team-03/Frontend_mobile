import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../donations/domain/entities/donation.dart';
import 'status_badge.dart';

class DonationCard extends StatelessWidget {
  final Donation donation;
  final VoidCallback onTap;
  final String imageUrl;

  const DonationCard({
    super.key,
    required this.donation,
    required this.onTap,
    String? imageUrl,
  }) : imageUrl = imageUrl ?? '';

  String _getStatusLabel(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
      case 'PUBLISHED':
        return 'Active';
      case 'RESERVED':
        return 'Reserved';
      case 'COMPLETED':
        return 'Completed';
      case 'EXPIRED':
      case 'DRAFT':
        return 'Expired';
      case 'REJECTED':
        return 'Rejected';
      case 'PENDING_APPROVAL':
        return 'Pending';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final imageToUse = donation.imageUrl;
    final createdAtLabel = donation.createdAt != null
        ? donation.createdAt!.toLocal().toString().split(' ')[0]
        : 'N/A';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium.w,
          vertical: AppDimensions.paddingSmall.h,
        ),
        padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          border: Border.all(color: colors.divider, width: 1),
        ),
        child: Row(
          children: [
            // Image
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppDimensions.borderRadiusMedium,
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(imageToUse),
                  fit: BoxFit.cover,
                  onError: (_, __) {
                    // Fallback if image fails to load
                  },
                ),
              ),
              child: imageToUse.isEmpty
                  ? Container(
                      color: colors.lightGrayBackground,
                      child: Icon(
                        Icons.image_not_supported,
                        color: colors.textMuted,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: AppDimensions.paddingMedium.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    donation.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppDimensions.subtitleSize.sp,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                  SizedBox(height: AppDimensions.paddingSmall.h),

                  // Date
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        createdAtLabel,
                        style: TextStyle(
                          fontSize: AppDimensions.bodySize.sp,
                          color: colors.textSecondary,
                          fontFamily: AppFonts.primaryFont,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: AppDimensions.paddingSmall.w),

            // Status Badge
            StatusBadge(
              status: donation.status,
              label: _getStatusLabel(donation.status),
            ),
          ],
        ),
      ),
    );
  }
}
