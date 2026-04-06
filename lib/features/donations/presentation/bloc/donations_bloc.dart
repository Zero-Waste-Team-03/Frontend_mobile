import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/donation_repository.dart';
import 'donations_event.dart';
import 'donations_state.dart';

class DonationsBloc extends Bloc<DonationsEvent, DonationsState> {
  final DonationRepository donationRepository;

  DonationsBloc({required this.donationRepository}) : super(DonationsInitial()) {
    on<LoadDonationsEvent>(_onLoadDonations);
    on<AddDonationEvent>(_onAddDonation);
  }

  Future<void> _onLoadDonations(
    LoadDonationsEvent event,
    Emitter<DonationsState> emit,
  ) async {
    emit(DonationsLoading());
    try {
      final categories = await donationRepository.getCategories();
      final donations = await donationRepository.getDonations(
        categoryId: event.categoryId,
      );

      emit(DonationsLoaded(
        donations: donations,
        categories: categories,
        selectedCategoryId: event.categoryId,
      ));
    } catch (e) {
      emit(DonationsError(e.toString()));
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
        urgency: event.urgency,
        mainAttachmentId: event.mainAttachmentId,
        attachmentIds: event.attachmentIds,
        expiryDate: event.expiryDate,
      );
      emit(DonationAddSuccess(newDonation));
      // Reload donations might be handled from the UI after success
    } catch (e) {
      emit(DonationAddError(e.toString()));
    }
  }
}
