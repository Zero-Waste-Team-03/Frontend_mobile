import '../../../donations/domain/entities/donation.dart';

class ProfileActivitiesPage {
  final List<Donation> activities;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int limit;
  final int page;
  final int totalCount;

  const ProfileActivitiesPage({
    required this.activities,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.limit,
    required this.page,
    required this.totalCount,
  });
}
