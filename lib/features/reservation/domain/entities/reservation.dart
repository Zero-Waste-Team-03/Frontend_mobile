import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../donations/domain/entities/donation.dart';

enum ReservationStatus { pending, confirmed, completed, cancelled }

extension ReservationStatusExt on ReservationStatus {
  String get value {
    switch (this) {
      case ReservationStatus.pending:
        return 'PENDING';
      case ReservationStatus.confirmed:
        return 'CONFIRMED';
      case ReservationStatus.completed:
        return 'COMPLETED';
      case ReservationStatus.cancelled:
        return 'CANCELLED';
    }
  }

  String get displayName {
    switch (this) {
      case ReservationStatus.pending:
        return 'Pending';
      case ReservationStatus.confirmed:
        return 'Confirmed';
      case ReservationStatus.completed:
        return 'Completed';
      case ReservationStatus.cancelled:
        return 'Cancelled';
    }
  }

  static ReservationStatus fromString(String value) {
    switch (value.toUpperCase()) {
      case 'PENDING':
      case 'RESERVED':
        return ReservationStatus.pending;
      case 'CONFIRMED':
        return ReservationStatus.confirmed;
      case 'COMPLETED':
      case 'PICKED_UP':
        return ReservationStatus.completed;
      case 'CANCELLED':
      case 'EXPIRED':
        return ReservationStatus.cancelled;
      default:
        return ReservationStatus.pending;
    }
  }
}

class Reservation extends Equatable {
  final String id;
  final String donationId;
  final String? beneficiaryId;
  final Donation? donation;
  final User? beneficiary;
  final ReservationStatus status;
  final DateTime createdAt;
  final DateTime? confirmedAt;
  final DateTime? pickedUpAt;
  final DateTime? expiresAt;
  final DateTime? updatedAt;

  const Reservation({
    required this.id,
    required this.donationId,
    this.beneficiaryId,
    this.donation,
    this.beneficiary,
    required this.status,
    required this.createdAt,
    this.confirmedAt,
    this.pickedUpAt,
    this.expiresAt,
    this.updatedAt,
  });

  bool get isActive =>
      status == ReservationStatus.pending ||
      status == ReservationStatus.confirmed;
  bool get isCompleted => status == ReservationStatus.completed;
  bool get isCancelled => status == ReservationStatus.cancelled;

  Reservation copyWith({
    String? id,
    String? donationId,
    String? beneficiaryId,
    Donation? donation,
    User? beneficiary,
    ReservationStatus? status,
    DateTime? createdAt,
    DateTime? confirmedAt,
    DateTime? pickedUpAt,
    DateTime? expiresAt,
    DateTime? updatedAt,
  }) {
    return Reservation(
      id: id ?? this.id,
      donationId: donationId ?? this.donationId,
      beneficiaryId: beneficiaryId ?? this.beneficiaryId,
      donation: donation ?? this.donation,
      beneficiary: beneficiary ?? this.beneficiary,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      confirmedAt: confirmedAt ?? this.confirmedAt,
      pickedUpAt: pickedUpAt ?? this.pickedUpAt,
      expiresAt: expiresAt ?? this.expiresAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  @override
  List<Object?> get props => [
    id,
    donationId,
    beneficiaryId,
    donation,
    beneficiary,
    status,
    createdAt,
    confirmedAt,
    pickedUpAt,
    expiresAt,
    updatedAt,
  ];
}
