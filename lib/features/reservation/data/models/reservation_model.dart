import 'package:gaspzero/features/auth/data/models/user_model.dart';

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
        final rawUserJson = donationJson['user'];
        Map<String, dynamic> userJson = rawUserJson is Map<String, dynamic>
            ? rawUserJson
            : <String, dynamic>{};
        if (userJson.isEmpty) {
          print('[ReservationModel] WARNING: No user info found in donation');
          userJson = {
            'id': _asString(donationJson['userId']) ?? '0',
            'displayName': 'Unknown User',
            'phoneNumber': 'No phone number',
          };
        } else {
          // Donation.user from GraphQL may omit `id`; UserModel requires it.
          userJson = {
            ...userJson,
            'id':
                _asString(userJson['id']) ??
                _asString(donationJson['userId']) ??
                '0',
          };
          print('[ReservationModel] User JSON keys: ${userJson.keys.toList()}');
        }
        final author = UserModel.fromJson(userJson);

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
                  id: _asString(id) ?? '',
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
          id: _asString(donationJson['id']) ?? '',
          title: _asString(donationJson['title']) ?? 'Untitled',
          description: _asString(donationJson['description']) ?? '',
          quantity: (donationJson['quantity'] as num?)?.toInt() ?? 1,
          categoryId: _asString(donationJson['categoryId']) ?? 'unknown',
          category: null, // Could be fetched separately
          condition: _asString(donationJson['urgency']) ?? 'MEDIUM',
          status: _asString(donationJson['status']) ?? 'PUBLISHED',
          author: _asString(donationJson['userId']) ?? 'Unknown',
          imageUrl: imageUrl,
          latitude: null,
          longitude: null,
          attachments: attachments,
          userId: _asString(donationJson['userId']),
          foodWeightKg: (donationJson['foodWeightKg'] as num?)?.toDouble(),
          expiryDate: donationJson['expiryDate'] != null
              ? DateTime.tryParse(_asString(donationJson['expiryDate']) ?? '')
              : null,
          urgency: _asString(donationJson['urgency']),
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
      final reservationId = _asString(json['id']) ?? 'unknown_reservation';
      print('[ReservationModel] Reservation ID: $reservationId');

      final model = ReservationModel(
        id: reservationId,
        donationId: _asString(json['donation']?['id']) ?? '',
        beneficiaryId: null, // Not included in new myReservations query
        donation: donation,
        beneficiary: null, // Not included in new myReservations query
        status: ReservationStatusExt.fromString(
          _asString(json['status']) ?? 'PENDING',
        ),
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(_asString(json['createdAt']) ?? '') ??
                  DateTime.now()
            : DateTime.now(),
        confirmedAt: json['confirmedAt'] != null
            ? DateTime.tryParse(_asString(json['confirmedAt']) ?? '')
            : null,
        pickedUpAt: null, // Not in new response
        expiresAt: null, // Not in new response
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(_asString(json['updatedAt']) ?? '')
            : null,
      );

      print('[ReservationModel] SUCCESS: ReservationModel created');
      return model;
    } catch (e) {
      print('[ReservationModel] ERROR during parsing: ${e.runtimeType} - $e');
      rethrow;
    }
  }

  static String? _asString(dynamic value) {
    if (value == null) {
      return null;
    }
    return value.toString();
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
//nothing
