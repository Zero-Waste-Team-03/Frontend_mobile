// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_donation_by_id.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetDonationByIdData> _$gGetDonationByIdDataSerializer =
    _$GGetDonationByIdDataSerializer();
Serializer<GGetDonationByIdData_donation>
_$gGetDonationByIdDataDonationSerializer =
    _$GGetDonationByIdData_donationSerializer();
Serializer<GGetDonationByIdData_donation_category>
_$gGetDonationByIdDataDonationCategorySerializer =
    _$GGetDonationByIdData_donation_categorySerializer();
Serializer<GGetDonationByIdData_donation_mainAttachment>
_$gGetDonationByIdDataDonationMainAttachmentSerializer =
    _$GGetDonationByIdData_donation_mainAttachmentSerializer();
Serializer<GGetDonationByIdData_donation_location>
_$gGetDonationByIdDataDonationLocationSerializer =
    _$GGetDonationByIdData_donation_locationSerializer();
Serializer<GGetDonationByIdData_donation_user>
_$gGetDonationByIdDataDonationUserSerializer =
    _$GGetDonationByIdData_donation_userSerializer();

class _$GGetDonationByIdDataSerializer
    implements StructuredSerializer<GGetDonationByIdData> {
  @override
  final Iterable<Type> types = const [
    GGetDonationByIdData,
    _$GGetDonationByIdData,
  ];
  @override
  final String wireName = 'GGetDonationByIdData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationByIdData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'donation',
      serializers.serialize(
        object.donation,
        specifiedType: const FullType(GGetDonationByIdData_donation),
      ),
    ];

    return result;
  }

  @override
  GGetDonationByIdData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationByIdDataBuilder();

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
        case 'donation':
          result.donation.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GGetDonationByIdData_donation),
                )!
                as GGetDonationByIdData_donation,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetDonationByIdData_donationSerializer
    implements StructuredSerializer<GGetDonationByIdData_donation> {
  @override
  final Iterable<Type> types = const [
    GGetDonationByIdData_donation,
    _$GGetDonationByIdData_donation,
  ];
  @override
  final String wireName = 'GGetDonationByIdData_donation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationByIdData_donation object, {
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
      'user',
      serializers.serialize(
        object.user,
        specifiedType: const FullType(GGetDonationByIdData_donation_user),
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
              GGetDonationByIdData_donation_category,
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
              GGetDonationByIdData_donation_mainAttachment,
            ),
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
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GGetDonationByIdData_donation_location,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GGetDonationByIdData_donation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationByIdData_donationBuilder();

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
                    GGetDonationByIdData_donation_category,
                  ),
                )!
                as GGetDonationByIdData_donation_category,
          );
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
                    GGetDonationByIdData_donation_mainAttachment,
                  ),
                )!
                as GGetDonationByIdData_donation_mainAttachment,
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
        case 'location':
          result.location.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetDonationByIdData_donation_location,
                  ),
                )!
                as GGetDonationByIdData_donation_location,
          );
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetDonationByIdData_donation_user,
                  ),
                )!
                as GGetDonationByIdData_donation_user,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetDonationByIdData_donation_categorySerializer
    implements StructuredSerializer<GGetDonationByIdData_donation_category> {
  @override
  final Iterable<Type> types = const [
    GGetDonationByIdData_donation_category,
    _$GGetDonationByIdData_donation_category,
  ];
  @override
  final String wireName = 'GGetDonationByIdData_donation_category';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationByIdData_donation_category object, {
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
  GGetDonationByIdData_donation_category deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationByIdData_donation_categoryBuilder();

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

class _$GGetDonationByIdData_donation_mainAttachmentSerializer
    implements
        StructuredSerializer<GGetDonationByIdData_donation_mainAttachment> {
  @override
  final Iterable<Type> types = const [
    GGetDonationByIdData_donation_mainAttachment,
    _$GGetDonationByIdData_donation_mainAttachment,
  ];
  @override
  final String wireName = 'GGetDonationByIdData_donation_mainAttachment';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationByIdData_donation_mainAttachment object, {
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
  GGetDonationByIdData_donation_mainAttachment deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationByIdData_donation_mainAttachmentBuilder();

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

class _$GGetDonationByIdData_donation_locationSerializer
    implements StructuredSerializer<GGetDonationByIdData_donation_location> {
  @override
  final Iterable<Type> types = const [
    GGetDonationByIdData_donation_location,
    _$GGetDonationByIdData_donation_location,
  ];
  @override
  final String wireName = 'GGetDonationByIdData_donation_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationByIdData_donation_location object, {
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
  GGetDonationByIdData_donation_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationByIdData_donation_locationBuilder();

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

class _$GGetDonationByIdData_donation_userSerializer
    implements StructuredSerializer<GGetDonationByIdData_donation_user> {
  @override
  final Iterable<Type> types = const [
    GGetDonationByIdData_donation_user,
    _$GGetDonationByIdData_donation_user,
  ];
  @override
  final String wireName = 'GGetDonationByIdData_donation_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationByIdData_donation_user object, {
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
  GGetDonationByIdData_donation_user deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationByIdData_donation_userBuilder();

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

class _$GGetDonationByIdData extends GGetDonationByIdData {
  @override
  final String G__typename;
  @override
  final GGetDonationByIdData_donation donation;

  factory _$GGetDonationByIdData([
    void Function(GGetDonationByIdDataBuilder)? updates,
  ]) => (GGetDonationByIdDataBuilder()..update(updates))._build();

  _$GGetDonationByIdData._({required this.G__typename, required this.donation})
    : super._();
  @override
  GGetDonationByIdData rebuild(
    void Function(GGetDonationByIdDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationByIdDataBuilder toBuilder() =>
      GGetDonationByIdDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationByIdData &&
        G__typename == other.G__typename &&
        donation == other.donation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, donation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetDonationByIdData')
          ..add('G__typename', G__typename)
          ..add('donation', donation))
        .toString();
  }
}

class GGetDonationByIdDataBuilder
    implements Builder<GGetDonationByIdData, GGetDonationByIdDataBuilder> {
  _$GGetDonationByIdData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetDonationByIdData_donationBuilder? _donation;
  GGetDonationByIdData_donationBuilder get donation =>
      _$this._donation ??= GGetDonationByIdData_donationBuilder();
  set donation(GGetDonationByIdData_donationBuilder? donation) =>
      _$this._donation = donation;

  GGetDonationByIdDataBuilder() {
    GGetDonationByIdData._initializeBuilder(this);
  }

  GGetDonationByIdDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _donation = $v.donation.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetDonationByIdData other) {
    _$v = other as _$GGetDonationByIdData;
  }

  @override
  void update(void Function(GGetDonationByIdDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationByIdData build() => _build();

  _$GGetDonationByIdData _build() {
    _$GGetDonationByIdData _$result;
    try {
      _$result =
          _$v ??
          _$GGetDonationByIdData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetDonationByIdData',
              'G__typename',
            ),
            donation: donation.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'donation';
        donation.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetDonationByIdData',
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

class _$GGetDonationByIdData_donation extends GGetDonationByIdData_donation {
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
  final GGetDonationByIdData_donation_category? category;
  @override
  final _i2.GDonationStatusValues status;
  @override
  final _i2.GDonationUrgencyValues urgency;
  @override
  final String? mainAttachmentId;
  @override
  final GGetDonationByIdData_donation_mainAttachment? mainAttachment;
  @override
  final String? locationId;
  @override
  final GGetDonationByIdData_donation_location? location;
  @override
  final GGetDonationByIdData_donation_user user;

  factory _$GGetDonationByIdData_donation([
    void Function(GGetDonationByIdData_donationBuilder)? updates,
  ]) => (GGetDonationByIdData_donationBuilder()..update(updates))._build();

  _$GGetDonationByIdData_donation._({
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
    this.locationId,
    this.location,
    required this.user,
  }) : super._();
  @override
  GGetDonationByIdData_donation rebuild(
    void Function(GGetDonationByIdData_donationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationByIdData_donationBuilder toBuilder() =>
      GGetDonationByIdData_donationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationByIdData_donation &&
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
        locationId == other.locationId &&
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
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetDonationByIdData_donation')
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
          ..add('locationId', locationId)
          ..add('location', location)
          ..add('user', user))
        .toString();
  }
}

class GGetDonationByIdData_donationBuilder
    implements
        Builder<
          GGetDonationByIdData_donation,
          GGetDonationByIdData_donationBuilder
        > {
  _$GGetDonationByIdData_donation? _$v;

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

  GGetDonationByIdData_donation_categoryBuilder? _category;
  GGetDonationByIdData_donation_categoryBuilder get category =>
      _$this._category ??= GGetDonationByIdData_donation_categoryBuilder();
  set category(GGetDonationByIdData_donation_categoryBuilder? category) =>
      _$this._category = category;

  _i2.GDonationStatusValues? _status;
  _i2.GDonationStatusValues? get status => _$this._status;
  set status(_i2.GDonationStatusValues? status) => _$this._status = status;

  _i2.GDonationUrgencyValues? _urgency;
  _i2.GDonationUrgencyValues? get urgency => _$this._urgency;
  set urgency(_i2.GDonationUrgencyValues? urgency) => _$this._urgency = urgency;

  String? _mainAttachmentId;
  String? get mainAttachmentId => _$this._mainAttachmentId;
  set mainAttachmentId(String? mainAttachmentId) =>
      _$this._mainAttachmentId = mainAttachmentId;

  GGetDonationByIdData_donation_mainAttachmentBuilder? _mainAttachment;
  GGetDonationByIdData_donation_mainAttachmentBuilder get mainAttachment =>
      _$this._mainAttachment ??=
          GGetDonationByIdData_donation_mainAttachmentBuilder();
  set mainAttachment(
    GGetDonationByIdData_donation_mainAttachmentBuilder? mainAttachment,
  ) => _$this._mainAttachment = mainAttachment;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  GGetDonationByIdData_donation_locationBuilder? _location;
  GGetDonationByIdData_donation_locationBuilder get location =>
      _$this._location ??= GGetDonationByIdData_donation_locationBuilder();
  set location(GGetDonationByIdData_donation_locationBuilder? location) =>
      _$this._location = location;

  GGetDonationByIdData_donation_userBuilder? _user;
  GGetDonationByIdData_donation_userBuilder get user =>
      _$this._user ??= GGetDonationByIdData_donation_userBuilder();
  set user(GGetDonationByIdData_donation_userBuilder? user) =>
      _$this._user = user;

  GGetDonationByIdData_donationBuilder() {
    GGetDonationByIdData_donation._initializeBuilder(this);
  }

  GGetDonationByIdData_donationBuilder get _$this {
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
      _locationId = $v.locationId;
      _location = $v.location?.toBuilder();
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetDonationByIdData_donation other) {
    _$v = other as _$GGetDonationByIdData_donation;
  }

  @override
  void update(void Function(GGetDonationByIdData_donationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationByIdData_donation build() => _build();

  _$GGetDonationByIdData_donation _build() {
    _$GGetDonationByIdData_donation _$result;
    try {
      _$result =
          _$v ??
          _$GGetDonationByIdData_donation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetDonationByIdData_donation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GGetDonationByIdData_donation',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GGetDonationByIdData_donation',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'GGetDonationByIdData_donation',
              'description',
            ),
            quantity: BuiltValueNullFieldError.checkNotNull(
              quantity,
              r'GGetDonationByIdData_donation',
              'quantity',
            ),
            categoryId: BuiltValueNullFieldError.checkNotNull(
              categoryId,
              r'GGetDonationByIdData_donation',
              'categoryId',
            ),
            category: _category?.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GGetDonationByIdData_donation',
              'status',
            ),
            urgency: BuiltValueNullFieldError.checkNotNull(
              urgency,
              r'GGetDonationByIdData_donation',
              'urgency',
            ),
            mainAttachmentId: mainAttachmentId,
            mainAttachment: _mainAttachment?.build(),
            locationId: locationId,
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
          r'GGetDonationByIdData_donation',
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

class _$GGetDonationByIdData_donation_category
    extends GGetDonationByIdData_donation_category {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;

  factory _$GGetDonationByIdData_donation_category([
    void Function(GGetDonationByIdData_donation_categoryBuilder)? updates,
  ]) => (GGetDonationByIdData_donation_categoryBuilder()..update(updates))
      ._build();

  _$GGetDonationByIdData_donation_category._({
    required this.G__typename,
    required this.id,
    required this.name,
  }) : super._();
  @override
  GGetDonationByIdData_donation_category rebuild(
    void Function(GGetDonationByIdData_donation_categoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationByIdData_donation_categoryBuilder toBuilder() =>
      GGetDonationByIdData_donation_categoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationByIdData_donation_category &&
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
            r'GGetDonationByIdData_donation_category',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GGetDonationByIdData_donation_categoryBuilder
    implements
        Builder<
          GGetDonationByIdData_donation_category,
          GGetDonationByIdData_donation_categoryBuilder
        > {
  _$GGetDonationByIdData_donation_category? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GGetDonationByIdData_donation_categoryBuilder() {
    GGetDonationByIdData_donation_category._initializeBuilder(this);
  }

  GGetDonationByIdData_donation_categoryBuilder get _$this {
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
  void replace(GGetDonationByIdData_donation_category other) {
    _$v = other as _$GGetDonationByIdData_donation_category;
  }

  @override
  void update(
    void Function(GGetDonationByIdData_donation_categoryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationByIdData_donation_category build() => _build();

  _$GGetDonationByIdData_donation_category _build() {
    final _$result =
        _$v ??
        _$GGetDonationByIdData_donation_category._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetDonationByIdData_donation_category',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GGetDonationByIdData_donation_category',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GGetDonationByIdData_donation_category',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetDonationByIdData_donation_mainAttachment
    extends GGetDonationByIdData_donation_mainAttachment {
  @override
  final String G__typename;
  @override
  final String? url;

  factory _$GGetDonationByIdData_donation_mainAttachment([
    void Function(GGetDonationByIdData_donation_mainAttachmentBuilder)? updates,
  ]) => (GGetDonationByIdData_donation_mainAttachmentBuilder()..update(updates))
      ._build();

  _$GGetDonationByIdData_donation_mainAttachment._({
    required this.G__typename,
    this.url,
  }) : super._();
  @override
  GGetDonationByIdData_donation_mainAttachment rebuild(
    void Function(GGetDonationByIdData_donation_mainAttachmentBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationByIdData_donation_mainAttachmentBuilder toBuilder() =>
      GGetDonationByIdData_donation_mainAttachmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationByIdData_donation_mainAttachment &&
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
            r'GGetDonationByIdData_donation_mainAttachment',
          )
          ..add('G__typename', G__typename)
          ..add('url', url))
        .toString();
  }
}

class GGetDonationByIdData_donation_mainAttachmentBuilder
    implements
        Builder<
          GGetDonationByIdData_donation_mainAttachment,
          GGetDonationByIdData_donation_mainAttachmentBuilder
        > {
  _$GGetDonationByIdData_donation_mainAttachment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GGetDonationByIdData_donation_mainAttachmentBuilder() {
    GGetDonationByIdData_donation_mainAttachment._initializeBuilder(this);
  }

  GGetDonationByIdData_donation_mainAttachmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetDonationByIdData_donation_mainAttachment other) {
    _$v = other as _$GGetDonationByIdData_donation_mainAttachment;
  }

  @override
  void update(
    void Function(GGetDonationByIdData_donation_mainAttachmentBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationByIdData_donation_mainAttachment build() => _build();

  _$GGetDonationByIdData_donation_mainAttachment _build() {
    final _$result =
        _$v ??
        _$GGetDonationByIdData_donation_mainAttachment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetDonationByIdData_donation_mainAttachment',
            'G__typename',
          ),
          url: url,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetDonationByIdData_donation_location
    extends GGetDonationByIdData_donation_location {
  @override
  final String G__typename;
  @override
  final double? latitude;
  @override
  final double? longitude;

  factory _$GGetDonationByIdData_donation_location([
    void Function(GGetDonationByIdData_donation_locationBuilder)? updates,
  ]) => (GGetDonationByIdData_donation_locationBuilder()..update(updates))
      ._build();

  _$GGetDonationByIdData_donation_location._({
    required this.G__typename,
    this.latitude,
    this.longitude,
  }) : super._();
  @override
  GGetDonationByIdData_donation_location rebuild(
    void Function(GGetDonationByIdData_donation_locationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationByIdData_donation_locationBuilder toBuilder() =>
      GGetDonationByIdData_donation_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationByIdData_donation_location &&
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
            r'GGetDonationByIdData_donation_location',
          )
          ..add('G__typename', G__typename)
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class GGetDonationByIdData_donation_locationBuilder
    implements
        Builder<
          GGetDonationByIdData_donation_location,
          GGetDonationByIdData_donation_locationBuilder
        > {
  _$GGetDonationByIdData_donation_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  GGetDonationByIdData_donation_locationBuilder() {
    GGetDonationByIdData_donation_location._initializeBuilder(this);
  }

  GGetDonationByIdData_donation_locationBuilder get _$this {
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
  void replace(GGetDonationByIdData_donation_location other) {
    _$v = other as _$GGetDonationByIdData_donation_location;
  }

  @override
  void update(
    void Function(GGetDonationByIdData_donation_locationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationByIdData_donation_location build() => _build();

  _$GGetDonationByIdData_donation_location _build() {
    final _$result =
        _$v ??
        _$GGetDonationByIdData_donation_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetDonationByIdData_donation_location',
            'G__typename',
          ),
          latitude: latitude,
          longitude: longitude,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetDonationByIdData_donation_user
    extends GGetDonationByIdData_donation_user {
  @override
  final String G__typename;
  @override
  final String? displayName;
  @override
  final String email;

  factory _$GGetDonationByIdData_donation_user([
    void Function(GGetDonationByIdData_donation_userBuilder)? updates,
  ]) => (GGetDonationByIdData_donation_userBuilder()..update(updates))._build();

  _$GGetDonationByIdData_donation_user._({
    required this.G__typename,
    this.displayName,
    required this.email,
  }) : super._();
  @override
  GGetDonationByIdData_donation_user rebuild(
    void Function(GGetDonationByIdData_donation_userBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationByIdData_donation_userBuilder toBuilder() =>
      GGetDonationByIdData_donation_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationByIdData_donation_user &&
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
    return (newBuiltValueToStringHelper(r'GGetDonationByIdData_donation_user')
          ..add('G__typename', G__typename)
          ..add('displayName', displayName)
          ..add('email', email))
        .toString();
  }
}

class GGetDonationByIdData_donation_userBuilder
    implements
        Builder<
          GGetDonationByIdData_donation_user,
          GGetDonationByIdData_donation_userBuilder
        > {
  _$GGetDonationByIdData_donation_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GGetDonationByIdData_donation_userBuilder() {
    GGetDonationByIdData_donation_user._initializeBuilder(this);
  }

  GGetDonationByIdData_donation_userBuilder get _$this {
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
  void replace(GGetDonationByIdData_donation_user other) {
    _$v = other as _$GGetDonationByIdData_donation_user;
  }

  @override
  void update(
    void Function(GGetDonationByIdData_donation_userBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationByIdData_donation_user build() => _build();

  _$GGetDonationByIdData_donation_user _build() {
    final _$result =
        _$v ??
        _$GGetDonationByIdData_donation_user._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetDonationByIdData_donation_user',
            'G__typename',
          ),
          displayName: displayName,
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'GGetDonationByIdData_donation_user',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
