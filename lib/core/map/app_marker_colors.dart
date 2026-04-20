import 'package:flutter/material.dart';

import '../enums/donation_urgency_value.dart';

class AppMarkerColors {
  static const Color urgencyHigh = Color(0xFFE53935);
  static const Color urgencyMedium = Color(0xFFFB8C00);
  static const Color urgencyLow = Color(0xFF2E7D32);

  static const Color urgencyHighLabelBackground = urgencyHigh;
  static const Color urgencyMediumLabelBackground = urgencyMedium;
  static const Color urgencyLowLabelBackground = urgencyLow;

  static const Color markerIconForeground = Colors.white;
  static const Color markerCircleShadow = Color(0x33000000);
  static const Color markerLabelShadow = Color(0x29000000);

  static Color forUrgency(DonationUrgencyValue value) {
    switch (value) {
      case DonationUrgencyValue.high:
        return urgencyHigh;
      case DonationUrgencyValue.medium:
        return urgencyMedium;
      case DonationUrgencyValue.low:
        return urgencyLow;
    }
  }

  static Color markerLabelBackgroundForUrgency(DonationUrgencyValue value) {
    switch (value) {
      case DonationUrgencyValue.high:
        return urgencyHighLabelBackground;
      case DonationUrgencyValue.medium:
        return urgencyMediumLabelBackground;
      case DonationUrgencyValue.low:
        return urgencyLowLabelBackground;
    }
  }
}
