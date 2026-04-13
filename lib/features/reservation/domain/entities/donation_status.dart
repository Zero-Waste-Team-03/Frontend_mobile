enum DonationStatus { draft, published, reserved, completed, expired }

extension DonationStatusExt on DonationStatus {
  String get value {
    switch (this) {
      case DonationStatus.draft:
        return 'DRAFT';
      case DonationStatus.published:
        return 'PUBLISHED';
      case DonationStatus.reserved:
        return 'RESERVED';
      case DonationStatus.completed:
        return 'COMPLETED';
      case DonationStatus.expired:
        return 'EXPIRED';
    }
  }

  String get displayName {
    switch (this) {
      case DonationStatus.draft:
        return 'Draft';
      case DonationStatus.published:
        return 'Published';
      case DonationStatus.reserved:
        return 'Reserved';
      case DonationStatus.completed:
        return 'Completed';
      case DonationStatus.expired:
        return 'Expired';
    }
  }

  static DonationStatus fromString(String value) {
    return DonationStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => DonationStatus.draft,
    );
  }
}
