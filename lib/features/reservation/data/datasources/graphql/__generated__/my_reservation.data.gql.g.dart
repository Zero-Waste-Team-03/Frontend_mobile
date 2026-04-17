// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservation.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyReservationData> _$gMyReservationDataSerializer =
    _$GMyReservationDataSerializer();
Serializer<GMyReservationData_myReservation>
_$gMyReservationDataMyReservationSerializer =
    _$GMyReservationData_myReservationSerializer();
Serializer<GMyReservationData_myReservation_donation>
_$gMyReservationDataMyReservationDonationSerializer =
    _$GMyReservationData_myReservation_donationSerializer();
Serializer<GMyReservationData_myReservation_donation_mainAttachment>
_$gMyReservationDataMyReservationDonationMainAttachmentSerializer =
    _$GMyReservationData_myReservation_donation_mainAttachmentSerializer();
Serializer<GMyReservationData_myReservation_donation_user>
_$gMyReservationDataMyReservationDonationUserSerializer =
    _$GMyReservationData_myReservation_donation_userSerializer();
Serializer<GMyReservationData_myReservation_donation_user_avatar>
_$gMyReservationDataMyReservationDonationUserAvatarSerializer =
    _$GMyReservationData_myReservation_donation_user_avatarSerializer();

class _$GMyReservationDataSerializer
    implements StructuredSerializer<GMyReservationData> {
  @override
  final Iterable<Type> types = const [GMyReservationData, _$GMyReservationData];
  @override
  final String wireName = 'GMyReservationData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'myReservation',
      serializers.serialize(
        object.myReservation,
        specifiedType: const FullType(GMyReservationData_myReservation),
      ),
    ];

    return result;
  }

  @override
  GMyReservationData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'myReservation':
          result.myReservation.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMyReservationData_myReservation,
                  ),
                )!
                as GMyReservationData_myReservation,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationData_myReservationSerializer
    implements StructuredSerializer<GMyReservationData_myReservation> {
  @override
  final Iterable<Type> types = const [
    GMyReservationData_myReservation,
    _$GMyReservationData_myReservation,
  ];
  @override
  final String wireName = 'GMyReservationData_myReservation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationData_myReservation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i2.GReservationStatus),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
    ];
    Object? value;
    value = object.confirmedAt;
    if (value != null) {
      result
        ..add('confirmedAt')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i2.GDateTime),
          ),
        );
    }
    value = object.donation;
    if (value != null) {
      result
        ..add('donation')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GMyReservationData_myReservation_donation,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GMyReservationData_myReservation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationData_myReservationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GReservationStatus),
                  )!
                  as _i2.GReservationStatus;
          break;
        case 'createdAt':
          result.createdAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'confirmedAt':
          result.confirmedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'updatedAt':
          result.updatedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'donation':
          result.donation.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMyReservationData_myReservation_donation,
                  ),
                )!
                as GMyReservationData_myReservation_donation,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationData_myReservation_donationSerializer
    implements StructuredSerializer<GMyReservationData_myReservation_donation> {
  @override
  final Iterable<Type> types = const [
    GMyReservationData_myReservation_donation,
    _$GMyReservationData_myReservation_donation,
  ];
  @override
  final String wireName = 'GMyReservationData_myReservation_donation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationData_myReservation_donation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'description',
      serializers.serialize(
        object.description,
        specifiedType: const FullType(String),
      ),
      'quantity',
      serializers.serialize(
        object.quantity,
        specifiedType: const FullType(int),
      ),
      'categoryId',
      serializers.serialize(
        object.categoryId,
        specifiedType: const FullType(String),
      ),
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i2.GDonationStatusValues),
      ),
      'urgency',
      serializers.serialize(
        object.urgency,
        specifiedType: const FullType(_i2.GDonationUrgencyValues),
      ),
      'expiryDate',
      serializers.serialize(
        object.expiryDate,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'attachmentIds',
      serializers.serialize(
        object.attachmentIds,
        specifiedType: const FullType(BuiltList, const [
          const FullType(String),
        ]),
      ),
      'userId',
      serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      ),
      'safetyChecklistCompleted',
      serializers.serialize(
        object.safetyChecklistCompleted,
        specifiedType: const FullType(bool),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'user',
      serializers.serialize(
        object.user,
        specifiedType: const FullType(
          GMyReservationData_myReservation_donation_user,
        ),
      ),
    ];
    Object? value;
    value = object.publishedAt;
    if (value != null) {
      result
        ..add('publishedAt')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i2.GDateTime),
          ),
        );
    }
    value = object.locationId;
    if (value != null) {
      result
        ..add('locationId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.mainAttachmentId;
    if (value != null) {
      result
        ..add('mainAttachmentId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.listingExpiresAt;
    if (value != null) {
      result
        ..add('listingExpiresAt')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i2.GDateTime),
          ),
        );
    }
    value = object.mainAttachment;
    if (value != null) {
      result
        ..add('mainAttachment')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GMyReservationData_myReservation_donation_mainAttachment,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GMyReservationData_myReservation_donation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationData_myReservation_donationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'quantity':
          result.quantity =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'categoryId':
          result.categoryId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GDonationStatusValues),
                  )!
                  as _i2.GDonationStatusValues;
          break;
        case 'urgency':
          result.urgency =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GDonationUrgencyValues),
                  )!
                  as _i2.GDonationUrgencyValues;
          break;
        case 'expiryDate':
          result.expiryDate.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'publishedAt':
          result.publishedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'locationId':
          result.locationId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'mainAttachmentId':
          result.mainAttachmentId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'attachmentIds':
          result.attachmentIds.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(String),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
        case 'userId':
          result.userId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'safetyChecklistCompleted':
          result.safetyChecklistCompleted =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'listingExpiresAt':
          result.listingExpiresAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'updatedAt':
          result.updatedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'mainAttachment':
          result.mainAttachment.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMyReservationData_myReservation_donation_mainAttachment,
                  ),
                )!
                as GMyReservationData_myReservation_donation_mainAttachment,
          );
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMyReservationData_myReservation_donation_user,
                  ),
                )!
                as GMyReservationData_myReservation_donation_user,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationData_myReservation_donation_mainAttachmentSerializer
    implements
        StructuredSerializer<
          GMyReservationData_myReservation_donation_mainAttachment
        > {
  @override
  final Iterable<Type> types = const [
    GMyReservationData_myReservation_donation_mainAttachment,
    _$GMyReservationData_myReservation_donation_mainAttachment,
  ];
  @override
  final String wireName =
      'GMyReservationData_myReservation_donation_mainAttachment';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationData_myReservation_donation_mainAttachment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'fileName',
      serializers.serialize(
        object.fileName,
        specifiedType: const FullType(String),
      ),
      'fileType',
      serializers.serialize(
        object.fileType,
        specifiedType: const FullType(String),
      ),
      'fileSize',
      serializers.serialize(
        object.fileSize,
        specifiedType: const FullType(double),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'uploadedById',
      serializers.serialize(
        object.uploadedById,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.url;
    if (value != null) {
      result
        ..add('url')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updatedAt')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i2.GDateTime),
          ),
        );
    }
    value = object.uploadStatus;
    if (value != null) {
      result
        ..add('uploadStatus')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i2.GUploadStatusValues),
          ),
        );
    }
    value = object.jobId;
    if (value != null) {
      result
        ..add('jobId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GMyReservationData_myReservation_donation_mainAttachment deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GMyReservationData_myReservation_donation_mainAttachmentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'url':
          result.url =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'fileName':
          result.fileName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'fileType':
          result.fileType =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'fileSize':
          result.fileSize =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )!
                  as double;
          break;
        case 'createdAt':
          result.createdAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'updatedAt':
          result.updatedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'uploadStatus':
          result.uploadStatus =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GUploadStatusValues),
                  )
                  as _i2.GUploadStatusValues?;
          break;
        case 'jobId':
          result.jobId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'uploadedById':
          result.uploadedById =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationData_myReservation_donation_userSerializer
    implements
        StructuredSerializer<GMyReservationData_myReservation_donation_user> {
  @override
  final Iterable<Type> types = const [
    GMyReservationData_myReservation_donation_user,
    _$GMyReservationData_myReservation_donation_user,
  ];
  @override
  final String wireName = 'GMyReservationData_myReservation_donation_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationData_myReservation_donation_user object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'email',
      serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'isMailVerified',
      serializers.serialize(
        object.isMailVerified,
        specifiedType: const FullType(bool),
      ),
      'reputationScore',
      serializers.serialize(
        object.reputationScore,
        specifiedType: const FullType(int),
      ),
      'role',
      serializers.serialize(
        object.role,
        specifiedType: const FullType(_i2.GUserRole),
      ),
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
    ];
    Object? value;
    value = object.avatarAttachmentId;
    if (value != null) {
      result
        ..add('avatarAttachmentId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('displayName')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.lastChangedPasswordDate;
    if (value != null) {
      result
        ..add('lastChangedPasswordDate')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i2.GDateTime),
          ),
        );
    }
    value = object.locationId;
    if (value != null) {
      result
        ..add('locationId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phoneNumber')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.avatar;
    if (value != null) {
      result
        ..add('avatar')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GMyReservationData_myReservation_donation_user_avatar,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GMyReservationData_myReservation_donation_user deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationData_myReservation_donation_userBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'avatarAttachmentId':
          result.avatarAttachmentId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'createdAt':
          result.createdAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'displayName':
          result.displayName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'email':
          result.email =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'isMailVerified':
          result.isMailVerified =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'lastChangedPasswordDate':
          result.lastChangedPasswordDate.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'locationId':
          result.locationId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'phoneNumber':
          result.phoneNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'reputationScore':
          result.reputationScore =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'role':
          result.role =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GUserRole),
                  )!
                  as _i2.GUserRole;
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'updatedAt':
          result.updatedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'avatar':
          result.avatar.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMyReservationData_myReservation_donation_user_avatar,
                  ),
                )!
                as GMyReservationData_myReservation_donation_user_avatar,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationData_myReservation_donation_user_avatarSerializer
    implements
        StructuredSerializer<
          GMyReservationData_myReservation_donation_user_avatar
        > {
  @override
  final Iterable<Type> types = const [
    GMyReservationData_myReservation_donation_user_avatar,
    _$GMyReservationData_myReservation_donation_user_avatar,
  ];
  @override
  final String wireName =
      'GMyReservationData_myReservation_donation_user_avatar';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationData_myReservation_donation_user_avatar object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'fileName',
      serializers.serialize(
        object.fileName,
        specifiedType: const FullType(String),
      ),
      'fileSize',
      serializers.serialize(
        object.fileSize,
        specifiedType: const FullType(double),
      ),
      'fileType',
      serializers.serialize(
        object.fileType,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'uploadedById',
      serializers.serialize(
        object.uploadedById,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.jobId;
    if (value != null) {
      result
        ..add('jobId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updatedAt')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i2.GDateTime),
          ),
        );
    }
    value = object.uploadStatus;
    if (value != null) {
      result
        ..add('uploadStatus')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i2.GUploadStatusValues),
          ),
        );
    }
    value = object.url;
    if (value != null) {
      result
        ..add('url')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GMyReservationData_myReservation_donation_user_avatar deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GMyReservationData_myReservation_donation_user_avatarBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'createdAt':
          result.createdAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'fileName':
          result.fileName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'fileSize':
          result.fileSize =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )!
                  as double;
          break;
        case 'fileType':
          result.fileType =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'jobId':
          result.jobId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'updatedAt':
          result.updatedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'uploadStatus':
          result.uploadStatus =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i2.GUploadStatusValues),
                  )
                  as _i2.GUploadStatusValues?;
          break;
        case 'uploadedById':
          result.uploadedById =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'url':
          result.url =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationData extends GMyReservationData {
  @override
  final String G__typename;
  @override
  final GMyReservationData_myReservation myReservation;

  factory _$GMyReservationData([
    void Function(GMyReservationDataBuilder)? updates,
  ]) => (GMyReservationDataBuilder()..update(updates))._build();

  _$GMyReservationData._({
    required this.G__typename,
    required this.myReservation,
  }) : super._();
  @override
  GMyReservationData rebuild(
    void Function(GMyReservationDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationDataBuilder toBuilder() =>
      GMyReservationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationData &&
        G__typename == other.G__typename &&
        myReservation == other.myReservation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, myReservation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyReservationData')
          ..add('G__typename', G__typename)
          ..add('myReservation', myReservation))
        .toString();
  }
}

class GMyReservationDataBuilder
    implements Builder<GMyReservationData, GMyReservationDataBuilder> {
  _$GMyReservationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMyReservationData_myReservationBuilder? _myReservation;
  GMyReservationData_myReservationBuilder get myReservation =>
      _$this._myReservation ??= GMyReservationData_myReservationBuilder();
  set myReservation(GMyReservationData_myReservationBuilder? myReservation) =>
      _$this._myReservation = myReservation;

  GMyReservationDataBuilder() {
    GMyReservationData._initializeBuilder(this);
  }

  GMyReservationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _myReservation = $v.myReservation.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationData other) {
    _$v = other as _$GMyReservationData;
  }

  @override
  void update(void Function(GMyReservationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationData build() => _build();

  _$GMyReservationData _build() {
    _$GMyReservationData _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationData',
              'G__typename',
            ),
            myReservation: myReservation.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'myReservation';
        myReservation.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationData',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyReservationData_myReservation
    extends GMyReservationData_myReservation {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GReservationStatus status;
  @override
  final _i2.GDateTime createdAt;
  @override
  final _i2.GDateTime? confirmedAt;
  @override
  final _i2.GDateTime updatedAt;
  @override
  final GMyReservationData_myReservation_donation? donation;

  factory _$GMyReservationData_myReservation([
    void Function(GMyReservationData_myReservationBuilder)? updates,
  ]) => (GMyReservationData_myReservationBuilder()..update(updates))._build();

  _$GMyReservationData_myReservation._({
    required this.G__typename,
    required this.id,
    required this.status,
    required this.createdAt,
    this.confirmedAt,
    required this.updatedAt,
    this.donation,
  }) : super._();
  @override
  GMyReservationData_myReservation rebuild(
    void Function(GMyReservationData_myReservationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationData_myReservationBuilder toBuilder() =>
      GMyReservationData_myReservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationData_myReservation &&
        G__typename == other.G__typename &&
        id == other.id &&
        status == other.status &&
        createdAt == other.createdAt &&
        confirmedAt == other.confirmedAt &&
        updatedAt == other.updatedAt &&
        donation == other.donation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, confirmedAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, donation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyReservationData_myReservation')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('confirmedAt', confirmedAt)
          ..add('updatedAt', updatedAt)
          ..add('donation', donation))
        .toString();
  }
}

class GMyReservationData_myReservationBuilder
    implements
        Builder<
          GMyReservationData_myReservation,
          GMyReservationData_myReservationBuilder
        > {
  _$GMyReservationData_myReservation? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GReservationStatus? _status;
  _i2.GReservationStatus? get status => _$this._status;
  set status(_i2.GReservationStatus? status) => _$this._status = status;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  _i2.GDateTimeBuilder? _confirmedAt;
  _i2.GDateTimeBuilder get confirmedAt =>
      _$this._confirmedAt ??= _i2.GDateTimeBuilder();
  set confirmedAt(_i2.GDateTimeBuilder? confirmedAt) =>
      _$this._confirmedAt = confirmedAt;

  _i2.GDateTimeBuilder? _updatedAt;
  _i2.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i2.GDateTimeBuilder();
  set updatedAt(_i2.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  GMyReservationData_myReservation_donationBuilder? _donation;
  GMyReservationData_myReservation_donationBuilder get donation =>
      _$this._donation ??= GMyReservationData_myReservation_donationBuilder();
  set donation(GMyReservationData_myReservation_donationBuilder? donation) =>
      _$this._donation = donation;

  GMyReservationData_myReservationBuilder() {
    GMyReservationData_myReservation._initializeBuilder(this);
  }

  GMyReservationData_myReservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _status = $v.status;
      _createdAt = $v.createdAt.toBuilder();
      _confirmedAt = $v.confirmedAt?.toBuilder();
      _updatedAt = $v.updatedAt.toBuilder();
      _donation = $v.donation?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationData_myReservation other) {
    _$v = other as _$GMyReservationData_myReservation;
  }

  @override
  void update(void Function(GMyReservationData_myReservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationData_myReservation build() => _build();

  _$GMyReservationData_myReservation _build() {
    _$GMyReservationData_myReservation _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationData_myReservation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationData_myReservation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyReservationData_myReservation',
              'id',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GMyReservationData_myReservation',
              'status',
            ),
            createdAt: createdAt.build(),
            confirmedAt: _confirmedAt?.build(),
            updatedAt: updatedAt.build(),
            donation: _donation?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'confirmedAt';
        _confirmedAt?.build();
        _$failedField = 'updatedAt';
        updatedAt.build();
        _$failedField = 'donation';
        _donation?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationData_myReservation',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyReservationData_myReservation_donation
    extends GMyReservationData_myReservation_donation {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int quantity;
  @override
  final String categoryId;
  @override
  final _i2.GDonationStatusValues status;
  @override
  final _i2.GDonationUrgencyValues urgency;
  @override
  final _i2.GDateTime expiryDate;
  @override
  final _i2.GDateTime? publishedAt;
  @override
  final String? locationId;
  @override
  final String? mainAttachmentId;
  @override
  final BuiltList<String> attachmentIds;
  @override
  final String userId;
  @override
  final bool safetyChecklistCompleted;
  @override
  final _i2.GDateTime? listingExpiresAt;
  @override
  final _i2.GDateTime updatedAt;
  @override
  final GMyReservationData_myReservation_donation_mainAttachment?
  mainAttachment;
  @override
  final GMyReservationData_myReservation_donation_user user;

  factory _$GMyReservationData_myReservation_donation([
    void Function(GMyReservationData_myReservation_donationBuilder)? updates,
  ]) => (GMyReservationData_myReservation_donationBuilder()..update(updates))
      ._build();

  _$GMyReservationData_myReservation_donation._({
    required this.G__typename,
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.categoryId,
    required this.status,
    required this.urgency,
    required this.expiryDate,
    this.publishedAt,
    this.locationId,
    this.mainAttachmentId,
    required this.attachmentIds,
    required this.userId,
    required this.safetyChecklistCompleted,
    this.listingExpiresAt,
    required this.updatedAt,
    this.mainAttachment,
    required this.user,
  }) : super._();
  @override
  GMyReservationData_myReservation_donation rebuild(
    void Function(GMyReservationData_myReservation_donationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationData_myReservation_donationBuilder toBuilder() =>
      GMyReservationData_myReservation_donationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationData_myReservation_donation &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        quantity == other.quantity &&
        categoryId == other.categoryId &&
        status == other.status &&
        urgency == other.urgency &&
        expiryDate == other.expiryDate &&
        publishedAt == other.publishedAt &&
        locationId == other.locationId &&
        mainAttachmentId == other.mainAttachmentId &&
        attachmentIds == other.attachmentIds &&
        userId == other.userId &&
        safetyChecklistCompleted == other.safetyChecklistCompleted &&
        listingExpiresAt == other.listingExpiresAt &&
        updatedAt == other.updatedAt &&
        mainAttachment == other.mainAttachment &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, categoryId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, urgency.hashCode);
    _$hash = $jc(_$hash, expiryDate.hashCode);
    _$hash = $jc(_$hash, publishedAt.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, mainAttachmentId.hashCode);
    _$hash = $jc(_$hash, attachmentIds.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, safetyChecklistCompleted.hashCode);
    _$hash = $jc(_$hash, listingExpiresAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, mainAttachment.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMyReservationData_myReservation_donation',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('quantity', quantity)
          ..add('categoryId', categoryId)
          ..add('status', status)
          ..add('urgency', urgency)
          ..add('expiryDate', expiryDate)
          ..add('publishedAt', publishedAt)
          ..add('locationId', locationId)
          ..add('mainAttachmentId', mainAttachmentId)
          ..add('attachmentIds', attachmentIds)
          ..add('userId', userId)
          ..add('safetyChecklistCompleted', safetyChecklistCompleted)
          ..add('listingExpiresAt', listingExpiresAt)
          ..add('updatedAt', updatedAt)
          ..add('mainAttachment', mainAttachment)
          ..add('user', user))
        .toString();
  }
}

class GMyReservationData_myReservation_donationBuilder
    implements
        Builder<
          GMyReservationData_myReservation_donation,
          GMyReservationData_myReservation_donationBuilder
        > {
  _$GMyReservationData_myReservation_donation? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _quantity;
  int? get quantity => _$this._quantity;
  set quantity(int? quantity) => _$this._quantity = quantity;

  String? _categoryId;
  String? get categoryId => _$this._categoryId;
  set categoryId(String? categoryId) => _$this._categoryId = categoryId;

  _i2.GDonationStatusValues? _status;
  _i2.GDonationStatusValues? get status => _$this._status;
  set status(_i2.GDonationStatusValues? status) => _$this._status = status;

  _i2.GDonationUrgencyValues? _urgency;
  _i2.GDonationUrgencyValues? get urgency => _$this._urgency;
  set urgency(_i2.GDonationUrgencyValues? urgency) => _$this._urgency = urgency;

  _i2.GDateTimeBuilder? _expiryDate;
  _i2.GDateTimeBuilder get expiryDate =>
      _$this._expiryDate ??= _i2.GDateTimeBuilder();
  set expiryDate(_i2.GDateTimeBuilder? expiryDate) =>
      _$this._expiryDate = expiryDate;

  _i2.GDateTimeBuilder? _publishedAt;
  _i2.GDateTimeBuilder get publishedAt =>
      _$this._publishedAt ??= _i2.GDateTimeBuilder();
  set publishedAt(_i2.GDateTimeBuilder? publishedAt) =>
      _$this._publishedAt = publishedAt;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  String? _mainAttachmentId;
  String? get mainAttachmentId => _$this._mainAttachmentId;
  set mainAttachmentId(String? mainAttachmentId) =>
      _$this._mainAttachmentId = mainAttachmentId;

  ListBuilder<String>? _attachmentIds;
  ListBuilder<String> get attachmentIds =>
      _$this._attachmentIds ??= ListBuilder<String>();
  set attachmentIds(ListBuilder<String>? attachmentIds) =>
      _$this._attachmentIds = attachmentIds;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  bool? _safetyChecklistCompleted;
  bool? get safetyChecklistCompleted => _$this._safetyChecklistCompleted;
  set safetyChecklistCompleted(bool? safetyChecklistCompleted) =>
      _$this._safetyChecklistCompleted = safetyChecklistCompleted;

  _i2.GDateTimeBuilder? _listingExpiresAt;
  _i2.GDateTimeBuilder get listingExpiresAt =>
      _$this._listingExpiresAt ??= _i2.GDateTimeBuilder();
  set listingExpiresAt(_i2.GDateTimeBuilder? listingExpiresAt) =>
      _$this._listingExpiresAt = listingExpiresAt;

  _i2.GDateTimeBuilder? _updatedAt;
  _i2.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i2.GDateTimeBuilder();
  set updatedAt(_i2.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  GMyReservationData_myReservation_donation_mainAttachmentBuilder?
  _mainAttachment;
  GMyReservationData_myReservation_donation_mainAttachmentBuilder
  get mainAttachment => _$this._mainAttachment ??=
      GMyReservationData_myReservation_donation_mainAttachmentBuilder();
  set mainAttachment(
    GMyReservationData_myReservation_donation_mainAttachmentBuilder?
    mainAttachment,
  ) => _$this._mainAttachment = mainAttachment;

  GMyReservationData_myReservation_donation_userBuilder? _user;
  GMyReservationData_myReservation_donation_userBuilder get user =>
      _$this._user ??= GMyReservationData_myReservation_donation_userBuilder();
  set user(GMyReservationData_myReservation_donation_userBuilder? user) =>
      _$this._user = user;

  GMyReservationData_myReservation_donationBuilder() {
    GMyReservationData_myReservation_donation._initializeBuilder(this);
  }

  GMyReservationData_myReservation_donationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _quantity = $v.quantity;
      _categoryId = $v.categoryId;
      _status = $v.status;
      _urgency = $v.urgency;
      _expiryDate = $v.expiryDate.toBuilder();
      _publishedAt = $v.publishedAt?.toBuilder();
      _locationId = $v.locationId;
      _mainAttachmentId = $v.mainAttachmentId;
      _attachmentIds = $v.attachmentIds.toBuilder();
      _userId = $v.userId;
      _safetyChecklistCompleted = $v.safetyChecklistCompleted;
      _listingExpiresAt = $v.listingExpiresAt?.toBuilder();
      _updatedAt = $v.updatedAt.toBuilder();
      _mainAttachment = $v.mainAttachment?.toBuilder();
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationData_myReservation_donation other) {
    _$v = other as _$GMyReservationData_myReservation_donation;
  }

  @override
  void update(
    void Function(GMyReservationData_myReservation_donationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationData_myReservation_donation build() => _build();

  _$GMyReservationData_myReservation_donation _build() {
    _$GMyReservationData_myReservation_donation _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationData_myReservation_donation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationData_myReservation_donation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyReservationData_myReservation_donation',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GMyReservationData_myReservation_donation',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'GMyReservationData_myReservation_donation',
              'description',
            ),
            quantity: BuiltValueNullFieldError.checkNotNull(
              quantity,
              r'GMyReservationData_myReservation_donation',
              'quantity',
            ),
            categoryId: BuiltValueNullFieldError.checkNotNull(
              categoryId,
              r'GMyReservationData_myReservation_donation',
              'categoryId',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GMyReservationData_myReservation_donation',
              'status',
            ),
            urgency: BuiltValueNullFieldError.checkNotNull(
              urgency,
              r'GMyReservationData_myReservation_donation',
              'urgency',
            ),
            expiryDate: expiryDate.build(),
            publishedAt: _publishedAt?.build(),
            locationId: locationId,
            mainAttachmentId: mainAttachmentId,
            attachmentIds: attachmentIds.build(),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'GMyReservationData_myReservation_donation',
              'userId',
            ),
            safetyChecklistCompleted: BuiltValueNullFieldError.checkNotNull(
              safetyChecklistCompleted,
              r'GMyReservationData_myReservation_donation',
              'safetyChecklistCompleted',
            ),
            listingExpiresAt: _listingExpiresAt?.build(),
            updatedAt: updatedAt.build(),
            mainAttachment: _mainAttachment?.build(),
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'expiryDate';
        expiryDate.build();
        _$failedField = 'publishedAt';
        _publishedAt?.build();

        _$failedField = 'attachmentIds';
        attachmentIds.build();

        _$failedField = 'listingExpiresAt';
        _listingExpiresAt?.build();
        _$failedField = 'updatedAt';
        updatedAt.build();
        _$failedField = 'mainAttachment';
        _mainAttachment?.build();
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationData_myReservation_donation',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyReservationData_myReservation_donation_mainAttachment
    extends GMyReservationData_myReservation_donation_mainAttachment {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? url;
  @override
  final String fileName;
  @override
  final String fileType;
  @override
  final double fileSize;
  @override
  final _i2.GDateTime createdAt;
  @override
  final _i2.GDateTime? updatedAt;
  @override
  final _i2.GUploadStatusValues? uploadStatus;
  @override
  final String? jobId;
  @override
  final String uploadedById;

  factory _$GMyReservationData_myReservation_donation_mainAttachment([
    void Function(
      GMyReservationData_myReservation_donation_mainAttachmentBuilder,
    )?
    updates,
  ]) =>
      (GMyReservationData_myReservation_donation_mainAttachmentBuilder()
            ..update(updates))
          ._build();

  _$GMyReservationData_myReservation_donation_mainAttachment._({
    required this.G__typename,
    required this.id,
    this.url,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.createdAt,
    this.updatedAt,
    this.uploadStatus,
    this.jobId,
    required this.uploadedById,
  }) : super._();
  @override
  GMyReservationData_myReservation_donation_mainAttachment rebuild(
    void Function(
      GMyReservationData_myReservation_donation_mainAttachmentBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationData_myReservation_donation_mainAttachmentBuilder toBuilder() =>
      GMyReservationData_myReservation_donation_mainAttachmentBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationData_myReservation_donation_mainAttachment &&
        G__typename == other.G__typename &&
        id == other.id &&
        url == other.url &&
        fileName == other.fileName &&
        fileType == other.fileType &&
        fileSize == other.fileSize &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        uploadStatus == other.uploadStatus &&
        jobId == other.jobId &&
        uploadedById == other.uploadedById;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, fileType.hashCode);
    _$hash = $jc(_$hash, fileSize.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, uploadStatus.hashCode);
    _$hash = $jc(_$hash, jobId.hashCode);
    _$hash = $jc(_$hash, uploadedById.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMyReservationData_myReservation_donation_mainAttachment',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('url', url)
          ..add('fileName', fileName)
          ..add('fileType', fileType)
          ..add('fileSize', fileSize)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('uploadStatus', uploadStatus)
          ..add('jobId', jobId)
          ..add('uploadedById', uploadedById))
        .toString();
  }
}

class GMyReservationData_myReservation_donation_mainAttachmentBuilder
    implements
        Builder<
          GMyReservationData_myReservation_donation_mainAttachment,
          GMyReservationData_myReservation_donation_mainAttachmentBuilder
        > {
  _$GMyReservationData_myReservation_donation_mainAttachment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  String? _fileType;
  String? get fileType => _$this._fileType;
  set fileType(String? fileType) => _$this._fileType = fileType;

  double? _fileSize;
  double? get fileSize => _$this._fileSize;
  set fileSize(double? fileSize) => _$this._fileSize = fileSize;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  _i2.GDateTimeBuilder? _updatedAt;
  _i2.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i2.GDateTimeBuilder();
  set updatedAt(_i2.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  _i2.GUploadStatusValues? _uploadStatus;
  _i2.GUploadStatusValues? get uploadStatus => _$this._uploadStatus;
  set uploadStatus(_i2.GUploadStatusValues? uploadStatus) =>
      _$this._uploadStatus = uploadStatus;

  String? _jobId;
  String? get jobId => _$this._jobId;
  set jobId(String? jobId) => _$this._jobId = jobId;

  String? _uploadedById;
  String? get uploadedById => _$this._uploadedById;
  set uploadedById(String? uploadedById) => _$this._uploadedById = uploadedById;

  GMyReservationData_myReservation_donation_mainAttachmentBuilder() {
    GMyReservationData_myReservation_donation_mainAttachment._initializeBuilder(
      this,
    );
  }

  GMyReservationData_myReservation_donation_mainAttachmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _url = $v.url;
      _fileName = $v.fileName;
      _fileType = $v.fileType;
      _fileSize = $v.fileSize;
      _createdAt = $v.createdAt.toBuilder();
      _updatedAt = $v.updatedAt?.toBuilder();
      _uploadStatus = $v.uploadStatus;
      _jobId = $v.jobId;
      _uploadedById = $v.uploadedById;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationData_myReservation_donation_mainAttachment other) {
    _$v = other as _$GMyReservationData_myReservation_donation_mainAttachment;
  }

  @override
  void update(
    void Function(
      GMyReservationData_myReservation_donation_mainAttachmentBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationData_myReservation_donation_mainAttachment build() => _build();

  _$GMyReservationData_myReservation_donation_mainAttachment _build() {
    _$GMyReservationData_myReservation_donation_mainAttachment _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationData_myReservation_donation_mainAttachment._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationData_myReservation_donation_mainAttachment',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyReservationData_myReservation_donation_mainAttachment',
              'id',
            ),
            url: url,
            fileName: BuiltValueNullFieldError.checkNotNull(
              fileName,
              r'GMyReservationData_myReservation_donation_mainAttachment',
              'fileName',
            ),
            fileType: BuiltValueNullFieldError.checkNotNull(
              fileType,
              r'GMyReservationData_myReservation_donation_mainAttachment',
              'fileType',
            ),
            fileSize: BuiltValueNullFieldError.checkNotNull(
              fileSize,
              r'GMyReservationData_myReservation_donation_mainAttachment',
              'fileSize',
            ),
            createdAt: createdAt.build(),
            updatedAt: _updatedAt?.build(),
            uploadStatus: uploadStatus,
            jobId: jobId,
            uploadedById: BuiltValueNullFieldError.checkNotNull(
              uploadedById,
              r'GMyReservationData_myReservation_donation_mainAttachment',
              'uploadedById',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'updatedAt';
        _updatedAt?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationData_myReservation_donation_mainAttachment',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyReservationData_myReservation_donation_user
    extends GMyReservationData_myReservation_donation_user {
  @override
  final String G__typename;
  @override
  final String? avatarAttachmentId;
  @override
  final _i2.GDateTime createdAt;
  @override
  final String? description;
  @override
  final String? displayName;
  @override
  final String email;
  @override
  final String id;
  @override
  final bool isMailVerified;
  @override
  final _i2.GDateTime? lastChangedPasswordDate;
  @override
  final String? locationId;
  @override
  final String? phoneNumber;
  @override
  final int reputationScore;
  @override
  final _i2.GUserRole role;
  @override
  final String status;
  @override
  final _i2.GDateTime updatedAt;
  @override
  final GMyReservationData_myReservation_donation_user_avatar? avatar;

  factory _$GMyReservationData_myReservation_donation_user([
    void Function(GMyReservationData_myReservation_donation_userBuilder)?
    updates,
  ]) =>
      (GMyReservationData_myReservation_donation_userBuilder()..update(updates))
          ._build();

  _$GMyReservationData_myReservation_donation_user._({
    required this.G__typename,
    this.avatarAttachmentId,
    required this.createdAt,
    this.description,
    this.displayName,
    required this.email,
    required this.id,
    required this.isMailVerified,
    this.lastChangedPasswordDate,
    this.locationId,
    this.phoneNumber,
    required this.reputationScore,
    required this.role,
    required this.status,
    required this.updatedAt,
    this.avatar,
  }) : super._();
  @override
  GMyReservationData_myReservation_donation_user rebuild(
    void Function(GMyReservationData_myReservation_donation_userBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationData_myReservation_donation_userBuilder toBuilder() =>
      GMyReservationData_myReservation_donation_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationData_myReservation_donation_user &&
        G__typename == other.G__typename &&
        avatarAttachmentId == other.avatarAttachmentId &&
        createdAt == other.createdAt &&
        description == other.description &&
        displayName == other.displayName &&
        email == other.email &&
        id == other.id &&
        isMailVerified == other.isMailVerified &&
        lastChangedPasswordDate == other.lastChangedPasswordDate &&
        locationId == other.locationId &&
        phoneNumber == other.phoneNumber &&
        reputationScore == other.reputationScore &&
        role == other.role &&
        status == other.status &&
        updatedAt == other.updatedAt &&
        avatar == other.avatar;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, avatarAttachmentId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, isMailVerified.hashCode);
    _$hash = $jc(_$hash, lastChangedPasswordDate.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, reputationScore.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMyReservationData_myReservation_donation_user',
          )
          ..add('G__typename', G__typename)
          ..add('avatarAttachmentId', avatarAttachmentId)
          ..add('createdAt', createdAt)
          ..add('description', description)
          ..add('displayName', displayName)
          ..add('email', email)
          ..add('id', id)
          ..add('isMailVerified', isMailVerified)
          ..add('lastChangedPasswordDate', lastChangedPasswordDate)
          ..add('locationId', locationId)
          ..add('phoneNumber', phoneNumber)
          ..add('reputationScore', reputationScore)
          ..add('role', role)
          ..add('status', status)
          ..add('updatedAt', updatedAt)
          ..add('avatar', avatar))
        .toString();
  }
}

class GMyReservationData_myReservation_donation_userBuilder
    implements
        Builder<
          GMyReservationData_myReservation_donation_user,
          GMyReservationData_myReservation_donation_userBuilder
        > {
  _$GMyReservationData_myReservation_donation_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _avatarAttachmentId;
  String? get avatarAttachmentId => _$this._avatarAttachmentId;
  set avatarAttachmentId(String? avatarAttachmentId) =>
      _$this._avatarAttachmentId = avatarAttachmentId;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  bool? _isMailVerified;
  bool? get isMailVerified => _$this._isMailVerified;
  set isMailVerified(bool? isMailVerified) =>
      _$this._isMailVerified = isMailVerified;

  _i2.GDateTimeBuilder? _lastChangedPasswordDate;
  _i2.GDateTimeBuilder get lastChangedPasswordDate =>
      _$this._lastChangedPasswordDate ??= _i2.GDateTimeBuilder();
  set lastChangedPasswordDate(_i2.GDateTimeBuilder? lastChangedPasswordDate) =>
      _$this._lastChangedPasswordDate = lastChangedPasswordDate;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  int? _reputationScore;
  int? get reputationScore => _$this._reputationScore;
  set reputationScore(int? reputationScore) =>
      _$this._reputationScore = reputationScore;

  _i2.GUserRole? _role;
  _i2.GUserRole? get role => _$this._role;
  set role(_i2.GUserRole? role) => _$this._role = role;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  _i2.GDateTimeBuilder? _updatedAt;
  _i2.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i2.GDateTimeBuilder();
  set updatedAt(_i2.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  GMyReservationData_myReservation_donation_user_avatarBuilder? _avatar;
  GMyReservationData_myReservation_donation_user_avatarBuilder get avatar =>
      _$this._avatar ??=
          GMyReservationData_myReservation_donation_user_avatarBuilder();
  set avatar(
    GMyReservationData_myReservation_donation_user_avatarBuilder? avatar,
  ) => _$this._avatar = avatar;

  GMyReservationData_myReservation_donation_userBuilder() {
    GMyReservationData_myReservation_donation_user._initializeBuilder(this);
  }

  GMyReservationData_myReservation_donation_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _avatarAttachmentId = $v.avatarAttachmentId;
      _createdAt = $v.createdAt.toBuilder();
      _description = $v.description;
      _displayName = $v.displayName;
      _email = $v.email;
      _id = $v.id;
      _isMailVerified = $v.isMailVerified;
      _lastChangedPasswordDate = $v.lastChangedPasswordDate?.toBuilder();
      _locationId = $v.locationId;
      _phoneNumber = $v.phoneNumber;
      _reputationScore = $v.reputationScore;
      _role = $v.role;
      _status = $v.status;
      _updatedAt = $v.updatedAt.toBuilder();
      _avatar = $v.avatar?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationData_myReservation_donation_user other) {
    _$v = other as _$GMyReservationData_myReservation_donation_user;
  }

  @override
  void update(
    void Function(GMyReservationData_myReservation_donation_userBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationData_myReservation_donation_user build() => _build();

  _$GMyReservationData_myReservation_donation_user _build() {
    _$GMyReservationData_myReservation_donation_user _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationData_myReservation_donation_user._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationData_myReservation_donation_user',
              'G__typename',
            ),
            avatarAttachmentId: avatarAttachmentId,
            createdAt: createdAt.build(),
            description: description,
            displayName: displayName,
            email: BuiltValueNullFieldError.checkNotNull(
              email,
              r'GMyReservationData_myReservation_donation_user',
              'email',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyReservationData_myReservation_donation_user',
              'id',
            ),
            isMailVerified: BuiltValueNullFieldError.checkNotNull(
              isMailVerified,
              r'GMyReservationData_myReservation_donation_user',
              'isMailVerified',
            ),
            lastChangedPasswordDate: _lastChangedPasswordDate?.build(),
            locationId: locationId,
            phoneNumber: phoneNumber,
            reputationScore: BuiltValueNullFieldError.checkNotNull(
              reputationScore,
              r'GMyReservationData_myReservation_donation_user',
              'reputationScore',
            ),
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'GMyReservationData_myReservation_donation_user',
              'role',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GMyReservationData_myReservation_donation_user',
              'status',
            ),
            updatedAt: updatedAt.build(),
            avatar: _avatar?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();

        _$failedField = 'lastChangedPasswordDate';
        _lastChangedPasswordDate?.build();

        _$failedField = 'updatedAt';
        updatedAt.build();
        _$failedField = 'avatar';
        _avatar?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationData_myReservation_donation_user',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GMyReservationData_myReservation_donation_user_avatar
    extends GMyReservationData_myReservation_donation_user_avatar {
  @override
  final String G__typename;
  @override
  final _i2.GDateTime createdAt;
  @override
  final String fileName;
  @override
  final double fileSize;
  @override
  final String fileType;
  @override
  final String id;
  @override
  final String? jobId;
  @override
  final _i2.GDateTime? updatedAt;
  @override
  final _i2.GUploadStatusValues? uploadStatus;
  @override
  final String uploadedById;
  @override
  final String? url;

  factory _$GMyReservationData_myReservation_donation_user_avatar([
    void Function(GMyReservationData_myReservation_donation_user_avatarBuilder)?
    updates,
  ]) =>
      (GMyReservationData_myReservation_donation_user_avatarBuilder()
            ..update(updates))
          ._build();

  _$GMyReservationData_myReservation_donation_user_avatar._({
    required this.G__typename,
    required this.createdAt,
    required this.fileName,
    required this.fileSize,
    required this.fileType,
    required this.id,
    this.jobId,
    this.updatedAt,
    this.uploadStatus,
    required this.uploadedById,
    this.url,
  }) : super._();
  @override
  GMyReservationData_myReservation_donation_user_avatar rebuild(
    void Function(GMyReservationData_myReservation_donation_user_avatarBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationData_myReservation_donation_user_avatarBuilder toBuilder() =>
      GMyReservationData_myReservation_donation_user_avatarBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationData_myReservation_donation_user_avatar &&
        G__typename == other.G__typename &&
        createdAt == other.createdAt &&
        fileName == other.fileName &&
        fileSize == other.fileSize &&
        fileType == other.fileType &&
        id == other.id &&
        jobId == other.jobId &&
        updatedAt == other.updatedAt &&
        uploadStatus == other.uploadStatus &&
        uploadedById == other.uploadedById &&
        url == other.url;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, fileName.hashCode);
    _$hash = $jc(_$hash, fileSize.hashCode);
    _$hash = $jc(_$hash, fileType.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, jobId.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, uploadStatus.hashCode);
    _$hash = $jc(_$hash, uploadedById.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMyReservationData_myReservation_donation_user_avatar',
          )
          ..add('G__typename', G__typename)
          ..add('createdAt', createdAt)
          ..add('fileName', fileName)
          ..add('fileSize', fileSize)
          ..add('fileType', fileType)
          ..add('id', id)
          ..add('jobId', jobId)
          ..add('updatedAt', updatedAt)
          ..add('uploadStatus', uploadStatus)
          ..add('uploadedById', uploadedById)
          ..add('url', url))
        .toString();
  }
}

class GMyReservationData_myReservation_donation_user_avatarBuilder
    implements
        Builder<
          GMyReservationData_myReservation_donation_user_avatar,
          GMyReservationData_myReservation_donation_user_avatarBuilder
        > {
  _$GMyReservationData_myReservation_donation_user_avatar? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  String? _fileName;
  String? get fileName => _$this._fileName;
  set fileName(String? fileName) => _$this._fileName = fileName;

  double? _fileSize;
  double? get fileSize => _$this._fileSize;
  set fileSize(double? fileSize) => _$this._fileSize = fileSize;

  String? _fileType;
  String? get fileType => _$this._fileType;
  set fileType(String? fileType) => _$this._fileType = fileType;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _jobId;
  String? get jobId => _$this._jobId;
  set jobId(String? jobId) => _$this._jobId = jobId;

  _i2.GDateTimeBuilder? _updatedAt;
  _i2.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i2.GDateTimeBuilder();
  set updatedAt(_i2.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  _i2.GUploadStatusValues? _uploadStatus;
  _i2.GUploadStatusValues? get uploadStatus => _$this._uploadStatus;
  set uploadStatus(_i2.GUploadStatusValues? uploadStatus) =>
      _$this._uploadStatus = uploadStatus;

  String? _uploadedById;
  String? get uploadedById => _$this._uploadedById;
  set uploadedById(String? uploadedById) => _$this._uploadedById = uploadedById;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GMyReservationData_myReservation_donation_user_avatarBuilder() {
    GMyReservationData_myReservation_donation_user_avatar._initializeBuilder(
      this,
    );
  }

  GMyReservationData_myReservation_donation_user_avatarBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createdAt = $v.createdAt.toBuilder();
      _fileName = $v.fileName;
      _fileSize = $v.fileSize;
      _fileType = $v.fileType;
      _id = $v.id;
      _jobId = $v.jobId;
      _updatedAt = $v.updatedAt?.toBuilder();
      _uploadStatus = $v.uploadStatus;
      _uploadedById = $v.uploadedById;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationData_myReservation_donation_user_avatar other) {
    _$v = other as _$GMyReservationData_myReservation_donation_user_avatar;
  }

  @override
  void update(
    void Function(GMyReservationData_myReservation_donation_user_avatarBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationData_myReservation_donation_user_avatar build() => _build();

  _$GMyReservationData_myReservation_donation_user_avatar _build() {
    _$GMyReservationData_myReservation_donation_user_avatar _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationData_myReservation_donation_user_avatar._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationData_myReservation_donation_user_avatar',
              'G__typename',
            ),
            createdAt: createdAt.build(),
            fileName: BuiltValueNullFieldError.checkNotNull(
              fileName,
              r'GMyReservationData_myReservation_donation_user_avatar',
              'fileName',
            ),
            fileSize: BuiltValueNullFieldError.checkNotNull(
              fileSize,
              r'GMyReservationData_myReservation_donation_user_avatar',
              'fileSize',
            ),
            fileType: BuiltValueNullFieldError.checkNotNull(
              fileType,
              r'GMyReservationData_myReservation_donation_user_avatar',
              'fileType',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyReservationData_myReservation_donation_user_avatar',
              'id',
            ),
            jobId: jobId,
            updatedAt: _updatedAt?.build(),
            uploadStatus: uploadStatus,
            uploadedById: BuiltValueNullFieldError.checkNotNull(
              uploadedById,
              r'GMyReservationData_myReservation_donation_user_avatar',
              'uploadedById',
            ),
            url: url,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();

        _$failedField = 'updatedAt';
        _updatedAt?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationData_myReservation_donation_user_avatar',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
