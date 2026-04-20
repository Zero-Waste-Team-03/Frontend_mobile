import 'package:equatable/equatable.dart';
import '../../domain/entities/donation.dart';
import '../../domain/entities/category.dart';

abstract class DonationsState extends Equatable {
  const DonationsState();

  @override
  List<Object?> get props => [];
}

class DonationsInitial extends DonationsState {}

class DonationsLoading extends DonationsState {}

class DonationsLoaded extends DonationsState {
  final List<Donation> donations;
  final List<Donation> featuredDonations;
  final List<Donation> standardDonations;
  final List<Category> categories;
  final String? selectedCategoryId;

  const DonationsLoaded({
    required this.donations,
    required this.featuredDonations,
    required this.standardDonations,
    required this.categories,
    this.selectedCategoryId,
  });

  @override
  List<Object?> get props => [
    donations,
    featuredDonations,
    standardDonations,
    categories,
    selectedCategoryId,
  ];
}

class DonationsError extends DonationsState {
  final String message;
  const DonationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class DonationAddSuccess extends DonationsState {
  final Donation donation;
  const DonationAddSuccess(this.donation);

  @override
  List<Object?> get props => [donation];
}

class DonationImageUploadLoading extends DonationsState {}

class DonationImageUploadSuccess extends DonationsState {
  final String attachmentId;
  const DonationImageUploadSuccess(this.attachmentId);

  @override
  List<Object?> get props => [attachmentId];
}

class DonationImageUploadError extends DonationsState {
  final String message;
  const DonationImageUploadError(this.message);

  @override
  List<Object?> get props => [message];
}

class DonationAddLoading extends DonationsState {}

class DonationAddError extends DonationsState {
  final String message;
  const DonationAddError(this.message);

  @override
  List<Object?> get props => [message];
}
