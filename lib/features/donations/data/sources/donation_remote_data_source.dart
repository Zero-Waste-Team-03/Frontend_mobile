import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
import '../models/category_model.dart';
import '../models/donation_model.dart';
import 'graphql/__generated__/create_donation.req.gql.dart';
import 'graphql/__generated__/create_donation.var.gql.dart';
import 'graphql/__generated__/delete_donation.req.gql.dart';
import 'graphql/__generated__/delete_donation.var.gql.dart';
import 'graphql/__generated__/get_categories.req.gql.dart';
import 'graphql/__generated__/get_categories.var.gql.dart';
import 'graphql/__generated__/get_donation_by_id.req.gql.dart';
import 'graphql/__generated__/get_donation_by_id.var.gql.dart';
import 'graphql/__generated__/get_donations.req.gql.dart';
import 'graphql/__generated__/get_donations.var.gql.dart';
import 'graphql/__generated__/update_donation.req.gql.dart';
import 'graphql/__generated__/update_donation.var.gql.dart';

abstract class DonationRemoteDataSource {
  Future<List<DonationModel>> getDonations({
    int page = 1,
    int limit = 50,
    String? categoryId,
    String? searchQuery,
    double? latitude,
    double? longitude,
    double? radius,
  });
  Future<String> uploadDonationImage(File file);
  Future<List<CategoryModel>> getCategories({int page = 1, int limit = 50});
  Future<DonationModel> getDonationDetails(String id);
  Future<DonationModel> createDonation({
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
  Future<DonationModel> updateDonation({
    required String id,
    String? title,
    String? description,
    String? categoryId,
    int? quantity,
    double? foodWeightKg,
    String? urgency,
    String? mainAttachmentId,
    List<String>? attachmentIds,
    DateTime? expiryDate,
    bool? safetyChecklistCompleted,
    double? latitude,
    double? longitude,
  });
  Future<void> deleteDonation(String id);
}

class DonationRemoteDataSourceImpl implements DonationRemoteDataSource {
  DonationRemoteDataSourceImpl(
    this.dio,
    this._ferryClient,
    this._graphqlRequestExecutor,
  );

  final Dio dio;
  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  @override
  Future<List<DonationModel>> getDonations({
    int page = 1,
    int limit = 50,
    String? categoryId,
    String? searchQuery,
    double? latitude,
    double? longitude,
    double? radius,
  }) async {
    _logger.i(
      'getDonations called with params: page=$page, limit=$limit, categoryId=$categoryId, '
      'searchQuery=$searchQuery, latitude=$latitude, longitude=$longitude, radius=$radius',
    );

    try {
      final filter = <String, dynamic>{};
      if (categoryId != null && categoryId.isNotEmpty) {
        filter['categoryId'] = categoryId;
        _logger.d('Added categoryId to filter: $categoryId');
      }

      final varsMap = <String, dynamic>{
        'pagination': {'page': page, 'limit': limit},
        if (filter.isNotEmpty) 'filter': filter,
        if (searchQuery != null && searchQuery.isNotEmpty)
          'searchName': searchQuery,
      };

      _logger.d('Building getDonations variables: $varsMap');

      final vars = GGetDonationsVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e('Failed to build getDonations variables from: $varsMap');
        throw ServerException('Failed to build getDonations request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GGetDonationsReq((b) => b.vars = vars.toBuilder()),
        operationName: 'getDonations',
      );

      final items = data.donations.items;
      _logger.i('getDonations returned ${items?.length ?? 0} items');

      if (items == null || items.isEmpty) {
        return const [];
      }

      return items
          .map(
            (item) => DonationModel.fromJson(
              Map<String, dynamic>.from(item.toJson()),
            ),
          )
          .toList();
    } catch (e) {
      _logger.e('getDonations error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<List<CategoryModel>> getCategories({
    int page = 1,
    int limit = 50,
  }) async {
    _logger.i('getCategories called with page=$page, limit=$limit');

    try {
      final varsMap = {
        'pagination': {'page': page, 'limit': limit},
      };

      _logger.d('Building getCategories variables: $varsMap');

      final vars = GGetCategoriesVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e('Failed to build getCategories variables from: $varsMap');
        throw ServerException('Failed to build getCategories request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GGetCategoriesReq((b) => b.vars = vars.toBuilder()),
        operationName: 'getCategories',
      );

      final items = data.categories.items;
      _logger.i('getCategories returned ${items?.length ?? 0} items');

      if (items == null || items.isEmpty) {
        return const [];
      }

      return items
          .map(
            (item) => CategoryModel.fromJson(
              Map<String, dynamic>.from(item.toJson()),
            ),
          )
          .toList();
    } catch (e) {
      _logger.e('getCategories error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<DonationModel> getDonationDetails(String id) async {
    _logger.i('getDonationDetails called with id=$id');

    try {
      final varsMap = {'id': id};
      _logger.d('Building getDonationDetails variables: $varsMap');

      final vars = GGetDonationByIdVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e('Failed to build getDonationById variables from: $varsMap');
        throw ServerException('Failed to build getDonationById request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GGetDonationByIdReq((b) => b.vars = vars.toBuilder()),
        operationName: 'getDonationById',
      );

      _logger.i('Successfully retrieved donation details for id=$id');
      return DonationModel.fromJson(
        Map<String, dynamic>.from(data.donation.toJson()),
      );
    } catch (e) {
      _logger.e('getDonationDetails error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<DonationModel> createDonation({
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
    _logger.i(
      'createDonation called with title=$title, categoryId=$categoryId, '
      'urgency=$urgency, expiryDate=$expiryDate, foodWeightKg=$foodWeightKg, quantity=$quantity, safetyChecklistCompleted=$safetyChecklistCompleted, ',
    );

    try {
      final normalizedUrgency = urgency.trim().toUpperCase();
      const allowedUrgency = {'LOW', 'MEDIUM', 'HIGH'};

      final inputParams = <String, dynamic>{
        'title': title,
        'description': description,
        'categoryId': categoryId,
        'quantity': quantity,
        'foodWeightKg': foodWeightKg,
        'urgency': allowedUrgency.contains(normalizedUrgency)
            ? normalizedUrgency
            : 'MEDIUM',
        'mainAttachmentId': mainAttachmentId,
        'attachmentIds': attachmentIds,
        'expiryDate': expiryDate.toUtc().toIso8601String(),
        'safetyChecklistCompleted': safetyChecklistCompleted,
      };

      if (latitude != null && longitude != null) {
        inputParams['locationInput'] = {
          'latitude': latitude,
          'longitude': longitude,
        };
        _logger.d('Added location to createDonation input');
      }

      final varsMap = {'input': inputParams};
      _logger.d(
        'Building createDonation variables with input keys: ${inputParams.keys.toList()}',
      );

      final vars = GCreateDonationVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e(
          'Failed to build createDonation variables from input keys: ${inputParams.keys.toList()}',
        );
        throw ServerException('Failed to build createDonation request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GCreateDonationReq((b) => b.vars = vars.toBuilder()),
        operationName: 'createDonation',
      );

      _logger.i('Successfully created donation with title=$title');
      return DonationModel.fromJson(
        Map<String, dynamic>.from(data.createDonation.toJson()),
      );
    } catch (e) {
      _logger.e('createDonation error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<DonationModel> updateDonation({
    required String id,
    String? title,
    String? description,
    String? categoryId,
    int? quantity,
    double? foodWeightKg,
    String? urgency,
    String? mainAttachmentId,
    List<String>? attachmentIds,
    DateTime? expiryDate,
    bool? safetyChecklistCompleted,
    double? latitude,
    double? longitude,
  }) async {
    _logger.i('updateDonation called with id=$id');

    try {
      final inputParams = <String, dynamic>{
        if (title != null) 'title': title,
        if (description != null) 'description': description,
        if (categoryId != null) 'categoryId': categoryId,
        if (quantity != null) 'quantity': quantity,
        if (foodWeightKg != null) 'foodWeightKg': foodWeightKg,
        if (urgency != null) 'urgency': urgency.trim().toUpperCase(),
        if (mainAttachmentId != null) 'mainAttachmentId': mainAttachmentId,
        if (attachmentIds != null) 'attachmentIds': attachmentIds,
        if (expiryDate != null)
          'expiryDate': expiryDate.toUtc().toIso8601String(),
        if (safetyChecklistCompleted != null)
          'safetyChecklistCompleted': safetyChecklistCompleted,
      };

      if (latitude != null && longitude != null) {
        inputParams['locationInput'] = {
          'latitude': latitude,
          'longitude': longitude,
        };
      }

      final varsMap = {'id': id, 'input': inputParams};
      final vars = GUpdateDonationVars.fromJson(varsMap);
      if (vars == null) {
        throw ServerException('Failed to build updateDonation request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GUpdateDonationReq((b) => b.vars = vars.toBuilder()),
        operationName: 'updateDonation',
      );

      _logger.i('Successfully updated donation with id=$id');
      return DonationModel.fromJson(
        Map<String, dynamic>.from(data.updateDonation.toJson()),
      );
    } catch (e) {
      _logger.e('updateDonation error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteDonation(String id) async {
    _logger.i('deleteDonation called with id=$id');

    try {
      final varsMap = {'id': id};
      final vars = GDeleteDonationVars.fromJson(varsMap);
      if (vars == null) {
        throw ServerException('Failed to build deleteDonation request');
      }

      await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GDeleteDonationReq((b) => b.vars = vars.toBuilder()),
        operationName: 'deleteDonation',
      );

      _logger.i('Successfully deleted donation with id=$id');
    } catch (e) {
      _logger.e('deleteDonation error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<String> uploadDonationImage(File file) async {
    _logger.i('Uploading donation image: ${file.path}');
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });

      _logger.d(
        'Sending file upload request to /api/v1/upload/file?uploadType=DONATION',
      );

      final response = await dio.post(
        '/api/v1/upload/file?uploadType=DONATION',
        data: formData,
      );

      _logger.d('File upload response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>?;
        final attachmentId =
            data?['attachmentId'] as String? ?? response.data['id'] as String;
        _logger.i(
          'File uploaded successfully with attachmentId: $attachmentId',
        );
        return attachmentId;
      }

      _logger.e('File upload failed with status: ${response.statusCode}');
      throw ServerException('Failed to upload image');
    } on DioException catch (e) {
      final errorMessage =
          e.response?.data?['message'] ??
          e.message ??
          e.error?.toString() ??
          'Failed to upload image';
      _logger.e('DioException during upload: $errorMessage', error: e);
      throw ServerException(errorMessage);
    } catch (e) {
      _logger.e('Unexpected error during file upload: $e', error: e);
      throw ServerException('Failed to upload image: $e');
    }
  }
}
