enum DonationUrgencyValue { high, medium, low }

extension DonationUrgencyValueParsing on String? {
  DonationUrgencyValue toDonationUrgencyValue() {
    switch ((this ?? '').trim().toUpperCase()) {
      case 'HIGH':
        return DonationUrgencyValue.high;
      case 'MEDIUM':
        return DonationUrgencyValue.medium;
      case 'LOW':
        return DonationUrgencyValue.low;
      default:
        return DonationUrgencyValue.medium;
    }
  }
}
