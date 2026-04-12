import 'dart:io';
import '../entities/category.dart';
import '../entities/donation.dart';

abstract class DonationRepository {
  Future<List<Donation>> getDonations({
    int page = 1,
    int limit = 50,
    String? categoryId,
    String? searchQuery,
    double? latitude,
    double? longitude,
    double? radius,
  });
  Future<List<Category>> getCategories({int page = 1, int limit = 50});
  Future<String> uploadDonationImage(File file);
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
  });
}
