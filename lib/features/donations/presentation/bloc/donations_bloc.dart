import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/donation_card_tier.dart';
import '../../domain/repositories/donation_repository.dart';
import '../../domain/entities/donation.dart';
import '../../domain/entities/category.dart';
import '../../domain/utils/donation_split_criteria.dart';
import 'donations_event.dart';
import 'donations_state.dart';

class DonationsBloc extends Bloc<DonationsEvent, DonationsState> {
  final DonationRepository donationRepository;
  List<Category> _cachedCategories = const [];

  DonationsBloc({required this.donationRepository})
    : super(DonationsInitial()) {
    on<LoadDonationCategoriesEvent>(_onLoadCategories);
    on<LoadDonationsEvent>(_onLoadDonations);
    on<UploadDonationImageEvent>(_onUploadImage);
    on<AddDonationEvent>(_onAddDonation);
  }

  Future<void> _onLoadCategories(
    LoadDonationCategoriesEvent event,
    Emitter<DonationsState> emit,
  ) async {
    final currentState = state;

    if (_cachedCategories.isNotEmpty && !event.forceRefresh) {
      if (currentState is DonationsLoaded) {
        return;
      }

      emit(
        DonationsLoaded(
          donations: const [],
          featuredDonations: const [],
          standardDonations: const [],
          categories: _cachedCategories,
        ),
      );
      return;
    }

    try {
      _cachedCategories = await donationRepository.getCategories();
      final donations = currentState is DonationsLoaded
          ? currentState.donations
          : const <Donation>[];
      final selectedCategoryId = currentState is DonationsLoaded
          ? currentState.selectedCategoryId
          : null;

      emit(
        DonationsLoaded(
          donations: donations,
          featuredDonations: currentState is DonationsLoaded
              ? currentState.featuredDonations
              : const [],
          standardDonations: currentState is DonationsLoaded
              ? currentState.standardDonations
              : const [],
          categories: _cachedCategories,
          selectedCategoryId: selectedCategoryId,
        ),
      );
    } catch (e) {
      if (currentState is! DonationsLoaded) {
        emit(DonationsError(e.toString()));
      }
    }
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
    final currentState = state;
    List<Donation> existingDonations = [];
    List<Category> categories = _cachedCategories;

    if (currentState is DonationsLoaded && categories.isEmpty) {
      categories = List<Category>.from(currentState.categories);
      _cachedCategories = categories;
    }

    if (event.append && currentState is DonationsLoaded) {
      existingDonations = List.from(currentState.donations);
    } else {
      if (currentState is! DonationsLoaded) {
        emit(DonationsLoading());
      }
    }

    try {
      if (categories.isEmpty) {
        categories = await donationRepository.getCategories();
        _cachedCategories = categories;
      }

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
        final mergedDonations = merged.values.toList();
        final split = _splitDonations(
          mergedDonations,
          event.latitude,
          event.longitude,
        );
        emit(
          DonationsLoaded(
            donations: mergedDonations,
            featuredDonations: split.$1,
            standardDonations: split.$2,
            categories: categories,
            selectedCategoryId: event.categoryId,
          ),
        );
      } else {
        final split = _splitDonations(
          donations,
          event.latitude,
          event.longitude,
        );
        emit(
          DonationsLoaded(
            donations: donations,
            featuredDonations: split.$1,
            standardDonations: split.$2,
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

  (List<Donation>, List<Donation>) _splitDonations(
    List<Donation> donations,
    double? userLatitude,
    double? userLongitude,
  ) {
    final featured = <Donation>[];
    final standard = <Donation>[];

    for (final donation in donations) {
      final tier = resolveDonationCardTier(
        donation: donation,
        userLatitude: userLatitude,
        userLongitude: userLongitude,
      );

      if (tier == DonationCardTier.featured) {
        featured.add(donation);
      } else {
        standard.add(donation);
      }
    }

    return (featured, standard);
  }
}
