import '../../../donations/domain/entities/donation.dart';

class FavoriteDonationsPage {
  final List<Donation> donations;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int limit;
  final int page;
  final int totalCount;

  const FavoriteDonationsPage({
    required this.donations,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.limit,
    required this.page,
    required this.totalCount,
  });
}
