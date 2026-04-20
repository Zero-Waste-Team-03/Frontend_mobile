enum DonationStatusValue {
  draft,
  published,
  reserved,
  completed,
  expired,
  unknown,
}

extension DonationStatusValueParser on String {
  DonationStatusValue toDonationStatusValue() {
    switch (trim().toUpperCase()) {
      case 'DRAFT':
        return DonationStatusValue.draft;
      case 'PUBLISHED':
        return DonationStatusValue.published;
      case 'RESERVED':
        return DonationStatusValue.reserved;
      case 'COMPLETED':
        return DonationStatusValue.completed;
      case 'EXPIRED':
        return DonationStatusValue.expired;
      default:
        return DonationStatusValue.unknown;
    }
  }
}
