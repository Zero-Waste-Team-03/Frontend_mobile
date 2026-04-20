// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Gasp\'Zero';

  @override
  String get browseFeaturedSectionTitle => 'Featured nearby';

  @override
  String get browseFeaturedSectionSubtitle =>
      'Fresh donations that match your area';

  @override
  String get browseStandardSectionTitle => 'More donations';

  @override
  String get browseStandardSectionSubtitle => 'All available opportunities';

  @override
  String get browseFilterAll => 'All';

  @override
  String get browseFilterPublished => 'Published';

  @override
  String get browseFilterReserved => 'Reserved';

  @override
  String get browseFilterCompleted => 'Completed';

  @override
  String get browseFilterDraft => 'Draft';

  @override
  String get browseSearchHint => 'Search donations...';

  @override
  String donationsNearbyCount(int count) {
    return '$count donations nearby';
  }

  @override
  String get browseEmptyTitle => 'No donations found';

  @override
  String get browseEmptyDescription =>
      'Try another filter or adjust your search.';

  @override
  String get browseErrorRetry => 'Retry';

  @override
  String get featuredBadge => 'Featured';

  @override
  String donationCardDistanceKm(String value) {
    return '$value km';
  }

  @override
  String donationCardQuantity(int count) {
    return '$count portions';
  }

  @override
  String donationCardExpiresLabel(String date) {
    return 'Expires $date';
  }

  @override
  String get donationCardAnonymousDonor => 'Anonymous donor';

  @override
  String get statusDraft => 'Draft';

  @override
  String get statusPublished => 'Published';

  @override
  String get statusReserved => 'Reserved';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusExpired => 'Expired';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get donationUrgencyHigh => 'High';

  @override
  String get donationUrgencyMedium => 'Medium';

  @override
  String get donationUrgencyLow => 'Low';

  @override
  String get detailsPickupLocation => 'Pickup location';

  @override
  String get detailsCategoryFallback => 'Category';

  @override
  String get detailsNoExpiry => 'No expiry';

  @override
  String get detailsReserveNow => 'Reserve now';

  @override
  String get addDonationLocationTitle => 'Donation location';

  @override
  String get addDonationLocationSubtitle =>
      'Tap and drag the map to place your pin.';

  @override
  String get addDonationLocationInstruction =>
      'Keep the pin on the exact pickup point.';

  @override
  String get addDonationLocationConfirm => 'Confirm location';

  @override
  String get addDonationLocationChange => 'Change';

  @override
  String get addDonationLocationUseCurrent => 'Use my location';

  @override
  String get addDonationLocationSelected => 'Selected location';

  @override
  String get mapLocationPermissionDenied => 'Location permission is denied.';

  @override
  String get mapLocationPermissionDeniedForever =>
      'Location permission is permanently denied.';

  @override
  String get mapLocationMyLocation => 'My location';

  @override
  String get mapLocationLoading => 'Loading map...';
}
