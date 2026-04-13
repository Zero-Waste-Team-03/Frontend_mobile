import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/reservation_repository.dart';
import '../../domain/usecases/create_reservation_usecase.dart';
import '../../domain/usecases/get_user_donations_usecase.dart';
import '../../domain/usecases/get_user_reservations_usecase.dart';
import 'reservation_event.dart';
import 'reservation_state.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final GetUserDonationsUseCase getUserDonationsUseCase;
  final GetUserReservationsUseCase getUserReservationsUseCase;
  final CreateReservationUseCase createReservationUseCase;
  final ReservationRepository repository;

  ReservationBloc({
    required this.getUserDonationsUseCase,
    required this.getUserReservationsUseCase,
    required this.createReservationUseCase,
    required this.repository,
  }) : super(const ReservationInitial()) {
    on<FetchUserDonationsEvent>(_onFetchUserDonations);
    on<FetchUserReservationsEvent>(_onFetchUserReservations);
    on<FetchDonationDetailsEvent>(_onFetchDonationDetails);
    on<FetchReservationDetailsEvent>(_onFetchReservationDetails);
    on<CreateReservationEvent>(_onCreateReservation);
    on<UpdateReservationStatusEvent>(_onUpdateReservationStatus);
    on<FilterDonationsEvent>(_onFilterDonations);
    on<FilterReservationsEvent>(_onFilterReservations);
  }

  Future<void> _onFetchUserDonations(
    FetchUserDonationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const UserDonationsLoading());

    final result = await getUserDonationsUseCase(
      userId: event.userId,
      status: event.statusFilter,
    );

    result.fold(
      (failure) => emit(UserDonationsError(failure.message)),
      (donations) => emit(
        UserDonationsLoaded(donations, activeFilter: event.statusFilter),
      ),
    );
  }

  Future<void> _onFetchUserReservations(
    FetchUserReservationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const UserReservationsLoading());

    final result = await getUserReservationsUseCase(
      userId: event.userId,
      status: event.statusFilter,
    );

    result.fold(
      (failure) => emit(UserReservationsError(failure.message)),
      (reservations) => emit(
        UserReservationsLoaded(reservations, activeFilter: event.statusFilter),
      ),
    );
  }

  Future<void> _onFetchDonationDetails(
    FetchDonationDetailsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const DonationDetailsLoading());

    final result = await repository.getDonationDetails(event.donationId);

    result.fold(
      (failure) => emit(DonationDetailsError(failure.message)),
      (donation) => emit(DonationDetailsLoaded(donation)),
    );
  }

  Future<void> _onFetchReservationDetails(
    FetchReservationDetailsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const ReservationDetailsLoading());

    final result = await repository.getReservationDetails(event.reservationId);

    result.fold(
      (failure) => emit(ReservationDetailsError(failure.message)),
      (reservation) => emit(ReservationDetailsLoaded(reservation)),
    );
  }

  Future<void> _onCreateReservation(
    CreateReservationEvent event,
    Emitter<ReservationState> emit,
  ) async {
    try {
      emit(const ReservationCreating());

      final result = await createReservationUseCase(
        donationId: event.donationId,
      );

      result.fold(
        (failure) {
          emit(ReservationCreationError(failure.message));
        },
        (reservation) {
          emit(ReservationCreated(reservation));
        },
      );
    } catch (e) {
      // Catch any uncaught exceptions and emit error state
      emit(ReservationCreationError('Unexpected error: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateReservationStatus(
    UpdateReservationStatusEvent event,
    Emitter<ReservationState> emit,
  ) async {
    emit(const ReservationStatusUpdating());

    final result = await repository.updateReservationStatus(
      reservationId: event.reservationId,
      newStatus: event.newStatus,
    );

    result.fold(
      (failure) => emit(ReservationStatusUpdateError(failure.message)),
      (reservation) => emit(ReservationStatusUpdated(reservation)),
    );
  }

  Future<void> _onFilterDonations(
    FilterDonationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    final currentState = state;
    if (currentState is UserDonationsLoaded) {
      emit(const UserDonationsLoading());

      final donations = currentState.donations;
      final filtered = event.statusFilter == null || event.statusFilter!.isEmpty
          ? donations
          : donations.where((d) => d.status == event.statusFilter).toList();

      emit(UserDonationsLoaded(filtered, activeFilter: event.statusFilter));
    }
  }

  Future<void> _onFilterReservations(
    FilterReservationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    final currentState = state;
    if (currentState is UserReservationsLoaded) {
      emit(const UserReservationsLoading());

      final reservations = currentState.reservations;
      final filtered = event.statusFilter == null || event.statusFilter!.isEmpty
          ? reservations
          : reservations.where((d) => d.status == event.statusFilter).toList();

      emit(UserReservationsLoaded(filtered, activeFilter: event.statusFilter));
    }
  }
}
