import 'package:equatable/equatable.dart';

abstract class ReservationEvent extends Equatable {
  const ReservationEvent();

  @override
  List<Object?> get props => [];
}

class FetchUserDonationsEvent extends ReservationEvent {
  final String userId;
  final String? statusFilter;

  const FetchUserDonationsEvent(this.userId, {this.statusFilter});

  @override
  List<Object?> get props => [userId, statusFilter];
}

class FetchUserReservationsEvent extends ReservationEvent {
  final String userId;
  final String? statusFilter;
  final int page;
  final int limit;

  const FetchUserReservationsEvent(
    this.userId, {
    this.statusFilter,
    this.page = 1,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [userId, statusFilter, page, limit];
}

class FetchDonationDetailsEvent extends ReservationEvent {
  final String donationId;

  const FetchDonationDetailsEvent(this.donationId);

  @override
  List<Object?> get props => [donationId];
}

class FetchReservationDetailsEvent extends ReservationEvent {
  final String reservationId;

  const FetchReservationDetailsEvent(this.reservationId);

  @override
  List<Object?> get props => [reservationId];
}

class CreateReservationEvent extends ReservationEvent {
  final String donationId;

  const CreateReservationEvent({required this.donationId});

  @override
  List<Object?> get props => [donationId];
}

class UpdateReservationStatusEvent extends ReservationEvent {
  final String reservationId;
  final String newStatus;

  const UpdateReservationStatusEvent({
    required this.reservationId,
    required this.newStatus,
  });

  @override
  List<Object?> get props => [reservationId, newStatus];
}

class FilterDonationsEvent extends ReservationEvent {
  final String? statusFilter;

  const FilterDonationsEvent(this.statusFilter);

  @override
  List<Object?> get props => [statusFilter];
}

class FilterReservationsEvent extends ReservationEvent {
  final String? statusFilter;

  const FilterReservationsEvent(this.statusFilter);

  @override
  List<Object?> get props => [statusFilter];
}
