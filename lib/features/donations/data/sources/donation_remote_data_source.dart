import 'package:dio/dio.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../models/category_model.dart';
import '../models/donation_model.dart';
import 'package:logger/logger.dart';

abstract class DonationRemoteDataSource {
  Future<List<DonationModel>> getDonations({int page = 1, int limit = 20, String? categoryId});
  Future<List<CategoryModel>> getCategories({int page = 1, int limit = 50});
  Future<DonationModel> getDonationDetails(String id);
  Future<DonationModel> createDonation({
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

class DonationRemoteDataSourceImpl implements DonationRemoteDataSource {
  final Dio dio;
  final Logger _logger = Logger();

  static const String _donationFields = '''
    id
    title
    description
    quantity
    categoryId
    category {
      id
      name
    }
    status
    urgency
    mainAttachmentId
    locationId
    location {
      latitude
      longitude
    }
    user {
      displayName
      email
    }
  ''';

  DonationRemoteDataSourceImpl(this.dio);

  @override
  Future<List<DonationModel>> getDonations({int page = 1, int limit = 20, String? categoryId}) async {
    final query = '''
      query GetDonations(\$pagination: PaginationInput, \$filter: DonationsFilterInput) {
        donations(pagination: \$pagination, filter: \$filter) {
          items {
            $_donationFields
          }
        }
      }
    ''';

    final variables = {
      'pagination': {
        'page': page,
        'limit': limit,
      },
      'filter': categoryId != null ? {'categoryId': categoryId} : {},
    };

    try {
      final response = await dio.post('/graphql', data: {
        'query': query,
        'variables': variables,
      });

      if (response.data['errors'] != null) {
        throw ServerException(response.data['errors'][0]['message']);
      }

      final items = response.data['data']['donations']['items'] as List;
      return items.map((json) => DonationModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to get donations');
    }
  }

  @override
  Future<List<CategoryModel>> getCategories({int page = 1, int limit = 50}) async {
    const query = '''
      query GetCategories(\$pagination: PaginationInput) {
        categories(pagination: \$pagination) {
          items {
            id
            name
          }
        }
      }
    ''';

    try {
      final response = await dio.post('/graphql', data: {
        'query': query,
        'variables': {
          'pagination': {
            'page': page,
            'limit': limit,
          }
        },
      });

      if (response.data['errors'] != null) {
        throw ServerException(response.data['errors'][0]['message']);
      }

      final items = response.data['data']['categories']['items'] as List;
      return items.map((json) => CategoryModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to get categories');
    }
  }

  @override
  Future<DonationModel> getDonationDetails(String id) async {
    // Actually the backend might not have getDonationDetails by id query explicitly 
    // unless we use `donations(filter...)` or if there's a specific one. Let's use donations array filtering.
    // However, I observed donations filter might not support ID. For now I just fetch it from getDonations by passing ID if possible,
    // or we assume it's pre-fetched and passed via route extra in Flutter (which it is currently doing).
    throw UnimplementedError('Details are usually passed from list');
  }

  @override
  Future<DonationModel> createDonation({
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
    final query = '''
      mutation CreateDonation(\$input: CreateDonationInput!) {
        createDonation(input: \$input) {
          $_donationFields
        }
      }
    ''';

    final variables = {
      'input': {
        'title': title,
        'description': description,
        'categoryId': categoryId,
        'quantity': quantity,
        'urgency': urgency,
        'mainAttachmentId': mainAttachmentId,
        'attachmentIds': attachmentIds,
        'expiryDate': expiryDate.toUtc().toIso8601String(),
        'safetyChecklistCompleted': safetyChecklistCompleted,
      }
    };

    try {
      final response = await dio.post('/graphql', data: {
        'query': query,
        'variables': variables,
      });

      if (response.data['errors'] != null) {
        throw ServerException(response.data['errors'][0]['message']);
      }

      return DonationModel.fromJson(response.data['data']['createDonation']);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to create donation');
    }
  }
}
