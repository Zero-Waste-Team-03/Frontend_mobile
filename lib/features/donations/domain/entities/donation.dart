import 'category.dart';

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
  });
}
