// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetCategoriesData> _$gGetCategoriesDataSerializer =
    _$GGetCategoriesDataSerializer();
Serializer<GGetCategoriesData_categories>
_$gGetCategoriesDataCategoriesSerializer =
    _$GGetCategoriesData_categoriesSerializer();
Serializer<GGetCategoriesData_categories_items>
_$gGetCategoriesDataCategoriesItemsSerializer =
    _$GGetCategoriesData_categories_itemsSerializer();

class _$GGetCategoriesDataSerializer
    implements StructuredSerializer<GGetCategoriesData> {
  @override
  final Iterable<Type> types = const [GGetCategoriesData, _$GGetCategoriesData];
  @override
  final String wireName = 'GGetCategoriesData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetCategoriesData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'categories',
      serializers.serialize(
        object.categories,
        specifiedType: const FullType(GGetCategoriesData_categories),
      ),
    ];

    return result;
  }

  @override
  GGetCategoriesData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetCategoriesDataBuilder();

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
        case 'categories':
          result.categories.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GGetCategoriesData_categories),
                )!
                as GGetCategoriesData_categories,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetCategoriesData_categoriesSerializer
    implements StructuredSerializer<GGetCategoriesData_categories> {
  @override
  final Iterable<Type> types = const [
    GGetCategoriesData_categories,
    _$GGetCategoriesData_categories,
  ];
  @override
  final String wireName = 'GGetCategoriesData_categories';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetCategoriesData_categories object, {
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
              const FullType(GGetCategoriesData_categories_items),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  GGetCategoriesData_categories deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetCategoriesData_categoriesBuilder();

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
                    const FullType(GGetCategoriesData_categories_items),
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

class _$GGetCategoriesData_categories_itemsSerializer
    implements StructuredSerializer<GGetCategoriesData_categories_items> {
  @override
  final Iterable<Type> types = const [
    GGetCategoriesData_categories_items,
    _$GGetCategoriesData_categories_items,
  ];
  @override
  final String wireName = 'GGetCategoriesData_categories_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetCategoriesData_categories_items object, {
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
  GGetCategoriesData_categories_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetCategoriesData_categories_itemsBuilder();

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

class _$GGetCategoriesData extends GGetCategoriesData {
  @override
  final String G__typename;
  @override
  final GGetCategoriesData_categories categories;

  factory _$GGetCategoriesData([
    void Function(GGetCategoriesDataBuilder)? updates,
  ]) => (GGetCategoriesDataBuilder()..update(updates))._build();

  _$GGetCategoriesData._({required this.G__typename, required this.categories})
    : super._();
  @override
  GGetCategoriesData rebuild(
    void Function(GGetCategoriesDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetCategoriesDataBuilder toBuilder() =>
      GGetCategoriesDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetCategoriesData &&
        G__typename == other.G__typename &&
        categories == other.categories;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, categories.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetCategoriesData')
          ..add('G__typename', G__typename)
          ..add('categories', categories))
        .toString();
  }
}

class GGetCategoriesDataBuilder
    implements Builder<GGetCategoriesData, GGetCategoriesDataBuilder> {
  _$GGetCategoriesData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetCategoriesData_categoriesBuilder? _categories;
  GGetCategoriesData_categoriesBuilder get categories =>
      _$this._categories ??= GGetCategoriesData_categoriesBuilder();
  set categories(GGetCategoriesData_categoriesBuilder? categories) =>
      _$this._categories = categories;

  GGetCategoriesDataBuilder() {
    GGetCategoriesData._initializeBuilder(this);
  }

  GGetCategoriesDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _categories = $v.categories.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetCategoriesData other) {
    _$v = other as _$GGetCategoriesData;
  }

  @override
  void update(void Function(GGetCategoriesDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetCategoriesData build() => _build();

  _$GGetCategoriesData _build() {
    _$GGetCategoriesData _$result;
    try {
      _$result =
          _$v ??
          _$GGetCategoriesData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetCategoriesData',
              'G__typename',
            ),
            categories: categories.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'categories';
        categories.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetCategoriesData',
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

class _$GGetCategoriesData_categories extends GGetCategoriesData_categories {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetCategoriesData_categories_items>? items;

  factory _$GGetCategoriesData_categories([
    void Function(GGetCategoriesData_categoriesBuilder)? updates,
  ]) => (GGetCategoriesData_categoriesBuilder()..update(updates))._build();

  _$GGetCategoriesData_categories._({required this.G__typename, this.items})
    : super._();
  @override
  GGetCategoriesData_categories rebuild(
    void Function(GGetCategoriesData_categoriesBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetCategoriesData_categoriesBuilder toBuilder() =>
      GGetCategoriesData_categoriesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetCategoriesData_categories &&
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
    return (newBuiltValueToStringHelper(r'GGetCategoriesData_categories')
          ..add('G__typename', G__typename)
          ..add('items', items))
        .toString();
  }
}

class GGetCategoriesData_categoriesBuilder
    implements
        Builder<
          GGetCategoriesData_categories,
          GGetCategoriesData_categoriesBuilder
        > {
  _$GGetCategoriesData_categories? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GGetCategoriesData_categories_items>? _items;
  ListBuilder<GGetCategoriesData_categories_items> get items =>
      _$this._items ??= ListBuilder<GGetCategoriesData_categories_items>();
  set items(ListBuilder<GGetCategoriesData_categories_items>? items) =>
      _$this._items = items;

  GGetCategoriesData_categoriesBuilder() {
    GGetCategoriesData_categories._initializeBuilder(this);
  }

  GGetCategoriesData_categoriesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetCategoriesData_categories other) {
    _$v = other as _$GGetCategoriesData_categories;
  }

  @override
  void update(void Function(GGetCategoriesData_categoriesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetCategoriesData_categories build() => _build();

  _$GGetCategoriesData_categories _build() {
    _$GGetCategoriesData_categories _$result;
    try {
      _$result =
          _$v ??
          _$GGetCategoriesData_categories._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetCategoriesData_categories',
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
          r'GGetCategoriesData_categories',
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

class _$GGetCategoriesData_categories_items
    extends GGetCategoriesData_categories_items {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String name;

  factory _$GGetCategoriesData_categories_items([
    void Function(GGetCategoriesData_categories_itemsBuilder)? updates,
  ]) =>
      (GGetCategoriesData_categories_itemsBuilder()..update(updates))._build();

  _$GGetCategoriesData_categories_items._({
    required this.G__typename,
    required this.id,
    required this.name,
  }) : super._();
  @override
  GGetCategoriesData_categories_items rebuild(
    void Function(GGetCategoriesData_categories_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetCategoriesData_categories_itemsBuilder toBuilder() =>
      GGetCategoriesData_categories_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetCategoriesData_categories_items &&
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
    return (newBuiltValueToStringHelper(r'GGetCategoriesData_categories_items')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('name', name))
        .toString();
  }
}

class GGetCategoriesData_categories_itemsBuilder
    implements
        Builder<
          GGetCategoriesData_categories_items,
          GGetCategoriesData_categories_itemsBuilder
        > {
  _$GGetCategoriesData_categories_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  GGetCategoriesData_categories_itemsBuilder() {
    GGetCategoriesData_categories_items._initializeBuilder(this);
  }

  GGetCategoriesData_categories_itemsBuilder get _$this {
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
  void replace(GGetCategoriesData_categories_items other) {
    _$v = other as _$GGetCategoriesData_categories_items;
  }

  @override
  void update(
    void Function(GGetCategoriesData_categories_itemsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetCategoriesData_categories_items build() => _build();

  _$GGetCategoriesData_categories_items _build() {
    final _$result =
        _$v ??
        _$GGetCategoriesData_categories_items._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetCategoriesData_categories_items',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GGetCategoriesData_categories_items',
            'id',
          ),
          name: BuiltValueNullFieldError.checkNotNull(
            name,
            r'GGetCategoriesData_categories_items',
            'name',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
