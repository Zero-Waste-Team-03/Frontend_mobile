import 'dart:io';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/donation.dart';
import '../../domain/repositories/donation_repository.dart';
import '../sources/donation_remote_data_source.dart';

class DonationRepositoryImpl implements DonationRepository {
  final DonationRemoteDataSource remoteDataSource;

  DonationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Donation>>> getDonations({
    int page = 1,
    int limit = 50,
    String? categoryId,
    String? searchQuery,
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    try {
      final donations = await remoteDataSource.getDonations(
        page: page,
        limit: limit,
        categoryId: categoryId,
        searchQuery: searchQuery,
        latitude: latitude,
        longitude: longitude,
        radius: radius,
      );
      return right(donations);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadDonationImage(File file) async {
    try {
      final result = await remoteDataSource.uploadDonationImage(file);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories({
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final categories = await remoteDataSource.getCategories(
        page: page,
        limit: limit,
      );
      return right(categories);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      final donation = await remoteDataSource.createDonation(
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
      return right(donation);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
