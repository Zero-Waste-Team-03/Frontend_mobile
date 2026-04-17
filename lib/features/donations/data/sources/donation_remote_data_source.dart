import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import 'package:logger/logger.dart';

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
      };

      _logger.d('Building getDonations variables: $varsMap');

      final vars = GGetDonationsVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e('Failed to build getDonations variables from: $varsMap');
        throw ServerException('Failed to build getDonations request');
      }

      final data = await _executeRequest(
        GGetDonationsReq((b) => b.vars = vars.toBuilder()),
        'getDonations',
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

      final data = await _executeRequest(
        GGetCategoriesReq((b) => b.vars = vars.toBuilder()),
        'getCategories',
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

      final data = await _executeRequest(
        GGetDonationByIdReq((b) => b.vars = vars.toBuilder()),
        'getDonationById',
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
      'urgency=$urgency, expiryDate=$expiryDate',
    );

    try {
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

      final data = await _executeRequest(
        GCreateDonationReq((b) => b.vars = vars.toBuilder()),
        'createDonation',
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

  Future<TData> _executeRequest<TData, TVars>(
    OperationRequest<TData, TVars> request,
    String operationName,
  ) async {
    _logger.i('Executing GraphQL operation: $operationName');

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

        String linkExceptionMsg = 'Unknown link exception';
        if (response.linkException != null) {
          final originalMsg = response.linkException!.originalException
              ?.toString();
          linkExceptionMsg = originalMsg ?? response.linkException.toString();
        }

        final errorMessage =
            graphQLErrorMessage ?? linkExceptionMsg ?? 'Unknown error';

        _logger.e(
          'GraphQL error in $operationName: $errorMessage\n'
          'Has GraphQL errors: ${response.hasErrors}\n'
          'Has link exception: ${response.linkException != null}\n'
          'GraphQL error details: ${graphQLErrors?.map((e) => 'Message: ${e.message}, Extensions: ${e.extensions}').toList()}',
        );

        throw ServerException('GraphQL error in $operationName: $errorMessage');
      }

      final data = response.data;
      if (data == null) {
        _logger.e('No data returned for $operationName');
        throw ServerException('No data returned for $operationName');
      }

      _logger.i('$operationName completed successfully');
      return data;
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      _logger.e(
        'Unexpected error in GraphQL request for $operationName: $e',
        error: e,
      );
      throw ServerException('GraphQL request failed for $operationName: $e');
    }
  }
}
