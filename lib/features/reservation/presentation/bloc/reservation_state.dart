import 'package:equatable/equatable.dart';
import '../../../donations/domain/entities/donation.dart';
import '../../domain/entities/reservation.dart';

abstract class ReservationState extends Equatable {
  const ReservationState();

  @override
  List<Object?> get props => [];
}

class ReservationInitial extends ReservationState {
  const ReservationInitial();
}

// User Donations States
class UserDonationsLoading extends ReservationState {
  const UserDonationsLoading();
}

class UserDonationsLoaded extends ReservationState {
  final List<Donation> donations;
  final String? activeFilter;

  const UserDonationsLoaded(this.donations, {this.activeFilter});

  @override
  List<Object?> get props => [donations, activeFilter];
}

class UserDonationsError extends ReservationState {
  final String message;

  const UserDonationsError(this.message);

  @override
  List<Object?> get props => [message];
}

// User Reservations States
class UserReservationsLoading extends ReservationState {
  const UserReservationsLoading();
}

class UserReservationsLoaded extends ReservationState {
  final List<Reservation> reservations;
  final String? activeFilter;

  const UserReservationsLoaded(this.reservations, {this.activeFilter});

  @override
  List<Object?> get props => [reservations, activeFilter];
}

class UserReservationsError extends ReservationState {
  final String message;

  const UserReservationsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Donation Details States
class DonationDetailsLoading extends ReservationState {
  const DonationDetailsLoading();
}

class DonationDetailsLoaded extends ReservationState {
  final Donation donation;

  const DonationDetailsLoaded(this.donation);

  @override
  List<Object?> get props => [donation];
}

class DonationDetailsError extends ReservationState {
  final String message;

  const DonationDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Reservation Details States
class ReservationDetailsLoading extends ReservationState {
  const ReservationDetailsLoading();
}

class ReservationDetailsLoaded extends ReservationState {
  final Reservation reservation;

  const ReservationDetailsLoaded(this.reservation);

  @override
  List<Object?> get props => [reservation];
}

class ReservationDetailsError extends ReservationState {
  final String message;

  const ReservationDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

// Reservation Creation States
class ReservationCreating extends ReservationState {
  const ReservationCreating();
}

class ReservationCreated extends ReservationState {
  final Reservation reservation;

  const ReservationCreated(this.reservation);

  @override
  List<Object?> get props => [reservation];
}

class ReservationCreationError extends ReservationState {
  final String message;

  const ReservationCreationError(this.message);

  @override
  List<Object?> get props => [message];
}

// Reservation Status Update States
class ReservationStatusUpdating extends ReservationState {
  const ReservationStatusUpdating();
}

class ReservationStatusUpdated extends ReservationState {
  final Reservation reservation;

  const ReservationStatusUpdated(this.reservation);

  @override
  List<Object?> get props => [reservation];
}

class ReservationStatusUpdateError extends ReservationState {
  final String message;

  const ReservationStatusUpdateError(this.message);

  @override
  List<Object?> get props => [message];
}
