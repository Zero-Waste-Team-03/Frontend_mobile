// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_myDonations.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyDonationsData> _$gMyDonationsDataSerializer =
    _$GMyDonationsDataSerializer();
Serializer<GMyDonationsData_myDonations>
_$gMyDonationsDataMyDonationsSerializer =
    _$GMyDonationsData_myDonationsSerializer();
Serializer<GMyDonationsData_myDonations_items>
_$gMyDonationsDataMyDonationsItemsSerializer =
    _$GMyDonationsData_myDonations_itemsSerializer();
Serializer<GMyDonationsData_myDonations_items_category>
_$gMyDonationsDataMyDonationsItemsCategorySerializer =
    _$GMyDonationsData_myDonations_items_categorySerializer();
Serializer<GMyDonationsData_myDonations_items_mainAttachment>
_$gMyDonationsDataMyDonationsItemsMainAttachmentSerializer =
    _$GMyDonationsData_myDonations_items_mainAttachmentSerializer();
Serializer<GMyDonationsData_myDonations_items_location>
_$gMyDonationsDataMyDonationsItemsLocationSerializer =
    _$GMyDonationsData_myDonations_items_locationSerializer();
Serializer<GMyDonationsData_myDonations_items_user>
_$gMyDonationsDataMyDonationsItemsUserSerializer =
    _$GMyDonationsData_myDonations_items_userSerializer();

class _$GMyDonationsDataSerializer
    implements StructuredSerializer<GMyDonationsData> {
  @override
  final Iterable<Type> types = const [GMyDonationsData, _$GMyDonationsData];
  @override
  final String wireName = 'GMyDonationsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyDonationsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'myDonations',
      serializers.serialize(
        object.myDonations,
        specifiedType: const FullType(GMyDonationsData_myDonations),
      ),
    ];

    return result;
  }

  @override
  GMyDonationsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyDonationsDataBuilder();

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
        case 'myDonations':
          result.myDonations.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GMyDonationsData_myDonations),
                )!
                as GMyDonationsData_myDonations,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyDonationsData_myDonationsSerializer
    implements StructuredSerializer<GMyDonationsData_myDonations> {
  @override
  final Iterable<Type> types = const [
    GMyDonationsData_myDonations,
    _$GMyDonationsData_myDonations,
  ];
  @override
  final String wireName = 'GMyDonationsData_myDonations';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyDonationsData_myDonations object, {
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
      'limit',
      serializers.serialize(object.limit, specifiedType: const FullType(int)),
      'page',
      serializers.serialize(object.page, specifiedType: const FullType(int)),
      'totalCount',
      serializers.serialize(
        object.totalCount,
        specifiedType: const FullType(int),
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
              const FullType(GMyDonationsData_myDonations_items),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  GMyDonationsData_myDonations deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyDonationsData_myDonationsBuilder();

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
        case 'limit':
          result.limit =
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
        case 'totalCount':
          result.totalCount =
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
                    const FullType(GMyDonationsData_myDonations_items),
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

class _$GMyDonationsData_myDonations_itemsSerializer
    implements StructuredSerializer<GMyDonationsData_myDonations_items> {
  @override
  final Iterable<Type> types = const [
    GMyDonationsData_myDonations_items,
    _$GMyDonationsData_myDonations_items,
  ];
  @override
  final String wireName = 'GMyDonationsData_myDonations_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyDonationsData_myDonations_items object, {
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
        specifiedType: const FullType(GMyDonationsData_myDonations_items_user),
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
              GMyDonationsData_myDonations_items_category,
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
              GMyDonationsData_myDonations_items_mainAttachment,
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
              GMyDonationsData_myDonations_items_location,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GMyDonationsData_myDonations_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyDonationsData_myDonations_itemsBuilder();

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
                    GMyDonationsData_myDonations_items_category,
                  ),
                )!
                as GMyDonationsData_myDonations_items_category,
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
                    GMyDonationsData_myDonations_items_mainAttachment,
                  ),
                )!
                as GMyDonationsData_myDonations_items_mainAttachment,
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
                    GMyDonationsData_myDonations_items_location,
                  ),
                )!
                as GMyDonationsData_myDonations_items_location,
          );
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMyDonationsData_myDonations_items_user,
                  ),
                )!
                as GMyDonationsData_myDonations_items_user,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyDonationsData_myDonations_items_categorySerializer
    implements
        StructuredSerializer<GMyDonationsData_myDonations_items_category> {
  @override
  final Iterable<Type> types = const [
    GMyDonationsData_myDonations_items_category,
    _$GMyDonationsData_myDonations_items_category,
  ];
  @override
  final String wireName = 'GMyDonationsData_myDonations_items_category';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyDonationsData_myDonations_items_category object, {
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
  GMyDonationsData_myDonations_items_category deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyDonationsData_myDonations_items_categoryBuilder();

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

class _$GMyDonationsData_myDonations_items_mainAttachmentSerializer
    implements
        StructuredSerializer<
          GMyDonationsData_myDonations_items_mainAttachment
        > {
  @override
  final Iterable<Type> types = const [
    GMyDonationsData_myDonations_items_mainAttachment,
    _$GMyDonationsData_myDonations_items_mainAttachment,
  ];
  @override
  final String wireName = 'GMyDonationsData_myDonations_items_mainAttachment';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyDonationsData_myDonations_items_mainAttachment object, {
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
  GMyDonationsData_myDonations_items_mainAttachment deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyDonationsData_myDonations_items_mainAttachmentBuilder();

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

class _$GMyDonationsData_myDonations_items_locationSerializer
    implements
        StructuredSerializer<GMyDonationsData_myDonations_items_location> {
  @override
  final Iterable<Type> types = const [
    GMyDonationsData_myDonations_items_location,
    _$GMyDonationsData_myDonations_items_location,
  ];
  @override
  final String wireName = 'GMyDonationsData_myDonations_items_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyDonationsData_myDonations_items_location object, {
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
  GMyDonationsData_myDonations_items_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyDonationsData_myDonations_items_locationBuilder();

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

class _$GMyDonationsData_myDonations_items_userSerializer
    implements StructuredSerializer<GMyDonationsData_myDonations_items_user> {
  @override
  final Iterable<Type> types = const [
    GMyDonationsData_myDonations_items_user,
    _$GMyDonationsData_myDonations_items_user,
  ];
  @override
  final String wireName = 'GMyDonationsData_myDonations_items_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyDonationsData_myDonations_items_user object, {
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
  GMyDonationsData_myDonations_items_user deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyDonationsData_myDonations_items_userBuilder();

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

class _$GMyDonationsData extends GMyDonationsData {
  @override
  final String G__typename;
  @override
  final GMyDonationsData_myDonations myDonations;

  factory _$GMyDonationsData([
    void Function(GMyDonationsDataBuilder)? updates,
  ]) => (GMyDonationsDataBuilder()..update(updates))._build();

  _$GMyDonationsData._({required this.G__typename, required this.myDonations})
    : super._();
  @override
  GMyDonationsData rebuild(void Function(GMyDonationsDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyDonationsDataBuilder toBuilder() =>
      GMyDonationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyDonationsData &&
        G__typename == other.G__typename &&
        myDonations == other.myDonations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, myDonations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyDonationsData')
          ..add('G__typename', G__typename)
          ..add('myDonations', myDonations))
        .toString();
  }
}

class GMyDonationsDataBuilder
    implements Builder<GMyDonationsData, GMyDonationsDataBuilder> {
  _$GMyDonationsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMyDonationsData_myDonationsBuilder? _myDonations;
  GMyDonationsData_myDonationsBuilder get myDonations =>
      _$this._myDonations ??= GMyDonationsData_myDonationsBuilder();
  set myDonations(GMyDonationsData_myDonationsBuilder? myDonations) =>
      _$this._myDonations = myDonations;

  GMyDonationsDataBuilder() {
    GMyDonationsData._initializeBuilder(this);
  }

  GMyDonationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _myDonations = $v.myDonations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyDonationsData other) {
    _$v = other as _$GMyDonationsData;
  }

  @override
  void update(void Function(GMyDonationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyDonationsData build() => _build();

  _$GMyDonationsData _build() {
    _$GMyDonationsData _$result;
    try {
      _$result =
          _$v ??
          _$GMyDonationsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyDonationsData',
              'G__typename',
            ),
            myDonations: myDonations.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'myDonations';
        myDonations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyDonationsData',
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

class _$GMyDonationsData_myDonations extends GMyDonationsData_myDonations {
  @override
  final String G__typename;
  @override
  final bool hasNextPage;
  @override
  final bool hasPreviousPage;
  @override
  final int limit;
  @override
  final int page;
  @override
  final int totalCount;
  @override
  final BuiltList<GMyDonationsData_myDonations_items>? items;

  factory _$GMyDonationsData_myDonations([
    void Function(GMyDonationsData_myDonationsBuilder)? updates,
  ]) => (GMyDonationsData_myDonationsBuilder()..update(updates))._build();

  _$GMyDonationsData_myDonations._({
    required this.G__typename,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.limit,
    required this.page,
    required this.totalCount,
    this.items,
  }) : super._();
  @override
  GMyDonationsData_myDonations rebuild(
    void Function(GMyDonationsData_myDonationsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyDonationsData_myDonationsBuilder toBuilder() =>
      GMyDonationsData_myDonationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyDonationsData_myDonations &&
        G__typename == other.G__typename &&
        hasNextPage == other.hasNextPage &&
        hasPreviousPage == other.hasPreviousPage &&
        limit == other.limit &&
        page == other.page &&
        totalCount == other.totalCount &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, hasNextPage.hashCode);
    _$hash = $jc(_$hash, hasPreviousPage.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyDonationsData_myDonations')
          ..add('G__typename', G__typename)
          ..add('hasNextPage', hasNextPage)
          ..add('hasPreviousPage', hasPreviousPage)
          ..add('limit', limit)
          ..add('page', page)
          ..add('totalCount', totalCount)
          ..add('items', items))
        .toString();
  }
}

class GMyDonationsData_myDonationsBuilder
    implements
        Builder<
          GMyDonationsData_myDonations,
          GMyDonationsData_myDonationsBuilder
        > {
  _$GMyDonationsData_myDonations? _$v;

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

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  ListBuilder<GMyDonationsData_myDonations_items>? _items;
  ListBuilder<GMyDonationsData_myDonations_items> get items =>
      _$this._items ??= ListBuilder<GMyDonationsData_myDonations_items>();
  set items(ListBuilder<GMyDonationsData_myDonations_items>? items) =>
      _$this._items = items;

  GMyDonationsData_myDonationsBuilder() {
    GMyDonationsData_myDonations._initializeBuilder(this);
  }

  GMyDonationsData_myDonationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _hasNextPage = $v.hasNextPage;
      _hasPreviousPage = $v.hasPreviousPage;
      _limit = $v.limit;
      _page = $v.page;
      _totalCount = $v.totalCount;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyDonationsData_myDonations other) {
    _$v = other as _$GMyDonationsData_myDonations;
  }

  @override
  void update(void Function(GMyDonationsData_myDonationsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyDonationsData_myDonations build() => _build();

  _$GMyDonationsData_myDonations _build() {
    _$GMyDonationsData_myDonations _$result;
    try {
      _$result =
          _$v ??
          _$GMyDonationsData_myDonations._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyDonationsData_myDonations',
              'G__typename',
            ),
            hasNextPage: BuiltValueNullFieldError.checkNotNull(
              hasNextPage,
              r'GMyDonationsData_myDonations',
              'hasNextPage',
            ),
            hasPreviousPage: BuiltValueNullFieldError.checkNotNull(
              hasPreviousPage,
              r'GMyDonationsData_myDonations',
              'hasPreviousPage',
            ),
            limit: BuiltValueNullFieldError.checkNotNull(
              limit,
              r'GMyDonationsData_myDonations',
              'limit',
            ),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'GMyDonationsData_myDonations',
              'page',
            ),
            totalCount: BuiltValueNullFieldError.checkNotNull(
              totalCount,
              r'GMyDonationsData_myDonations',
              'totalCount',
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
          r'GMyDonationsData_myDonations',
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

class _$GMyDonationsData_myDonations_items
    extends GMyDonationsData_myDonations_items {
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
  final GMyDonationsData_myDonations_items_category? category;
  @override
  final _i2.GDonationStatusValues status;
  @override
  final _i2.GDonationUrgencyValues urgency;
  @override
  final String? mainAttachmentId;
  @override
  final GMyDonationsData_myDonations_items_mainAttachment? mainAttachment;
  @override
  final String? locationId;
  @override
  final GMyDonationsData_myDonations_items_location? location;
  @override
  final GMyDonationsData_myDonations_items_user user;

  factory _$GMyDonationsData_myDonations_items([
    void Function(GMyDonationsData_myDonations_itemsBuilder)? updates,
  ]) => (GMyDonationsData_myDonations_itemsBuilder()..update(updates))._build();

  _$GMyDonationsData_myDonations_items._({
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
  GMyDonationsData_myDonations_items rebuild(
    void Function(GMyDonationsData_myDonations_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyDonationsData_myDonations_itemsBuilder toBuilder() =>
      GMyDonationsData_myDonations_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyDonationsData_myDonations_items &&
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
    return (newBuiltValueToStringHelper(r'GMyDonationsData_myDonations_items')
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

class GMyDonationsData_myDonations_itemsBuilder
    implements
        Builder<
          GMyDonationsData_myDonations_items,
          GMyDonationsData_myDonations_itemsBuilder
        > {
  _$GMyDonationsData_myDonations_items? _$v;

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

  GMyDonationsData_myDonations_items_categoryBuilder? _category;
  GMyDonationsData_myDonations_items_categoryBuilder get category =>
      _$this._category ??= GMyDonationsData_myDonations_items_categoryBuilder();
  set category(GMyDonationsData_myDonations_items_categoryBuilder? category) =>
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

  GMyDonationsData_myDonations_items_mainAttachmentBuilder? _mainAttachment;
  GMyDonationsData_myDonations_items_mainAttachmentBuilder get mainAttachment =>
      _$this._mainAttachment ??=
          GMyDonationsData_myDonations_items_mainAttachmentBuilder();
  set mainAttachment(
    GMyDonationsData_myDonations_items_mainAttachmentBuilder? mainAttachment,
  ) => _$this._mainAttachment = mainAttachment;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  GMyDonationsData_myDonations_items_locationBuilder? _location;
  GMyDonationsData_myDonations_items_locationBuilder get location =>
      _$this._location ??= GMyDonationsData_myDonations_items_locationBuilder();
  set location(GMyDonationsData_myDonations_items_locationBuilder? location) =>
      _$this._location = location;

  GMyDonationsData_myDonations_items_userBuilder? _user;
  GMyDonationsData_myDonations_items_userBuilder get user =>
      _$this._user ??= GMyDonationsData_myDonations_items_userBuilder();
  set user(GMyDonationsData_myDonations_items_userBuilder? user) =>
      _$this._user = user;

  GMyDonationsData_myDonations_itemsBuilder() {
    GMyDonationsData_myDonations_items._initializeBuilder(this);
  }

  GMyDonationsData_myDonations_itemsBuilder get _$this {
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
  void replace(GMyDonationsData_myDonations_items other) {
    _$v = other as _$GMyDonationsData_myDonations_items;
  }

  @override
  void update(
    void Function(GMyDonationsData_myDonations_itemsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyDonationsData_myDonations_items build() => _build();

  _$GMyDonationsData_myDonations_items _build() {
    _$GMyDonationsData_myDonations_items _$result;
    try {
      _$result =
          _$v ??
          _$GMyDonationsData_myDonations_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyDonationsData_myDonations_items',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyDonationsData_myDonations_items',
              'id',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GMyDonationsData_myDonations_items',
              'title',
            ),
            description: BuiltValueNullFieldError.checkNotNull(
              description,
              r'GMyDonationsData_myDonations_items',
              'description',
            ),
            quantity: BuiltValueNullFieldError.checkNotNull(
              quantity,
              r'GMyDonationsData_myDonations_items',
              'quantity',
            ),
            categoryId: BuiltValueNullFieldError.checkNotNull(
              categoryId,
              r'GMyDonationsData_myDonations_items',
              'categoryId',
            ),
            category: _category?.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GMyDonationsData_myDonations_items',
              'status',
            ),
            urgency: BuiltValueNullFieldError.checkNotNull(
              urgency,
              r'GMyDonationsData_myDonations_items',
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
          r'GMyDonationsData_myDonations_items',
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

class _$GMyDonationsData_myDonations_items_category
    extends GMyDonationsData_myDonations_items_category {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;

  factory _$GMyDonationsData_myDonations_items_category([
    void Function(GMyDonationsData_myDonations_items_categoryBuilder)? updates,
  ]) => (GMyDonationsData_myDonations_items_categoryBuilder()..update(updates))
      ._build();

  _$GMyDonationsData_myDonations_items_category._({
    required this.G__typename,
    required this.id,
    required this.name,
  }) : super._();
  @override
  GMyDonationsData_myDonations_items_category rebuild(
    void Function(GMyDonationsData_myDonations_items_categoryBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyDonationsData_myDonations_items_categoryBuilder toBuilder() =>
      GMyDonationsData_myDonations_items_categoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyDonationsData_myDonations_items_category &&
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
            r'GMyDonationsData_myDonations_items_category',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GMyDonationsData_myDonations_items_categoryBuilder
    implements
        Builder<
          GMyDonationsData_myDonations_items_category,
          GMyDonationsData_myDonations_items_categoryBuilder
        > {
  _$GMyDonationsData_myDonations_items_category? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GMyDonationsData_myDonations_items_categoryBuilder() {
    GMyDonationsData_myDonations_items_category._initializeBuilder(this);
  }

  GMyDonationsData_myDonations_items_categoryBuilder get _$this {
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
  void replace(GMyDonationsData_myDonations_items_category other) {
    _$v = other as _$GMyDonationsData_myDonations_items_category;
  }

  @override
  void update(
    void Function(GMyDonationsData_myDonations_items_categoryBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyDonationsData_myDonations_items_category build() => _build();

  _$GMyDonationsData_myDonations_items_category _build() {
    final _$result =
        _$v ??
        _$GMyDonationsData_myDonations_items_category._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GMyDonationsData_myDonations_items_category',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GMyDonationsData_myDonations_items_category',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GMyDonationsData_myDonations_items_category',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMyDonationsData_myDonations_items_mainAttachment
    extends GMyDonationsData_myDonations_items_mainAttachment {
  @override
  final String G__typename;
  @override
  final String? url;

  factory _$GMyDonationsData_myDonations_items_mainAttachment([
    void Function(GMyDonationsData_myDonations_items_mainAttachmentBuilder)?
    updates,
  ]) =>
      (GMyDonationsData_myDonations_items_mainAttachmentBuilder()
            ..update(updates))
          ._build();

  _$GMyDonationsData_myDonations_items_mainAttachment._({
    required this.G__typename,
    this.url,
  }) : super._();
  @override
  GMyDonationsData_myDonations_items_mainAttachment rebuild(
    void Function(GMyDonationsData_myDonations_items_mainAttachmentBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyDonationsData_myDonations_items_mainAttachmentBuilder toBuilder() =>
      GMyDonationsData_myDonations_items_mainAttachmentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyDonationsData_myDonations_items_mainAttachment &&
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
            r'GMyDonationsData_myDonations_items_mainAttachment',
          )
          ..add('G__typename', G__typename)
          ..add('url', url))
        .toString();
  }
}

class GMyDonationsData_myDonations_items_mainAttachmentBuilder
    implements
        Builder<
          GMyDonationsData_myDonations_items_mainAttachment,
          GMyDonationsData_myDonations_items_mainAttachmentBuilder
        > {
  _$GMyDonationsData_myDonations_items_mainAttachment? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  GMyDonationsData_myDonations_items_mainAttachmentBuilder() {
    GMyDonationsData_myDonations_items_mainAttachment._initializeBuilder(this);
  }

  GMyDonationsData_myDonations_items_mainAttachmentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyDonationsData_myDonations_items_mainAttachment other) {
    _$v = other as _$GMyDonationsData_myDonations_items_mainAttachment;
  }

  @override
  void update(
    void Function(GMyDonationsData_myDonations_items_mainAttachmentBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyDonationsData_myDonations_items_mainAttachment build() => _build();

  _$GMyDonationsData_myDonations_items_mainAttachment _build() {
    final _$result =
        _$v ??
        _$GMyDonationsData_myDonations_items_mainAttachment._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GMyDonationsData_myDonations_items_mainAttachment',
            'G__typename',
          ),
          url: url,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMyDonationsData_myDonations_items_location
    extends GMyDonationsData_myDonations_items_location {
  @override
  final String G__typename;
  @override
  final double? latitude;
  @override
  final double? longitude;

  factory _$GMyDonationsData_myDonations_items_location([
    void Function(GMyDonationsData_myDonations_items_locationBuilder)? updates,
  ]) => (GMyDonationsData_myDonations_items_locationBuilder()..update(updates))
      ._build();

  _$GMyDonationsData_myDonations_items_location._({
    required this.G__typename,
    this.latitude,
    this.longitude,
  }) : super._();
  @override
  GMyDonationsData_myDonations_items_location rebuild(
    void Function(GMyDonationsData_myDonations_items_locationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyDonationsData_myDonations_items_locationBuilder toBuilder() =>
      GMyDonationsData_myDonations_items_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyDonationsData_myDonations_items_location &&
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
            r'GMyDonationsData_myDonations_items_location',
          )
          ..add('G__typename', G__typename)
          ..add('latitude', latitude)
          ..add('longitude', longitude))
        .toString();
  }
}

class GMyDonationsData_myDonations_items_locationBuilder
    implements
        Builder<
          GMyDonationsData_myDonations_items_location,
          GMyDonationsData_myDonations_items_locationBuilder
        > {
  _$GMyDonationsData_myDonations_items_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  GMyDonationsData_myDonations_items_locationBuilder() {
    GMyDonationsData_myDonations_items_location._initializeBuilder(this);
  }

  GMyDonationsData_myDonations_items_locationBuilder get _$this {
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
  void replace(GMyDonationsData_myDonations_items_location other) {
    _$v = other as _$GMyDonationsData_myDonations_items_location;
  }

  @override
  void update(
    void Function(GMyDonationsData_myDonations_items_locationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyDonationsData_myDonations_items_location build() => _build();

  _$GMyDonationsData_myDonations_items_location _build() {
    final _$result =
        _$v ??
        _$GMyDonationsData_myDonations_items_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GMyDonationsData_myDonations_items_location',
            'G__typename',
          ),
          latitude: latitude,
          longitude: longitude,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GMyDonationsData_myDonations_items_user
    extends GMyDonationsData_myDonations_items_user {
  @override
  final String G__typename;
  @override
  final String? displayName;
  @override
  final String email;

  factory _$GMyDonationsData_myDonations_items_user([
    void Function(GMyDonationsData_myDonations_items_userBuilder)? updates,
  ]) => (GMyDonationsData_myDonations_items_userBuilder()..update(updates))
      ._build();

  _$GMyDonationsData_myDonations_items_user._({
    required this.G__typename,
    this.displayName,
    required this.email,
  }) : super._();
  @override
  GMyDonationsData_myDonations_items_user rebuild(
    void Function(GMyDonationsData_myDonations_items_userBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyDonationsData_myDonations_items_userBuilder toBuilder() =>
      GMyDonationsData_myDonations_items_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyDonationsData_myDonations_items_user &&
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
            r'GMyDonationsData_myDonations_items_user',
          )
          ..add('G__typename', G__typename)
          ..add('displayName', displayName)
          ..add('email', email))
        .toString();
  }
}

class GMyDonationsData_myDonations_items_userBuilder
    implements
        Builder<
          GMyDonationsData_myDonations_items_user,
          GMyDonationsData_myDonations_items_userBuilder
        > {
  _$GMyDonationsData_myDonations_items_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GMyDonationsData_myDonations_items_userBuilder() {
    GMyDonationsData_myDonations_items_user._initializeBuilder(this);
  }

  GMyDonationsData_myDonations_items_userBuilder get _$this {
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
  void replace(GMyDonationsData_myDonations_items_user other) {
    _$v = other as _$GMyDonationsData_myDonations_items_user;
  }

  @override
  void update(
    void Function(GMyDonationsData_myDonations_items_userBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyDonationsData_myDonations_items_user build() => _build();

  _$GMyDonationsData_myDonations_items_user _build() {
    final _$result =
        _$v ??
        _$GMyDonationsData_myDonations_items_user._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GMyDonationsData_myDonations_items_user',
            'G__typename',
          ),
          displayName: displayName,
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'GMyDonationsData_myDonations_items_user',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
