import '../../domain/entities/donation.dart';
import 'category_model.dart';
import '../../../../core/env.dart';

class DonationModel extends Donation {
  const DonationModel({
    required super.id,
    required super.title,
    required super.description,
    required super.quantity,
    required super.categoryId,
    super.category,
    required super.condition,
    required super.status,
    required super.author,
    required super.imageUrl,
    super.latitude,
    super.longitude,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    // Parse location if it exists
    final location = json['location'] as Map<String, dynamic>?;
    final lat = location != null
        ? (location['latitude'] as num?)?.toDouble()
        : null;
    final lng = location != null
        ? (location['longitude'] as num?)?.toDouble()
        : null;

    // Parse imageUrl from API, with fallback to mainAttachment or mainAttachmentId
    final baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.gaspzero.qzz.io/',
    );
    final envBaseUrl = Env.get('API_BASE_URL') ?? baseUrl;

    String imageUrl =
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent(json['title'] ?? 'Food')}&background=random';

    // Priority 1: Use imageUrl directly from API (new field)
    if (json['imageUrl'] != null && (json['imageUrl'] as String).isNotEmpty) {
      imageUrl = json['imageUrl'] as String;
    }
    // Priority 2: Use mainAttachment URL
    else {
      final mainAttachment = json['mainAttachment'] as Map<String, dynamic>?;
      final fallbackAttachmentId = json['mainAttachmentId'] as String?;

      if (mainAttachment != null && mainAttachment['url'] != null) {
        imageUrl = mainAttachment['url'] as String;
      } else if (fallbackAttachmentId != null) {
        imageUrl = '${envBaseUrl}attachments/$fallbackAttachmentId';
      }
    }

    // Parse the user (author)
    final user = json['user'] as Map<String, dynamic>?;
    final authorName = user != null
        ? (user['displayName'] ?? user['email'])
        : 'Unknown';

    return DonationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      categoryId: json['categoryId'] as String,
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      condition: json['urgency'] as String? ?? 'MEDIUM',
      status: json['status'] as String? ?? 'DRAFT',
      author: authorName as String,
      imageUrl: imageUrl,
      latitude: lat,
      longitude: lng,
    );
  }
}
