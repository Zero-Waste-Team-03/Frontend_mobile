import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/donation_repository.dart';
import '../../domain/entities/donation.dart';
import '../../domain/entities/category.dart';
import 'donations_event.dart';
import 'donations_state.dart';

class DonationsBloc extends Bloc<DonationsEvent, DonationsState> {
  final DonationRepository donationRepository;

  DonationsBloc({required this.donationRepository})
    : super(DonationsInitial()) {
    on<LoadDonationsEvent>(_onLoadDonations);
    on<UploadDonationImageEvent>(_onUploadImage);
    on<AddDonationEvent>(_onAddDonation);
  }

  Future<void> _onUploadImage(
    UploadDonationImageEvent event,
    Emitter<DonationsState> emit,
  ) async {
    emit(DonationImageUploadLoading());
    try {
      final attachmentId = await donationRepository.uploadDonationImage(
        event.imageFile,
      );
      emit(DonationImageUploadSuccess(attachmentId));
    } catch (e) {
      emit(DonationImageUploadError(e.toString()));
    }
  }

  Future<void> _onLoadDonations(
    LoadDonationsEvent event,
    Emitter<DonationsState> emit,
  ) async {
    List<Donation> existingDonations = [];
    List<Category>? existingCategories;

    if (event.append && state is DonationsLoaded) {
      existingDonations = List.from((state as DonationsLoaded).donations);
      existingCategories = (state as DonationsLoaded).categories;
    } else {
      emit(DonationsLoading());
    }

    try {
      final categories =
          existingCategories ?? await donationRepository.getCategories();
      final donations = await donationRepository.getDonations(
        categoryId: event.categoryId,
        searchQuery: event.searchQuery,
        latitude: event.latitude,
        longitude: event.longitude,
        radius: event.radius,
      );

      if (event.append) {
        final Map<String, Donation> merged = {
          for (var d in existingDonations) d.id: d,
          for (var d in donations) d.id: d,
        };
        emit(
          DonationsLoaded(
            donations: merged.values.toList(),
            categories: categories,
            selectedCategoryId: event.categoryId,
          ),
        );
      } else {
        emit(
          DonationsLoaded(
            donations: donations,
            categories: categories,
            selectedCategoryId: event.categoryId,
          ),
        );
      }
    } catch (e) {
      if (!event.append) {
        emit(DonationsError(e.toString()));
      }
    }
  }

  Future<void> _onAddDonation(
    AddDonationEvent event,
    Emitter<DonationsState> emit,
  ) async {
    emit(DonationAddLoading());
    try {
      final newDonation = await donationRepository.createDonation(
        title: event.title,
        description: event.description,
        categoryId: event.categoryId,
        quantity: event.quantity,
        foodWeightKg: event.foodWeightKg,
        urgency: event.urgency,
        mainAttachmentId: event.mainAttachmentId,
        attachmentIds: event.attachmentIds,
        expiryDate: event.expiryDate,
        safetyChecklistCompleted: event.safetyChecklistCompleted,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      emit(DonationAddSuccess(newDonation));
      // Reload donations might be handled from the UI after success
    } catch (e) {
      emit(DonationAddError(e.toString()));
    }
  }
}
