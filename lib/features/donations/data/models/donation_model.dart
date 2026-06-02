import '../../domain/entities/donation.dart';
import 'category_model.dart';
import '../../../../core/env.dart';
import 'package:gaspzero/features/auth/data/models/user_model.dart';

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
    super.expiryDate,
    super.urgency,
    super.createdAt,
    super.isLikedByMe,
    super.isReservable,
    super.isDeletable,
    super.safetyChecklistCompleted,
    super.userId,
    super.authorDetails,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    // Location
    final location = json['location'] as Map<String, dynamic>?;
    final lat = location != null
        ? (location['latitude'] as num?)?.toDouble()
        : null;
    final lng = location != null
        ? (location['longitude'] as num?)?.toDouble()
        : null;

    // Base URL
    final baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.gaspzero.qzz.io/',
    );
    final envBaseUrl = Env.get('API_BASE_URL') ?? baseUrl;

    // Image URL fallback
    String imageUrl =
        'https://ui-avatars.com/api/?name=${Uri.encodeComponent((json['title'] ?? 'Food').toString())}&background=random';

    // Prefer explicit imageUrl
    if (json['imageUrl'] != null &&
        (json['imageUrl'] as String?)?.isNotEmpty == true) {
      imageUrl = json['imageUrl'].toString();
    } else {
      final mainAttachment = json['mainAttachment'] as Map<String, dynamic>?;
      final fallbackAttachmentId = json['mainAttachmentId'] != null
          ? json['mainAttachmentId'].toString()
          : null;

      if (mainAttachment != null && mainAttachment['url'] != null) {
        imageUrl = mainAttachment['url'].toString();
      } else if (fallbackAttachmentId != null &&
          fallbackAttachmentId.isNotEmpty) {
        imageUrl = '${envBaseUrl}attachments/$fallbackAttachmentId';
      }
    }

    // User / author
    final userMap = json['user'] as Map<String, dynamic>?;
    final userId = userMap != null
        ? (userMap['id']?.toString())
        : (json['userId']?.toString());

    final authorDetails = userMap != null ? UserModel.fromJson(userMap) : null;

    final authorName = userMap != null
        ? ((userMap['displayName'] ?? userMap['email'])?.toString() ??
              'Unknown')
        : (json['author']?.toString() ??
              json['postedBy']?.toString() ??
              'Unknown');

    // Dates & misc
    final expiryDateRaw = json['expiryDate'] as String?;
    final expiryDate = expiryDateRaw != null
        ? DateTime.tryParse(expiryDateRaw)
        : null;
    final createdAtRaw = json['createdAt'] as String?;
    final createdAt = createdAtRaw != null
        ? DateTime.tryParse(createdAtRaw)
        : null;
    final urgency = json['urgency'] as String?;
    final isLikedByMe = json['isLikedByMe'] as bool?;
    final isReservable = json['isReservable'] as bool?;
    final isDeletable = json['isDeletable'] as bool?;
    final safetyChecklistCompleted = json['safetyChecklistCompleted'] as bool?;

    return DonationModel(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      categoryId: (json['categoryId'] ?? '').toString(),
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      condition: (json['urgency'] as String?) ?? 'MEDIUM',
      status: (json['status'] as String?) ?? 'DRAFT',
      author: authorName,
      imageUrl: imageUrl,
      latitude: lat,
      longitude: lng,
      userId: userId,
      authorDetails: authorDetails,
      expiryDate: expiryDate,
      urgency: urgency,
      createdAt: createdAt,
      isLikedByMe: isLikedByMe,
      isReservable: isReservable,
      isDeletable: isDeletable,
      safetyChecklistCompleted: safetyChecklistCompleted,
    );
  }
}
