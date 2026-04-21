import '../entities/favorite_donations_page.dart';

abstract class FavoritesRepository {
  Future<FavoriteDonationsPage> getLikedDonations({
    int page = 1,
    int limit = 10,
  });

  Future<void> likeDonation(String donationId);

  Future<void> unlikeDonation(String donationId);
}
