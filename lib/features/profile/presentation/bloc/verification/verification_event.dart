import 'package:equatable/equatable.dart';
import '../../../domain/entities/verification_request.dart';

abstract class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object?> get props => [];
}

class VerificationRequestsLoadRequested extends VerificationEvent {
  final int page;
  final int limit;
  final bool isFoodSaver;
  final String? search;

  const VerificationRequestsLoadRequested({
    this.page = 1,
    this.limit = 10,
    required this.isFoodSaver,
    this.search,
  });

  @override
  List<Object?> get props => [page, limit, isFoodSaver, search];
}

class VerificationRequestsLoadMoreRequested extends VerificationEvent {
  final int limit;
  final bool isFoodSaver;

  const VerificationRequestsLoadMoreRequested({
    this.limit = 10,
    required this.isFoodSaver,
  });

  @override
  List<Object?> get props => [limit, isFoodSaver];
}

class VerificationRequestStatusUpdateRequested extends VerificationEvent {
  final String requestId;
  final VerificationRequestStatus status;

  const VerificationRequestStatusUpdateRequested({
    required this.requestId,
    required this.status,
  });

  @override
  List<Object?> get props => [requestId, status];
}

class VerificationSearchRequested extends VerificationEvent {
  final String? search;
  final int page;
  final int limit;

  const VerificationSearchRequested({
    this.search,
    this.page = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [search, page, limit];
}

class VerificationSearchLoadMoreRequested extends VerificationEvent {
  final String? search;
  final int limit;

  const VerificationSearchLoadMoreRequested({
    this.search,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [search, limit];
}

class VerificationRequestCreationRequested extends VerificationEvent {
  final String targetFoodSaverId;

  const VerificationRequestCreationRequested({
    required this.targetFoodSaverId,
  });

  @override
  List<Object?> get props => [targetFoodSaverId];
}

class VerificationRequestDismissed extends VerificationEvent {
  final String requestId;

  const VerificationRequestDismissed({
    required this.requestId,
  });

  @override
  List<Object?> get props => [requestId];
}

class VerificationMessageCleared extends VerificationEvent {
  const VerificationMessageCleared();
}
