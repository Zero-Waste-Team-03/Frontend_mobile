import 'package:gaspzero/features/auth/data/models/user_model.dart';
import 'package:gaspzero/features/auth/domain/entities/user.dart';

import '../../domain/entities/reservation.dart';
import '../../../../core/entities/attachment.dart';
import '../../../donations/domain/entities/donation.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.id,
    required super.donationId,
    super.beneficiaryId,
    super.donation,
    super.beneficiary,
    required super.status,
    required super.createdAt,
    super.confirmedAt,
    super.pickedUpAt,
    super.expiresAt,
    super.updatedAt,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    print('[ReservationModel] fromJson() called');
    print('[ReservationModel] JSON keys: ${json.keys.toList()}');

    try {
      // Parse donation with attachments
      Donation? donation;
      if (json['donation'] != null) {
        print('[ReservationModel] Parsing donation...');
        final donationJson = json['donation'] as Map<String, dynamic>;
        print(
          '[ReservationModel] Donation JSON keys: ${donationJson.keys.toList()}',
        );
        var userJson = json['donation']?['user'] ;
        if (userJson == null) {
          print('[ReservationModel] WARNING: No user info found in donation');
          userJson = {'id': '0', 'displayName': 'Unknown User', 'phoneNumber': 'No phone number'};
        } else {
          print(
            '[ReservationModel] User JSON keys: ${(userJson as Map<String, dynamic>).keys.toList()}',
          );
        };
          var author = UserModel.fromJson(userJson);
          

        // Parse attachments
        List<Attachment> attachments = [];
        if (donationJson['attachmentIds'] != null) {
          final attachmentIds = donationJson['attachmentIds'] as List<dynamic>;
          print('[ReservationModel] Found ${attachmentIds.length} attachments');
          // Note: In real scenario, you'd fetch attachment URLs from backend
          // For now, we store the IDs and use mainAttachmentId for image
          attachments = attachmentIds
              .map(
                (id) => Attachment(
                  id: id as String,
                  url: '', // Would be fetched from backend
                  fileName: 'attachment_$id',
                  fileType: 'image/jpeg',
                  createdAt: DateTime.now(),
                ),
              )
              .toList();
        }

        print('[ReservationModel] Creating Donation entity...');

        // Extract image URL from mainAttachment
        String imageUrl = '';
        if (donationJson['mainAttachment'] != null) {
          final mainAttachment =
              donationJson['mainAttachment'] as Map<String, dynamic>;
          imageUrl = mainAttachment['url'] as String? ?? '';
          print('[ReservationModel] MainAttachment URL: $imageUrl');
        } else {
          print('[ReservationModel] No mainAttachment found in donation');
        }

        donation = Donation(
          id: donationJson['id'] as String? ?? '',
          title: donationJson['title'] as String? ?? 'Untitled',
          description: donationJson['description'] as String? ?? '',
          quantity: (donationJson['quantity'] as num?)?.toInt() ?? 1,
          categoryId: donationJson['categoryId'] as String? ?? 'unknown',
          category: null, // Could be fetched separately
          condition: donationJson['urgency'] as String? ?? 'MEDIUM',
          status: donationJson['status'] as String? ?? 'PUBLISHED',
          author: donationJson['userId'] as String? ?? 'Unknown',
          imageUrl: imageUrl,
          latitude: null,
          longitude: null,
          attachments: attachments,
          userId: donationJson['userId'] as String?,
          foodWeightKg: (donationJson['foodWeightKg'] as num?)?.toDouble(),
          expiryDate: donationJson['expiryDate'] != null
              ? DateTime.parse(donationJson['expiryDate'] as String)
              : null,
          urgency: donationJson['urgency'] as String?,
          isLikedByMe: donationJson['isLikedByMe'] as bool?,
          authorDetails: author,
        );
        print(
          '[ReservationModel] Donation entity created with ID: ${donation.id}',
        );
      } else {
        print('[ReservationModel] No donation found in response');
      }

      print('[ReservationModel] Creating ReservationModel...');
      final reservationId = json['id'] as String;
      print('[ReservationModel] Reservation ID: $reservationId');
      
      final model = ReservationModel(
        id: reservationId,
        donationId: json['donation']?['id'] as String? ?? '',
        beneficiaryId: null, // Not included in new myReservations query
        donation: donation,
        beneficiary: null, // Not included in new myReservations query
        status: ReservationStatusExt.fromString(
          json['status'] as String? ?? 'PENDING',
        ),
        createdAt: json['createdAt'] != null
            ? DateTime.parse(json['createdAt'] as String)
            : DateTime.now(),
        confirmedAt: json['confirmedAt'] != null
            ? DateTime.parse(json['confirmedAt'] as String)
            : null,
        pickedUpAt: null, // Not in new response
        expiresAt: null, // Not in new response
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : null,
      );

      print('[ReservationModel] SUCCESS: ReservationModel created');
      return model;
    } catch (e) {
      print('[ReservationModel] ERROR during parsing: ${e.runtimeType} - $e');
      rethrow;
    }
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
      'updatedAt': updatedAt?.toIso8601String(),
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
      updatedAt: updatedAt,
    );
  }
}
