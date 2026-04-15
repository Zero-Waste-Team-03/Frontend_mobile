// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_donation.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GCreateDonationData> _$gCreateDonationDataSerializer =
    _$GCreateDonationDataSerializer();
Serializer<GCreateDonationData_createDonation>
_$gCreateDonationDataCreateDonationSerializer =
    _$GCreateDonationData_createDonationSerializer();
Serializer<GCreateDonationData_createDonation_category>
_$gCreateDonationDataCreateDonationCategorySerializer =
    _$GCreateDonationData_createDonation_categorySerializer();
Serializer<GCreateDonationData_createDonation_mainAttachment>
_$gCreateDonationDataCreateDonationMainAttachmentSerializer =
    _$GCreateDonationData_createDonation_mainAttachmentSerializer();
Serializer<GCreateDonationData_createDonation_location>
_$gCreateDonationDataCreateDonationLocationSerializer =
    _$GCreateDonationData_createDonation_locationSerializer();
Serializer<GCreateDonationData_createDonation_user>
_$gCreateDonationDataCreateDonationUserSerializer =
    _$GCreateDonationData_createDonation_userSerializer();

class _$GCreateDonationDataSerializer
    implements StructuredSerializer<GCreateDonationData> {
  @override
  final Iterable<Type> types = const [
    GCreateDonationData,
    _$GCreateDonationData,
  ];
  @override
  final String wireName = 'GCreateDonationData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateDonationData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'createDonation',
      serializers.serialize(
        object.createDonation,
        specifiedType: const FullType(GCreateDonationData_createDonation),
      ),
    ];

    return result;
  }

  @override
  GCreateDonationData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateDonationDataBuilder();

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
        case 'createDonation':
          result.createDonation.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GCreateDonationData_createDonation,
                  ),
                )!
                as GCreateDonationData_createDonation,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateDonationData_createDonationSerializer
    implements StructuredSerializer<GCreateDonationData_createDonation> {
  @override
  final Iterable<Type> types = const [
    GCreateDonationData_createDonation,
    _$GCreateDonationData_createDonation,
  ];
  @override
  final String wireName = 'GCreateDonationData_createDonation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateDonationData_createDonation object, {
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
        specifiedType: const FullType(GCreateDonationData_createDonation_user),
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
              GCreateDonationData_createDonation_category,
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
              GCreateDonationData_createDonation_mainAttachment,
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
              GCreateDonationData_createDonation_location,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GCreateDonationData_createDonation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateDonationData_createDonationBuilder();

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
                    GCreateDonationData_createDonation_category,
                  ),
                )!
                as GCreateDonationData_createDonation_category,
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
                    GCreateDonationData_createDonation_mainAttachment,
                  ),
                )!
                as GCreateDonationData_createDonation_mainAttachment,
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
                    GCreateDonationData_createDonation_location,
                  ),
                )!
                as GCreateDonationData_createDonation_location,
          );
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GCreateDonationData_createDonation_user,
                  ),
                )!
                as GCreateDonationData_createDonation_user,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateDonationData_createDonation_categorySerializer
    implements
        StructuredSerializer<GCreateDonationData_createDonation_category> {
  @override
  final Iterable<Type> types = const [
    GCreateDonationData_createDonation_category,
    _$GCreateDonationData_createDonation_category,
  ];
  @override
  final String wireName = 'GCreateDonationData_createDonation_category';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateDonationData_createDonation_category object, {
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
  GCreateDonationData_createDonation_category deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateDonationData_createDonation_categoryBuilder();

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

class _$GCreateDonationData_createDonation_mainAttachmentSerializer
    implements
        StructuredSerializer<
          GCreateDonationData_createDonation_mainAttachment
        > {
  @override
  final Iterable<Type> types = const [
    GCreateDonationData_createDonation_mainAttachment,
    _$GCreateDonationData_createDonation_mainAttachment,
  ];
  @override
  final String wireName = 'GCreateDonationData_createDonation_mainAttachment';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateDonationData_createDonation_mainAttachment object, {
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
  GCreateDonationData_createDonation_mainAttachment deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateDonationData_createDonation_mainAttachmentBuilder();

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

class _$GCreateDonationData_createDonation_locationSerializer
    implements
        StructuredSerializer<GCreateDonationData_createDonation_location> {
  @override
  final Iterable<Type> types = const [
    GCreateDonationData_createDonation_location,
    _$GCreateDonationData_createDonation_location,
  ];
  @override
  final String wireName = 'GCreateDonationData_createDonation_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateDonationData_createDonation_location object, {
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
  GCreateDonationData_createDonation_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateDonationData_createDonation_locationBuilder();

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

class _$GCreateDonationData_createDonation_userSerializer
    implements StructuredSerializer<GCreateDonationData_createDonation_user> {
  @override
  final Iterable<Type> types = const [
    GCreateDonationData_createDonation_user,
    _$GCreateDonationData_createDonation_user,
  ];
  @override
  final String wireName = 'GCreateDonationData_createDonation_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateDonationData_createDonation_user object, {
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
  GCreateDonationData_createDonation_user deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateDonationData_createDonation_userBuilder();

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

class _$GCreateDonationData extends GCreateDonationData {
  @override
  final String G__typename;
  @override
  final GCreateDonationData_createDonation createDonation;

  factory _$GCreateDonationData([
    void Function(GCreateDonationDataBuilder)? updates,
  ]) => (GCreateDonationDataBuilder()..update(updates))._build();

  _$GCreateDonationData._({
    required this.G__typename,
    required this.createDonation,
  }) : super._();
  @override
  GCreateDonationData rebuild(
    void Function(GCreateDonationDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateDonationDataBuilder toBuilder() =>
      GCreateDonationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateDonationData &&
        G__typename == other.G__typename &&
        createDonation == other.createDonation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, createDonation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GCreateDonationData')
          ..add('G__typename', G__typename)
          ..add('createDonation', createDonation))
        .toString();
  }
}

class GCreateDonationDataBuilder
    implements Builder<GCreateDonationData, GCreateDonationDataBuilder> {
  _$GCreateDonationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GCreateDonationData_createDonationBuilder? _createDonation;
  GCreateDonationData_createDonationBuilder get createDonation =>
      _$this._createDonation ??= GCreateDonationData_createDonationBuilder();
  set createDonation(
    GCreateDonationData_createDonationBuilder? createDonation,
  ) => _$this._createDonation = createDonation;

  GCreateDonationDataBuilder() {
    GCreateDonationData._initializeBuilder(this);
  }

  GCreateDonationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _createDonation = $v.createDonation.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateDonationData other) {
    _$v = other as _$GCreateDonationData;
  }

  @override
  void update(void Function(GCreateDonationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateDonationData build() => _build();

  _$GCreateDonationData _build() {
    _$GCreateDonationData _$result;
    try {
      _$result =
          _$v ??
          _$GCreateDonationData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GCreateDonationData',
              'G__typename',
            ),
            createDonation: createDonation.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createDonation';
        createDonation.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GCreateDonationData',
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

class _$GCreateDonationData_createDonation
    extends GCreateDonationData_createDonation {
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
  final GCreateDonationData_createDonation_category? category;
  @override
  final _i2.GDonationStatusValues status;
  @override
  final _i2.GDonationUrgencyValues urgency;
  @override
  final String? mainAttachmentId;
  @override
  final GCreateDonationData_createDonation_mainAttachment? mainAttachment;
  @override
  final String? locationId;
  @override
  final GCreateDonationData_createDonation_location? location;
  @override
  final GCreateDonationData_createDonation_user user;

  factory _$GCreateDonationData_createDonation([
    void Function(GCreateDonationData_createDonationBuilder)? updates,
  ]) => (GCreateDonationData_createDonationBuilder()..update(updates))._build();

  _$GCreateDonationData_createDonation._({
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
  GCreateDonationData_createDonation rebuild(
    void Function(GCreateDonationData_createDonationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateDonationData_createDonationBuilder toBuilder() =>
      GCreateDonationData_createDonationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateDonationData_createDonation &&
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
    return (newBuiltValueToStringHelper(r'GCreateDonationData_createDonation')
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

class GCreateDonationData_createDonationBuilder
    implements
        Builder<
          GCreateDonationData_createDonation,
          GCreateDonationData_createDonationBuilder
        > {
  _$GCreateDonationData_createDonation? _$v;

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

  GCreateDonationData_createDonation_categoryBuilder? _category;
  GCreateDonationData_createDonation_categoryBuilder get category =>
      _$this._category ??= GCreateDonationData_createDonation_categoryBuilder();
  set category(GCreateDonationData_createDonation_categoryBuilder? category) =>
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

  GCreateDonationData_createDonation_mainAttachmentBuilder? _mainAttachment;
  GCreateDonationData_createDonation_mainAttachmentBuilder get mainAttachment =>
      _$this._mainAttachment ??=
          GCreateDonationData_createDonation_mainAttachmentBuilder();
  set mainAttachment(
    GCreateDonationData_createDonation_mainAttachmentBuilder? mainAttachment,
  ) => _$this._mainAttachment = mainAttachment;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  GCreateDonationData_createDonation_locationBuilder? _location;
  GCreateDonationData_createDonation_locationBuilder get location =>
      _$this._location ??= GCreateDonationData_createDonation_locationBuilder();
  set location(GCreateDonationData_createDonation_locationBuilder? location) =>
      _$this._location = location;

  GCreateDonationData_createDonation_userBuilder? _user;
  GCreateDonationData_createDonation_userBuilder get user =>
      _$this._user ??= GCreateDonationData_createDonation_userBuilder();
  set user(GCreateDonationData_createDonation_userBuilder? user) =>
      _$this._user = user;

  GCreateDonationData_createDonationBuilder() {
    GCreateDonationData_createDonation._initializeBuilder(this);
  }

  GCreateDonationData_createDonationBuilder get _$this {
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
  void replace(GCreateDonationData_createDonation other) {
    _$v = other as _$GCreateDonationData_createDonation;
  }

  @override
  void update(
    void Function(GCreateDonationData_createDonationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateDonationData_createDonation build() => _build();

  _$GCreateDonationData_createDonation _build() {
    _$GCreateDonationData_createDonation _$result;
    try {
      _$result =
          _$v ??
          _$GCreateDonationData_createDonation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GCreateDonationData_createDonation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GCreateDonationData_createDonation',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GCreateDonationData_createDonation',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'GCreateDonationData_createDonation',
              'description',
            ),
            quantity: BuiltValueNullFieldError.checkNotNull(
              quantity,
              r'GCreateDonationData_createDonation',
              'quantity',
            ),
            categoryId: BuiltValueNullFieldError.checkNotNull(
              categoryId,
              r'GCreateDonationData_createDonation',
              'categoryId',
            ),
            category: _category?.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GCreateDonationData_createDonation',
              'status',
            ),
            urgency: BuiltValueNullFieldError.checkNotNull(
              urgency,
              r'GCreateDonationData_createDonation',
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
          r'GCreateDonationData_createDonation',
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

class _$GCreateDonationData_createDonation_category
    extends GCreateDonationData_createDonation_category {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;

  factory _$GCreateDonationData_createDonation_category([
    void Function(GCreateDonationData_createDonation_categoryBuilder)? updates,
  ]) => (GCreateDonationData_createDonation_categoryBuilder()..update(updates))
      ._build();

  _$GCreateDonationData_createDonation_category._({
    required this.G__typename,
    required this.id,
    required this.name,
  }) : super._();
  @override
  GCreateDonationData_createDonation_category rebuild(
    void Function(GCreateDonationData_createDonation_categoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateDonationData_createDonation_categoryBuilder toBuilder() =>
      GCreateDonationData_createDonation_categoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateDonationData_createDonation_category &&
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
            r'GCreateDonationData_createDonation_category',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GCreateDonationData_createDonation_categoryBuilder
    implements
        Builder<
          GCreateDonationData_createDonation_category,
          GCreateDonationData_createDonation_categoryBuilder
        > {
  _$GCreateDonationData_createDonation_category? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GCreateDonationData_createDonation_categoryBuilder() {
    GCreateDonationData_createDonation_category._initializeBuilder(this);
  }

  GCreateDonationData_createDonation_categoryBuilder get _$this {
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
  void replace(GCreateDonationData_createDonation_category other) {
    _$v = other as _$GCreateDonationData_createDonation_category;
  }

  @override
  void update(
    void Function(GCreateDonationData_createDonation_categoryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateDonationData_createDonation_category build() => _build();

  _$GCreateDonationData_createDonation_category _build() {
    final _$result =
        _$v ??
        _$GCreateDonationData_createDonation_category._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GCreateDonationData_createDonation_category',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GCreateDonationData_createDonation_category',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GCreateDonationData_createDonation_category',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateDonationData_createDonation_mainAttachment
    extends GCreateDonationData_createDonation_mainAttachment {
  @override
  final String G__typename;
  @override
  final String? url;

  factory _$GCreateDonationData_createDonation_mainAttachment([
    void Function(GCreateDonationData_createDonation_mainAttachmentBuilder)?
    updates,
  ]) =>
      (GCreateDonationData_createDonation_mainAttachmentBuilder()
            ..update(updates))
          ._build();

  _$GCreateDonationData_createDonation_mainAttachment._({
    required this.G__typename,
    this.url,
  }) : super._();
  @override
  GCreateDonationData_createDonation_mainAttachment rebuild(
    void Function(GCreateDonationData_createDonation_mainAttachmentBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateDonationData_createDonation_mainAttachmentBuilder toBuilder() =>
      GCreateDonationData_createDonation_mainAttachmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateDonationData_createDonation_mainAttachment &&
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
            r'GCreateDonationData_createDonation_mainAttachment',
          )
          ..add('G__typename', G__typename)
          ..add('url', url))
        .toString();
  }
}

class GCreateDonationData_createDonation_mainAttachmentBuilder
    implements
        Builder<
          GCreateDonationData_createDonation_mainAttachment,
          GCreateDonationData_createDonation_mainAttachmentBuilder
        > {
  _$GCreateDonationData_createDonation_mainAttachment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GCreateDonationData_createDonation_mainAttachmentBuilder() {
    GCreateDonationData_createDonation_mainAttachment._initializeBuilder(this);
  }

  GCreateDonationData_createDonation_mainAttachmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateDonationData_createDonation_mainAttachment other) {
    _$v = other as _$GCreateDonationData_createDonation_mainAttachment;
  }

  @override
  void update(
    void Function(GCreateDonationData_createDonation_mainAttachmentBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateDonationData_createDonation_mainAttachment build() => _build();

  _$GCreateDonationData_createDonation_mainAttachment _build() {
    final _$result =
        _$v ??
        _$GCreateDonationData_createDonation_mainAttachment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GCreateDonationData_createDonation_mainAttachment',
            'G__typename',
          ),
          url: url,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateDonationData_createDonation_location
    extends GCreateDonationData_createDonation_location {
  @override
  final String G__typename;
  @override
  final double? latitude;
  @override
  final double? longitude;

  factory _$GCreateDonationData_createDonation_location([
    void Function(GCreateDonationData_createDonation_locationBuilder)? updates,
  ]) => (GCreateDonationData_createDonation_locationBuilder()..update(updates))
      ._build();

  _$GCreateDonationData_createDonation_location._({
    required this.G__typename,
    this.latitude,
    this.longitude,
  }) : super._();
  @override
  GCreateDonationData_createDonation_location rebuild(
    void Function(GCreateDonationData_createDonation_locationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateDonationData_createDonation_locationBuilder toBuilder() =>
      GCreateDonationData_createDonation_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateDonationData_createDonation_location &&
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
            r'GCreateDonationData_createDonation_location',
          )
          ..add('G__typename', G__typename)
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class GCreateDonationData_createDonation_locationBuilder
    implements
        Builder<
          GCreateDonationData_createDonation_location,
          GCreateDonationData_createDonation_locationBuilder
        > {
  _$GCreateDonationData_createDonation_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  GCreateDonationData_createDonation_locationBuilder() {
    GCreateDonationData_createDonation_location._initializeBuilder(this);
  }

  GCreateDonationData_createDonation_locationBuilder get _$this {
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
  void replace(GCreateDonationData_createDonation_location other) {
    _$v = other as _$GCreateDonationData_createDonation_location;
  }

  @override
  void update(
    void Function(GCreateDonationData_createDonation_locationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateDonationData_createDonation_location build() => _build();

  _$GCreateDonationData_createDonation_location _build() {
    final _$result =
        _$v ??
        _$GCreateDonationData_createDonation_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GCreateDonationData_createDonation_location',
            'G__typename',
          ),
          latitude: latitude,
          longitude: longitude,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GCreateDonationData_createDonation_user
    extends GCreateDonationData_createDonation_user {
  @override
  final String G__typename;
  @override
  final String? displayName;
  @override
  final String email;

  factory _$GCreateDonationData_createDonation_user([
    void Function(GCreateDonationData_createDonation_userBuilder)? updates,
  ]) => (GCreateDonationData_createDonation_userBuilder()..update(updates))
      ._build();

  _$GCreateDonationData_createDonation_user._({
    required this.G__typename,
    this.displayName,
    required this.email,
  }) : super._();
  @override
  GCreateDonationData_createDonation_user rebuild(
    void Function(GCreateDonationData_createDonation_userBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateDonationData_createDonation_userBuilder toBuilder() =>
      GCreateDonationData_createDonation_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateDonationData_createDonation_user &&
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
            r'GCreateDonationData_createDonation_user',
          )
          ..add('G__typename', G__typename)
          ..add('displayName', displayName)
          ..add('email', email))
        .toString();
  }
}

class GCreateDonationData_createDonation_userBuilder
    implements
        Builder<
          GCreateDonationData_createDonation_user,
          GCreateDonationData_createDonation_userBuilder
        > {
  _$GCreateDonationData_createDonation_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GCreateDonationData_createDonation_userBuilder() {
    GCreateDonationData_createDonation_user._initializeBuilder(this);
  }

  GCreateDonationData_createDonation_userBuilder get _$this {
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
  void replace(GCreateDonationData_createDonation_user other) {
    _$v = other as _$GCreateDonationData_createDonation_user;
  }

  @override
  void update(
    void Function(GCreateDonationData_createDonation_userBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GCreateDonationData_createDonation_user build() => _build();

  _$GCreateDonationData_createDonation_user _build() {
    final _$result =
        _$v ??
        _$GCreateDonationData_createDonation_user._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GCreateDonationData_createDonation_user',
            'G__typename',
          ),
          displayName: displayName,
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'GCreateDonationData_createDonation_user',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
