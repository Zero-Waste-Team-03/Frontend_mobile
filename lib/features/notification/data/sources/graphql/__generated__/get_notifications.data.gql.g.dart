// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notifications.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetNotificationsData> _$gGetNotificationsDataSerializer =
    _$GGetNotificationsDataSerializer();
Serializer<GGetNotificationsData_getNotifications>
_$gGetNotificationsDataGetNotificationsSerializer =
    _$GGetNotificationsData_getNotificationsSerializer();
Serializer<GGetNotificationsData_getNotifications_items>
_$gGetNotificationsDataGetNotificationsItemsSerializer =
    _$GGetNotificationsData_getNotifications_itemsSerializer();

class _$GGetNotificationsDataSerializer
    implements StructuredSerializer<GGetNotificationsData> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsData,
    _$GGetNotificationsData,
  ];
  @override
  final String wireName = 'GGetNotificationsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetNotificationsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'getNotifications',
      serializers.serialize(
        object.getNotifications,
        specifiedType: const FullType(GGetNotificationsData_getNotifications),
      ),
    ];

    return result;
  }

  @override
  GGetNotificationsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetNotificationsDataBuilder();

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
        case 'getNotifications':
          result.getNotifications.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetNotificationsData_getNotifications,
                  ),
                )!
                as GGetNotificationsData_getNotifications,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetNotificationsData_getNotificationsSerializer
    implements StructuredSerializer<GGetNotificationsData_getNotifications> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsData_getNotifications,
    _$GGetNotificationsData_getNotifications,
  ];
  @override
  final String wireName = 'GGetNotificationsData_getNotifications';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetNotificationsData_getNotifications object, {
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
              const FullType(GGetNotificationsData_getNotifications_items),
            ]),
          ),
        );
    }
    return result;
  }

  @override
  GGetNotificationsData_getNotifications deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetNotificationsData_getNotificationsBuilder();

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
                    const FullType(
                      GGetNotificationsData_getNotifications_items,
                    ),
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

class _$GGetNotificationsData_getNotifications_itemsSerializer
    implements
        StructuredSerializer<GGetNotificationsData_getNotifications_items> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsData_getNotifications_items,
    _$GGetNotificationsData_getNotifications_items,
  ];
  @override
  final String wireName = 'GGetNotificationsData_getNotifications_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetNotificationsData_getNotifications_items object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'isRead',
      serializers.serialize(object.isRead, specifiedType: const FullType(bool)),
      'receiverId',
      serializers.serialize(
        object.receiverId,
        specifiedType: const FullType(String),
      ),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
    ];

    return result;
  }

  @override
  GGetNotificationsData_getNotifications_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetNotificationsData_getNotifications_itemsBuilder();

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
        case 'body':
          result.body =
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
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'isRead':
          result.isRead =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'receiverId':
          result.receiverId =
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
        case 'type':
          result.type =
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
      }
    }

    return result.build();
  }
}

class _$GGetNotificationsData extends GGetNotificationsData {
  @override
  final String G__typename;
  @override
  final GGetNotificationsData_getNotifications getNotifications;

  factory _$GGetNotificationsData([
    void Function(GGetNotificationsDataBuilder)? updates,
  ]) => (GGetNotificationsDataBuilder()..update(updates))._build();

  _$GGetNotificationsData._({
    required this.G__typename,
    required this.getNotifications,
  }) : super._();
  @override
  GGetNotificationsData rebuild(
    void Function(GGetNotificationsDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsDataBuilder toBuilder() =>
      GGetNotificationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsData &&
        G__typename == other.G__typename &&
        getNotifications == other.getNotifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getNotifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetNotificationsData')
          ..add('G__typename', G__typename)
          ..add('getNotifications', getNotifications))
        .toString();
  }
}

class GGetNotificationsDataBuilder
    implements Builder<GGetNotificationsData, GGetNotificationsDataBuilder> {
  _$GGetNotificationsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetNotificationsData_getNotificationsBuilder? _getNotifications;
  GGetNotificationsData_getNotificationsBuilder get getNotifications =>
      _$this._getNotifications ??=
          GGetNotificationsData_getNotificationsBuilder();
  set getNotifications(
    GGetNotificationsData_getNotificationsBuilder? getNotifications,
  ) => _$this._getNotifications = getNotifications;

  GGetNotificationsDataBuilder() {
    GGetNotificationsData._initializeBuilder(this);
  }

  GGetNotificationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getNotifications = $v.getNotifications.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetNotificationsData other) {
    _$v = other as _$GGetNotificationsData;
  }

  @override
  void update(void Function(GGetNotificationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsData build() => _build();

  _$GGetNotificationsData _build() {
    _$GGetNotificationsData _$result;
    try {
      _$result =
          _$v ??
          _$GGetNotificationsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetNotificationsData',
              'G__typename',
            ),
            getNotifications: getNotifications.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getNotifications';
        getNotifications.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetNotificationsData',
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

class _$GGetNotificationsData_getNotifications
    extends GGetNotificationsData_getNotifications {
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
  final BuiltList<GGetNotificationsData_getNotifications_items>? items;

  factory _$GGetNotificationsData_getNotifications([
    void Function(GGetNotificationsData_getNotificationsBuilder)? updates,
  ]) => (GGetNotificationsData_getNotificationsBuilder()..update(updates))
      ._build();

  _$GGetNotificationsData_getNotifications._({
    required this.G__typename,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.limit,
    required this.page,
    required this.totalCount,
    this.items,
  }) : super._();
  @override
  GGetNotificationsData_getNotifications rebuild(
    void Function(GGetNotificationsData_getNotificationsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsData_getNotificationsBuilder toBuilder() =>
      GGetNotificationsData_getNotificationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsData_getNotifications &&
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
    return (newBuiltValueToStringHelper(
            r'GGetNotificationsData_getNotifications',
          )
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

class GGetNotificationsData_getNotificationsBuilder
    implements
        Builder<
          GGetNotificationsData_getNotifications,
          GGetNotificationsData_getNotificationsBuilder
        > {
  _$GGetNotificationsData_getNotifications? _$v;

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

  ListBuilder<GGetNotificationsData_getNotifications_items>? _items;
  ListBuilder<GGetNotificationsData_getNotifications_items> get items =>
      _$this._items ??=
          ListBuilder<GGetNotificationsData_getNotifications_items>();
  set items(ListBuilder<GGetNotificationsData_getNotifications_items>? items) =>
      _$this._items = items;

  GGetNotificationsData_getNotificationsBuilder() {
    GGetNotificationsData_getNotifications._initializeBuilder(this);
  }

  GGetNotificationsData_getNotificationsBuilder get _$this {
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
  void replace(GGetNotificationsData_getNotifications other) {
    _$v = other as _$GGetNotificationsData_getNotifications;
  }

  @override
  void update(
    void Function(GGetNotificationsData_getNotificationsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsData_getNotifications build() => _build();

  _$GGetNotificationsData_getNotifications _build() {
    _$GGetNotificationsData_getNotifications _$result;
    try {
      _$result =
          _$v ??
          _$GGetNotificationsData_getNotifications._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetNotificationsData_getNotifications',
              'G__typename',
            ),
            hasNextPage: BuiltValueNullFieldError.checkNotNull(
              hasNextPage,
              r'GGetNotificationsData_getNotifications',
              'hasNextPage',
            ),
            hasPreviousPage: BuiltValueNullFieldError.checkNotNull(
              hasPreviousPage,
              r'GGetNotificationsData_getNotifications',
              'hasPreviousPage',
            ),
            limit: BuiltValueNullFieldError.checkNotNull(
              limit,
              r'GGetNotificationsData_getNotifications',
              'limit',
            ),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'GGetNotificationsData_getNotifications',
              'page',
            ),
            totalCount: BuiltValueNullFieldError.checkNotNull(
              totalCount,
              r'GGetNotificationsData_getNotifications',
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
          r'GGetNotificationsData_getNotifications',
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

class _$GGetNotificationsData_getNotifications_items
    extends GGetNotificationsData_getNotifications_items {
  @override
  final String G__typename;
  @override
  final String body;
  @override
  final _i2.GDateTime createdAt;
  @override
  final String id;
  @override
  final bool isRead;
  @override
  final String receiverId;
  @override
  final String title;
  @override
  final String type;
  @override
  final _i2.GDateTime updatedAt;

  factory _$GGetNotificationsData_getNotifications_items([
    void Function(GGetNotificationsData_getNotifications_itemsBuilder)? updates,
  ]) => (GGetNotificationsData_getNotifications_itemsBuilder()..update(updates))
      ._build();

  _$GGetNotificationsData_getNotifications_items._({
    required this.G__typename,
    required this.body,
    required this.createdAt,
    required this.id,
    required this.isRead,
    required this.receiverId,
    required this.title,
    required this.type,
    required this.updatedAt,
  }) : super._();
  @override
  GGetNotificationsData_getNotifications_items rebuild(
    void Function(GGetNotificationsData_getNotifications_itemsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsData_getNotifications_itemsBuilder toBuilder() =>
      GGetNotificationsData_getNotifications_itemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsData_getNotifications_items &&
        G__typename == other.G__typename &&
        body == other.body &&
        createdAt == other.createdAt &&
        id == other.id &&
        isRead == other.isRead &&
        receiverId == other.receiverId &&
        title == other.title &&
        type == other.type &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetNotificationsData_getNotifications_items',
          )
          ..add('G__typename', G__typename)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('id', id)
          ..add('isRead', isRead)
          ..add('receiverId', receiverId)
          ..add('title', title)
          ..add('type', type)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GGetNotificationsData_getNotifications_itemsBuilder
    implements
        Builder<
          GGetNotificationsData_getNotifications_items,
          GGetNotificationsData_getNotifications_itemsBuilder
        > {
  _$GGetNotificationsData_getNotifications_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  String? _receiverId;
  String? get receiverId => _$this._receiverId;
  set receiverId(String? receiverId) => _$this._receiverId = receiverId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  _i2.GDateTimeBuilder? _updatedAt;
  _i2.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i2.GDateTimeBuilder();
  set updatedAt(_i2.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  GGetNotificationsData_getNotifications_itemsBuilder() {
    GGetNotificationsData_getNotifications_items._initializeBuilder(this);
  }

  GGetNotificationsData_getNotifications_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _id = $v.id;
      _isRead = $v.isRead;
      _receiverId = $v.receiverId;
      _title = $v.title;
      _type = $v.type;
      _updatedAt = $v.updatedAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetNotificationsData_getNotifications_items other) {
    _$v = other as _$GGetNotificationsData_getNotifications_items;
  }

  @override
  void update(
    void Function(GGetNotificationsData_getNotifications_itemsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsData_getNotifications_items build() => _build();

  _$GGetNotificationsData_getNotifications_items _build() {
    _$GGetNotificationsData_getNotifications_items _$result;
    try {
      _$result =
          _$v ??
          _$GGetNotificationsData_getNotifications_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetNotificationsData_getNotifications_items',
              'G__typename',
            ),
            body: BuiltValueNullFieldError.checkNotNull(
              body,
              r'GGetNotificationsData_getNotifications_items',
              'body',
            ),
            createdAt: createdAt.build(),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GGetNotificationsData_getNotifications_items',
              'id',
            ),
            isRead: BuiltValueNullFieldError.checkNotNull(
              isRead,
              r'GGetNotificationsData_getNotifications_items',
              'isRead',
            ),
            receiverId: BuiltValueNullFieldError.checkNotNull(
              receiverId,
              r'GGetNotificationsData_getNotifications_items',
              'receiverId',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GGetNotificationsData_getNotifications_items',
              'title',
            ),
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'GGetNotificationsData_getNotifications_items',
              'type',
            ),
            updatedAt: updatedAt.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();

        _$failedField = 'updatedAt';
        updatedAt.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetNotificationsData_getNotifications_items',
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
