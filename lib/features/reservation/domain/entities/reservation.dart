import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../donations/domain/entities/donation.dart';

enum ReservationStatus { reserved, confirmed, pickedUp, expired }

extension ReservationStatusExt on ReservationStatus {
  String get value {
    switch (this) {
      case ReservationStatus.reserved:
        return 'RESERVED';
      case ReservationStatus.confirmed:
        return 'CONFIRMED';
      case ReservationStatus.pickedUp:
        return 'PICKED_UP';
      case ReservationStatus.expired:
        return 'EXPIRED';
    }
  }

  String get displayName {
    switch (this) {
      case ReservationStatus.reserved:
        return 'Reserved';
      case ReservationStatus.confirmed:
        return 'Confirmed';
      case ReservationStatus.pickedUp:
        return 'Picked up';
      case ReservationStatus.expired:
        return 'Expired';
    }
  }

  static ReservationStatus fromString(String value) {
    return ReservationStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ReservationStatus.reserved,
    );
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
  });

  bool get isActive =>
      status == ReservationStatus.reserved ||
      status == ReservationStatus.confirmed;
  bool get isCompleted => status == ReservationStatus.pickedUp;
  bool get isExpired => status == ReservationStatus.expired;

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
    );
  }

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
  ];
}
