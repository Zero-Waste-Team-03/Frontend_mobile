import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../../../core/enums/donation_status_value.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/donation.dart';

double? donationDistanceKm(
  Donation donation,
  double? userLatitude,
  double? userLongitude,
) {
  if (userLatitude == null || userLongitude == null) {
    return null;
  }
  if (donation.latitude == null || donation.longitude == null) {
    return null;
  }

  final meters = Geolocator.distanceBetween(
    userLatitude,
    userLongitude,
    donation.latitude!,
    donation.longitude!,
  );
  return meters / 1000.0;
}

String localizedDistance(
  BuildContext context,
  Donation donation,
  double? userLatitude,
  double? userLongitude,
) {
  final l10n = AppLocalizations.of(context);
  final km = donationDistanceKm(donation, userLatitude, userLongitude);
  if (km == null) {
    return l10n.donationCardDistanceKm('-');
  }
  return l10n.donationCardDistanceKm(km.toStringAsFixed(1));
}

String localizedStatusLabel(BuildContext context, String status) {
  final l10n = AppLocalizations.of(context);
  switch (status.toDonationStatusValue()) {
    case DonationStatusValue.draft:
      return l10n.statusDraft;
    case DonationStatusValue.published:
      return l10n.statusPublished;
    case DonationStatusValue.reserved:
      return l10n.statusReserved;
    case DonationStatusValue.completed:
      return l10n.statusCompleted;
    case DonationStatusValue.expired:
      return l10n.statusExpired;
    case DonationStatusValue.unknown:
      return l10n.statusUnknown;
  }
}

Color statusBackgroundColor(String status) {
  return AppColors.donationStatusBadgeBackground[status
          .toDonationStatusValue()] ??
      AppColors.surface;
}

Color statusTextColor(String status) {
  return AppColors.donationStatusBadgeText[status.toDonationStatusValue()] ??
      AppColors.textSecondary;
}

String localizedExpiryLabel(BuildContext context, DateTime? expiryDate) {
  final l10n = AppLocalizations.of(context);
  if (expiryDate == null) {
    return l10n.donationCardExpiresLabel('--/--');
  }
  final formatted = DateFormat('dd MMM').format(expiryDate);
  return l10n.donationCardExpiresLabel(formatted);
}

String donationAuthorLabel(BuildContext context, Donation donation) {
  final l10n = AppLocalizations.of(context);
  final author = donation.authorDetails?.displayName?.trim();
  if (author != null && author.isNotEmpty) {
    return author;
  }

  final fallback = donation.author.trim();
  if (fallback.isNotEmpty) {
    return fallback;
  }

  return l10n.donationCardAnonymousDonor;
}
