import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class DonationsEvent extends Equatable {
  const DonationsEvent();

  @override
  List<Object?> get props => [];
}

class LoadDonationsEvent extends DonationsEvent {
  final String? categoryId;
  final String? searchQuery;
  final double? latitude;
  final double? longitude;
  final double? radius;

  final bool append;

  const LoadDonationsEvent({
    this.categoryId,
    this.searchQuery,
    this.latitude,
    this.longitude,
    this.radius,
    this.append = false,
  });

  @override
  List<Object?> get props => [categoryId, searchQuery, latitude, longitude, radius, append];
}

class UploadDonationImageEvent extends DonationsEvent {
  final File imageFile;
  const UploadDonationImageEvent(this.imageFile);

  @override
  List<Object?> get props => [imageFile.path];
}

class AddDonationEvent extends DonationsEvent {
  final String title;
  final String description;
  final String categoryId;
  final int quantity;
  final double foodWeightKg;
  final String urgency;
  final String mainAttachmentId;
  final List<String> attachmentIds;
  final DateTime expiryDate;
  final bool safetyChecklistCompleted;
  final double? latitude;
  final double? longitude;

  const AddDonationEvent({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.quantity,
    required this.foodWeightKg,
    required this.urgency,
    required this.mainAttachmentId,
    required this.attachmentIds,
    required this.expiryDate,
    required this.safetyChecklistCompleted,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        categoryId,
        quantity,
        foodWeightKg,
        urgency,
        mainAttachmentId,
        attachmentIds,
        expiryDate,
        safetyChecklistCompleted,
        latitude,
        longitude,
      ];
}
