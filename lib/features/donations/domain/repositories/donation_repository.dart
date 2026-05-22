import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/category.dart';
import '../entities/donation.dart';

abstract class DonationRepository {
  Future<Either<Failure, List<Donation>>> getDonations({
    int page = 1,
    int limit = 50,
    String? categoryId,
    String? searchQuery,
    double? latitude,
    double? longitude,
    double? radius,
  });
  Future<Either<Failure, List<Category>>> getCategories({int page = 1, int limit = 50});
  Future<Either<Failure, String>> uploadDonationImage(File file);
  Future<Either<Failure, Donation>> createDonation({
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
