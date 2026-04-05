import '../entities/category.dart';
import '../entities/donation.dart';

abstract class DonationRepository {
  Future<List<Donation>> getDonations({int page = 1, int limit = 20, String? categoryId});
  Future<List<Category>> getCategories({int page = 1, int limit = 50});
  Future<Donation> createDonation({
    required String title,
    required String description,
    required String categoryId,
    required int quantity,
    required String urgency,
    required String mainAttachmentId,
    List<String> attachmentIds = const [],
    required DateTime expiryDate,
    bool safetyChecklistCompleted = true,
  });
}
