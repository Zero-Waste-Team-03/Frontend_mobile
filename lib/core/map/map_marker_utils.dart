import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';
import '../enums/donation_urgency_value.dart';
import '../extensions/donation_urgency_value_localization.dart';
import 'marker_image_generator.dart';
import '../../features/donations/domain/entities/donation.dart';

class MapMarkerUtils {
  static const String markerUrgencyHighImageId = 'marker_urgency_high';
  static const String markerUrgencyMediumImageId = 'marker_urgency_medium';
  static const String markerUrgencyLowImageId = 'marker_urgency_low';

  static bool hasCoordinates(Donation donation) {
    return donation.latitude != null && donation.longitude != null;
  }

  static DonationUrgencyValue donationUrgency(Donation donation) {
    return donation.urgency.toDonationUrgencyValue();
  }

  static String imageIdForUrgency(DonationUrgencyValue urgency) {
    switch (urgency) {
      case DonationUrgencyValue.high:
        return markerUrgencyHighImageId;
      case DonationUrgencyValue.medium:
        return markerUrgencyMediumImageId;
      case DonationUrgencyValue.low:
        return markerUrgencyLowImageId;
    }
  }

  static LatLng? donationLatLng(Donation donation) {
    if (!hasCoordinates(donation)) {
      return null;
    }
    return LatLng(donation.latitude!, donation.longitude!);
  }

  static Future<void> registerDonationMarkers({
    required List<Donation> donations,
    required MapLibreMapController controller,
    required BuildContext context,
    required AppLocalizations l10n,
  }) async {
    final withCoordinates = donations.where(hasCoordinates).toList();

    await controller.clearSymbols();

    if (withCoordinates.isEmpty) {
      return;
    }

    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final urgencies = withCoordinates.map(donationUrgency).toSet();

    for (final urgency in urgencies) {
      final imageId = imageIdForUrgency(urgency);
      final bytes = await MarkerImageGenerator.generate(
        urgency: urgency,
        label: urgency.localizedLabel(l10n),
        pixelRatio: pixelRatio,
      );
      try {
        await controller.addImage(imageId, bytes);
      } catch (_) {}
    }

    final symbolOptions = withCoordinates.map((donation) {
      final geometry = donationLatLng(donation)!;
      final urgency = donationUrgency(donation);

      return SymbolOptions(
        geometry: geometry,
        iconImage: imageIdForUrgency(urgency),
        iconSize: 1.0,
      );
    }).toList();

    final symbolData = withCoordinates
        .map((donation) => <String, dynamic>{'donationId': donation.id})
        .toList();

    await controller.addSymbols(symbolOptions, symbolData);
  }
}
