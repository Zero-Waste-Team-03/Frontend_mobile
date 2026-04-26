import '../../domain/entities/favorite_donations_page.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_remote_data_source.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl({required this.remoteDataSource});

  final FavoritesRemoteDataSource remoteDataSource;

  @override
  Future<FavoriteDonationsPage> getLikedDonations({
    int page = 1,
    int limit = 10,
  }) async {
    return remoteDataSource.getLikedDonations(page: page, limit: limit);
  }

  @override
  Future<void> likeDonation(String donationId) async {
    await remoteDataSource.likeDonation(donationId);
  }

  @override
  Future<void> unlikeDonation(String donationId) async {
    await remoteDataSource.unlikeDonation(donationId);
  }
}
