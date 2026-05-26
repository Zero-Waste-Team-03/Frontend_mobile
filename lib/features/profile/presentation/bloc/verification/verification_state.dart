import 'package:equatable/equatable.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../../domain/entities/verification_request.dart';

abstract class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {
  const VerificationInitial();
}

class VerificationLoading extends VerificationState {
  const VerificationLoading();
}

class VerificationLoaded extends VerificationState {
  final List<VerificationRequest> requests;
  final int currentPage;
  final int totalCount;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? updatingRequestId;
  final List<User> searchResults;
  final bool isSearching;
  final bool hasReachedSearchMax;
  final int searchPage;
  final String? creatingRequestId;
  final String? successMessage;
  final String? errorMessage;

  const VerificationLoaded({
    required this.requests,
    required this.currentPage,
    required this.totalCount,
    required this.hasReachedMax,
    this.isLoadingMore = false,
    this.updatingRequestId,
    this.searchResults = const [],
    this.isSearching = false,
    this.hasReachedSearchMax = false,
    this.searchPage = 1,
    this.creatingRequestId,
    this.successMessage,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        requests,
        currentPage,
        totalCount,
        hasReachedMax,
        isLoadingMore,
        updatingRequestId,
        searchResults,
        isSearching,
        hasReachedSearchMax,
        searchPage,
        creatingRequestId,
        successMessage,
        errorMessage,
      ];

  VerificationLoaded copyWith({
    List<VerificationRequest>? requests,
    int? currentPage,
    int? totalCount,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? updatingRequestId,
    bool clearUpdatingRequestId = false,
    List<User>? searchResults,
    bool? isSearching,
    bool? hasReachedSearchMax,
    int? searchPage,
    String? creatingRequestId,
    bool clearCreatingRequestId = false,
    String? successMessage,
    bool clearSuccessMessage = false,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return VerificationLoaded(
      requests: requests ?? this.requests,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      updatingRequestId: clearUpdatingRequestId ? null : (updatingRequestId ?? this.updatingRequestId),
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
      hasReachedSearchMax: hasReachedSearchMax ?? this.hasReachedSearchMax,
      searchPage: searchPage ?? this.searchPage,
      creatingRequestId: clearCreatingRequestId ? null : (creatingRequestId ?? this.creatingRequestId),
      successMessage: clearSuccessMessage ? null : (successMessage ?? this.successMessage),
      errorMessage: clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class VerificationError extends VerificationState {
  final String message;

  const VerificationError(this.message);

  @override
  List<Object?> get props => [message];
}
