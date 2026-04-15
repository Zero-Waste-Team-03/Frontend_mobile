// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_donations.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetDonationsData> _$gGetDonationsDataSerializer =
    _$GGetDonationsDataSerializer();
Serializer<GGetDonationsData_donations> _$gGetDonationsDataDonationsSerializer =
    _$GGetDonationsData_donationsSerializer();
Serializer<GGetDonationsData_donations_items>
_$gGetDonationsDataDonationsItemsSerializer =
    _$GGetDonationsData_donations_itemsSerializer();
Serializer<GGetDonationsData_donations_items_category>
_$gGetDonationsDataDonationsItemsCategorySerializer =
    _$GGetDonationsData_donations_items_categorySerializer();
Serializer<GGetDonationsData_donations_items_mainAttachment>
_$gGetDonationsDataDonationsItemsMainAttachmentSerializer =
    _$GGetDonationsData_donations_items_mainAttachmentSerializer();
Serializer<GGetDonationsData_donations_items_location>
_$gGetDonationsDataDonationsItemsLocationSerializer =
    _$GGetDonationsData_donations_items_locationSerializer();
Serializer<GGetDonationsData_donations_items_user>
_$gGetDonationsDataDonationsItemsUserSerializer =
    _$GGetDonationsData_donations_items_userSerializer();

class _$GGetDonationsDataSerializer
    implements StructuredSerializer<GGetDonationsData> {
  @override
  final Iterable<Type> types = const [GGetDonationsData, _$GGetDonationsData];
  @override
  final String wireName = 'GGetDonationsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'donations',
      serializers.serialize(
        object.donations,
        specifiedType: const FullType(GGetDonationsData_donations),
      ),
    ];

    return result;
  }

  @override
  GGetDonationsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationsDataBuilder();

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
        case 'donations':
          result.donations.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GGetDonationsData_donations),
                )!
                as GGetDonationsData_donations,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetDonationsData_donationsSerializer
    implements StructuredSerializer<GGetDonationsData_donations> {
  @override
  final Iterable<Type> types = const [
    GGetDonationsData_donations,
    _$GGetDonationsData_donations,
  ];
  @override
  final String wireName = 'GGetDonationsData_donations';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationsData_donations object, {
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
    value = object.items;
    if (value != null) {
      result
        ..add('items')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(GGetDonationsData_donations_items),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  GGetDonationsData_donations deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationsData_donationsBuilder();

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
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GGetDonationsData_donations_items),
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

class _$GGetDonationsData_donations_itemsSerializer
    implements StructuredSerializer<GGetDonationsData_donations_items> {
  @override
  final Iterable<Type> types = const [
    GGetDonationsData_donations_items,
    _$GGetDonationsData_donations_items,
  ];
  @override
  final String wireName = 'GGetDonationsData_donations_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationsData_donations_items object, {
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
        specifiedType: const FullType(GGetDonationsData_donations_items_user),
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
              GGetDonationsData_donations_items_category,
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
              GGetDonationsData_donations_items_mainAttachment,
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
              GGetDonationsData_donations_items_location,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GGetDonationsData_donations_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationsData_donations_itemsBuilder();

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
                    GGetDonationsData_donations_items_category,
                  ),
                )!
                as GGetDonationsData_donations_items_category,
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
                    GGetDonationsData_donations_items_mainAttachment,
                  ),
                )!
                as GGetDonationsData_donations_items_mainAttachment,
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
                    GGetDonationsData_donations_items_location,
                  ),
                )!
                as GGetDonationsData_donations_items_location,
          );
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetDonationsData_donations_items_user,
                  ),
                )!
                as GGetDonationsData_donations_items_user,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetDonationsData_donations_items_categorySerializer
    implements
        StructuredSerializer<GGetDonationsData_donations_items_category> {
  @override
  final Iterable<Type> types = const [
    GGetDonationsData_donations_items_category,
    _$GGetDonationsData_donations_items_category,
  ];
  @override
  final String wireName = 'GGetDonationsData_donations_items_category';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationsData_donations_items_category object, {
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
  GGetDonationsData_donations_items_category deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationsData_donations_items_categoryBuilder();

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

class _$GGetDonationsData_donations_items_mainAttachmentSerializer
    implements
        StructuredSerializer<GGetDonationsData_donations_items_mainAttachment> {
  @override
  final Iterable<Type> types = const [
    GGetDonationsData_donations_items_mainAttachment,
    _$GGetDonationsData_donations_items_mainAttachment,
  ];
  @override
  final String wireName = 'GGetDonationsData_donations_items_mainAttachment';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationsData_donations_items_mainAttachment object, {
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
  GGetDonationsData_donations_items_mainAttachment deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationsData_donations_items_mainAttachmentBuilder();

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

class _$GGetDonationsData_donations_items_locationSerializer
    implements
        StructuredSerializer<GGetDonationsData_donations_items_location> {
  @override
  final Iterable<Type> types = const [
    GGetDonationsData_donations_items_location,
    _$GGetDonationsData_donations_items_location,
  ];
  @override
  final String wireName = 'GGetDonationsData_donations_items_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationsData_donations_items_location object, {
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
  GGetDonationsData_donations_items_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationsData_donations_items_locationBuilder();

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

class _$GGetDonationsData_donations_items_userSerializer
    implements StructuredSerializer<GGetDonationsData_donations_items_user> {
  @override
  final Iterable<Type> types = const [
    GGetDonationsData_donations_items_user,
    _$GGetDonationsData_donations_items_user,
  ];
  @override
  final String wireName = 'GGetDonationsData_donations_items_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationsData_donations_items_user object, {
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
  GGetDonationsData_donations_items_user deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationsData_donations_items_userBuilder();

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

class _$GGetDonationsData extends GGetDonationsData {
  @override
  final String G__typename;
  @override
  final GGetDonationsData_donations donations;

  factory _$GGetDonationsData([
    void Function(GGetDonationsDataBuilder)? updates,
  ]) => (GGetDonationsDataBuilder()..update(updates))._build();

  _$GGetDonationsData._({required this.G__typename, required this.donations})
    : super._();
  @override
  GGetDonationsData rebuild(void Function(GGetDonationsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetDonationsDataBuilder toBuilder() =>
      GGetDonationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationsData &&
        G__typename == other.G__typename &&
        donations == other.donations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, donations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetDonationsData')
          ..add('G__typename', G__typename)
          ..add('donations', donations))
        .toString();
  }
}

class GGetDonationsDataBuilder
    implements Builder<GGetDonationsData, GGetDonationsDataBuilder> {
  _$GGetDonationsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetDonationsData_donationsBuilder? _donations;
  GGetDonationsData_donationsBuilder get donations =>
      _$this._donations ??= GGetDonationsData_donationsBuilder();
  set donations(GGetDonationsData_donationsBuilder? donations) =>
      _$this._donations = donations;

  GGetDonationsDataBuilder() {
    GGetDonationsData._initializeBuilder(this);
  }

  GGetDonationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _donations = $v.donations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetDonationsData other) {
    _$v = other as _$GGetDonationsData;
  }

  @override
  void update(void Function(GGetDonationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationsData build() => _build();

  _$GGetDonationsData _build() {
    _$GGetDonationsData _$result;
    try {
      _$result =
          _$v ??
          _$GGetDonationsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetDonationsData',
              'G__typename',
            ),
            donations: donations.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'donations';
        donations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetDonationsData',
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

class _$GGetDonationsData_donations extends GGetDonationsData_donations {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetDonationsData_donations_items>? items;

  factory _$GGetDonationsData_donations([
    void Function(GGetDonationsData_donationsBuilder)? updates,
  ]) => (GGetDonationsData_donationsBuilder()..update(updates))._build();

  _$GGetDonationsData_donations._({required this.G__typename, this.items})
    : super._();
  @override
  GGetDonationsData_donations rebuild(
    void Function(GGetDonationsData_donationsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationsData_donationsBuilder toBuilder() =>
      GGetDonationsData_donationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationsData_donations &&
        G__typename == other.G__typename &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetDonationsData_donations')
          ..add('G__typename', G__typename)
          ..add('items', items))
        .toString();
  }
}

class GGetDonationsData_donationsBuilder
    implements
        Builder<
          GGetDonationsData_donations,
          GGetDonationsData_donationsBuilder
        > {
  _$GGetDonationsData_donations? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GGetDonationsData_donations_items>? _items;
  ListBuilder<GGetDonationsData_donations_items> get items =>
      _$this._items ??= ListBuilder<GGetDonationsData_donations_items>();
  set items(ListBuilder<GGetDonationsData_donations_items>? items) =>
      _$this._items = items;

  GGetDonationsData_donationsBuilder() {
    GGetDonationsData_donations._initializeBuilder(this);
  }

  GGetDonationsData_donationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetDonationsData_donations other) {
    _$v = other as _$GGetDonationsData_donations;
  }

  @override
  void update(void Function(GGetDonationsData_donationsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationsData_donations build() => _build();

  _$GGetDonationsData_donations _build() {
    _$GGetDonationsData_donations _$result;
    try {
      _$result =
          _$v ??
          _$GGetDonationsData_donations._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetDonationsData_donations',
              'G__typename',
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
          r'GGetDonationsData_donations',
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

class _$GGetDonationsData_donations_items
    extends GGetDonationsData_donations_items {
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
  final GGetDonationsData_donations_items_category? category;
  @override
  final _i2.GDonationStatusValues status;
  @override
  final _i2.GDonationUrgencyValues urgency;
  @override
  final String? mainAttachmentId;
  @override
  final GGetDonationsData_donations_items_mainAttachment? mainAttachment;
  @override
  final String? locationId;
  @override
  final GGetDonationsData_donations_items_location? location;
  @override
  final GGetDonationsData_donations_items_user user;

  factory _$GGetDonationsData_donations_items([
    void Function(GGetDonationsData_donations_itemsBuilder)? updates,
  ]) => (GGetDonationsData_donations_itemsBuilder()..update(updates))._build();

  _$GGetDonationsData_donations_items._({
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
  GGetDonationsData_donations_items rebuild(
    void Function(GGetDonationsData_donations_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationsData_donations_itemsBuilder toBuilder() =>
      GGetDonationsData_donations_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationsData_donations_items &&
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
    return (newBuiltValueToStringHelper(r'GGetDonationsData_donations_items')
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

class GGetDonationsData_donations_itemsBuilder
    implements
        Builder<
          GGetDonationsData_donations_items,
          GGetDonationsData_donations_itemsBuilder
        > {
  _$GGetDonationsData_donations_items? _$v;

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

  GGetDonationsData_donations_items_categoryBuilder? _category;
  GGetDonationsData_donations_items_categoryBuilder get category =>
      _$this._category ??= GGetDonationsData_donations_items_categoryBuilder();
  set category(GGetDonationsData_donations_items_categoryBuilder? category) =>
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

  GGetDonationsData_donations_items_mainAttachmentBuilder? _mainAttachment;
  GGetDonationsData_donations_items_mainAttachmentBuilder get mainAttachment =>
      _$this._mainAttachment ??=
          GGetDonationsData_donations_items_mainAttachmentBuilder();
  set mainAttachment(
    GGetDonationsData_donations_items_mainAttachmentBuilder? mainAttachment,
  ) => _$this._mainAttachment = mainAttachment;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  GGetDonationsData_donations_items_locationBuilder? _location;
  GGetDonationsData_donations_items_locationBuilder get location =>
      _$this._location ??= GGetDonationsData_donations_items_locationBuilder();
  set location(GGetDonationsData_donations_items_locationBuilder? location) =>
      _$this._location = location;

  GGetDonationsData_donations_items_userBuilder? _user;
  GGetDonationsData_donations_items_userBuilder get user =>
      _$this._user ??= GGetDonationsData_donations_items_userBuilder();
  set user(GGetDonationsData_donations_items_userBuilder? user) =>
      _$this._user = user;

  GGetDonationsData_donations_itemsBuilder() {
    GGetDonationsData_donations_items._initializeBuilder(this);
  }

  GGetDonationsData_donations_itemsBuilder get _$this {
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
  void replace(GGetDonationsData_donations_items other) {
    _$v = other as _$GGetDonationsData_donations_items;
  }

  @override
  void update(
    void Function(GGetDonationsData_donations_itemsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationsData_donations_items build() => _build();

  _$GGetDonationsData_donations_items _build() {
    _$GGetDonationsData_donations_items _$result;
    try {
      _$result =
          _$v ??
          _$GGetDonationsData_donations_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetDonationsData_donations_items',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GGetDonationsData_donations_items',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GGetDonationsData_donations_items',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'GGetDonationsData_donations_items',
              'description',
            ),
            quantity: BuiltValueNullFieldError.checkNotNull(
              quantity,
              r'GGetDonationsData_donations_items',
              'quantity',
            ),
            categoryId: BuiltValueNullFieldError.checkNotNull(
              categoryId,
              r'GGetDonationsData_donations_items',
              'categoryId',
            ),
            category: _category?.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GGetDonationsData_donations_items',
              'status',
            ),
            urgency: BuiltValueNullFieldError.checkNotNull(
              urgency,
              r'GGetDonationsData_donations_items',
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
          r'GGetDonationsData_donations_items',
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

class _$GGetDonationsData_donations_items_category
    extends GGetDonationsData_donations_items_category {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;

  factory _$GGetDonationsData_donations_items_category([
    void Function(GGetDonationsData_donations_items_categoryBuilder)? updates,
  ]) => (GGetDonationsData_donations_items_categoryBuilder()..update(updates))
      ._build();

  _$GGetDonationsData_donations_items_category._({
    required this.G__typename,
    required this.id,
    required this.name,
  }) : super._();
  @override
  GGetDonationsData_donations_items_category rebuild(
    void Function(GGetDonationsData_donations_items_categoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationsData_donations_items_categoryBuilder toBuilder() =>
      GGetDonationsData_donations_items_categoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationsData_donations_items_category &&
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
            r'GGetDonationsData_donations_items_category',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GGetDonationsData_donations_items_categoryBuilder
    implements
        Builder<
          GGetDonationsData_donations_items_category,
          GGetDonationsData_donations_items_categoryBuilder
        > {
  _$GGetDonationsData_donations_items_category? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GGetDonationsData_donations_items_categoryBuilder() {
    GGetDonationsData_donations_items_category._initializeBuilder(this);
  }

  GGetDonationsData_donations_items_categoryBuilder get _$this {
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
  void replace(GGetDonationsData_donations_items_category other) {
    _$v = other as _$GGetDonationsData_donations_items_category;
  }

  @override
  void update(
    void Function(GGetDonationsData_donations_items_categoryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationsData_donations_items_category build() => _build();

  _$GGetDonationsData_donations_items_category _build() {
    final _$result =
        _$v ??
        _$GGetDonationsData_donations_items_category._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetDonationsData_donations_items_category',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GGetDonationsData_donations_items_category',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GGetDonationsData_donations_items_category',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetDonationsData_donations_items_mainAttachment
    extends GGetDonationsData_donations_items_mainAttachment {
  @override
  final String G__typename;
  @override
  final String? url;

  factory _$GGetDonationsData_donations_items_mainAttachment([
    void Function(GGetDonationsData_donations_items_mainAttachmentBuilder)?
    updates,
  ]) =>
      (GGetDonationsData_donations_items_mainAttachmentBuilder()
            ..update(updates))
          ._build();

  _$GGetDonationsData_donations_items_mainAttachment._({
    required this.G__typename,
    this.url,
  }) : super._();
  @override
  GGetDonationsData_donations_items_mainAttachment rebuild(
    void Function(GGetDonationsData_donations_items_mainAttachmentBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationsData_donations_items_mainAttachmentBuilder toBuilder() =>
      GGetDonationsData_donations_items_mainAttachmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationsData_donations_items_mainAttachment &&
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
            r'GGetDonationsData_donations_items_mainAttachment',
          )
          ..add('G__typename', G__typename)
          ..add('url', url))
        .toString();
  }
}

class GGetDonationsData_donations_items_mainAttachmentBuilder
    implements
        Builder<
          GGetDonationsData_donations_items_mainAttachment,
          GGetDonationsData_donations_items_mainAttachmentBuilder
        > {
  _$GGetDonationsData_donations_items_mainAttachment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GGetDonationsData_donations_items_mainAttachmentBuilder() {
    GGetDonationsData_donations_items_mainAttachment._initializeBuilder(this);
  }

  GGetDonationsData_donations_items_mainAttachmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetDonationsData_donations_items_mainAttachment other) {
    _$v = other as _$GGetDonationsData_donations_items_mainAttachment;
  }

  @override
  void update(
    void Function(GGetDonationsData_donations_items_mainAttachmentBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationsData_donations_items_mainAttachment build() => _build();

  _$GGetDonationsData_donations_items_mainAttachment _build() {
    final _$result =
        _$v ??
        _$GGetDonationsData_donations_items_mainAttachment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetDonationsData_donations_items_mainAttachment',
            'G__typename',
          ),
          url: url,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetDonationsData_donations_items_location
    extends GGetDonationsData_donations_items_location {
  @override
  final String G__typename;
  @override
  final double? latitude;
  @override
  final double? longitude;

  factory _$GGetDonationsData_donations_items_location([
    void Function(GGetDonationsData_donations_items_locationBuilder)? updates,
  ]) => (GGetDonationsData_donations_items_locationBuilder()..update(updates))
      ._build();

  _$GGetDonationsData_donations_items_location._({
    required this.G__typename,
    this.latitude,
    this.longitude,
  }) : super._();
  @override
  GGetDonationsData_donations_items_location rebuild(
    void Function(GGetDonationsData_donations_items_locationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationsData_donations_items_locationBuilder toBuilder() =>
      GGetDonationsData_donations_items_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationsData_donations_items_location &&
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
            r'GGetDonationsData_donations_items_location',
          )
          ..add('G__typename', G__typename)
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class GGetDonationsData_donations_items_locationBuilder
    implements
        Builder<
          GGetDonationsData_donations_items_location,
          GGetDonationsData_donations_items_locationBuilder
        > {
  _$GGetDonationsData_donations_items_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  GGetDonationsData_donations_items_locationBuilder() {
    GGetDonationsData_donations_items_location._initializeBuilder(this);
  }

  GGetDonationsData_donations_items_locationBuilder get _$this {
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
  void replace(GGetDonationsData_donations_items_location other) {
    _$v = other as _$GGetDonationsData_donations_items_location;
  }

  @override
  void update(
    void Function(GGetDonationsData_donations_items_locationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationsData_donations_items_location build() => _build();

  _$GGetDonationsData_donations_items_location _build() {
    final _$result =
        _$v ??
        _$GGetDonationsData_donations_items_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetDonationsData_donations_items_location',
            'G__typename',
          ),
          latitude: latitude,
          longitude: longitude,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetDonationsData_donations_items_user
    extends GGetDonationsData_donations_items_user {
  @override
  final String G__typename;
  @override
  final String? displayName;
  @override
  final String email;

  factory _$GGetDonationsData_donations_items_user([
    void Function(GGetDonationsData_donations_items_userBuilder)? updates,
  ]) => (GGetDonationsData_donations_items_userBuilder()..update(updates))
      ._build();

  _$GGetDonationsData_donations_items_user._({
    required this.G__typename,
    this.displayName,
    required this.email,
  }) : super._();
  @override
  GGetDonationsData_donations_items_user rebuild(
    void Function(GGetDonationsData_donations_items_userBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationsData_donations_items_userBuilder toBuilder() =>
      GGetDonationsData_donations_items_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationsData_donations_items_user &&
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
            r'GGetDonationsData_donations_items_user',
          )
          ..add('G__typename', G__typename)
          ..add('displayName', displayName)
          ..add('email', email))
        .toString();
  }
}

class GGetDonationsData_donations_items_userBuilder
    implements
        Builder<
          GGetDonationsData_donations_items_user,
          GGetDonationsData_donations_items_userBuilder
        > {
  _$GGetDonationsData_donations_items_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GGetDonationsData_donations_items_userBuilder() {
    GGetDonationsData_donations_items_user._initializeBuilder(this);
  }

  GGetDonationsData_donations_items_userBuilder get _$this {
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
  void replace(GGetDonationsData_donations_items_user other) {
    _$v = other as _$GGetDonationsData_donations_items_user;
  }

  @override
  void update(
    void Function(GGetDonationsData_donations_items_userBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationsData_donations_items_user build() => _build();

  _$GGetDonationsData_donations_items_user _build() {
    final _$result =
        _$v ??
        _$GGetDonationsData_donations_items_user._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetDonationsData_donations_items_user',
            'G__typename',
          ),
          displayName: displayName,
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'GGetDonationsData_donations_items_user',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
