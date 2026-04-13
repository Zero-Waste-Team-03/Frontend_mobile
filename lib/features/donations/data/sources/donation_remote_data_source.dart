import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart' hide ServerException;

import '../../../../core/exceptions/exceptions.dart';
import '../models/category_model.dart';
import '../models/donation_model.dart';
import 'graphql/__generated__/create_donation.req.gql.dart';
import 'graphql/__generated__/create_donation.var.gql.dart';
import 'graphql/__generated__/get_categories.req.gql.dart';
import 'graphql/__generated__/get_categories.var.gql.dart';
import 'graphql/__generated__/get_donation_by_id.req.gql.dart';
import 'graphql/__generated__/get_donation_by_id.var.gql.dart';
import 'graphql/__generated__/get_donations.req.gql.dart';
import 'graphql/__generated__/get_donations.var.gql.dart';

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
}

class DonationRemoteDataSourceImpl implements DonationRemoteDataSource {
  DonationRemoteDataSourceImpl(this.dio, this._ferryClient);

  final Dio dio;
  final Client _ferryClient;

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
    final filter = <String, dynamic>{};
    if (categoryId != null && categoryId.isNotEmpty) {
      filter['categoryId'] = categoryId;
    }

    final varsMap = <String, dynamic>{
      'pagination': {'page': page, 'limit': limit},
      if (filter.isNotEmpty) 'filter': filter,
    };

    final vars = GGetDonationsVars.fromJson(varsMap);
    if (vars == null) {
      throw ServerException('Failed to build getDonations request');
    }

    final data = await _executeRequest(
      GGetDonationsReq((b) => b.vars = vars.toBuilder()),
      'getDonations',
    );

    final items = data.donations.items;
    if (items == null || items.isEmpty) {
      return const [];
    }

    return items
        .map(
          (item) =>
              DonationModel.fromJson(Map<String, dynamic>.from(item.toJson())),
        )
        .toList();
  }

  @override
  Future<List<CategoryModel>> getCategories({
    int page = 1,
    int limit = 50,
  }) async {
    final vars = GGetCategoriesVars.fromJson({
      'pagination': {'page': page, 'limit': limit},
    });
    if (vars == null) {
      throw ServerException('Failed to build getCategories request');
    }

    final data = await _executeRequest(
      GGetCategoriesReq((b) => b.vars = vars.toBuilder()),
      'getCategories',
    );

    final items = data.categories.items;
    if (items == null || items.isEmpty) {
      return const [];
    }

    return items
        .map(
          (item) =>
              CategoryModel.fromJson(Map<String, dynamic>.from(item.toJson())),
        )
        .toList();
  }

  @override
  Future<DonationModel> getDonationDetails(String id) async {
    final vars = GGetDonationByIdVars.fromJson({'id': id});
    if (vars == null) {
      throw ServerException('Failed to build getDonationById request');
    }

    final data = await _executeRequest(
      GGetDonationByIdReq((b) => b.vars = vars.toBuilder()),
      'getDonationById',
    );

    return DonationModel.fromJson(
      Map<String, dynamic>.from(data.donation.toJson()),
    );
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
    final normalizedUrgency = urgency.trim().toUpperCase();
    const allowedUrgency = {'LOW', 'MEDIUM', 'HIGH'};

    final inputParams = <String, dynamic>{
      'title': title,
      'description': description,
      'categoryId': categoryId,
      'quantity': quantity,
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
    }

    final vars = GCreateDonationVars.fromJson({'input': inputParams});
    if (vars == null) {
      throw ServerException('Failed to build createDonation request');
    }

    final data = await _executeRequest(
      GCreateDonationReq((b) => b.vars = vars.toBuilder()),
      'createDonation',
    );

    return DonationModel.fromJson(
      Map<String, dynamic>.from(data.createDonation.toJson()),
    );
  }

  @override
  Future<String> uploadDonationImage(File file) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });
      final response = await dio.post(
        '/api/v1/upload/file?uploadType=DONATION',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['data'] as Map<String, dynamic>?;
        return data?['attachmentId'] as String? ??
            response.data['id'] as String;
      }
      throw ServerException('Failed to upload image');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to upload image');
    }
  }

  Future<TData> _executeRequest<TData, TVars>(
    OperationRequest<TData, TVars> request,
    String operationName,
  ) async {
    try {
      final response = await _ferryClient
          .request(request)
          .firstWhere(
            (event) =>
                event.data != null ||
                event.hasErrors ||
                event.linkException != null,
          );

      if (response.hasErrors || response.linkException != null) {
        final graphQLErrors = response.graphqlErrors;
        final graphQLErrorMessage =
            graphQLErrors != null && graphQLErrors.isNotEmpty
            ? graphQLErrors.first.message
            : null;

        final message =
            graphQLErrorMessage ??
            response.linkException?.originalException?.toString() ??
            response.linkException.toString();

        throw ServerException(message);
      }

      final data = response.data;
      if (data == null) {
        throw ServerException('No data returned for $operationName');
      }

      return data;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('GraphQL request failed: $e');
    }
  }
}
