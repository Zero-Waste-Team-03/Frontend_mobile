// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_messages.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetConversationMessagesData>
_$gGetConversationMessagesDataSerializer =
    _$GGetConversationMessagesDataSerializer();
Serializer<GGetConversationMessagesData_conversationMessages>
_$gGetConversationMessagesDataConversationMessagesSerializer =
    _$GGetConversationMessagesData_conversationMessagesSerializer();
Serializer<GGetConversationMessagesData_conversationMessages_items>
_$gGetConversationMessagesDataConversationMessagesItemsSerializer =
    _$GGetConversationMessagesData_conversationMessages_itemsSerializer();

class _$GGetConversationMessagesDataSerializer
    implements StructuredSerializer<GGetConversationMessagesData> {
  @override
  final Iterable<Type> types = const [
    GGetConversationMessagesData,
    _$GGetConversationMessagesData,
  ];
  @override
  final String wireName = 'GGetConversationMessagesData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetConversationMessagesData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'conversationMessages',
      serializers.serialize(
        object.conversationMessages,
        specifiedType: const FullType(
          GGetConversationMessagesData_conversationMessages,
        ),
      ),
    ];

    return result;
  }

  @override
  GGetConversationMessagesData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetConversationMessagesDataBuilder();

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
        case 'conversationMessages':
          result.conversationMessages.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetConversationMessagesData_conversationMessages,
                  ),
                )!
                as GGetConversationMessagesData_conversationMessages,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetConversationMessagesData_conversationMessagesSerializer
    implements
        StructuredSerializer<
          GGetConversationMessagesData_conversationMessages
        > {
  @override
  final Iterable<Type> types = const [
    GGetConversationMessagesData_conversationMessages,
    _$GGetConversationMessagesData_conversationMessages,
  ];
  @override
  final String wireName = 'GGetConversationMessagesData_conversationMessages';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetConversationMessagesData_conversationMessages object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
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
      'items',
      serializers.serialize(
        object.items,
        specifiedType: const FullType(BuiltList, const [
          const FullType(
            GGetConversationMessagesData_conversationMessages_items,
          ),
        ]),
      ),
    ];

    return result;
  }

  @override
  GGetConversationMessagesData_conversationMessages deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetConversationMessagesData_conversationMessagesBuilder();

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
        case 'items':
          result.items.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(
                      GGetConversationMessagesData_conversationMessages_items,
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

class _$GGetConversationMessagesData_conversationMessages_itemsSerializer
    implements
        StructuredSerializer<
          GGetConversationMessagesData_conversationMessages_items
        > {
  @override
  final Iterable<Type> types = const [
    GGetConversationMessagesData_conversationMessages_items,
    _$GGetConversationMessagesData_conversationMessages_items,
  ];
  @override
  final String wireName =
      'GGetConversationMessagesData_conversationMessages_items';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetConversationMessagesData_conversationMessages_items object, {
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
      'content',
      serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'isModerated',
      serializers.serialize(
        object.isModerated,
        specifiedType: const FullType(bool),
      ),
      'senderId',
      serializers.serialize(
        object.senderId,
        specifiedType: const FullType(String),
      ),
      'conversationId',
      serializers.serialize(
        object.conversationId,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GGetConversationMessagesData_conversationMessages_items deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GGetConversationMessagesData_conversationMessages_itemsBuilder();

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
        case 'content':
          result.content =
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
        case 'isModerated':
          result.isModerated =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'senderId':
          result.senderId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'conversationId':
          result.conversationId =
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

class _$GGetConversationMessagesData extends GGetConversationMessagesData {
  @override
  final String G__typename;
  @override
  final GGetConversationMessagesData_conversationMessages conversationMessages;

  factory _$GGetConversationMessagesData([
    void Function(GGetConversationMessagesDataBuilder)? updates,
  ]) => (GGetConversationMessagesDataBuilder()..update(updates))._build();

  _$GGetConversationMessagesData._({
    required this.G__typename,
    required this.conversationMessages,
  }) : super._();
  @override
  GGetConversationMessagesData rebuild(
    void Function(GGetConversationMessagesDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetConversationMessagesDataBuilder toBuilder() =>
      GGetConversationMessagesDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetConversationMessagesData &&
        G__typename == other.G__typename &&
        conversationMessages == other.conversationMessages;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, conversationMessages.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetConversationMessagesData')
          ..add('G__typename', G__typename)
          ..add('conversationMessages', conversationMessages))
        .toString();
  }
}

class GGetConversationMessagesDataBuilder
    implements
        Builder<
          GGetConversationMessagesData,
          GGetConversationMessagesDataBuilder
        > {
  _$GGetConversationMessagesData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetConversationMessagesData_conversationMessagesBuilder?
  _conversationMessages;
  GGetConversationMessagesData_conversationMessagesBuilder
  get conversationMessages => _$this._conversationMessages ??=
      GGetConversationMessagesData_conversationMessagesBuilder();
  set conversationMessages(
    GGetConversationMessagesData_conversationMessagesBuilder?
    conversationMessages,
  ) => _$this._conversationMessages = conversationMessages;

  GGetConversationMessagesDataBuilder() {
    GGetConversationMessagesData._initializeBuilder(this);
  }

  GGetConversationMessagesDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _conversationMessages = $v.conversationMessages.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetConversationMessagesData other) {
    _$v = other as _$GGetConversationMessagesData;
  }

  @override
  void update(void Function(GGetConversationMessagesDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetConversationMessagesData build() => _build();

  _$GGetConversationMessagesData _build() {
    _$GGetConversationMessagesData _$result;
    try {
      _$result =
          _$v ??
          _$GGetConversationMessagesData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetConversationMessagesData',
              'G__typename',
            ),
            conversationMessages: conversationMessages.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'conversationMessages';
        conversationMessages.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetConversationMessagesData',
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

class _$GGetConversationMessagesData_conversationMessages
    extends GGetConversationMessagesData_conversationMessages {
  @override
  final String G__typename;
  @override
  final int totalCount;
  @override
  final int page;
  @override
  final int limit;
  @override
  final bool hasNextPage;
  @override
  final bool hasPreviousPage;
  @override
  final BuiltList<GGetConversationMessagesData_conversationMessages_items>
  items;

  factory _$GGetConversationMessagesData_conversationMessages([
    void Function(GGetConversationMessagesData_conversationMessagesBuilder)?
    updates,
  ]) =>
      (GGetConversationMessagesData_conversationMessagesBuilder()
            ..update(updates))
          ._build();

  _$GGetConversationMessagesData_conversationMessages._({
    required this.G__typename,
    required this.totalCount,
    required this.page,
    required this.limit,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.items,
  }) : super._();
  @override
  GGetConversationMessagesData_conversationMessages rebuild(
    void Function(GGetConversationMessagesData_conversationMessagesBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetConversationMessagesData_conversationMessagesBuilder toBuilder() =>
      GGetConversationMessagesData_conversationMessagesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetConversationMessagesData_conversationMessages &&
        G__typename == other.G__typename &&
        totalCount == other.totalCount &&
        page == other.page &&
        limit == other.limit &&
        hasNextPage == other.hasNextPage &&
        hasPreviousPage == other.hasPreviousPage &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, totalCount.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, hasNextPage.hashCode);
    _$hash = $jc(_$hash, hasPreviousPage.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetConversationMessagesData_conversationMessages',
          )
          ..add('G__typename', G__typename)
          ..add('totalCount', totalCount)
          ..add('page', page)
          ..add('limit', limit)
          ..add('hasNextPage', hasNextPage)
          ..add('hasPreviousPage', hasPreviousPage)
          ..add('items', items))
        .toString();
  }
}

class GGetConversationMessagesData_conversationMessagesBuilder
    implements
        Builder<
          GGetConversationMessagesData_conversationMessages,
          GGetConversationMessagesData_conversationMessagesBuilder
        > {
  _$GGetConversationMessagesData_conversationMessages? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  int? _totalCount;
  int? get totalCount => _$this._totalCount;
  set totalCount(int? totalCount) => _$this._totalCount = totalCount;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  bool? _hasNextPage;
  bool? get hasNextPage => _$this._hasNextPage;
  set hasNextPage(bool? hasNextPage) => _$this._hasNextPage = hasNextPage;

  bool? _hasPreviousPage;
  bool? get hasPreviousPage => _$this._hasPreviousPage;
  set hasPreviousPage(bool? hasPreviousPage) =>
      _$this._hasPreviousPage = hasPreviousPage;

  ListBuilder<GGetConversationMessagesData_conversationMessages_items>? _items;
  ListBuilder<GGetConversationMessagesData_conversationMessages_items>
  get items => _$this._items ??=
      ListBuilder<GGetConversationMessagesData_conversationMessages_items>();
  set items(
    ListBuilder<GGetConversationMessagesData_conversationMessages_items>? items,
  ) => _$this._items = items;

  GGetConversationMessagesData_conversationMessagesBuilder() {
    GGetConversationMessagesData_conversationMessages._initializeBuilder(this);
  }

  GGetConversationMessagesData_conversationMessagesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _totalCount = $v.totalCount;
      _page = $v.page;
      _limit = $v.limit;
      _hasNextPage = $v.hasNextPage;
      _hasPreviousPage = $v.hasPreviousPage;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetConversationMessagesData_conversationMessages other) {
    _$v = other as _$GGetConversationMessagesData_conversationMessages;
  }

  @override
  void update(
    void Function(GGetConversationMessagesData_conversationMessagesBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetConversationMessagesData_conversationMessages build() => _build();

  _$GGetConversationMessagesData_conversationMessages _build() {
    _$GGetConversationMessagesData_conversationMessages _$result;
    try {
      _$result =
          _$v ??
          _$GGetConversationMessagesData_conversationMessages._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetConversationMessagesData_conversationMessages',
              'G__typename',
            ),
            totalCount: BuiltValueNullFieldError.checkNotNull(
              totalCount,
              r'GGetConversationMessagesData_conversationMessages',
              'totalCount',
            ),
            page: BuiltValueNullFieldError.checkNotNull(
              page,
              r'GGetConversationMessagesData_conversationMessages',
              'page',
            ),
            limit: BuiltValueNullFieldError.checkNotNull(
              limit,
              r'GGetConversationMessagesData_conversationMessages',
              'limit',
            ),
            hasNextPage: BuiltValueNullFieldError.checkNotNull(
              hasNextPage,
              r'GGetConversationMessagesData_conversationMessages',
              'hasNextPage',
            ),
            hasPreviousPage: BuiltValueNullFieldError.checkNotNull(
              hasPreviousPage,
              r'GGetConversationMessagesData_conversationMessages',
              'hasPreviousPage',
            ),
            items: items.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetConversationMessagesData_conversationMessages',
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

class _$GGetConversationMessagesData_conversationMessages_items
    extends GGetConversationMessagesData_conversationMessages_items {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String content;
  @override
  final _i2.GDateTime createdAt;
  @override
  final bool isModerated;
  @override
  final String senderId;
  @override
  final String conversationId;

  factory _$GGetConversationMessagesData_conversationMessages_items([
    void Function(
      GGetConversationMessagesData_conversationMessages_itemsBuilder,
    )?
    updates,
  ]) =>
      (GGetConversationMessagesData_conversationMessages_itemsBuilder()
            ..update(updates))
          ._build();

  _$GGetConversationMessagesData_conversationMessages_items._({
    required this.G__typename,
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isModerated,
    required this.senderId,
    required this.conversationId,
  }) : super._();
  @override
  GGetConversationMessagesData_conversationMessages_items rebuild(
    void Function(
      GGetConversationMessagesData_conversationMessages_itemsBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetConversationMessagesData_conversationMessages_itemsBuilder toBuilder() =>
      GGetConversationMessagesData_conversationMessages_itemsBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetConversationMessagesData_conversationMessages_items &&
        G__typename == other.G__typename &&
        id == other.id &&
        content == other.content &&
        createdAt == other.createdAt &&
        isModerated == other.isModerated &&
        senderId == other.senderId &&
        conversationId == other.conversationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, isModerated.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, conversationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetConversationMessagesData_conversationMessages_items',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('isModerated', isModerated)
          ..add('senderId', senderId)
          ..add('conversationId', conversationId))
        .toString();
  }
}

class GGetConversationMessagesData_conversationMessages_itemsBuilder
    implements
        Builder<
          GGetConversationMessagesData_conversationMessages_items,
          GGetConversationMessagesData_conversationMessages_itemsBuilder
        > {
  _$GGetConversationMessagesData_conversationMessages_items? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  bool? _isModerated;
  bool? get isModerated => _$this._isModerated;
  set isModerated(bool? isModerated) => _$this._isModerated = isModerated;

  String? _senderId;
  String? get senderId => _$this._senderId;
  set senderId(String? senderId) => _$this._senderId = senderId;

  String? _conversationId;
  String? get conversationId => _$this._conversationId;
  set conversationId(String? conversationId) =>
      _$this._conversationId = conversationId;

  GGetConversationMessagesData_conversationMessages_itemsBuilder() {
    GGetConversationMessagesData_conversationMessages_items._initializeBuilder(
      this,
    );
  }

  GGetConversationMessagesData_conversationMessages_itemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _content = $v.content;
      _createdAt = $v.createdAt.toBuilder();
      _isModerated = $v.isModerated;
      _senderId = $v.senderId;
      _conversationId = $v.conversationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetConversationMessagesData_conversationMessages_items other) {
    _$v = other as _$GGetConversationMessagesData_conversationMessages_items;
  }

  @override
  void update(
    void Function(
      GGetConversationMessagesData_conversationMessages_itemsBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetConversationMessagesData_conversationMessages_items build() => _build();

  _$GGetConversationMessagesData_conversationMessages_items _build() {
    _$GGetConversationMessagesData_conversationMessages_items _$result;
    try {
      _$result =
          _$v ??
          _$GGetConversationMessagesData_conversationMessages_items._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetConversationMessagesData_conversationMessages_items',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GGetConversationMessagesData_conversationMessages_items',
              'id',
            ),
            content: BuiltValueNullFieldError.checkNotNull(
              content,
              r'GGetConversationMessagesData_conversationMessages_items',
              'content',
            ),
            createdAt: createdAt.build(),
            isModerated: BuiltValueNullFieldError.checkNotNull(
              isModerated,
              r'GGetConversationMessagesData_conversationMessages_items',
              'isModerated',
            ),
            senderId: BuiltValueNullFieldError.checkNotNull(
              senderId,
              r'GGetConversationMessagesData_conversationMessages_items',
              'senderId',
            ),
            conversationId: BuiltValueNullFieldError.checkNotNull(
              conversationId,
              r'GGetConversationMessagesData_conversationMessages_items',
              'conversationId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetConversationMessagesData_conversationMessages_items',
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
