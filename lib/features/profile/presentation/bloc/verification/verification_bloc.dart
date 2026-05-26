import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/verification_request.dart';
import '../../../domain/repositories/profile_repository.dart';
import 'verification_event.dart';
import 'verification_state.dart';

@injectable
class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final ProfileRepository profileRepository;

  VerificationBloc({required this.profileRepository})
      : super(const VerificationInitial()) {
    on<VerificationRequestsLoadRequested>(_onVerificationRequestsLoadRequested);
    on<VerificationRequestsLoadMoreRequested>(_onVerificationRequestsLoadMoreRequested);
    on<VerificationRequestStatusUpdateRequested>(_onVerificationRequestStatusUpdateRequested);
    on<VerificationSearchRequested>(_onVerificationSearchRequested);
    on<VerificationSearchLoadMoreRequested>(_onVerificationSearchLoadMoreRequested);
    on<VerificationRequestCreationRequested>(_onVerificationRequestCreationRequested);
    on<VerificationMessageCleared>(_onVerificationMessageCleared);
  }

  void _onVerificationMessageCleared(
    VerificationMessageCleared event,
    Emitter<VerificationState> emit,
  ) {
    if (state is VerificationLoaded) {
      emit((state as VerificationLoaded).copyWith(
        clearSuccessMessage: true,
        clearErrorMessage: true,
      ));
    }
  }

  Future<void> _onVerificationSearchRequested(
    VerificationSearchRequested event,
    Emitter<VerificationState> emit,
  ) async {
    final isFirstPage = event.page == 1;
    final currentState = state is VerificationLoaded
        ? state as VerificationLoaded
        : VerificationLoaded(
            requests: const [],
            currentPage: 1,
            totalCount: 0,
            hasReachedMax: false,
          );

    if (isFirstPage) {
      emit(currentState.copyWith(
        isSearching: true,
        searchResults: [],
        searchPage: 1,
        hasReachedSearchMax: false,
      ));
    } else {
      if (currentState.hasReachedSearchMax || currentState.isSearching) return;
      emit(currentState.copyWith(isSearching: true));
    }

    final result = await profileRepository.searchUsersToVerify(
      page: event.page,
      limit: event.limit,
      search: event.search,
    );

    result.fold(
      (failure) => emit(currentState.copyWith(isSearching: false)),
      (users) {
        final newResults = isFirstPage ? users : [...currentState.searchResults, ...users];
        emit(currentState.copyWith(
          searchResults: newResults,
          isSearching: false,
          searchPage: event.page,
          hasReachedSearchMax: users.length < event.limit,
        ));
      },
    );
  }

  Future<void> _onVerificationSearchLoadMoreRequested(
    VerificationSearchLoadMoreRequested event,
    Emitter<VerificationState> emit,
  ) async {
    if (state is! VerificationLoaded) return;
    final currentState = state as VerificationLoaded;

    add(VerificationSearchRequested(
      page: currentState.searchPage + 1,
      limit: event.limit,
      search: event.search,
    ));
  }

  Future<void> _onVerificationRequestCreationRequested(
    VerificationRequestCreationRequested event,
    Emitter<VerificationState> emit,
  ) async {
    if (state is! VerificationLoaded) return;
    final currentState = state as VerificationLoaded;

    emit(currentState.copyWith(creatingRequestId: event.targetFoodSaverId));

    final result = await profileRepository.createVerificationRequest(
      targetFoodSaverId: event.targetFoodSaverId,
    );

    result.fold(
      (failure) => emit(currentState.copyWith(
        clearCreatingRequestId: true,
        errorMessage: failure.message,
      )),
      (newRequest) {
        emit(currentState.copyWith(
          requests: [newRequest, ...currentState.requests],
          clearCreatingRequestId: true,
          successMessage: 'Connection request sent successfully!',
        ));
      },
    );
  }

  Future<void> _onVerificationRequestStatusUpdateRequested(
    VerificationRequestStatusUpdateRequested event,
    Emitter<VerificationState> emit,
  ) async {
    if (state is! VerificationLoaded) return;
    final currentState = state as VerificationLoaded;

    emit(currentState.copyWith(updatingRequestId: event.requestId));

    final result = await profileRepository.updateVerificationRequestStatus(
      id: event.requestId,
      status: event.status,
    );

    result.fold(
      (failure) => emit(currentState.copyWith(
        clearUpdatingRequestId: true,
        errorMessage: failure.message,
      )),
      (updatedRequest) {
        final updatedRequests = currentState.requests.map((r) {
          return r.id == updatedRequest.id ? updatedRequest : r;
        }).toList();

        emit(currentState.copyWith(
          requests: List<VerificationRequest>.from(updatedRequests),
          clearUpdatingRequestId: true,
          successMessage: event.status == VerificationRequestStatus.approved
              ? 'Member verified successfully!'
              : 'Request rejected.',
        ));
      },
    );
  }

  Future<void> _onVerificationRequestsLoadRequested(
    VerificationRequestsLoadRequested event,
    Emitter<VerificationState> emit,
  ) async {
    final isFirstPage = event.page == 1;

    if (isFirstPage) {
      emit(const VerificationLoading());
    } else if (state is VerificationLoaded) {
      final currentState = state as VerificationLoaded;
      if (currentState.hasReachedMax || currentState.isLoadingMore) return;
      emit(currentState.copyWith(isLoadingMore: true));
    }

    final result = event.isFoodSaver
        ? await profileRepository.getVerificationRequestsForFoodSaver(
            page: event.page,
            limit: event.limit,
            search: event.search,
          )
        : await profileRepository.getSentVerificationRequests(
            page: event.page,
            limit: event.limit,
          );

    result.fold(
      (failure) => emit(VerificationError(failure.message)),
      (page) {
        if (isFirstPage || state is! VerificationLoaded) {
          emit(VerificationLoaded(
            requests: page.requests,
            currentPage: page.page,
            totalCount: page.totalCount,
            hasReachedMax: !page.hasNextPage,
          ));
        } else {
          final currentState = state as VerificationLoaded;
          emit(VerificationLoaded(
            requests: [...currentState.requests, ...page.requests],
            currentPage: page.page,
            totalCount: page.totalCount,
            hasReachedMax: !page.hasNextPage,
          ));
        }
      },
    );
  }

  Future<void> _onVerificationRequestsLoadMoreRequested(
    VerificationRequestsLoadMoreRequested event,
    Emitter<VerificationState> emit,
  ) async {
    if (state is! VerificationLoaded) return;
    final currentState = state as VerificationLoaded;

    add(VerificationRequestsLoadRequested(
      page: currentState.currentPage + 1,
      limit: event.limit,
      isFoodSaver: event.isFoodSaver,
    ));
  }
}
