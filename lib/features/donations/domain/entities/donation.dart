import 'package:gaspzero/features/auth/data/models/user_model.dart';

import 'category.dart';
import '../../../../core/entities/attachment.dart';

class Donation {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final String categoryId;
  final Category? category;
  final String condition; // equivalent to urgency in mapped UI or status
  final String status;
  final String author;
  final String imageUrl;
  final double? latitude;
  final double? longitude;
  final String? distance; // Computed in UI
  final List<Attachment>? attachments;
  final String? userId;
  final double? foodWeightKg;
  final DateTime? expiryDate;
  final String? urgency;
  final bool? isLikedByMe;
  final bool? isReservable;
  final bool? isDeletable;
  final bool? safetyChecklistCompleted;
  final UserModel? authorDetails;
  final DateTime? createdAt;

  const Donation({
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.categoryId,
    this.category,
    required this.condition,
    required this.status,
    required this.author,
    required this.imageUrl,
    this.latitude,
    this.longitude,
    this.distance,
    this.attachments,
    this.userId,
    this.foodWeightKg,
    this.expiryDate,
    this.urgency,
    this.isLikedByMe,
    this.isReservable,
    this.isDeletable,
    this.safetyChecklistCompleted,
    this.authorDetails,
    this.createdAt,
  });
}
