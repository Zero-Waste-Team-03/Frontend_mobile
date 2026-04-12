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

  const LoadDonationsEvent({
    this.categoryId,
    this.searchQuery,
    this.latitude,
    this.longitude,
    this.radius,
  });

  @override
  List<Object?> get props => [categoryId, searchQuery, latitude, longitude, radius];
}

class AddDonationEvent extends DonationsEvent {
  final String title;
  final String description;
  final String categoryId;
  final int quantity;
  final double foodWeightKg;
  final String urgency;
  final File? imageFile;
  final List<String> attachmentIds;
  final DateTime expiryDate;
  final double? latitude;
  final double? longitude;

  const AddDonationEvent({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.quantity,
    required this.foodWeightKg,
    required this.urgency,
    this.imageFile,
    required this.attachmentIds,
    required this.expiryDate,
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
        imageFile?.path,
        attachmentIds,
        expiryDate,
        latitude,
        longitude,
      ];
}
