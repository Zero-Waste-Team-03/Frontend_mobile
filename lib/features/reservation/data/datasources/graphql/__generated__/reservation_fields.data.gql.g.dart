// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_fields.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GReservationFieldsData> _$gReservationFieldsDataSerializer =
    _$GReservationFieldsDataSerializer();
Serializer<GReservationFieldsData_donation>
_$gReservationFieldsDataDonationSerializer =
    _$GReservationFieldsData_donationSerializer();
Serializer<GReservationFieldsData_donation_category>
_$gReservationFieldsDataDonationCategorySerializer =
    _$GReservationFieldsData_donation_categorySerializer();
Serializer<GReservationFieldsData_donation_mainAttachment>
_$gReservationFieldsDataDonationMainAttachmentSerializer =
    _$GReservationFieldsData_donation_mainAttachmentSerializer();
Serializer<GReservationFieldsData_donation_location>
_$gReservationFieldsDataDonationLocationSerializer =
    _$GReservationFieldsData_donation_locationSerializer();
Serializer<GReservationFieldsData_donation_user>
_$gReservationFieldsDataDonationUserSerializer =
    _$GReservationFieldsData_donation_userSerializer();
Serializer<GReservationFieldsData_beneficiary>
_$gReservationFieldsDataBeneficiarySerializer =
    _$GReservationFieldsData_beneficiarySerializer();
Serializer<GReservationFieldsData_beneficiary_location>
_$gReservationFieldsDataBeneficiaryLocationSerializer =
    _$GReservationFieldsData_beneficiary_locationSerializer();
Serializer<GReservationFieldsData_beneficiary_avatar>
_$gReservationFieldsDataBeneficiaryAvatarSerializer =
    _$GReservationFieldsData_beneficiary_avatarSerializer();

class _$GReservationFieldsDataSerializer
    implements StructuredSerializer<GReservationFieldsData> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData,
    _$GReservationFieldsData,
  ];
  @override
  final String wireName = 'GReservationFieldsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData object, {
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
        specifiedType: const FullType(_i1.GReservationStatus),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i1.GDateTime),
      ),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(_i1.GDateTime),
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
            specifiedType: const FullType(_i1.GDateTime),
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
            specifiedType: const FullType(GReservationFieldsData_donation),
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
            specifiedType: const FullType(GReservationFieldsData_beneficiary),
          ),
        );
    }
    return result;
  }

  @override
  GReservationFieldsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsDataBuilder();

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
                    specifiedType: const FullType(_i1.GReservationStatus),
                  )!
                  as _i1.GReservationStatus;
          break;
        case 'createdAt':
          result.createdAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GDateTime),
                )!
                as _i1.GDateTime,
          );
          break;
        case 'confirmedAt':
          result.confirmedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GDateTime),
                )!
                as _i1.GDateTime,
          );
          break;
        case 'updatedAt':
          result.updatedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GDateTime),
                )!
                as _i1.GDateTime,
          );
          break;
        case 'donation':
          result.donation.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GReservationFieldsData_donation,
                  ),
                )!
                as GReservationFieldsData_donation,
          );
          break;
        case 'beneficiary':
          result.beneficiary.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GReservationFieldsData_beneficiary,
                  ),
                )!
                as GReservationFieldsData_beneficiary,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GReservationFieldsData_donationSerializer
    implements StructuredSerializer<GReservationFieldsData_donation> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData_donation,
    _$GReservationFieldsData_donation,
  ];
  @override
  final String wireName = 'GReservationFieldsData_donation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData_donation object, {
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
        specifiedType: const FullType(_i1.GDonationStatusValues),
      ),
      'urgency',
      serializers.serialize(
        object.urgency,
        specifiedType: const FullType(_i1.GDonationUrgencyValues),
      ),
      'user',
      serializers.serialize(
        object.user,
        specifiedType: const FullType(GReservationFieldsData_donation_user),
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
              GReservationFieldsData_donation_category,
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
              GReservationFieldsData_donation_mainAttachment,
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
              GReservationFieldsData_donation_location,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GReservationFieldsData_donation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsData_donationBuilder();

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
                    GReservationFieldsData_donation_category,
                  ),
                )!
                as GReservationFieldsData_donation_category,
          );
          break;
        case 'status':
          result.status =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i1.GDonationStatusValues),
                  )!
                  as _i1.GDonationStatusValues;
          break;
        case 'urgency':
          result.urgency =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i1.GDonationUrgencyValues),
                  )!
                  as _i1.GDonationUrgencyValues;
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
                    GReservationFieldsData_donation_mainAttachment,
                  ),
                )!
                as GReservationFieldsData_donation_mainAttachment,
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
                    GReservationFieldsData_donation_location,
                  ),
                )!
                as GReservationFieldsData_donation_location,
          );
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GReservationFieldsData_donation_user,
                  ),
                )!
                as GReservationFieldsData_donation_user,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GReservationFieldsData_donation_categorySerializer
    implements StructuredSerializer<GReservationFieldsData_donation_category> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData_donation_category,
    _$GReservationFieldsData_donation_category,
  ];
  @override
  final String wireName = 'GReservationFieldsData_donation_category';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData_donation_category object, {
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
  GReservationFieldsData_donation_category deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsData_donation_categoryBuilder();

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

class _$GReservationFieldsData_donation_mainAttachmentSerializer
    implements
        StructuredSerializer<GReservationFieldsData_donation_mainAttachment> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData_donation_mainAttachment,
    _$GReservationFieldsData_donation_mainAttachment,
  ];
  @override
  final String wireName = 'GReservationFieldsData_donation_mainAttachment';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData_donation_mainAttachment object, {
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
  GReservationFieldsData_donation_mainAttachment deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsData_donation_mainAttachmentBuilder();

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

class _$GReservationFieldsData_donation_locationSerializer
    implements StructuredSerializer<GReservationFieldsData_donation_location> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData_donation_location,
    _$GReservationFieldsData_donation_location,
  ];
  @override
  final String wireName = 'GReservationFieldsData_donation_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData_donation_location object, {
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
  GReservationFieldsData_donation_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsData_donation_locationBuilder();

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

class _$GReservationFieldsData_donation_userSerializer
    implements StructuredSerializer<GReservationFieldsData_donation_user> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData_donation_user,
    _$GReservationFieldsData_donation_user,
  ];
  @override
  final String wireName = 'GReservationFieldsData_donation_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData_donation_user object, {
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
  GReservationFieldsData_donation_user deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsData_donation_userBuilder();

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

class _$GReservationFieldsData_beneficiarySerializer
    implements StructuredSerializer<GReservationFieldsData_beneficiary> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData_beneficiary,
    _$GReservationFieldsData_beneficiary,
  ];
  @override
  final String wireName = 'GReservationFieldsData_beneficiary';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData_beneficiary object, {
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
        specifiedType: const FullType(_i1.GUserRole),
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
              GReservationFieldsData_beneficiary_location,
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
              GReservationFieldsData_beneficiary_avatar,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GReservationFieldsData_beneficiary deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsData_beneficiaryBuilder();

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
                    specifiedType: const FullType(_i1.GUserRole),
                  )!
                  as _i1.GUserRole;
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
                    GReservationFieldsData_beneficiary_location,
                  ),
                )!
                as GReservationFieldsData_beneficiary_location,
          );
          break;
        case 'avatar':
          result.avatar.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GReservationFieldsData_beneficiary_avatar,
                  ),
                )!
                as GReservationFieldsData_beneficiary_avatar,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GReservationFieldsData_beneficiary_locationSerializer
    implements
        StructuredSerializer<GReservationFieldsData_beneficiary_location> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData_beneficiary_location,
    _$GReservationFieldsData_beneficiary_location,
  ];
  @override
  final String wireName = 'GReservationFieldsData_beneficiary_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData_beneficiary_location object, {
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
  GReservationFieldsData_beneficiary_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsData_beneficiary_locationBuilder();

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

class _$GReservationFieldsData_beneficiary_avatarSerializer
    implements StructuredSerializer<GReservationFieldsData_beneficiary_avatar> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsData_beneficiary_avatar,
    _$GReservationFieldsData_beneficiary_avatar,
  ];
  @override
  final String wireName = 'GReservationFieldsData_beneficiary_avatar';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsData_beneficiary_avatar object, {
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
  GReservationFieldsData_beneficiary_avatar deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReservationFieldsData_beneficiary_avatarBuilder();

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

class _$GReservationFieldsData extends GReservationFieldsData {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String donationId;
  @override
  final String beneficiaryId;
  @override
  final _i1.GReservationStatus status;
  @override
  final _i1.GDateTime createdAt;
  @override
  final _i1.GDateTime? confirmedAt;
  @override
  final _i1.GDateTime updatedAt;
  @override
  final GReservationFieldsData_donation? donation;
  @override
  final GReservationFieldsData_beneficiary? beneficiary;

  factory _$GReservationFieldsData([
    void Function(GReservationFieldsDataBuilder)? updates,
  ]) => (GReservationFieldsDataBuilder()..update(updates))._build();

  _$GReservationFieldsData._({
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
  GReservationFieldsData rebuild(
    void Function(GReservationFieldsDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsDataBuilder toBuilder() =>
      GReservationFieldsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData &&
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
    return (newBuiltValueToStringHelper(r'GReservationFieldsData')
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

class GReservationFieldsDataBuilder
    implements Builder<GReservationFieldsData, GReservationFieldsDataBuilder> {
  _$GReservationFieldsData? _$v;

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

  _i1.GReservationStatus? _status;
  _i1.GReservationStatus? get status => _$this._status;
  set status(_i1.GReservationStatus? status) => _$this._status = status;

  _i1.GDateTimeBuilder? _createdAt;
  _i1.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i1.GDateTimeBuilder();
  set createdAt(_i1.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  _i1.GDateTimeBuilder? _confirmedAt;
  _i1.GDateTimeBuilder get confirmedAt =>
      _$this._confirmedAt ??= _i1.GDateTimeBuilder();
  set confirmedAt(_i1.GDateTimeBuilder? confirmedAt) =>
      _$this._confirmedAt = confirmedAt;

  _i1.GDateTimeBuilder? _updatedAt;
  _i1.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i1.GDateTimeBuilder();
  set updatedAt(_i1.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  GReservationFieldsData_donationBuilder? _donation;
  GReservationFieldsData_donationBuilder get donation =>
      _$this._donation ??= GReservationFieldsData_donationBuilder();
  set donation(GReservationFieldsData_donationBuilder? donation) =>
      _$this._donation = donation;

  GReservationFieldsData_beneficiaryBuilder? _beneficiary;
  GReservationFieldsData_beneficiaryBuilder get beneficiary =>
      _$this._beneficiary ??= GReservationFieldsData_beneficiaryBuilder();
  set beneficiary(GReservationFieldsData_beneficiaryBuilder? beneficiary) =>
      _$this._beneficiary = beneficiary;

  GReservationFieldsDataBuilder() {
    GReservationFieldsData._initializeBuilder(this);
  }

  GReservationFieldsDataBuilder get _$this {
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
  void replace(GReservationFieldsData other) {
    _$v = other as _$GReservationFieldsData;
  }

  @override
  void update(void Function(GReservationFieldsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData build() => _build();

  _$GReservationFieldsData _build() {
    _$GReservationFieldsData _$result;
    try {
      _$result =
          _$v ??
          _$GReservationFieldsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GReservationFieldsData',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GReservationFieldsData',
              'id',
            ),
            donationId: BuiltValueNullFieldError.checkNotNull(
              donationId,
              r'GReservationFieldsData',
              'donationId',
            ),
            beneficiaryId: BuiltValueNullFieldError.checkNotNull(
              beneficiaryId,
              r'GReservationFieldsData',
              'beneficiaryId',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GReservationFieldsData',
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
          r'GReservationFieldsData',
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

class _$GReservationFieldsData_donation
    extends GReservationFieldsData_donation {
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
  final GReservationFieldsData_donation_category? category;
  @override
  final _i1.GDonationStatusValues status;
  @override
  final _i1.GDonationUrgencyValues urgency;
  @override
  final String? mainAttachmentId;
  @override
  final GReservationFieldsData_donation_mainAttachment? mainAttachment;
  @override
  final String? imageUrl;
  @override
  final GReservationFieldsData_donation_location? location;
  @override
  final GReservationFieldsData_donation_user user;

  factory _$GReservationFieldsData_donation([
    void Function(GReservationFieldsData_donationBuilder)? updates,
  ]) => (GReservationFieldsData_donationBuilder()..update(updates))._build();

  _$GReservationFieldsData_donation._({
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
  GReservationFieldsData_donation rebuild(
    void Function(GReservationFieldsData_donationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsData_donationBuilder toBuilder() =>
      GReservationFieldsData_donationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData_donation &&
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
    return (newBuiltValueToStringHelper(r'GReservationFieldsData_donation')
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

class GReservationFieldsData_donationBuilder
    implements
        Builder<
          GReservationFieldsData_donation,
          GReservationFieldsData_donationBuilder
        > {
  _$GReservationFieldsData_donation? _$v;

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

  GReservationFieldsData_donation_categoryBuilder? _category;
  GReservationFieldsData_donation_categoryBuilder get category =>
      _$this._category ??= GReservationFieldsData_donation_categoryBuilder();
  set category(GReservationFieldsData_donation_categoryBuilder? category) =>
      _$this._category = category;

  _i1.GDonationStatusValues? _status;
  _i1.GDonationStatusValues? get status => _$this._status;
  set status(_i1.GDonationStatusValues? status) => _$this._status = status;

  _i1.GDonationUrgencyValues? _urgency;
  _i1.GDonationUrgencyValues? get urgency => _$this._urgency;
  set urgency(_i1.GDonationUrgencyValues? urgency) => _$this._urgency = urgency;

  String? _mainAttachmentId;
  String? get mainAttachmentId => _$this._mainAttachmentId;
  set mainAttachmentId(String? mainAttachmentId) =>
      _$this._mainAttachmentId = mainAttachmentId;

  GReservationFieldsData_donation_mainAttachmentBuilder? _mainAttachment;
  GReservationFieldsData_donation_mainAttachmentBuilder get mainAttachment =>
      _$this._mainAttachment ??=
          GReservationFieldsData_donation_mainAttachmentBuilder();
  set mainAttachment(
    GReservationFieldsData_donation_mainAttachmentBuilder? mainAttachment,
  ) => _$this._mainAttachment = mainAttachment;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  GReservationFieldsData_donation_locationBuilder? _location;
  GReservationFieldsData_donation_locationBuilder get location =>
      _$this._location ??= GReservationFieldsData_donation_locationBuilder();
  set location(GReservationFieldsData_donation_locationBuilder? location) =>
      _$this._location = location;

  GReservationFieldsData_donation_userBuilder? _user;
  GReservationFieldsData_donation_userBuilder get user =>
      _$this._user ??= GReservationFieldsData_donation_userBuilder();
  set user(GReservationFieldsData_donation_userBuilder? user) =>
      _$this._user = user;

  GReservationFieldsData_donationBuilder() {
    GReservationFieldsData_donation._initializeBuilder(this);
  }

  GReservationFieldsData_donationBuilder get _$this {
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
  void replace(GReservationFieldsData_donation other) {
    _$v = other as _$GReservationFieldsData_donation;
  }

  @override
  void update(void Function(GReservationFieldsData_donationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData_donation build() => _build();

  _$GReservationFieldsData_donation _build() {
    _$GReservationFieldsData_donation _$result;
    try {
      _$result =
          _$v ??
          _$GReservationFieldsData_donation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GReservationFieldsData_donation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GReservationFieldsData_donation',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GReservationFieldsData_donation',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'GReservationFieldsData_donation',
              'description',
            ),
            quantity: BuiltValueNullFieldError.checkNotNull(
              quantity,
              r'GReservationFieldsData_donation',
              'quantity',
            ),
            categoryId: BuiltValueNullFieldError.checkNotNull(
              categoryId,
              r'GReservationFieldsData_donation',
              'categoryId',
            ),
            category: _category?.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GReservationFieldsData_donation',
              'status',
            ),
            urgency: BuiltValueNullFieldError.checkNotNull(
              urgency,
              r'GReservationFieldsData_donation',
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
          r'GReservationFieldsData_donation',
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

class _$GReservationFieldsData_donation_category
    extends GReservationFieldsData_donation_category {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;

  factory _$GReservationFieldsData_donation_category([
    void Function(GReservationFieldsData_donation_categoryBuilder)? updates,
  ]) => (GReservationFieldsData_donation_categoryBuilder()..update(updates))
      ._build();

  _$GReservationFieldsData_donation_category._({
    required this.G__typename,
    required this.id,
    required this.name,
  }) : super._();
  @override
  GReservationFieldsData_donation_category rebuild(
    void Function(GReservationFieldsData_donation_categoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsData_donation_categoryBuilder toBuilder() =>
      GReservationFieldsData_donation_categoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData_donation_category &&
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
            r'GReservationFieldsData_donation_category',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GReservationFieldsData_donation_categoryBuilder
    implements
        Builder<
          GReservationFieldsData_donation_category,
          GReservationFieldsData_donation_categoryBuilder
        > {
  _$GReservationFieldsData_donation_category? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GReservationFieldsData_donation_categoryBuilder() {
    GReservationFieldsData_donation_category._initializeBuilder(this);
  }

  GReservationFieldsData_donation_categoryBuilder get _$this {
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
  void replace(GReservationFieldsData_donation_category other) {
    _$v = other as _$GReservationFieldsData_donation_category;
  }

  @override
  void update(
    void Function(GReservationFieldsData_donation_categoryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData_donation_category build() => _build();

  _$GReservationFieldsData_donation_category _build() {
    final _$result =
        _$v ??
        _$GReservationFieldsData_donation_category._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GReservationFieldsData_donation_category',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GReservationFieldsData_donation_category',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GReservationFieldsData_donation_category',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GReservationFieldsData_donation_mainAttachment
    extends GReservationFieldsData_donation_mainAttachment {
  @override
  final String G__typename;
  @override
  final String? url;

  factory _$GReservationFieldsData_donation_mainAttachment([
    void Function(GReservationFieldsData_donation_mainAttachmentBuilder)?
    updates,
  ]) =>
      (GReservationFieldsData_donation_mainAttachmentBuilder()..update(updates))
          ._build();

  _$GReservationFieldsData_donation_mainAttachment._({
    required this.G__typename,
    this.url,
  }) : super._();
  @override
  GReservationFieldsData_donation_mainAttachment rebuild(
    void Function(GReservationFieldsData_donation_mainAttachmentBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsData_donation_mainAttachmentBuilder toBuilder() =>
      GReservationFieldsData_donation_mainAttachmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData_donation_mainAttachment &&
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
            r'GReservationFieldsData_donation_mainAttachment',
          )
          ..add('G__typename', G__typename)
          ..add('url', url))
        .toString();
  }
}

class GReservationFieldsData_donation_mainAttachmentBuilder
    implements
        Builder<
          GReservationFieldsData_donation_mainAttachment,
          GReservationFieldsData_donation_mainAttachmentBuilder
        > {
  _$GReservationFieldsData_donation_mainAttachment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GReservationFieldsData_donation_mainAttachmentBuilder() {
    GReservationFieldsData_donation_mainAttachment._initializeBuilder(this);
  }

  GReservationFieldsData_donation_mainAttachmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReservationFieldsData_donation_mainAttachment other) {
    _$v = other as _$GReservationFieldsData_donation_mainAttachment;
  }

  @override
  void update(
    void Function(GReservationFieldsData_donation_mainAttachmentBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData_donation_mainAttachment build() => _build();

  _$GReservationFieldsData_donation_mainAttachment _build() {
    final _$result =
        _$v ??
        _$GReservationFieldsData_donation_mainAttachment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GReservationFieldsData_donation_mainAttachment',
            'G__typename',
          ),
          url: url,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GReservationFieldsData_donation_location
    extends GReservationFieldsData_donation_location {
  @override
  final String G__typename;
  @override
  final double? latitude;
  @override
  final double? longitude;

  factory _$GReservationFieldsData_donation_location([
    void Function(GReservationFieldsData_donation_locationBuilder)? updates,
  ]) => (GReservationFieldsData_donation_locationBuilder()..update(updates))
      ._build();

  _$GReservationFieldsData_donation_location._({
    required this.G__typename,
    this.latitude,
    this.longitude,
  }) : super._();
  @override
  GReservationFieldsData_donation_location rebuild(
    void Function(GReservationFieldsData_donation_locationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsData_donation_locationBuilder toBuilder() =>
      GReservationFieldsData_donation_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData_donation_location &&
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
            r'GReservationFieldsData_donation_location',
          )
          ..add('G__typename', G__typename)
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class GReservationFieldsData_donation_locationBuilder
    implements
        Builder<
          GReservationFieldsData_donation_location,
          GReservationFieldsData_donation_locationBuilder
        > {
  _$GReservationFieldsData_donation_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  GReservationFieldsData_donation_locationBuilder() {
    GReservationFieldsData_donation_location._initializeBuilder(this);
  }

  GReservationFieldsData_donation_locationBuilder get _$this {
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
  void replace(GReservationFieldsData_donation_location other) {
    _$v = other as _$GReservationFieldsData_donation_location;
  }

  @override
  void update(
    void Function(GReservationFieldsData_donation_locationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData_donation_location build() => _build();

  _$GReservationFieldsData_donation_location _build() {
    final _$result =
        _$v ??
        _$GReservationFieldsData_donation_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GReservationFieldsData_donation_location',
            'G__typename',
          ),
          latitude: latitude,
          longitude: longitude,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GReservationFieldsData_donation_user
    extends GReservationFieldsData_donation_user {
  @override
  final String G__typename;
  @override
  final String? displayName;
  @override
  final String email;

  factory _$GReservationFieldsData_donation_user([
    void Function(GReservationFieldsData_donation_userBuilder)? updates,
  ]) =>
      (GReservationFieldsData_donation_userBuilder()..update(updates))._build();

  _$GReservationFieldsData_donation_user._({
    required this.G__typename,
    this.displayName,
    required this.email,
  }) : super._();
  @override
  GReservationFieldsData_donation_user rebuild(
    void Function(GReservationFieldsData_donation_userBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsData_donation_userBuilder toBuilder() =>
      GReservationFieldsData_donation_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData_donation_user &&
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
    return (newBuiltValueToStringHelper(r'GReservationFieldsData_donation_user')
          ..add('G__typename', G__typename)
          ..add('displayName', displayName)
          ..add('email', email))
        .toString();
  }
}

class GReservationFieldsData_donation_userBuilder
    implements
        Builder<
          GReservationFieldsData_donation_user,
          GReservationFieldsData_donation_userBuilder
        > {
  _$GReservationFieldsData_donation_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GReservationFieldsData_donation_userBuilder() {
    GReservationFieldsData_donation_user._initializeBuilder(this);
  }

  GReservationFieldsData_donation_userBuilder get _$this {
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
  void replace(GReservationFieldsData_donation_user other) {
    _$v = other as _$GReservationFieldsData_donation_user;
  }

  @override
  void update(
    void Function(GReservationFieldsData_donation_userBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData_donation_user build() => _build();

  _$GReservationFieldsData_donation_user _build() {
    final _$result =
        _$v ??
        _$GReservationFieldsData_donation_user._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GReservationFieldsData_donation_user',
            'G__typename',
          ),
          displayName: displayName,
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'GReservationFieldsData_donation_user',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GReservationFieldsData_beneficiary
    extends GReservationFieldsData_beneficiary {
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
  final _i1.GUserRole role;
  @override
  final String? description;
  @override
  final bool isMailVerified;
  @override
  final int reputationScore;
  @override
  final String? locationId;
  @override
  final GReservationFieldsData_beneficiary_location? location;
  @override
  final GReservationFieldsData_beneficiary_avatar? avatar;

  factory _$GReservationFieldsData_beneficiary([
    void Function(GReservationFieldsData_beneficiaryBuilder)? updates,
  ]) => (GReservationFieldsData_beneficiaryBuilder()..update(updates))._build();

  _$GReservationFieldsData_beneficiary._({
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
  GReservationFieldsData_beneficiary rebuild(
    void Function(GReservationFieldsData_beneficiaryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsData_beneficiaryBuilder toBuilder() =>
      GReservationFieldsData_beneficiaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData_beneficiary &&
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
    return (newBuiltValueToStringHelper(r'GReservationFieldsData_beneficiary')
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

class GReservationFieldsData_beneficiaryBuilder
    implements
        Builder<
          GReservationFieldsData_beneficiary,
          GReservationFieldsData_beneficiaryBuilder
        > {
  _$GReservationFieldsData_beneficiary? _$v;

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

  _i1.GUserRole? _role;
  _i1.GUserRole? get role => _$this._role;
  set role(_i1.GUserRole? role) => _$this._role = role;

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

  GReservationFieldsData_beneficiary_locationBuilder? _location;
  GReservationFieldsData_beneficiary_locationBuilder get location =>
      _$this._location ??= GReservationFieldsData_beneficiary_locationBuilder();
  set location(GReservationFieldsData_beneficiary_locationBuilder? location) =>
      _$this._location = location;

  GReservationFieldsData_beneficiary_avatarBuilder? _avatar;
  GReservationFieldsData_beneficiary_avatarBuilder get avatar =>
      _$this._avatar ??= GReservationFieldsData_beneficiary_avatarBuilder();
  set avatar(GReservationFieldsData_beneficiary_avatarBuilder? avatar) =>
      _$this._avatar = avatar;

  GReservationFieldsData_beneficiaryBuilder() {
    GReservationFieldsData_beneficiary._initializeBuilder(this);
  }

  GReservationFieldsData_beneficiaryBuilder get _$this {
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
  void replace(GReservationFieldsData_beneficiary other) {
    _$v = other as _$GReservationFieldsData_beneficiary;
  }

  @override
  void update(
    void Function(GReservationFieldsData_beneficiaryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData_beneficiary build() => _build();

  _$GReservationFieldsData_beneficiary _build() {
    _$GReservationFieldsData_beneficiary _$result;
    try {
      _$result =
          _$v ??
          _$GReservationFieldsData_beneficiary._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GReservationFieldsData_beneficiary',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GReservationFieldsData_beneficiary',
              'id',
            ),
            email: BuiltValueNullFieldError.checkNotNull(
              email,
              r'GReservationFieldsData_beneficiary',
              'email',
            ),
            displayName: displayName,
            phoneNumber: phoneNumber,
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'GReservationFieldsData_beneficiary',
              'role',
            ),
            description: description,
            isMailVerified: BuiltValueNullFieldError.checkNotNull(
              isMailVerified,
              r'GReservationFieldsData_beneficiary',
              'isMailVerified',
            ),
            reputationScore: BuiltValueNullFieldError.checkNotNull(
              reputationScore,
              r'GReservationFieldsData_beneficiary',
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
          r'GReservationFieldsData_beneficiary',
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

class _$GReservationFieldsData_beneficiary_location
    extends GReservationFieldsData_beneficiary_location {
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

  factory _$GReservationFieldsData_beneficiary_location([
    void Function(GReservationFieldsData_beneficiary_locationBuilder)? updates,
  ]) => (GReservationFieldsData_beneficiary_locationBuilder()..update(updates))
      ._build();

  _$GReservationFieldsData_beneficiary_location._({
    required this.G__typename,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.neighborhood,
  }) : super._();
  @override
  GReservationFieldsData_beneficiary_location rebuild(
    void Function(GReservationFieldsData_beneficiary_locationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsData_beneficiary_locationBuilder toBuilder() =>
      GReservationFieldsData_beneficiary_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData_beneficiary_location &&
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
            r'GReservationFieldsData_beneficiary_location',
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

class GReservationFieldsData_beneficiary_locationBuilder
    implements
        Builder<
          GReservationFieldsData_beneficiary_location,
          GReservationFieldsData_beneficiary_locationBuilder
        > {
  _$GReservationFieldsData_beneficiary_location? _$v;

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

  GReservationFieldsData_beneficiary_locationBuilder() {
    GReservationFieldsData_beneficiary_location._initializeBuilder(this);
  }

  GReservationFieldsData_beneficiary_locationBuilder get _$this {
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
  void replace(GReservationFieldsData_beneficiary_location other) {
    _$v = other as _$GReservationFieldsData_beneficiary_location;
  }

  @override
  void update(
    void Function(GReservationFieldsData_beneficiary_locationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData_beneficiary_location build() => _build();

  _$GReservationFieldsData_beneficiary_location _build() {
    final _$result =
        _$v ??
        _$GReservationFieldsData_beneficiary_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GReservationFieldsData_beneficiary_location',
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

class _$GReservationFieldsData_beneficiary_avatar
    extends GReservationFieldsData_beneficiary_avatar {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? url;

  factory _$GReservationFieldsData_beneficiary_avatar([
    void Function(GReservationFieldsData_beneficiary_avatarBuilder)? updates,
  ]) => (GReservationFieldsData_beneficiary_avatarBuilder()..update(updates))
      ._build();

  _$GReservationFieldsData_beneficiary_avatar._({
    required this.G__typename,
    required this.id,
    this.url,
  }) : super._();
  @override
  GReservationFieldsData_beneficiary_avatar rebuild(
    void Function(GReservationFieldsData_beneficiary_avatarBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsData_beneficiary_avatarBuilder toBuilder() =>
      GReservationFieldsData_beneficiary_avatarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsData_beneficiary_avatar &&
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
            r'GReservationFieldsData_beneficiary_avatar',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('url', url))
        .toString();
  }
}

class GReservationFieldsData_beneficiary_avatarBuilder
    implements
        Builder<
          GReservationFieldsData_beneficiary_avatar,
          GReservationFieldsData_beneficiary_avatarBuilder
        > {
  _$GReservationFieldsData_beneficiary_avatar? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GReservationFieldsData_beneficiary_avatarBuilder() {
    GReservationFieldsData_beneficiary_avatar._initializeBuilder(this);
  }

  GReservationFieldsData_beneficiary_avatarBuilder get _$this {
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
  void replace(GReservationFieldsData_beneficiary_avatar other) {
    _$v = other as _$GReservationFieldsData_beneficiary_avatar;
  }

  @override
  void update(
    void Function(GReservationFieldsData_beneficiary_avatarBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsData_beneficiary_avatar build() => _build();

  _$GReservationFieldsData_beneficiary_avatar _build() {
    final _$result =
        _$v ??
        _$GReservationFieldsData_beneficiary_avatar._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GReservationFieldsData_beneficiary_avatar',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GReservationFieldsData_beneficiary_avatar',
            'id',
          ),
          url: url,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
