// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_reservation.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GConfirmReservationData> _$gConfirmReservationDataSerializer =
    _$GConfirmReservationDataSerializer();
Serializer<GConfirmReservationData_confirmReservation>
_$gConfirmReservationDataConfirmReservationSerializer =
    _$GConfirmReservationData_confirmReservationSerializer();
Serializer<GConfirmReservationData_confirmReservation_donation>
_$gConfirmReservationDataConfirmReservationDonationSerializer =
    _$GConfirmReservationData_confirmReservation_donationSerializer();
Serializer<GConfirmReservationData_confirmReservation_donation_category>
_$gConfirmReservationDataConfirmReservationDonationCategorySerializer =
    _$GConfirmReservationData_confirmReservation_donation_categorySerializer();
Serializer<GConfirmReservationData_confirmReservation_donation_mainAttachment>
_$gConfirmReservationDataConfirmReservationDonationMainAttachmentSerializer =
    _$GConfirmReservationData_confirmReservation_donation_mainAttachmentSerializer();
Serializer<GConfirmReservationData_confirmReservation_donation_location>
_$gConfirmReservationDataConfirmReservationDonationLocationSerializer =
    _$GConfirmReservationData_confirmReservation_donation_locationSerializer();
Serializer<GConfirmReservationData_confirmReservation_donation_user>
_$gConfirmReservationDataConfirmReservationDonationUserSerializer =
    _$GConfirmReservationData_confirmReservation_donation_userSerializer();
Serializer<GConfirmReservationData_confirmReservation_beneficiary>
_$gConfirmReservationDataConfirmReservationBeneficiarySerializer =
    _$GConfirmReservationData_confirmReservation_beneficiarySerializer();
Serializer<GConfirmReservationData_confirmReservation_beneficiary_location>
_$gConfirmReservationDataConfirmReservationBeneficiaryLocationSerializer =
    _$GConfirmReservationData_confirmReservation_beneficiary_locationSerializer();
Serializer<GConfirmReservationData_confirmReservation_beneficiary_avatar>
_$gConfirmReservationDataConfirmReservationBeneficiaryAvatarSerializer =
    _$GConfirmReservationData_confirmReservation_beneficiary_avatarSerializer();

class _$GConfirmReservationDataSerializer
    implements StructuredSerializer<GConfirmReservationData> {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData,
    _$GConfirmReservationData,
  ];
  @override
  final String wireName = 'GConfirmReservationData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'confirmReservation',
      serializers.serialize(
        object.confirmReservation,
        specifiedType: const FullType(
          GConfirmReservationData_confirmReservation,
        ),
      ),
    ];

    return result;
  }

  @override
  GConfirmReservationData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GConfirmReservationDataBuilder();

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
        case 'confirmReservation':
          result.confirmReservation.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation,
                  ),
                )!
                as GConfirmReservationData_confirmReservation,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GConfirmReservationData_confirmReservationSerializer
    implements
        StructuredSerializer<GConfirmReservationData_confirmReservation> {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation,
    _$GConfirmReservationData_confirmReservation,
  ];
  @override
  final String wireName = 'GConfirmReservationData_confirmReservation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation object, {
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
      'donationId',
      serializers.serialize(
        object.donationId,
        specifiedType: const FullType(String),
      ),
      'beneficiaryId',
      serializers.serialize(
        object.beneficiaryId,
        specifiedType: const FullType(String),
      ),
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i3.GReservationStatus),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i3.GDateTime),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(_i3.GDateTime),
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
            specifiedType: const FullType(_i3.GDateTime),
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
              GConfirmReservationData_confirmReservation_donation,
            ),
          ),
        );
    }
    value = object.beneficiary;
    if (value != null) {
      result
        ..add('beneficiary')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GConfirmReservationData_confirmReservation_beneficiary,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GConfirmReservationData_confirmReservation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GConfirmReservationData_confirmReservationBuilder();

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
        case 'donationId':
          result.donationId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'beneficiaryId':
          result.beneficiaryId =
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
                    specifiedType: const FullType(_i3.GReservationStatus),
                  )!
                  as _i3.GReservationStatus;
          break;
        case 'createdAt':
          result.createdAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i3.GDateTime),
                )!
                as _i3.GDateTime,
          );
          break;
        case 'confirmedAt':
          result.confirmedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i3.GDateTime),
                )!
                as _i3.GDateTime,
          );
          break;
        case 'updatedAt':
          result.updatedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i3.GDateTime),
                )!
                as _i3.GDateTime,
          );
          break;
        case 'donation':
          result.donation.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation_donation,
                  ),
                )!
                as GConfirmReservationData_confirmReservation_donation,
          );
          break;
        case 'beneficiary':
          result.beneficiary.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation_beneficiary,
                  ),
                )!
                as GConfirmReservationData_confirmReservation_beneficiary,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GConfirmReservationData_confirmReservation_donationSerializer
    implements
        StructuredSerializer<
          GConfirmReservationData_confirmReservation_donation
        > {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation_donation,
    _$GConfirmReservationData_confirmReservation_donation,
  ];
  @override
  final String wireName = 'GConfirmReservationData_confirmReservation_donation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation_donation object, {
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
        specifiedType: const FullType(_i3.GDonationStatusValues),
      ),
      'urgency',
      serializers.serialize(
        object.urgency,
        specifiedType: const FullType(_i3.GDonationUrgencyValues),
      ),
      'user',
      serializers.serialize(
        object.user,
        specifiedType: const FullType(
          GConfirmReservationData_confirmReservation_donation_user,
        ),
      ),
    ];
    Object? value;
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GConfirmReservationData_confirmReservation_donation_category,
            ),
          ),
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
    value = object.mainAttachment;
    if (value != null) {
      result
        ..add('mainAttachment')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GConfirmReservationData_confirmReservation_donation_mainAttachment,
            ),
          ),
        );
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GConfirmReservationData_confirmReservation_donation_location,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GConfirmReservationData_confirmReservation_donation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GConfirmReservationData_confirmReservation_donationBuilder();

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
        case 'category':
          result.category.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation_donation_category,
                  ),
                )!
                as GConfirmReservationData_confirmReservation_donation_category,
          );
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i3.GDonationStatusValues),
                  )!
                  as _i3.GDonationStatusValues;
          break;
        case 'urgency':
          result.urgency =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i3.GDonationUrgencyValues),
                  )!
                  as _i3.GDonationUrgencyValues;
          break;
        case 'mainAttachmentId':
          result.mainAttachmentId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'mainAttachment':
          result.mainAttachment.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation_donation_mainAttachment,
                  ),
                )!
                as GConfirmReservationData_confirmReservation_donation_mainAttachment,
          );
          break;
        case 'imageUrl':
          result.imageUrl =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'location':
          result.location.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation_donation_location,
                  ),
                )!
                as GConfirmReservationData_confirmReservation_donation_location,
          );
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation_donation_user,
                  ),
                )!
                as GConfirmReservationData_confirmReservation_donation_user,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GConfirmReservationData_confirmReservation_donation_categorySerializer
    implements
        StructuredSerializer<
          GConfirmReservationData_confirmReservation_donation_category
        > {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation_donation_category,
    _$GConfirmReservationData_confirmReservation_donation_category,
  ];
  @override
  final String wireName =
      'GConfirmReservationData_confirmReservation_donation_category';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation_donation_category object, {
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
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GConfirmReservationData_confirmReservation_donation_category deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GConfirmReservationData_confirmReservation_donation_categoryBuilder();

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
        case 'name':
          result.name =
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

class _$GConfirmReservationData_confirmReservation_donation_mainAttachmentSerializer
    implements
        StructuredSerializer<
          GConfirmReservationData_confirmReservation_donation_mainAttachment
        > {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation_donation_mainAttachment,
    _$GConfirmReservationData_confirmReservation_donation_mainAttachment,
  ];
  @override
  final String wireName =
      'GConfirmReservationData_confirmReservation_donation_mainAttachment';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation_donation_mainAttachment object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
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
    return result;
  }

  @override
  GConfirmReservationData_confirmReservation_donation_mainAttachment
  deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder();

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

class _$GConfirmReservationData_confirmReservation_donation_locationSerializer
    implements
        StructuredSerializer<
          GConfirmReservationData_confirmReservation_donation_location
        > {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation_donation_location,
    _$GConfirmReservationData_confirmReservation_donation_location,
  ];
  @override
  final String wireName =
      'GConfirmReservationData_confirmReservation_donation_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation_donation_location object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.latitude;
    if (value != null) {
      result
        ..add('latitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.longitude;
    if (value != null) {
      result
        ..add('longitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    return result;
  }

  @override
  GConfirmReservationData_confirmReservation_donation_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GConfirmReservationData_confirmReservation_donation_locationBuilder();

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
        case 'latitude':
          result.latitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'longitude':
          result.longitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
      }
    }

    return result.build();
  }
}

class _$GConfirmReservationData_confirmReservation_donation_userSerializer
    implements
        StructuredSerializer<
          GConfirmReservationData_confirmReservation_donation_user
        > {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation_donation_user,
    _$GConfirmReservationData_confirmReservation_donation_user,
  ];
  @override
  final String wireName =
      'GConfirmReservationData_confirmReservation_donation_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation_donation_user object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'email',
      serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.displayName;
    if (value != null) {
      result
        ..add('displayName')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GConfirmReservationData_confirmReservation_donation_user deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GConfirmReservationData_confirmReservation_donation_userBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GConfirmReservationData_confirmReservation_beneficiarySerializer
    implements
        StructuredSerializer<
          GConfirmReservationData_confirmReservation_beneficiary
        > {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation_beneficiary,
    _$GConfirmReservationData_confirmReservation_beneficiary,
  ];
  @override
  final String wireName =
      'GConfirmReservationData_confirmReservation_beneficiary';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation_beneficiary object, {
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
      'email',
      serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      ),
      'role',
      serializers.serialize(
        object.role,
        specifiedType: const FullType(_i3.GUserRole),
      ),
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
    ];
    Object? value;
    value = object.displayName;
    if (value != null) {
      result
        ..add('displayName')
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
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
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
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GConfirmReservationData_confirmReservation_beneficiary_location,
            ),
          ),
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
              GConfirmReservationData_confirmReservation_beneficiary_avatar,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GConfirmReservationData_confirmReservation_beneficiary deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GConfirmReservationData_confirmReservation_beneficiaryBuilder();

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
        case 'email':
          result.email =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'displayName':
          result.displayName =
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
        case 'role':
          result.role =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i3.GUserRole),
                  )!
                  as _i3.GUserRole;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'isMailVerified':
          result.isMailVerified =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'reputationScore':
          result.reputationScore =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'locationId':
          result.locationId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'location':
          result.location.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation_beneficiary_location,
                  ),
                )!
                as GConfirmReservationData_confirmReservation_beneficiary_location,
          );
          break;
        case 'avatar':
          result.avatar.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GConfirmReservationData_confirmReservation_beneficiary_avatar,
                  ),
                )!
                as GConfirmReservationData_confirmReservation_beneficiary_avatar,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GConfirmReservationData_confirmReservation_beneficiary_locationSerializer
    implements
        StructuredSerializer<
          GConfirmReservationData_confirmReservation_beneficiary_location
        > {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation_beneficiary_location,
    _$GConfirmReservationData_confirmReservation_beneficiary_location,
  ];
  @override
  final String wireName =
      'GConfirmReservationData_confirmReservation_beneficiary_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation_beneficiary_location object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.city;
    if (value != null) {
      result
        ..add('city')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.country;
    if (value != null) {
      result
        ..add('country')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.latitude;
    if (value != null) {
      result
        ..add('latitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.longitude;
    if (value != null) {
      result
        ..add('longitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.neighborhood;
    if (value != null) {
      result
        ..add('neighborhood')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GConfirmReservationData_confirmReservation_beneficiary_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GConfirmReservationData_confirmReservation_beneficiary_locationBuilder();

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
        case 'city':
          result.city =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'country':
          result.country =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'latitude':
          result.latitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'longitude':
          result.longitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'neighborhood':
          result.neighborhood =
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

class _$GConfirmReservationData_confirmReservation_beneficiary_avatarSerializer
    implements
        StructuredSerializer<
          GConfirmReservationData_confirmReservation_beneficiary_avatar
        > {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationData_confirmReservation_beneficiary_avatar,
    _$GConfirmReservationData_confirmReservation_beneficiary_avatar,
  ];
  @override
  final String wireName =
      'GConfirmReservationData_confirmReservation_beneficiary_avatar';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationData_confirmReservation_beneficiary_avatar object, {
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
    return result;
  }

  @override
  GConfirmReservationData_confirmReservation_beneficiary_avatar deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GConfirmReservationData extends GConfirmReservationData {
  @override
  final String G__typename;
  @override
  final GConfirmReservationData_confirmReservation confirmReservation;

  factory _$GConfirmReservationData([
    void Function(GConfirmReservationDataBuilder)? updates,
  ]) => (GConfirmReservationDataBuilder()..update(updates))._build();

  _$GConfirmReservationData._({
    required this.G__typename,
    required this.confirmReservation,
  }) : super._();
  @override
  GConfirmReservationData rebuild(
    void Function(GConfirmReservationDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationDataBuilder toBuilder() =>
      GConfirmReservationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GConfirmReservationData &&
        G__typename == other.G__typename &&
        confirmReservation == other.confirmReservation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, confirmReservation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GConfirmReservationData')
          ..add('G__typename', G__typename)
          ..add('confirmReservation', confirmReservation))
        .toString();
  }
}

class GConfirmReservationDataBuilder
    implements
        Builder<GConfirmReservationData, GConfirmReservationDataBuilder> {
  _$GConfirmReservationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GConfirmReservationData_confirmReservationBuilder? _confirmReservation;
  GConfirmReservationData_confirmReservationBuilder get confirmReservation =>
      _$this._confirmReservation ??=
          GConfirmReservationData_confirmReservationBuilder();
  set confirmReservation(
    GConfirmReservationData_confirmReservationBuilder? confirmReservation,
  ) => _$this._confirmReservation = confirmReservation;

  GConfirmReservationDataBuilder() {
    GConfirmReservationData._initializeBuilder(this);
  }

  GConfirmReservationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _confirmReservation = $v.confirmReservation.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GConfirmReservationData other) {
    _$v = other as _$GConfirmReservationData;
  }

  @override
  void update(void Function(GConfirmReservationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData build() => _build();

  _$GConfirmReservationData _build() {
    _$GConfirmReservationData _$result;
    try {
      _$result =
          _$v ??
          _$GConfirmReservationData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GConfirmReservationData',
              'G__typename',
            ),
            confirmReservation: confirmReservation.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'confirmReservation';
        confirmReservation.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GConfirmReservationData',
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

class _$GConfirmReservationData_confirmReservation
    extends GConfirmReservationData_confirmReservation {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String donationId;
  @override
  final String beneficiaryId;
  @override
  final _i3.GReservationStatus status;
  @override
  final _i3.GDateTime createdAt;
  @override
  final _i3.GDateTime? confirmedAt;
  @override
  final _i3.GDateTime updatedAt;
  @override
  final GConfirmReservationData_confirmReservation_donation? donation;
  @override
  final GConfirmReservationData_confirmReservation_beneficiary? beneficiary;

  factory _$GConfirmReservationData_confirmReservation([
    void Function(GConfirmReservationData_confirmReservationBuilder)? updates,
  ]) => (GConfirmReservationData_confirmReservationBuilder()..update(updates))
      ._build();

  _$GConfirmReservationData_confirmReservation._({
    required this.G__typename,
    required this.id,
    required this.donationId,
    required this.beneficiaryId,
    required this.status,
    required this.createdAt,
    this.confirmedAt,
    required this.updatedAt,
    this.donation,
    this.beneficiary,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation rebuild(
    void Function(GConfirmReservationData_confirmReservationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservationBuilder toBuilder() =>
      GConfirmReservationData_confirmReservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GConfirmReservationData_confirmReservation &&
        G__typename == other.G__typename &&
        id == other.id &&
        donationId == other.donationId &&
        beneficiaryId == other.beneficiaryId &&
        status == other.status &&
        createdAt == other.createdAt &&
        confirmedAt == other.confirmedAt &&
        updatedAt == other.updatedAt &&
        donation == other.donation &&
        beneficiary == other.beneficiary;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, donationId.hashCode);
    _$hash = $jc(_$hash, beneficiaryId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, confirmedAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, donation.hashCode);
    _$hash = $jc(_$hash, beneficiary.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('donationId', donationId)
          ..add('beneficiaryId', beneficiaryId)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('confirmedAt', confirmedAt)
          ..add('updatedAt', updatedAt)
          ..add('donation', donation)
          ..add('beneficiary', beneficiary))
        .toString();
  }
}

class GConfirmReservationData_confirmReservationBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation,
          GConfirmReservationData_confirmReservationBuilder
        > {
  _$GConfirmReservationData_confirmReservation? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _donationId;
  String? get donationId => _$this._donationId;
  set donationId(String? donationId) => _$this._donationId = donationId;

  String? _beneficiaryId;
  String? get beneficiaryId => _$this._beneficiaryId;
  set beneficiaryId(String? beneficiaryId) =>
      _$this._beneficiaryId = beneficiaryId;

  _i3.GReservationStatus? _status;
  _i3.GReservationStatus? get status => _$this._status;
  set status(_i3.GReservationStatus? status) => _$this._status = status;

  _i3.GDateTimeBuilder? _createdAt;
  _i3.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i3.GDateTimeBuilder();
  set createdAt(_i3.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  _i3.GDateTimeBuilder? _confirmedAt;
  _i3.GDateTimeBuilder get confirmedAt =>
      _$this._confirmedAt ??= _i3.GDateTimeBuilder();
  set confirmedAt(_i3.GDateTimeBuilder? confirmedAt) =>
      _$this._confirmedAt = confirmedAt;

  _i3.GDateTimeBuilder? _updatedAt;
  _i3.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i3.GDateTimeBuilder();
  set updatedAt(_i3.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  GConfirmReservationData_confirmReservation_donationBuilder? _donation;
  GConfirmReservationData_confirmReservation_donationBuilder get donation =>
      _$this._donation ??=
          GConfirmReservationData_confirmReservation_donationBuilder();
  set donation(
    GConfirmReservationData_confirmReservation_donationBuilder? donation,
  ) => _$this._donation = donation;

  GConfirmReservationData_confirmReservation_beneficiaryBuilder? _beneficiary;
  GConfirmReservationData_confirmReservation_beneficiaryBuilder
  get beneficiary => _$this._beneficiary ??=
      GConfirmReservationData_confirmReservation_beneficiaryBuilder();
  set beneficiary(
    GConfirmReservationData_confirmReservation_beneficiaryBuilder? beneficiary,
  ) => _$this._beneficiary = beneficiary;

  GConfirmReservationData_confirmReservationBuilder() {
    GConfirmReservationData_confirmReservation._initializeBuilder(this);
  }

  GConfirmReservationData_confirmReservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _donationId = $v.donationId;
      _beneficiaryId = $v.beneficiaryId;
      _status = $v.status;
      _createdAt = $v.createdAt.toBuilder();
      _confirmedAt = $v.confirmedAt?.toBuilder();
      _updatedAt = $v.updatedAt.toBuilder();
      _donation = $v.donation?.toBuilder();
      _beneficiary = $v.beneficiary?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GConfirmReservationData_confirmReservation other) {
    _$v = other as _$GConfirmReservationData_confirmReservation;
  }

  @override
  void update(
    void Function(GConfirmReservationData_confirmReservationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation build() => _build();

  _$GConfirmReservationData_confirmReservation _build() {
    _$GConfirmReservationData_confirmReservation _$result;
    try {
      _$result =
          _$v ??
          _$GConfirmReservationData_confirmReservation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GConfirmReservationData_confirmReservation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GConfirmReservationData_confirmReservation',
              'id',
            ),
            donationId: BuiltValueNullFieldError.checkNotNull(
              donationId,
              r'GConfirmReservationData_confirmReservation',
              'donationId',
            ),
            beneficiaryId: BuiltValueNullFieldError.checkNotNull(
              beneficiaryId,
              r'GConfirmReservationData_confirmReservation',
              'beneficiaryId',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GConfirmReservationData_confirmReservation',
              'status',
            ),
            createdAt: createdAt.build(),
            confirmedAt: _confirmedAt?.build(),
            updatedAt: updatedAt.build(),
            donation: _donation?.build(),
            beneficiary: _beneficiary?.build(),
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
        _$failedField = 'beneficiary';
        _beneficiary?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GConfirmReservationData_confirmReservation',
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

class _$GConfirmReservationData_confirmReservation_donation
    extends GConfirmReservationData_confirmReservation_donation {
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
  final GConfirmReservationData_confirmReservation_donation_category? category;
  @override
  final _i3.GDonationStatusValues status;
  @override
  final _i3.GDonationUrgencyValues urgency;
  @override
  final String? mainAttachmentId;
  @override
  final GConfirmReservationData_confirmReservation_donation_mainAttachment?
  mainAttachment;
  @override
  final String? imageUrl;
  @override
  final GConfirmReservationData_confirmReservation_donation_location? location;
  @override
  final GConfirmReservationData_confirmReservation_donation_user user;

  factory _$GConfirmReservationData_confirmReservation_donation([
    void Function(GConfirmReservationData_confirmReservation_donationBuilder)?
    updates,
  ]) =>
      (GConfirmReservationData_confirmReservation_donationBuilder()
            ..update(updates))
          ._build();

  _$GConfirmReservationData_confirmReservation_donation._({
    required this.G__typename,
    required this.id,
    required this.title,
    required this.description,
    required this.quantity,
    required this.categoryId,
    this.category,
    required this.status,
    required this.urgency,
    this.mainAttachmentId,
    this.mainAttachment,
    this.imageUrl,
    this.location,
    required this.user,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation_donation rebuild(
    void Function(GConfirmReservationData_confirmReservation_donationBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservation_donationBuilder toBuilder() =>
      GConfirmReservationData_confirmReservation_donationBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GConfirmReservationData_confirmReservation_donation &&
        G__typename == other.G__typename &&
        id == other.id &&
        title == other.title &&
        description == other.description &&
        quantity == other.quantity &&
        categoryId == other.categoryId &&
        category == other.category &&
        status == other.status &&
        urgency == other.urgency &&
        mainAttachmentId == other.mainAttachmentId &&
        mainAttachment == other.mainAttachment &&
        imageUrl == other.imageUrl &&
        location == other.location &&
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
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, urgency.hashCode);
    _$hash = $jc(_$hash, mainAttachmentId.hashCode);
    _$hash = $jc(_$hash, mainAttachment.hashCode);
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation_donation',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('title', title)
          ..add('description', description)
          ..add('quantity', quantity)
          ..add('categoryId', categoryId)
          ..add('category', category)
          ..add('status', status)
          ..add('urgency', urgency)
          ..add('mainAttachmentId', mainAttachmentId)
          ..add('mainAttachment', mainAttachment)
          ..add('imageUrl', imageUrl)
          ..add('location', location)
          ..add('user', user))
        .toString();
  }
}

class GConfirmReservationData_confirmReservation_donationBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation_donation,
          GConfirmReservationData_confirmReservation_donationBuilder
        > {
  _$GConfirmReservationData_confirmReservation_donation? _$v;

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

  GConfirmReservationData_confirmReservation_donation_categoryBuilder?
  _category;
  GConfirmReservationData_confirmReservation_donation_categoryBuilder
  get category => _$this._category ??=
      GConfirmReservationData_confirmReservation_donation_categoryBuilder();
  set category(
    GConfirmReservationData_confirmReservation_donation_categoryBuilder?
    category,
  ) => _$this._category = category;

  _i3.GDonationStatusValues? _status;
  _i3.GDonationStatusValues? get status => _$this._status;
  set status(_i3.GDonationStatusValues? status) => _$this._status = status;

  _i3.GDonationUrgencyValues? _urgency;
  _i3.GDonationUrgencyValues? get urgency => _$this._urgency;
  set urgency(_i3.GDonationUrgencyValues? urgency) => _$this._urgency = urgency;

  String? _mainAttachmentId;
  String? get mainAttachmentId => _$this._mainAttachmentId;
  set mainAttachmentId(String? mainAttachmentId) =>
      _$this._mainAttachmentId = mainAttachmentId;

  GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder?
  _mainAttachment;
  GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder
  get mainAttachment => _$this._mainAttachment ??=
      GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder();
  set mainAttachment(
    GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder?
    mainAttachment,
  ) => _$this._mainAttachment = mainAttachment;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  GConfirmReservationData_confirmReservation_donation_locationBuilder?
  _location;
  GConfirmReservationData_confirmReservation_donation_locationBuilder
  get location => _$this._location ??=
      GConfirmReservationData_confirmReservation_donation_locationBuilder();
  set location(
    GConfirmReservationData_confirmReservation_donation_locationBuilder?
    location,
  ) => _$this._location = location;

  GConfirmReservationData_confirmReservation_donation_userBuilder? _user;
  GConfirmReservationData_confirmReservation_donation_userBuilder get user =>
      _$this._user ??=
          GConfirmReservationData_confirmReservation_donation_userBuilder();
  set user(
    GConfirmReservationData_confirmReservation_donation_userBuilder? user,
  ) => _$this._user = user;

  GConfirmReservationData_confirmReservation_donationBuilder() {
    GConfirmReservationData_confirmReservation_donation._initializeBuilder(
      this,
    );
  }

  GConfirmReservationData_confirmReservation_donationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _title = $v.title;
      _description = $v.description;
      _quantity = $v.quantity;
      _categoryId = $v.categoryId;
      _category = $v.category?.toBuilder();
      _status = $v.status;
      _urgency = $v.urgency;
      _mainAttachmentId = $v.mainAttachmentId;
      _mainAttachment = $v.mainAttachment?.toBuilder();
      _imageUrl = $v.imageUrl;
      _location = $v.location?.toBuilder();
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GConfirmReservationData_confirmReservation_donation other) {
    _$v = other as _$GConfirmReservationData_confirmReservation_donation;
  }

  @override
  void update(
    void Function(GConfirmReservationData_confirmReservation_donationBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation_donation build() => _build();

  _$GConfirmReservationData_confirmReservation_donation _build() {
    _$GConfirmReservationData_confirmReservation_donation _$result;
    try {
      _$result =
          _$v ??
          _$GConfirmReservationData_confirmReservation_donation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GConfirmReservationData_confirmReservation_donation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GConfirmReservationData_confirmReservation_donation',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GConfirmReservationData_confirmReservation_donation',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'GConfirmReservationData_confirmReservation_donation',
              'description',
            ),
            quantity: BuiltValueNullFieldError.checkNotNull(
              quantity,
              r'GConfirmReservationData_confirmReservation_donation',
              'quantity',
            ),
            categoryId: BuiltValueNullFieldError.checkNotNull(
              categoryId,
              r'GConfirmReservationData_confirmReservation_donation',
              'categoryId',
            ),
            category: _category?.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GConfirmReservationData_confirmReservation_donation',
              'status',
            ),
            urgency: BuiltValueNullFieldError.checkNotNull(
              urgency,
              r'GConfirmReservationData_confirmReservation_donation',
              'urgency',
            ),
            mainAttachmentId: mainAttachmentId,
            mainAttachment: _mainAttachment?.build(),
            imageUrl: imageUrl,
            location: _location?.build(),
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'category';
        _category?.build();

        _$failedField = 'mainAttachment';
        _mainAttachment?.build();

        _$failedField = 'location';
        _location?.build();
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GConfirmReservationData_confirmReservation_donation',
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

class _$GConfirmReservationData_confirmReservation_donation_category
    extends GConfirmReservationData_confirmReservation_donation_category {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;

  factory _$GConfirmReservationData_confirmReservation_donation_category([
    void Function(
      GConfirmReservationData_confirmReservation_donation_categoryBuilder,
    )?
    updates,
  ]) =>
      (GConfirmReservationData_confirmReservation_donation_categoryBuilder()
            ..update(updates))
          ._build();

  _$GConfirmReservationData_confirmReservation_donation_category._({
    required this.G__typename,
    required this.id,
    required this.name,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation_donation_category rebuild(
    void Function(
      GConfirmReservationData_confirmReservation_donation_categoryBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservation_donation_categoryBuilder
  toBuilder() =>
      GConfirmReservationData_confirmReservation_donation_categoryBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GConfirmReservationData_confirmReservation_donation_category &&
        G__typename == other.G__typename &&
        id == other.id &&
        name == other.name;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation_donation_category',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GConfirmReservationData_confirmReservation_donation_categoryBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation_donation_category,
          GConfirmReservationData_confirmReservation_donation_categoryBuilder
        > {
  _$GConfirmReservationData_confirmReservation_donation_category? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GConfirmReservationData_confirmReservation_donation_categoryBuilder() {
    GConfirmReservationData_confirmReservation_donation_category._initializeBuilder(
      this,
    );
  }

  GConfirmReservationData_confirmReservation_donation_categoryBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _name = $v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GConfirmReservationData_confirmReservation_donation_category other,
  ) {
    _$v =
        other as _$GConfirmReservationData_confirmReservation_donation_category;
  }

  @override
  void update(
    void Function(
      GConfirmReservationData_confirmReservation_donation_categoryBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation_donation_category build() =>
      _build();

  _$GConfirmReservationData_confirmReservation_donation_category _build() {
    final _$result =
        _$v ??
        _$GConfirmReservationData_confirmReservation_donation_category._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GConfirmReservationData_confirmReservation_donation_category',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GConfirmReservationData_confirmReservation_donation_category',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GConfirmReservationData_confirmReservation_donation_category',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GConfirmReservationData_confirmReservation_donation_mainAttachment
    extends GConfirmReservationData_confirmReservation_donation_mainAttachment {
  @override
  final String G__typename;
  @override
  final String? url;

  factory _$GConfirmReservationData_confirmReservation_donation_mainAttachment([
    void Function(
      GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder,
    )?
    updates,
  ]) =>
      (GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder()
            ..update(updates))
          ._build();

  _$GConfirmReservationData_confirmReservation_donation_mainAttachment._({
    required this.G__typename,
    this.url,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation_donation_mainAttachment rebuild(
    void Function(
      GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder
  toBuilder() =>
      GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GConfirmReservationData_confirmReservation_donation_mainAttachment &&
        G__typename == other.G__typename &&
        url == other.url;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation_donation_mainAttachment',
          )
          ..add('G__typename', G__typename)
          ..add('url', url))
        .toString();
  }
}

class GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation_donation_mainAttachment,
          GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder
        > {
  _$GConfirmReservationData_confirmReservation_donation_mainAttachment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder() {
    GConfirmReservationData_confirmReservation_donation_mainAttachment._initializeBuilder(
      this,
    );
  }

  GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GConfirmReservationData_confirmReservation_donation_mainAttachment other,
  ) {
    _$v =
        other
            as _$GConfirmReservationData_confirmReservation_donation_mainAttachment;
  }

  @override
  void update(
    void Function(
      GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation_donation_mainAttachment build() =>
      _build();

  _$GConfirmReservationData_confirmReservation_donation_mainAttachment
  _build() {
    final _$result =
        _$v ??
        _$GConfirmReservationData_confirmReservation_donation_mainAttachment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GConfirmReservationData_confirmReservation_donation_mainAttachment',
            'G__typename',
          ),
          url: url,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GConfirmReservationData_confirmReservation_donation_location
    extends GConfirmReservationData_confirmReservation_donation_location {
  @override
  final String G__typename;
  @override
  final double? latitude;
  @override
  final double? longitude;

  factory _$GConfirmReservationData_confirmReservation_donation_location([
    void Function(
      GConfirmReservationData_confirmReservation_donation_locationBuilder,
    )?
    updates,
  ]) =>
      (GConfirmReservationData_confirmReservation_donation_locationBuilder()
            ..update(updates))
          ._build();

  _$GConfirmReservationData_confirmReservation_donation_location._({
    required this.G__typename,
    this.latitude,
    this.longitude,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation_donation_location rebuild(
    void Function(
      GConfirmReservationData_confirmReservation_donation_locationBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservation_donation_locationBuilder
  toBuilder() =>
      GConfirmReservationData_confirmReservation_donation_locationBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GConfirmReservationData_confirmReservation_donation_location &&
        G__typename == other.G__typename &&
        latitude == other.latitude &&
        longitude == other.longitude;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation_donation_location',
          )
          ..add('G__typename', G__typename)
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class GConfirmReservationData_confirmReservation_donation_locationBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation_donation_location,
          GConfirmReservationData_confirmReservation_donation_locationBuilder
        > {
  _$GConfirmReservationData_confirmReservation_donation_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  GConfirmReservationData_confirmReservation_donation_locationBuilder() {
    GConfirmReservationData_confirmReservation_donation_location._initializeBuilder(
      this,
    );
  }

  GConfirmReservationData_confirmReservation_donation_locationBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GConfirmReservationData_confirmReservation_donation_location other,
  ) {
    _$v =
        other as _$GConfirmReservationData_confirmReservation_donation_location;
  }

  @override
  void update(
    void Function(
      GConfirmReservationData_confirmReservation_donation_locationBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation_donation_location build() =>
      _build();

  _$GConfirmReservationData_confirmReservation_donation_location _build() {
    final _$result =
        _$v ??
        _$GConfirmReservationData_confirmReservation_donation_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GConfirmReservationData_confirmReservation_donation_location',
            'G__typename',
          ),
          latitude: latitude,
          longitude: longitude,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GConfirmReservationData_confirmReservation_donation_user
    extends GConfirmReservationData_confirmReservation_donation_user {
  @override
  final String G__typename;
  @override
  final String? displayName;
  @override
  final String email;

  factory _$GConfirmReservationData_confirmReservation_donation_user([
    void Function(
      GConfirmReservationData_confirmReservation_donation_userBuilder,
    )?
    updates,
  ]) =>
      (GConfirmReservationData_confirmReservation_donation_userBuilder()
            ..update(updates))
          ._build();

  _$GConfirmReservationData_confirmReservation_donation_user._({
    required this.G__typename,
    this.displayName,
    required this.email,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation_donation_user rebuild(
    void Function(
      GConfirmReservationData_confirmReservation_donation_userBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservation_donation_userBuilder toBuilder() =>
      GConfirmReservationData_confirmReservation_donation_userBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GConfirmReservationData_confirmReservation_donation_user &&
        G__typename == other.G__typename &&
        displayName == other.displayName &&
        email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation_donation_user',
          )
          ..add('G__typename', G__typename)
          ..add('displayName', displayName)
          ..add('email', email))
        .toString();
  }
}

class GConfirmReservationData_confirmReservation_donation_userBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation_donation_user,
          GConfirmReservationData_confirmReservation_donation_userBuilder
        > {
  _$GConfirmReservationData_confirmReservation_donation_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GConfirmReservationData_confirmReservation_donation_userBuilder() {
    GConfirmReservationData_confirmReservation_donation_user._initializeBuilder(
      this,
    );
  }

  GConfirmReservationData_confirmReservation_donation_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _displayName = $v.displayName;
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GConfirmReservationData_confirmReservation_donation_user other) {
    _$v = other as _$GConfirmReservationData_confirmReservation_donation_user;
  }

  @override
  void update(
    void Function(
      GConfirmReservationData_confirmReservation_donation_userBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation_donation_user build() => _build();

  _$GConfirmReservationData_confirmReservation_donation_user _build() {
    final _$result =
        _$v ??
        _$GConfirmReservationData_confirmReservation_donation_user._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GConfirmReservationData_confirmReservation_donation_user',
            'G__typename',
          ),
          displayName: displayName,
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'GConfirmReservationData_confirmReservation_donation_user',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GConfirmReservationData_confirmReservation_beneficiary
    extends GConfirmReservationData_confirmReservation_beneficiary {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final String? phoneNumber;
  @override
  final _i3.GUserRole role;
  @override
  final String? description;
  @override
  final bool isMailVerified;
  @override
  final int reputationScore;
  @override
  final String? locationId;
  @override
  final GConfirmReservationData_confirmReservation_beneficiary_location?
  location;
  @override
  final GConfirmReservationData_confirmReservation_beneficiary_avatar? avatar;

  factory _$GConfirmReservationData_confirmReservation_beneficiary([
    void Function(
      GConfirmReservationData_confirmReservation_beneficiaryBuilder,
    )?
    updates,
  ]) =>
      (GConfirmReservationData_confirmReservation_beneficiaryBuilder()
            ..update(updates))
          ._build();

  _$GConfirmReservationData_confirmReservation_beneficiary._({
    required this.G__typename,
    required this.id,
    required this.email,
    this.displayName,
    this.phoneNumber,
    required this.role,
    this.description,
    required this.isMailVerified,
    required this.reputationScore,
    this.locationId,
    this.location,
    this.avatar,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation_beneficiary rebuild(
    void Function(GConfirmReservationData_confirmReservation_beneficiaryBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservation_beneficiaryBuilder toBuilder() =>
      GConfirmReservationData_confirmReservation_beneficiaryBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GConfirmReservationData_confirmReservation_beneficiary &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email &&
        displayName == other.displayName &&
        phoneNumber == other.phoneNumber &&
        role == other.role &&
        description == other.description &&
        isMailVerified == other.isMailVerified &&
        reputationScore == other.reputationScore &&
        locationId == other.locationId &&
        location == other.location &&
        avatar == other.avatar;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isMailVerified.hashCode);
    _$hash = $jc(_$hash, reputationScore.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation_beneficiary',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('phoneNumber', phoneNumber)
          ..add('role', role)
          ..add('description', description)
          ..add('isMailVerified', isMailVerified)
          ..add('reputationScore', reputationScore)
          ..add('locationId', locationId)
          ..add('location', location)
          ..add('avatar', avatar))
        .toString();
  }
}

class GConfirmReservationData_confirmReservation_beneficiaryBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation_beneficiary,
          GConfirmReservationData_confirmReservation_beneficiaryBuilder
        > {
  _$GConfirmReservationData_confirmReservation_beneficiary? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  _i3.GUserRole? _role;
  _i3.GUserRole? get role => _$this._role;
  set role(_i3.GUserRole? role) => _$this._role = role;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isMailVerified;
  bool? get isMailVerified => _$this._isMailVerified;
  set isMailVerified(bool? isMailVerified) =>
      _$this._isMailVerified = isMailVerified;

  int? _reputationScore;
  int? get reputationScore => _$this._reputationScore;
  set reputationScore(int? reputationScore) =>
      _$this._reputationScore = reputationScore;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  GConfirmReservationData_confirmReservation_beneficiary_locationBuilder?
  _location;
  GConfirmReservationData_confirmReservation_beneficiary_locationBuilder
  get location => _$this._location ??=
      GConfirmReservationData_confirmReservation_beneficiary_locationBuilder();
  set location(
    GConfirmReservationData_confirmReservation_beneficiary_locationBuilder?
    location,
  ) => _$this._location = location;

  GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder? _avatar;
  GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder
  get avatar => _$this._avatar ??=
      GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder();
  set avatar(
    GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder?
    avatar,
  ) => _$this._avatar = avatar;

  GConfirmReservationData_confirmReservation_beneficiaryBuilder() {
    GConfirmReservationData_confirmReservation_beneficiary._initializeBuilder(
      this,
    );
  }

  GConfirmReservationData_confirmReservation_beneficiaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _displayName = $v.displayName;
      _phoneNumber = $v.phoneNumber;
      _role = $v.role;
      _description = $v.description;
      _isMailVerified = $v.isMailVerified;
      _reputationScore = $v.reputationScore;
      _locationId = $v.locationId;
      _location = $v.location?.toBuilder();
      _avatar = $v.avatar?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GConfirmReservationData_confirmReservation_beneficiary other) {
    _$v = other as _$GConfirmReservationData_confirmReservation_beneficiary;
  }

  @override
  void update(
    void Function(
      GConfirmReservationData_confirmReservation_beneficiaryBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation_beneficiary build() => _build();

  _$GConfirmReservationData_confirmReservation_beneficiary _build() {
    _$GConfirmReservationData_confirmReservation_beneficiary _$result;
    try {
      _$result =
          _$v ??
          _$GConfirmReservationData_confirmReservation_beneficiary._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GConfirmReservationData_confirmReservation_beneficiary',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GConfirmReservationData_confirmReservation_beneficiary',
              'id',
            ),
            email: BuiltValueNullFieldError.checkNotNull(
              email,
              r'GConfirmReservationData_confirmReservation_beneficiary',
              'email',
            ),
            displayName: displayName,
            phoneNumber: phoneNumber,
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'GConfirmReservationData_confirmReservation_beneficiary',
              'role',
            ),
            description: description,
            isMailVerified: BuiltValueNullFieldError.checkNotNull(
              isMailVerified,
              r'GConfirmReservationData_confirmReservation_beneficiary',
              'isMailVerified',
            ),
            reputationScore: BuiltValueNullFieldError.checkNotNull(
              reputationScore,
              r'GConfirmReservationData_confirmReservation_beneficiary',
              'reputationScore',
            ),
            locationId: locationId,
            location: _location?.build(),
            avatar: _avatar?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
        _$failedField = 'avatar';
        _avatar?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GConfirmReservationData_confirmReservation_beneficiary',
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

class _$GConfirmReservationData_confirmReservation_beneficiary_location
    extends GConfirmReservationData_confirmReservation_beneficiary_location {
  @override
  final String G__typename;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? neighborhood;

  factory _$GConfirmReservationData_confirmReservation_beneficiary_location([
    void Function(
      GConfirmReservationData_confirmReservation_beneficiary_locationBuilder,
    )?
    updates,
  ]) =>
      (GConfirmReservationData_confirmReservation_beneficiary_locationBuilder()
            ..update(updates))
          ._build();

  _$GConfirmReservationData_confirmReservation_beneficiary_location._({
    required this.G__typename,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.neighborhood,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation_beneficiary_location rebuild(
    void Function(
      GConfirmReservationData_confirmReservation_beneficiary_locationBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservation_beneficiary_locationBuilder
  toBuilder() =>
      GConfirmReservationData_confirmReservation_beneficiary_locationBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GConfirmReservationData_confirmReservation_beneficiary_location &&
        G__typename == other.G__typename &&
        city == other.city &&
        country == other.country &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        neighborhood == other.neighborhood;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, neighborhood.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation_beneficiary_location',
          )
          ..add('G__typename', G__typename)
          ..add('city', city)
          ..add('country', country)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('neighborhood', neighborhood))
        .toString();
  }
}

class GConfirmReservationData_confirmReservation_beneficiary_locationBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation_beneficiary_location,
          GConfirmReservationData_confirmReservation_beneficiary_locationBuilder
        > {
  _$GConfirmReservationData_confirmReservation_beneficiary_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  String? _neighborhood;
  String? get neighborhood => _$this._neighborhood;
  set neighborhood(String? neighborhood) => _$this._neighborhood = neighborhood;

  GConfirmReservationData_confirmReservation_beneficiary_locationBuilder() {
    GConfirmReservationData_confirmReservation_beneficiary_location._initializeBuilder(
      this,
    );
  }

  GConfirmReservationData_confirmReservation_beneficiary_locationBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _city = $v.city;
      _country = $v.country;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _neighborhood = $v.neighborhood;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GConfirmReservationData_confirmReservation_beneficiary_location other,
  ) {
    _$v =
        other
            as _$GConfirmReservationData_confirmReservation_beneficiary_location;
  }

  @override
  void update(
    void Function(
      GConfirmReservationData_confirmReservation_beneficiary_locationBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation_beneficiary_location build() =>
      _build();

  _$GConfirmReservationData_confirmReservation_beneficiary_location _build() {
    final _$result =
        _$v ??
        _$GConfirmReservationData_confirmReservation_beneficiary_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GConfirmReservationData_confirmReservation_beneficiary_location',
            'G__typename',
          ),
          city: city,
          country: country,
          latitude: latitude,
          longitude: longitude,
          neighborhood: neighborhood,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GConfirmReservationData_confirmReservation_beneficiary_avatar
    extends GConfirmReservationData_confirmReservation_beneficiary_avatar {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? url;

  factory _$GConfirmReservationData_confirmReservation_beneficiary_avatar([
    void Function(
      GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder,
    )?
    updates,
  ]) =>
      (GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder()
            ..update(updates))
          ._build();

  _$GConfirmReservationData_confirmReservation_beneficiary_avatar._({
    required this.G__typename,
    required this.id,
    this.url,
  }) : super._();
  @override
  GConfirmReservationData_confirmReservation_beneficiary_avatar rebuild(
    void Function(
      GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder
  toBuilder() =>
      GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GConfirmReservationData_confirmReservation_beneficiary_avatar &&
        G__typename == other.G__typename &&
        id == other.id &&
        url == other.url;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GConfirmReservationData_confirmReservation_beneficiary_avatar',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('url', url))
        .toString();
  }
}

class GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder
    implements
        Builder<
          GConfirmReservationData_confirmReservation_beneficiary_avatar,
          GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder
        > {
  _$GConfirmReservationData_confirmReservation_beneficiary_avatar? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder() {
    GConfirmReservationData_confirmReservation_beneficiary_avatar._initializeBuilder(
      this,
    );
  }

  GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GConfirmReservationData_confirmReservation_beneficiary_avatar other,
  ) {
    _$v =
        other
            as _$GConfirmReservationData_confirmReservation_beneficiary_avatar;
  }

  @override
  void update(
    void Function(
      GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationData_confirmReservation_beneficiary_avatar build() =>
      _build();

  _$GConfirmReservationData_confirmReservation_beneficiary_avatar _build() {
    final _$result =
        _$v ??
        _$GConfirmReservationData_confirmReservation_beneficiary_avatar._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GConfirmReservationData_confirmReservation_beneficiary_avatar',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GConfirmReservationData_confirmReservation_beneficiary_avatar',
            'id',
          ),
          url: url,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
