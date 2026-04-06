import 'package:equatable/equatable.dart';

abstract class DonationsEvent extends Equatable {
  const DonationsEvent();

  @override
  List<Object?> get props => [];
}

class LoadDonationsEvent extends DonationsEvent {
  final String? categoryId;
  const LoadDonationsEvent({this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}

class AddDonationEvent extends DonationsEvent {
  final String title;
  final String description;
  final String categoryId;
  final int quantity;
  final String urgency;
  final String mainAttachmentId;
  final List<String> attachmentIds;
  final DateTime expiryDate;

  const AddDonationEvent({
    required this.title,
    required this.description,
    required this.categoryId,
    required this.quantity,
    required this.urgency,
    required this.mainAttachmentId,
    required this.attachmentIds,
    required this.expiryDate,
  });

  @override
  List<Object?> get props => [
        title,
        description,
        categoryId,
        quantity,
        urgency,
        mainAttachmentId,
        attachmentIds,
        expiryDate,
      ];
}
