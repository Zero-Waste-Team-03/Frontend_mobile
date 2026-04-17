// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservations.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyReservationsData> _$gMyReservationsDataSerializer =
    _$GMyReservationsDataSerializer();
Serializer<GMyReservationsData_myReservations>
_$gMyReservationsDataMyReservationsSerializer =
    _$GMyReservationsData_myReservationsSerializer();
Serializer<GMyReservationsData_myReservations_items>
_$gMyReservationsDataMyReservationsItemsSerializer =
    _$GMyReservationsData_myReservations_itemsSerializer();
Serializer<GMyReservationsData_myReservations_items_donation>
_$gMyReservationsDataMyReservationsItemsDonationSerializer =
    _$GMyReservationsData_myReservations_items_donationSerializer();
Serializer<GMyReservationsData_myReservations_items_donation_mainAttachment>
_$gMyReservationsDataMyReservationsItemsDonationMainAttachmentSerializer =
    _$GMyReservationsData_myReservations_items_donation_mainAttachmentSerializer();

class _$GMyReservationsDataSerializer
    implements StructuredSerializer<GMyReservationsData> {
  @override
  final Iterable<Type> types = const [
    GMyReservationsData,
    _$GMyReservationsData,
  ];
  @override
  final String wireName = 'GMyReservationsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'myReservations',
      serializers.serialize(
        object.myReservations,
        specifiedType: const FullType(GMyReservationsData_myReservations),
      ),
    ];

    return result;
  }

  @override
  GMyReservationsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationsDataBuilder();

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
        case 'myReservations':
          result.myReservations.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMyReservationsData_myReservations,
                  ),
                )!
                as GMyReservationsData_myReservations,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationsData_myReservationsSerializer
    implements StructuredSerializer<GMyReservationsData_myReservations> {
  @override
  final Iterable<Type> types = const [
    GMyReservationsData_myReservations,
    _$GMyReservationsData_myReservations,
  ];
  @override
  final String wireName = 'GMyReservationsData_myReservations';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationsData_myReservations object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'hasNextPage',
      serializers.serialize(
        object.hasNextPage,
        specifiedType: const FullType(bool),
      ),
      'hasPreviousPage',
      serializers.serialize(
        object.hasPreviousPage,
        specifiedType: const FullType(bool),
      ),
      'totalCount',
      serializers.serialize(
        object.totalCount,
        specifiedType: const FullType(int),
      ),
      'page',
      serializers.serialize(object.page, specifiedType: const FullType(int)),
      'limit',
      serializers.serialize(object.limit, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.items;
    if (value != null) {
      result
        ..add('items')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(GMyReservationsData_myReservations_items),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  GMyReservationsData_myReservations deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationsData_myReservationsBuilder();

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
        case 'hasNextPage':
          result.hasNextPage =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'hasPreviousPage':
          result.hasPreviousPage =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'totalCount':
          result.totalCount =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'page':
          result.page =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'limit':
          result.limit =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GMyReservationsData_myReservations_items),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationsData_myReservations_itemsSerializer
    implements StructuredSerializer<GMyReservationsData_myReservations_items> {
  @override
  final Iterable<Type> types = const [
    GMyReservationsData_myReservations_items,
    _$GMyReservationsData_myReservations_items,
  ];
  @override
  final String wireName = 'GMyReservationsData_myReservations_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationsData_myReservations_items object, {
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
              GMyReservationsData_myReservations_items_donation,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GMyReservationsData_myReservations_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationsData_myReservations_itemsBuilder();

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
                    GMyReservationsData_myReservations_items_donation,
                  ),
                )!
                as GMyReservationsData_myReservations_items_donation,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationsData_myReservations_items_donationSerializer
    implements
        StructuredSerializer<
          GMyReservationsData_myReservations_items_donation
        > {
  @override
  final Iterable<Type> types = const [
    GMyReservationsData_myReservations_items_donation,
    _$GMyReservationsData_myReservations_items_donation,
  ];
  @override
  final String wireName = 'GMyReservationsData_myReservations_items_donation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationsData_myReservations_items_donation object, {
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
              GMyReservationsData_myReservations_items_donation_mainAttachment,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GMyReservationsData_myReservations_items_donation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationsData_myReservations_items_donationBuilder();

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
                    GMyReservationsData_myReservations_items_donation_mainAttachment,
                  ),
                )!
                as GMyReservationsData_myReservations_items_donation_mainAttachment,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationsData_myReservations_items_donation_mainAttachmentSerializer
    implements
        StructuredSerializer<
          GMyReservationsData_myReservations_items_donation_mainAttachment
        > {
  @override
  final Iterable<Type> types = const [
    GMyReservationsData_myReservations_items_donation_mainAttachment,
    _$GMyReservationsData_myReservations_items_donation_mainAttachment,
  ];
  @override
  final String wireName =
      'GMyReservationsData_myReservations_items_donation_mainAttachment';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationsData_myReservations_items_donation_mainAttachment object, {
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
  GMyReservationsData_myReservations_items_donation_mainAttachment deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder();

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

class _$GMyReservationsData extends GMyReservationsData {
  @override
  final String G__typename;
  @override
  final GMyReservationsData_myReservations myReservations;

  factory _$GMyReservationsData([
    void Function(GMyReservationsDataBuilder)? updates,
  ]) => (GMyReservationsDataBuilder()..update(updates))._build();

  _$GMyReservationsData._({
    required this.G__typename,
    required this.myReservations,
  }) : super._();
  @override
  GMyReservationsData rebuild(
    void Function(GMyReservationsDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationsDataBuilder toBuilder() =>
      GMyReservationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationsData &&
        G__typename == other.G__typename &&
        myReservations == other.myReservations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, myReservations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyReservationsData')
          ..add('G__typename', G__typename)
          ..add('myReservations', myReservations))
        .toString();
  }
}

class GMyReservationsDataBuilder
    implements Builder<GMyReservationsData, GMyReservationsDataBuilder> {
  _$GMyReservationsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMyReservationsData_myReservationsBuilder? _myReservations;
  GMyReservationsData_myReservationsBuilder get myReservations =>
      _$this._myReservations ??= GMyReservationsData_myReservationsBuilder();
  set myReservations(
    GMyReservationsData_myReservationsBuilder? myReservations,
  ) => _$this._myReservations = myReservations;

  GMyReservationsDataBuilder() {
    GMyReservationsData._initializeBuilder(this);
  }

  GMyReservationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _myReservations = $v.myReservations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationsData other) {
    _$v = other as _$GMyReservationsData;
  }

  @override
  void update(void Function(GMyReservationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationsData build() => _build();

  _$GMyReservationsData _build() {
    _$GMyReservationsData _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationsData',
              'G__typename',
            ),
            myReservations: myReservations.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'myReservations';
        myReservations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationsData',
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

class _$GMyReservationsData_myReservations
    extends GMyReservationsData_myReservations {
  @override
  final String G__typename;
  @override
  final bool hasNextPage;
  @override
  final bool hasPreviousPage;
  @override
  final int totalCount;
  @override
  final int page;
  @override
  final int limit;
  @override
  final BuiltList<GMyReservationsData_myReservations_items>? items;

  factory _$GMyReservationsData_myReservations([
    void Function(GMyReservationsData_myReservationsBuilder)? updates,
  ]) => (GMyReservationsData_myReservationsBuilder()..update(updates))._build();

  _$GMyReservationsData_myReservations._({
    required this.G__typename,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.totalCount,
    required this.page,
    required this.limit,
    this.items,
  }) : super._();
  @override
  GMyReservationsData_myReservations rebuild(
    void Function(GMyReservationsData_myReservationsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationsData_myReservationsBuilder toBuilder() =>
      GMyReservationsData_myReservationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationsData_myReservations &&
        G__typename == other.G__typename &&
        hasNextPage == other.hasNextPage &&
        hasPreviousPage == other.hasPreviousPage &&
        totalCount == other.totalCount &&
        page == other.page &&
        limit == other.limit &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, hasNextPage.hashCode);
    _$hash = $jc(_$hash, hasPreviousPage.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyReservationsData_myReservations')
          ..add('G__typename', G__typename)
          ..add('hasNextPage', hasNextPage)
          ..add('hasPreviousPage', hasPreviousPage)
          ..add('totalCount', totalCount)
          ..add('page', page)
          ..add('limit', limit)
          ..add('items', items))
        .toString();
  }
}

class GMyReservationsData_myReservationsBuilder
    implements
        Builder<
          GMyReservationsData_myReservations,
          GMyReservationsData_myReservationsBuilder
        > {
  _$GMyReservationsData_myReservations? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  bool? _hasNextPage;
  bool? get hasNextPage => _$this._hasNextPage;
  set hasNextPage(bool? hasNextPage) => _$this._hasNextPage = hasNextPage;

  bool? _hasPreviousPage;
  bool? get hasPreviousPage => _$this._hasPreviousPage;
  set hasPreviousPage(bool? hasPreviousPage) =>
      _$this._hasPreviousPage = hasPreviousPage;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  ListBuilder<GMyReservationsData_myReservations_items>? _items;
  ListBuilder<GMyReservationsData_myReservations_items> get items =>
      _$this._items ??= ListBuilder<GMyReservationsData_myReservations_items>();
  set items(ListBuilder<GMyReservationsData_myReservations_items>? items) =>
      _$this._items = items;

  GMyReservationsData_myReservationsBuilder() {
    GMyReservationsData_myReservations._initializeBuilder(this);
  }

  GMyReservationsData_myReservationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _hasNextPage = $v.hasNextPage;
      _hasPreviousPage = $v.hasPreviousPage;
      _totalCount = $v.totalCount;
      _page = $v.page;
      _limit = $v.limit;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationsData_myReservations other) {
    _$v = other as _$GMyReservationsData_myReservations;
  }

  @override
  void update(
    void Function(GMyReservationsData_myReservationsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationsData_myReservations build() => _build();

  _$GMyReservationsData_myReservations _build() {
    _$GMyReservationsData_myReservations _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationsData_myReservations._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationsData_myReservations',
              'G__typename',
            ),
            hasNextPage: BuiltValueNullFieldError.checkNotNull(
              hasNextPage,
              r'GMyReservationsData_myReservations',
              'hasNextPage',
            ),
            hasPreviousPage: BuiltValueNullFieldError.checkNotNull(
              hasPreviousPage,
              r'GMyReservationsData_myReservations',
              'hasPreviousPage',
            ),
            totalCount: BuiltValueNullFieldError.checkNotNull(
              totalCount,
              r'GMyReservationsData_myReservations',
              'totalCount',
            ),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'GMyReservationsData_myReservations',
              'page',
            ),
            limit: BuiltValueNullFieldError.checkNotNull(
              limit,
              r'GMyReservationsData_myReservations',
              'limit',
            ),
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationsData_myReservations',
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

class _$GMyReservationsData_myReservations_items
    extends GMyReservationsData_myReservations_items {
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
  final GMyReservationsData_myReservations_items_donation? donation;

  factory _$GMyReservationsData_myReservations_items([
    void Function(GMyReservationsData_myReservations_itemsBuilder)? updates,
  ]) => (GMyReservationsData_myReservations_itemsBuilder()..update(updates))
      ._build();

  _$GMyReservationsData_myReservations_items._({
    required this.G__typename,
    required this.id,
    required this.status,
    required this.createdAt,
    this.confirmedAt,
    required this.updatedAt,
    this.donation,
  }) : super._();
  @override
  GMyReservationsData_myReservations_items rebuild(
    void Function(GMyReservationsData_myReservations_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationsData_myReservations_itemsBuilder toBuilder() =>
      GMyReservationsData_myReservations_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationsData_myReservations_items &&
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
    return (newBuiltValueToStringHelper(
            r'GMyReservationsData_myReservations_items',
          )
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

class GMyReservationsData_myReservations_itemsBuilder
    implements
        Builder<
          GMyReservationsData_myReservations_items,
          GMyReservationsData_myReservations_itemsBuilder
        > {
  _$GMyReservationsData_myReservations_items? _$v;

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

  GMyReservationsData_myReservations_items_donationBuilder? _donation;
  GMyReservationsData_myReservations_items_donationBuilder get donation =>
      _$this._donation ??=
          GMyReservationsData_myReservations_items_donationBuilder();
  set donation(
    GMyReservationsData_myReservations_items_donationBuilder? donation,
  ) => _$this._donation = donation;

  GMyReservationsData_myReservations_itemsBuilder() {
    GMyReservationsData_myReservations_items._initializeBuilder(this);
  }

  GMyReservationsData_myReservations_itemsBuilder get _$this {
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
  void replace(GMyReservationsData_myReservations_items other) {
    _$v = other as _$GMyReservationsData_myReservations_items;
  }

  @override
  void update(
    void Function(GMyReservationsData_myReservations_itemsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationsData_myReservations_items build() => _build();

  _$GMyReservationsData_myReservations_items _build() {
    _$GMyReservationsData_myReservations_items _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationsData_myReservations_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationsData_myReservations_items',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyReservationsData_myReservations_items',
              'id',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GMyReservationsData_myReservations_items',
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
          r'GMyReservationsData_myReservations_items',
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

class _$GMyReservationsData_myReservations_items_donation
    extends GMyReservationsData_myReservations_items_donation {
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
  final GMyReservationsData_myReservations_items_donation_mainAttachment?
  mainAttachment;

  factory _$GMyReservationsData_myReservations_items_donation([
    void Function(GMyReservationsData_myReservations_items_donationBuilder)?
    updates,
  ]) =>
      (GMyReservationsData_myReservations_items_donationBuilder()
            ..update(updates))
          ._build();

  _$GMyReservationsData_myReservations_items_donation._({
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
  }) : super._();
  @override
  GMyReservationsData_myReservations_items_donation rebuild(
    void Function(GMyReservationsData_myReservations_items_donationBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationsData_myReservations_items_donationBuilder toBuilder() =>
      GMyReservationsData_myReservations_items_donationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationsData_myReservations_items_donation &&
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
        mainAttachment == other.mainAttachment;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMyReservationsData_myReservations_items_donation',
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
          ..add('mainAttachment', mainAttachment))
        .toString();
  }
}

class GMyReservationsData_myReservations_items_donationBuilder
    implements
        Builder<
          GMyReservationsData_myReservations_items_donation,
          GMyReservationsData_myReservations_items_donationBuilder
        > {
  _$GMyReservationsData_myReservations_items_donation? _$v;

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

  GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder?
  _mainAttachment;
  GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder
  get mainAttachment => _$this._mainAttachment ??=
      GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder();
  set mainAttachment(
    GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder?
    mainAttachment,
  ) => _$this._mainAttachment = mainAttachment;

  GMyReservationsData_myReservations_items_donationBuilder() {
    GMyReservationsData_myReservations_items_donation._initializeBuilder(this);
  }

  GMyReservationsData_myReservations_items_donationBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationsData_myReservations_items_donation other) {
    _$v = other as _$GMyReservationsData_myReservations_items_donation;
  }

  @override
  void update(
    void Function(GMyReservationsData_myReservations_items_donationBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationsData_myReservations_items_donation build() => _build();

  _$GMyReservationsData_myReservations_items_donation _build() {
    _$GMyReservationsData_myReservations_items_donation _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationsData_myReservations_items_donation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationsData_myReservations_items_donation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyReservationsData_myReservations_items_donation',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GMyReservationsData_myReservations_items_donation',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'GMyReservationsData_myReservations_items_donation',
              'description',
            ),
            quantity: BuiltValueNullFieldError.checkNotNull(
              quantity,
              r'GMyReservationsData_myReservations_items_donation',
              'quantity',
            ),
            categoryId: BuiltValueNullFieldError.checkNotNull(
              categoryId,
              r'GMyReservationsData_myReservations_items_donation',
              'categoryId',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GMyReservationsData_myReservations_items_donation',
              'status',
            ),
            urgency: BuiltValueNullFieldError.checkNotNull(
              urgency,
              r'GMyReservationsData_myReservations_items_donation',
              'urgency',
            ),
            expiryDate: expiryDate.build(),
            publishedAt: _publishedAt?.build(),
            locationId: locationId,
            mainAttachmentId: mainAttachmentId,
            attachmentIds: attachmentIds.build(),
            userId: BuiltValueNullFieldError.checkNotNull(
              userId,
              r'GMyReservationsData_myReservations_items_donation',
              'userId',
            ),
            safetyChecklistCompleted: BuiltValueNullFieldError.checkNotNull(
              safetyChecklistCompleted,
              r'GMyReservationsData_myReservations_items_donation',
              'safetyChecklistCompleted',
            ),
            listingExpiresAt: _listingExpiresAt?.build(),
            updatedAt: updatedAt.build(),
            mainAttachment: _mainAttachment?.build(),
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
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationsData_myReservations_items_donation',
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

class _$GMyReservationsData_myReservations_items_donation_mainAttachment
    extends GMyReservationsData_myReservations_items_donation_mainAttachment {
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

  factory _$GMyReservationsData_myReservations_items_donation_mainAttachment([
    void Function(
      GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder,
    )?
    updates,
  ]) =>
      (GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder()
            ..update(updates))
          ._build();

  _$GMyReservationsData_myReservations_items_donation_mainAttachment._({
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
  GMyReservationsData_myReservations_items_donation_mainAttachment rebuild(
    void Function(
      GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder
  toBuilder() =>
      GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GMyReservationsData_myReservations_items_donation_mainAttachment &&
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
            r'GMyReservationsData_myReservations_items_donation_mainAttachment',
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

class GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder
    implements
        Builder<
          GMyReservationsData_myReservations_items_donation_mainAttachment,
          GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder
        > {
  _$GMyReservationsData_myReservations_items_donation_mainAttachment? _$v;

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

  GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder() {
    GMyReservationsData_myReservations_items_donation_mainAttachment._initializeBuilder(
      this,
    );
  }

  GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder
  get _$this {
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
  void replace(
    GMyReservationsData_myReservations_items_donation_mainAttachment other,
  ) {
    _$v =
        other
            as _$GMyReservationsData_myReservations_items_donation_mainAttachment;
  }

  @override
  void update(
    void Function(
      GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationsData_myReservations_items_donation_mainAttachment build() =>
      _build();

  _$GMyReservationsData_myReservations_items_donation_mainAttachment _build() {
    _$GMyReservationsData_myReservations_items_donation_mainAttachment _$result;
    try {
      _$result =
          _$v ??
          _$GMyReservationsData_myReservations_items_donation_mainAttachment._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyReservationsData_myReservations_items_donation_mainAttachment',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyReservationsData_myReservations_items_donation_mainAttachment',
              'id',
            ),
            url: url,
            fileName: BuiltValueNullFieldError.checkNotNull(
              fileName,
              r'GMyReservationsData_myReservations_items_donation_mainAttachment',
              'fileName',
            ),
            fileType: BuiltValueNullFieldError.checkNotNull(
              fileType,
              r'GMyReservationsData_myReservations_items_donation_mainAttachment',
              'fileType',
            ),
            fileSize: BuiltValueNullFieldError.checkNotNull(
              fileSize,
              r'GMyReservationsData_myReservations_items_donation_mainAttachment',
              'fileSize',
            ),
            createdAt: createdAt.build(),
            updatedAt: _updatedAt?.build(),
            uploadStatus: uploadStatus,
            jobId: jobId,
            uploadedById: BuiltValueNullFieldError.checkNotNull(
              uploadedById,
              r'GMyReservationsData_myReservations_items_donation_mainAttachment',
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
          r'GMyReservationsData_myReservations_items_donation_mainAttachment',
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
