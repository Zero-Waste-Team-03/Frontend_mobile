import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/reservation.dart';
import '../../../auth/data/models/user_model.dart';
import '../../../donations/data/models/donation_model.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.donationId,
    required super.beneficiaryId,
    super.donation,
    super.beneficiary,
    required super.status,
    required super.createdAt,
    super.confirmedAt,
    super.pickedUpAt,
    super.expiresAt,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    final beneficiary = json['beneficiary'] != null
        ? UserModel.fromJson(
            json['beneficiary'] as Map<String, dynamic>,
          ).toEntity()
        : null;

    final donation = json['donation'] != null
        ? DonationModel.fromJson(json['donation'] as Map<String, dynamic>)
        : null;

    return ReservationModel(
      id: json['id'] as String,
      donationId: json['donationId'] as String,
      beneficiaryId: json['beneficiaryId'] as String,
      donation: donation,
      beneficiary: beneficiary,
      status: ReservationStatusExt.fromString(
        json['status'] as String? ?? 'RESERVED',
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      confirmedAt: json['confirmedAt'] != null
          ? DateTime.parse(json['confirmedAt'] as String)
          : null,
      pickedUpAt: json['pickedUpAt'] != null
          ? DateTime.parse(json['pickedUpAt'] as String)
          : null,
      expiresAt: json['expiresAt'] != null
          ? DateTime.parse(json['expiresAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'donationId': donationId,
      'beneficiaryId': beneficiaryId,
      'donation': donation,
      'beneficiary': beneficiary,
      'status': status.value,
      'createdAt': createdAt.toIso8601String(),
      'confirmedAt': confirmedAt?.toIso8601String(),
      'pickedUpAt': pickedUpAt?.toIso8601String(),
      'expiresAt': expiresAt?.toIso8601String(),
    };
  }

  Reservation toEntity() {
    return Reservation(
      id: id,
      donationId: donationId,
      beneficiaryId: beneficiaryId,
      donation: donation,
      beneficiary: beneficiary,
      status: status,
      createdAt: createdAt,
      confirmedAt: confirmedAt,
      pickedUpAt: pickedUpAt,
      expiresAt: expiresAt,
    );
  }
}

extension ReservationModelX on UserModel {
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: displayName,
      phoneNumber: phoneNumber,
      role: role,
      description: description,
      isMailVerified: isMailVerified,
      reputationScore: reputationScore,
      locationId: locationId,
      location: location,
      avatarUrl: avatarUrl,
    );
  }
}
