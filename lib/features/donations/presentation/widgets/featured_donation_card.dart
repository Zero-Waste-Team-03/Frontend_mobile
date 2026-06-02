import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/donation.dart';
import 'donation_card_utils.dart';

class FeaturedDonationCard extends StatelessWidget {
  final Donation donation;
  final double? userLatitude;
  final double? userLongitude;
  final VoidCallback onTap;

  const FeaturedDonationCard({
    super.key,
    required this.donation,
    required this.userLatitude,
    required this.userLongitude,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.themeColors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300.w,
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(18.r),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: donation.imageUrl,
                    width: 300.w,
                    height: 128.h,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(
                      width: 300.w,
                      height: 128.h,
                      color: colors.divider,
                    ),
                  ),
                ),
                Positioned(
                  left: 10.w,
                  top: 10.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.textPrimary.withValues(alpha: 0.72),
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          AppIcons.distance,
                          size: 12.sp,
                          color: colors.onPrimary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          localizedDistance(
                            context,
                            donation,
                            userLatitude,
                            userLongitude,
                          ),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: colors.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 10.w,
                  top: 10.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(999.r),
                    ),
                    child: Text(
                      l10n.featuredBadge,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if (donation.status != 'PUBLISHED' &&
                    donation.status != 'DRAFT')
                  Positioned(
                    left: 10.w,
                    bottom: 10.h,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusBackgroundColor(donation.status, context),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        localizedStatusLabel(context, donation.status),
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: statusTextColor(donation.status, context),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    donation.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          donationAuthorLabel(context, donation),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: colors.textSecondary,
                          ),
                        ),
                      ),
                      if (donation.authorDetails?.isVerified == true) ...[
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.verified_rounded,
                          size: 12.sp,
                          color: colors.primary,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        AppIcons.quantity,
                        size: 14.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        l10n.donationCardQuantity(donation.quantity),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: colors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(
                        AppIcons.expiry,
                        size: 14.sp,
                        color: colors.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          localizedExpiryLabel(context, donation.expiryDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: colors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
