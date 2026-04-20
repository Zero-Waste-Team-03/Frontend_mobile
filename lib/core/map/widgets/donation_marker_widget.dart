import 'package:flutter/material.dart';

import '../../app_icons.dart';
import '../../enums/donation_urgency_value.dart';
import '../app_marker_colors.dart';

class DonationMarkerWidget extends StatelessWidget {
  static const double circleSize = 44;
  static const double iconSize = 22;
  static const double labelFontSize = 11;
  static const double labelVerticalPadding = 4;
  static const double labelHorizontalPadding = 10;

  final DonationUrgencyValue urgency;
  final String label;

  const DonationMarkerWidget({
    super.key,
    required this.urgency,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppMarkerColors.forUrgency(urgency);
    final labelBackground = AppMarkerColors.markerLabelBackgroundForUrgency(
      urgency,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: AppMarkerColors.markerCircleShadow,
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              _iconForUrgency(urgency),
              size: iconSize,
              color: AppMarkerColors.markerIconForeground,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: labelHorizontalPadding,
            vertical: labelVerticalPadding,
          ),
          decoration: BoxDecoration(
            color: labelBackground,
            borderRadius: BorderRadius.circular(999),
            boxShadow: const [
              BoxShadow(
                color: AppMarkerColors.markerLabelShadow,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppMarkerColors.markerIconForeground,
              fontSize: labelFontSize,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }

  IconData _iconForUrgency(DonationUrgencyValue value) {
    switch (value) {
      case DonationUrgencyValue.high:
        return AppIcons.urgencyHigh;
      case DonationUrgencyValue.medium:
        return AppIcons.urgencyMedium;
      case DonationUrgencyValue.low:
        return AppIcons.urgencyLow;
    }
  }
}
