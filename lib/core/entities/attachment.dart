import 'package:equatable/equatable.dart';

/// Attachment entity representing a file/media attachment
/// Used across the application for images, documents, and other file references
class Attachment extends Equatable {
  final String id;
  final String url;
  final String fileName;
  final String fileType;
  final int? fileSize;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Attachment({
    required this.id,
    required this.url,
    required this.fileName,
    required this.fileType,
    this.fileSize,
    required this.createdAt,
    this.updatedAt,
  });

  /// Check if attachment is an image
  bool get isImage => fileType.startsWith('image/');

  /// Check if attachment is a document
  bool get isDocument => fileType.startsWith('application/');

  /// Get display name (fileName or 'Unnamed attachment')
  String get displayName =>
      fileName.isNotEmpty ? fileName : 'Unnamed attachment';

  @override
  List<Object?> get props => [
    id,
    url,
    fileName,
    fileType,
    fileSize,
    createdAt,
    updatedAt,
  ];
}
