import '../../domain/entities/category.dart';
import '../../domain/entities/donation.dart';
import '../../domain/repositories/donation_repository.dart';
import '../sources/donation_remote_data_source.dart';

class DonationRepositoryImpl implements DonationRepository {
  final DonationRemoteDataSource remoteDataSource;

  DonationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Donation>> getDonations({int page = 1, int limit = 20, String? categoryId}) async {
    return await remoteDataSource.getDonations(page: page, limit: limit, categoryId: categoryId);
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
    required String urgency,
    required String mainAttachmentId,
    List<String> attachmentIds = const [],
    required DateTime expiryDate,
    bool safetyChecklistCompleted = true,
  }) async {
    return await remoteDataSource.createDonation(
      title: title,
      description: description,
      categoryId: categoryId,
      quantity: quantity,
      urgency: urgency,
      mainAttachmentId: mainAttachmentId,
      attachmentIds: attachmentIds,
      expiryDate: expiryDate,
      safetyChecklistCompleted: safetyChecklistCompleted,
    );
  }
}
