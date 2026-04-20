import 'package:maplibre_gl/maplibre_gl.dart';

import '../../features/donations/domain/entities/donation.dart';

class MapMarkerUtils {
  static bool hasCoordinates(Donation donation) {
    return donation.latitude != null && donation.longitude != null;
  }

  static LatLng? donationLatLng(Donation donation) {
    if (!hasCoordinates(donation)) {
      return null;
    }
    return LatLng(donation.latitude!, donation.longitude!);
  }

  static SymbolOptions donationSymbolOptions({
    required Donation donation,
    required String iconImage,
    required bool isSelected,
  }) {
    final geometry = donationLatLng(donation);
    if (geometry == null) {
      throw ArgumentError('Donation has no valid coordinates.');
    }

    return SymbolOptions(
      geometry: geometry,
      iconImage: iconImage,
      iconSize: isSelected ? 1.4 : 1.1,
      textField: donation.title,
      textSize: 10.0,
    );
  }
}
