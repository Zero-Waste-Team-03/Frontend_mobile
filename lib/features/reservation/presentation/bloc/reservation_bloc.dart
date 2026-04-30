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

  // Store current user ID and filter for refetching
  String? _currentUserId;
  String? _currentReservationsFilter;
  int _currentReservationsLimit = 20;

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

    // Store user ID and filter for later refetching
    _currentUserId = event.userId;

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
    final currentState = state;
    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(const UserReservationsLoading());
    } else if (currentState is UserReservationsLoaded) {
      if (currentState.hasReachedMax || currentState.isLoadingMore) {
        return;
      }

      emit(
        UserReservationsLoaded(
          currentState.reservations,
          activeFilter: currentState.activeFilter,
          currentPage: currentState.currentPage,
          isLoadingMore: true,
          hasReachedMax: currentState.hasReachedMax,
        ),
      );
    }

    // Store user ID for later refetching
    _currentUserId = event.userId;
    _currentReservationsFilter = event.statusFilter;
    _currentReservationsLimit = event.limit;

    final result = await getUserReservationsUseCase(
      userId: event.userId,
      status: event.statusFilter,
      page: event.page,
      limit: event.limit,
    );

    result.fold(
      (failure) {
        if (!isFirstPage && currentState is UserReservationsLoaded) {
          emit(
            UserReservationsLoaded(
              currentState.reservations,
              activeFilter: currentState.activeFilter,
              currentPage: currentState.currentPage,
              isLoadingMore: false,
              hasReachedMax: currentState.hasReachedMax,
            ),
          );
        } else {
          emit(UserReservationsError(failure.message));
        }
      },
      (reservations) {
        final hasReachedMax = reservations.length < event.limit;

        if (isFirstPage || currentState is! UserReservationsLoaded) {
          emit(
            UserReservationsLoaded(
              reservations,
              activeFilter: event.statusFilter,
              currentPage: event.page,
              isLoadingMore: false,
              hasReachedMax: hasReachedMax,
            ),
          );
          return;
        }

        final existingById = {
          for (final reservation in currentState.reservations)
            reservation.id: reservation,
        };

        for (final reservation in reservations) {
          existingById[reservation.id] = reservation;
        }

        final mergedReservations = existingById.values.toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        emit(
          UserReservationsLoaded(
            mergedReservations,
            activeFilter: currentState.activeFilter,
            currentPage: event.page,
            isLoadingMore: false,
            hasReachedMax: hasReachedMax,
          ),
        );
      },
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
        quantity: event.quantity,
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
    final previousState = state;

    final result = await repository.updateReservationStatus(
      reservationId: event.reservationId,
      newStatus: event.newStatus,
    );

    result.fold(
      (failure) {
        emit(ReservationStatusUpdateError(failure.message));

        // Restore previous UI state so pages don't get stuck after a failed update.
        if (previousState is ReservationDetailsLoaded) {
          emit(previousState);
        } else if (previousState is UserReservationsLoaded) {
          emit(previousState);
        }
      },
      (reservation) {
        // Keep state shape aligned with the active page, similar to notification flow.
        if (previousState is ReservationDetailsLoaded) {
          emit(ReservationDetailsLoaded(reservation));
          return;
        }

        if (previousState is UserReservationsLoaded) {
          final updatedReservations = previousState.reservations
              .map((item) => item.id == reservation.id ? reservation : item)
              .toList();

          emit(
            UserReservationsLoaded(
              updatedReservations,
              activeFilter: previousState.activeFilter,
              currentPage: previousState.currentPage,
              isLoadingMore: false,
              hasReachedMax: previousState.hasReachedMax,
            ),
          );
          return;
        }

        emit(ReservationStatusUpdated(reservation));
      },
    );
  }

  Future<void> _onFilterDonations(
    FilterDonationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    if (_currentUserId != null) {
      emit(const UserDonationsLoading());

      final result = await getUserDonationsUseCase(
        userId: _currentUserId!,
        status: event.statusFilter,
      );

      result.fold(
        (failure) => emit(UserDonationsError(failure.message)),
        (donations) => emit(
          UserDonationsLoaded(donations, activeFilter: event.statusFilter),
        ),
      );
    }
  }

  Future<void> _onFilterReservations(
    FilterReservationsEvent event,
    Emitter<ReservationState> emit,
  ) async {
    if (_currentUserId != null) {
      _currentReservationsFilter = event.statusFilter;

      add(
        FetchUserReservationsEvent(
          _currentUserId!,
          statusFilter: _currentReservationsFilter,
          page: 1,
          limit: _currentReservationsLimit,
        ),
      );
    }
  }
}
