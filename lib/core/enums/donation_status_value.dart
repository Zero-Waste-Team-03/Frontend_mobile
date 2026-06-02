enum DonationStatusValue {
  draft,
  published,
  reserved,
  completed,
  expired,
  pendingApproval,
  rejected,
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
      case 'PENDING_APPROVAL':
        return DonationStatusValue.pendingApproval;
      case 'REJECTED':
        return DonationStatusValue.rejected;
      default:
        return DonationStatusValue.unknown;
    }
  }
}

extension DonationStatusValueFriendly on DonationStatusValue {
  String get friendlyName {
    switch (this) {
      case DonationStatusValue.draft:
        return 'Draft';
      case DonationStatusValue.published:
        return 'Published';
      case DonationStatusValue.reserved:
        return 'Reserved';
      case DonationStatusValue.completed:
        return 'Completed';
      case DonationStatusValue.expired:
        return 'Expired';
      case DonationStatusValue.pendingApproval:
        return 'Pending Approval';
      case DonationStatusValue.rejected:
        return 'Rejected';
      case DonationStatusValue.unknown:
        return 'Unknown';
    }
  }
}
