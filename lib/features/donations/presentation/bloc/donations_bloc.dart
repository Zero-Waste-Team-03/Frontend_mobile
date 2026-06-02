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
    on<UpdateDonationEvent>(_onUpdateDonation);
    on<DeleteDonationEvent>(_onDeleteDonation);
  }

  Future<void> _onUpdateDonation(
    UpdateDonationEvent event,
    Emitter<DonationsState> emit,
  ) async {
    emit(DonationUpdateLoading());
    try {
      final result = await donationRepository.updateDonation(
        id: event.id,
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
      result.fold(
        (failure) => emit(DonationUpdateError(failure.message)),
        (updatedDonation) => emit(DonationUpdateSuccess(updatedDonation)),
      );
    } catch (e) {
      emit(DonationUpdateError(e.toString()));
    }
  }

  Future<void> _onDeleteDonation(
    DeleteDonationEvent event,
    Emitter<DonationsState> emit,
  ) async {
    emit(DonationDeleteLoading());
    try {
      final result = await donationRepository.deleteDonation(event.id);
      result.fold(
        (failure) => emit(DonationDeleteError(failure.message)),
        (_) => emit(DonationDeleteSuccess(event.id)),
      );
    } catch (e) {
      emit(DonationDeleteError(e.toString()));
    }
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
      final categoriesResult = await donationRepository.getCategories();
      categoriesResult.fold(
        (failure) {
          if (currentState is! DonationsLoaded) {
            emit(DonationsError(failure.message));
          }
        },
        (cats) {
          _cachedCategories = cats;
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
        },
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
      final result = await donationRepository.uploadDonationImage(
        event.imageFile,
      );
      result.fold(
        (failure) => emit(DonationImageUploadError(failure.message)),
        (attachmentId) => emit(DonationImageUploadSuccess(attachmentId)),
      );
    } catch (e) {
      emit(DonationImageUploadError(e.toString()));
    }
  }

  Future<void> _onAddDonation(
    AddDonationEvent event,
    Emitter<DonationsState> emit,
  ) async {
    emit(DonationAddLoading());
    try {
      final result = await donationRepository.createDonation(
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
      result.fold(
        (failure) => emit(DonationAddError(failure.message)),
        (newDonation) => emit(DonationAddSuccess(newDonation)),
      );
    } catch (e) {
      emit(DonationAddError(e.toString()));
    }
  }

  Future<void> _onLoadDonations(
    LoadDonationsEvent event,
    Emitter<DonationsState> emit,
  ) async {
    final currentState = state;
    List<Donation> existingDonations = [];
    List<Category> categories = _cachedCategories;
    int pageToLoad = 1;

    if (currentState is DonationsLoaded) {
      if (categories.isEmpty) {
        categories = List<Category>.from(currentState.categories);
        _cachedCategories = categories;
      }
      
      if (event.append) {
        // Prevent concurrent page loads
        if (currentState.isLoadingMore || !currentState.hasNextPage) return;
        
        existingDonations = List.from(currentState.donations);
        pageToLoad = currentState.currentPage + 1;
        
        // Emit loading more state
        emit(currentState.copyWith(isLoadingMore: true));
      }
    }

    // Force a fresh loading state if not appending
    if (!event.append) {
      emit(DonationsLoading());
    }

    try {
      if (categories.isEmpty) {
        final categoriesResult = await donationRepository.getCategories();
        categoriesResult.fold(
          (failure) => throw Exception(failure.message),
          (cats) {
            categories = cats;
            _cachedCategories = categories;
          },
        );
      }

      final limit = 10;
      final donationsResult = await donationRepository.getDonations(
        page: pageToLoad,
        limit: limit,
        categoryId: event.categoryId,
        searchQuery: event.searchQuery,
        latitude: event.latitude,
        longitude: event.longitude,
        radius: event.radius,
      );

      donationsResult.fold(
        (failure) {
          if (!event.append) {
            emit(DonationsError(failure.message));
          } else if (state is DonationsLoaded) {
            emit((state as DonationsLoaded).copyWith(isLoadingMore: false));
          }
        },
        (donations) {
          final hasNextPage = donations.length == limit;

          if (event.append && state is DonationsLoaded) {
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
              (state as DonationsLoaded).copyWith(
                donations: mergedDonations,
                featuredDonations: split.$1,
                standardDonations: split.$2,
                categories: categories,
                selectedCategoryId: event.categoryId,
                currentPage: pageToLoad,
                hasNextPage: hasNextPage,
                isLoadingMore: false,
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
                currentPage: pageToLoad,
                hasNextPage: hasNextPage,
                isLoadingMore: false,
              ),
            );
          }
        },
      );
    } catch (e) {
      if (!event.append) {
        emit(DonationsError(e.toString()));
      } else if (state is DonationsLoaded) {
        emit((state as DonationsLoaded).copyWith(isLoadingMore: false));
      }
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
