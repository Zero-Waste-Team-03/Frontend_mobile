import '../../l10n/app_localizations.dart';
import '../enums/donation_urgency_value.dart';

extension DonationUrgencyValueLocalization on DonationUrgencyValue {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case DonationUrgencyValue.high:
        return l10n.donationUrgencyHigh;
      case DonationUrgencyValue.medium:
        return l10n.donationUrgencyMedium;
      case DonationUrgencyValue.low:
        return l10n.donationUrgencyLow;
    }
  }
}
