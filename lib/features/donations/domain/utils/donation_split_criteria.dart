import 'package:geolocator/geolocator.dart';

import '../../../../core/enums/donation_card_tier.dart';
import '../entities/donation.dart';

const double _featuredDonationDistanceThresholdKm = 5.0;

DonationCardTier resolveDonationCardTier({
  required Donation donation,
  required double? userLatitude,
  required double? userLongitude,
}) {
  final isPublished = donation.status.trim().toUpperCase() == 'PUBLISHED';
  final hasImage =
      donation.imageUrl.trim().isNotEmpty &&
      !donation.imageUrl.contains('ui-avatars.com');
  final hasQuantity = donation.quantity > 0;
  final isNearby = _isNearby(
    donation: donation,
    userLatitude: userLatitude,
    userLongitude: userLongitude,
  );

  final isFeatured = isPublished && hasImage && hasQuantity && isNearby;
  return isFeatured ? DonationCardTier.featured : DonationCardTier.standard;
}

bool _isNearby({
  required Donation donation,
  required double? userLatitude,
  required double? userLongitude,
}) {
  if (userLatitude == null || userLongitude == null) {
    return false;
  }
  if (donation.latitude == null || donation.longitude == null) {
    return false;
  }

  final distanceMeters = Geolocator.distanceBetween(
    userLatitude,
    userLongitude,
    donation.latitude!,
    donation.longitude!,
  );
  final distanceKm = distanceMeters / 1000.0;
  return distanceKm < _featuredDonationDistanceThresholdKm;
}
