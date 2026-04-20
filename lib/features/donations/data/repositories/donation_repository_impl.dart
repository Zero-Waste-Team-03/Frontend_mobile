import 'dart:io';
import '../../domain/entities/category.dart';
import '../../domain/entities/donation.dart';
import '../../domain/repositories/donation_repository.dart';
import '../sources/donation_remote_data_source.dart';
import 'package:geolocator/geolocator.dart';

class DonationRepositoryImpl implements DonationRepository {
  final DonationRemoteDataSource remoteDataSource;

  DonationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Donation>> getDonations({
    int page = 1,
    int limit = 50,
    String? categoryId,
    String? searchQuery,
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    final donations = await remoteDataSource.getDonations(
      page: page,
      limit: limit,
      categoryId: categoryId,
      searchQuery: searchQuery,
      latitude: latitude,
      longitude: longitude,
      radius: radius,
    );

    var filtered = List<Donation>.from(donations);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered
          .where(
            (d) =>
                d.title.toLowerCase().contains(query) ||
                d.description.toLowerCase().contains(query),
          )
          .toList();
    }

    if (latitude != null && longitude != null && radius != null) {
      filtered = filtered.where((d) {
        if (d.latitude == null || d.longitude == null) return false;
        final distKm =
            Geolocator.distanceBetween(
              latitude,
              longitude,
              d.latitude!,
              d.longitude!,
            ) /
            1000.0;
        return distKm <= radius;
      }).toList();
    }

    return filtered;
  }

  @override
  Future<String> uploadDonationImage(File file) async {
    return await remoteDataSource.uploadDonationImage(file);
  }

  @override
  Future<List<Category>> getCategories({int page = 1, int limit = 50}) async {
    return await remoteDataSource.getCategories(page: page, limit: limit);
  }

  @override
  Future<Donation> createDonation({
    required String title,
    required String description,
    required String categoryId,
    required int quantity,
    required double foodWeightKg,
    required String urgency,
    required String mainAttachmentId,
    List<String> attachmentIds = const [],
    required DateTime expiryDate,
    bool safetyChecklistCompleted = true,
    double? latitude,
    double? longitude,
  }) async {
    return await remoteDataSource.createDonation(
      title: title,
      description: description,
      categoryId: categoryId,
      quantity: quantity,
      foodWeightKg: foodWeightKg,
      urgency: urgency,
      mainAttachmentId: mainAttachmentId,
      attachmentIds: attachmentIds,
      expiryDate: expiryDate,
      safetyChecklistCompleted: safetyChecklistCompleted,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
