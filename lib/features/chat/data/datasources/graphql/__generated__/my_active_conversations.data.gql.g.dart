// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_active_conversations.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyActiveConversationsData> _$gMyActiveConversationsDataSerializer =
    _$GMyActiveConversationsDataSerializer();
Serializer<GMyActiveConversationsData_myActiveConversations>
_$gMyActiveConversationsDataMyActiveConversationsSerializer =
    _$GMyActiveConversationsData_myActiveConversationsSerializer();
Serializer<GMyActiveConversationsData_myActiveConversations_counterpart>
_$gMyActiveConversationsDataMyActiveConversationsCounterpartSerializer =
    _$GMyActiveConversationsData_myActiveConversations_counterpartSerializer();

class _$GMyActiveConversationsDataSerializer
    implements StructuredSerializer<GMyActiveConversationsData> {
  @override
  final Iterable<Type> types = const [
    GMyActiveConversationsData,
    _$GMyActiveConversationsData,
  ];
  @override
  final String wireName = 'GMyActiveConversationsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyActiveConversationsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'myActiveConversations',
      serializers.serialize(
        object.myActiveConversations,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GMyActiveConversationsData_myActiveConversations),
        ]),
      ),
    ];

    return result;
  }

  @override
  GMyActiveConversationsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyActiveConversationsDataBuilder();

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
        case 'myActiveConversations':
          result.myActiveConversations.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(
                      GMyActiveConversationsData_myActiveConversations,
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

class _$GMyActiveConversationsData_myActiveConversationsSerializer
    implements
        StructuredSerializer<GMyActiveConversationsData_myActiveConversations> {
  @override
  final Iterable<Type> types = const [
    GMyActiveConversationsData_myActiveConversations,
    _$GMyActiveConversationsData_myActiveConversations,
  ];
  @override
  final String wireName = 'GMyActiveConversationsData_myActiveConversations';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyActiveConversationsData_myActiveConversations object, {
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
      'reservationId',
      serializers.serialize(
        object.reservationId,
        specifiedType: const FullType(String),
      ),
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i2.GConversationStatus),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'counterpart',
      serializers.serialize(
        object.counterpart,
        specifiedType: const FullType(
          GMyActiveConversationsData_myActiveConversations_counterpart,
        ),
      ),
    ];
    Object? value;
    value = object.lastMessage;
    if (value != null) {
      result
        ..add('lastMessage')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GMyActiveConversationsData_myActiveConversations deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyActiveConversationsData_myActiveConversationsBuilder();

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
        case 'reservationId':
          result.reservationId =
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
                    specifiedType: const FullType(_i2.GConversationStatus),
                  )!
                  as _i2.GConversationStatus;
          break;
        case 'lastMessage':
          result.lastMessage =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
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
        case 'counterpart':
          result.counterpart.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMyActiveConversationsData_myActiveConversations_counterpart,
                  ),
                )!
                as GMyActiveConversationsData_myActiveConversations_counterpart,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyActiveConversationsData_myActiveConversations_counterpartSerializer
    implements
        StructuredSerializer<
          GMyActiveConversationsData_myActiveConversations_counterpart
        > {
  @override
  final Iterable<Type> types = const [
    GMyActiveConversationsData_myActiveConversations_counterpart,
    _$GMyActiveConversationsData_myActiveConversations_counterpart,
  ];
  @override
  final String wireName =
      'GMyActiveConversationsData_myActiveConversations_counterpart';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyActiveConversationsData_myActiveConversations_counterpart object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'displayName',
      serializers.serialize(
        object.displayName,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.avatarUrl;
    if (value != null) {
      result
        ..add('avatarUrl')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GMyActiveConversationsData_myActiveConversations_counterpart deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GMyActiveConversationsData_myActiveConversations_counterpartBuilder();

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
                  )!
                  as String;
          break;
        case 'avatarUrl':
          result.avatarUrl =
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

class _$GMyActiveConversationsData extends GMyActiveConversationsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GMyActiveConversationsData_myActiveConversations>
  myActiveConversations;

  factory _$GMyActiveConversationsData([
    void Function(GMyActiveConversationsDataBuilder)? updates,
  ]) => (GMyActiveConversationsDataBuilder()..update(updates))._build();

  _$GMyActiveConversationsData._({
    required this.G__typename,
    required this.myActiveConversations,
  }) : super._();
  @override
  GMyActiveConversationsData rebuild(
    void Function(GMyActiveConversationsDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyActiveConversationsDataBuilder toBuilder() =>
      GMyActiveConversationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyActiveConversationsData &&
        G__typename == other.G__typename &&
        myActiveConversations == other.myActiveConversations;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, myActiveConversations.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMyActiveConversationsData')
          ..add('G__typename', G__typename)
          ..add('myActiveConversations', myActiveConversations))
        .toString();
  }
}

class GMyActiveConversationsDataBuilder
    implements
        Builder<GMyActiveConversationsData, GMyActiveConversationsDataBuilder> {
  _$GMyActiveConversationsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GMyActiveConversationsData_myActiveConversations>?
  _myActiveConversations;
  ListBuilder<GMyActiveConversationsData_myActiveConversations>
  get myActiveConversations => _$this._myActiveConversations ??=
      ListBuilder<GMyActiveConversationsData_myActiveConversations>();
  set myActiveConversations(
    ListBuilder<GMyActiveConversationsData_myActiveConversations>?
    myActiveConversations,
  ) => _$this._myActiveConversations = myActiveConversations;

  GMyActiveConversationsDataBuilder() {
    GMyActiveConversationsData._initializeBuilder(this);
  }

  GMyActiveConversationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _myActiveConversations = $v.myActiveConversations.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyActiveConversationsData other) {
    _$v = other as _$GMyActiveConversationsData;
  }

  @override
  void update(void Function(GMyActiveConversationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyActiveConversationsData build() => _build();

  _$GMyActiveConversationsData _build() {
    _$GMyActiveConversationsData _$result;
    try {
      _$result =
          _$v ??
          _$GMyActiveConversationsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyActiveConversationsData',
              'G__typename',
            ),
            myActiveConversations: myActiveConversations.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'myActiveConversations';
        myActiveConversations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyActiveConversationsData',
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

class _$GMyActiveConversationsData_myActiveConversations
    extends GMyActiveConversationsData_myActiveConversations {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String reservationId;
  @override
  final _i2.GConversationStatus status;
  @override
  final String? lastMessage;
  @override
  final _i2.GDateTime createdAt;
  @override
  final GMyActiveConversationsData_myActiveConversations_counterpart
  counterpart;

  factory _$GMyActiveConversationsData_myActiveConversations([
    void Function(GMyActiveConversationsData_myActiveConversationsBuilder)?
    updates,
  ]) =>
      (GMyActiveConversationsData_myActiveConversationsBuilder()
            ..update(updates))
          ._build();

  _$GMyActiveConversationsData_myActiveConversations._({
    required this.G__typename,
    required this.id,
    required this.reservationId,
    required this.status,
    this.lastMessage,
    required this.createdAt,
    required this.counterpart,
  }) : super._();
  @override
  GMyActiveConversationsData_myActiveConversations rebuild(
    void Function(GMyActiveConversationsData_myActiveConversationsBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyActiveConversationsData_myActiveConversationsBuilder toBuilder() =>
      GMyActiveConversationsData_myActiveConversationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyActiveConversationsData_myActiveConversations &&
        G__typename == other.G__typename &&
        id == other.id &&
        reservationId == other.reservationId &&
        status == other.status &&
        lastMessage == other.lastMessage &&
        createdAt == other.createdAt &&
        counterpart == other.counterpart;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, reservationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, lastMessage.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, counterpart.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMyActiveConversationsData_myActiveConversations',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('reservationId', reservationId)
          ..add('status', status)
          ..add('lastMessage', lastMessage)
          ..add('createdAt', createdAt)
          ..add('counterpart', counterpart))
        .toString();
  }
}

class GMyActiveConversationsData_myActiveConversationsBuilder
    implements
        Builder<
          GMyActiveConversationsData_myActiveConversations,
          GMyActiveConversationsData_myActiveConversationsBuilder
        > {
  _$GMyActiveConversationsData_myActiveConversations? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _reservationId;
  String? get reservationId => _$this._reservationId;
  set reservationId(String? reservationId) =>
      _$this._reservationId = reservationId;

  _i2.GConversationStatus? _status;
  _i2.GConversationStatus? get status => _$this._status;
  set status(_i2.GConversationStatus? status) => _$this._status = status;

  String? _lastMessage;
  String? get lastMessage => _$this._lastMessage;
  set lastMessage(String? lastMessage) => _$this._lastMessage = lastMessage;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  GMyActiveConversationsData_myActiveConversations_counterpartBuilder?
  _counterpart;
  GMyActiveConversationsData_myActiveConversations_counterpartBuilder
  get counterpart => _$this._counterpart ??=
      GMyActiveConversationsData_myActiveConversations_counterpartBuilder();
  set counterpart(
    GMyActiveConversationsData_myActiveConversations_counterpartBuilder?
    counterpart,
  ) => _$this._counterpart = counterpart;

  GMyActiveConversationsData_myActiveConversationsBuilder() {
    GMyActiveConversationsData_myActiveConversations._initializeBuilder(this);
  }

  GMyActiveConversationsData_myActiveConversationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _reservationId = $v.reservationId;
      _status = $v.status;
      _lastMessage = $v.lastMessage;
      _createdAt = $v.createdAt.toBuilder();
      _counterpart = $v.counterpart.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyActiveConversationsData_myActiveConversations other) {
    _$v = other as _$GMyActiveConversationsData_myActiveConversations;
  }

  @override
  void update(
    void Function(GMyActiveConversationsData_myActiveConversationsBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyActiveConversationsData_myActiveConversations build() => _build();

  _$GMyActiveConversationsData_myActiveConversations _build() {
    _$GMyActiveConversationsData_myActiveConversations _$result;
    try {
      _$result =
          _$v ??
          _$GMyActiveConversationsData_myActiveConversations._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMyActiveConversationsData_myActiveConversations',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GMyActiveConversationsData_myActiveConversations',
              'id',
            ),
            reservationId: BuiltValueNullFieldError.checkNotNull(
              reservationId,
              r'GMyActiveConversationsData_myActiveConversations',
              'reservationId',
            ),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GMyActiveConversationsData_myActiveConversations',
              'status',
            ),
            lastMessage: lastMessage,
            createdAt: createdAt.build(),
            counterpart: counterpart.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
        _$failedField = 'counterpart';
        counterpart.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyActiveConversationsData_myActiveConversations',
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

class _$GMyActiveConversationsData_myActiveConversations_counterpart
    extends GMyActiveConversationsData_myActiveConversations_counterpart {
  @override
  final String G__typename;
  @override
  final String displayName;
  @override
  final String? avatarUrl;

  factory _$GMyActiveConversationsData_myActiveConversations_counterpart([
    void Function(
      GMyActiveConversationsData_myActiveConversations_counterpartBuilder,
    )?
    updates,
  ]) =>
      (GMyActiveConversationsData_myActiveConversations_counterpartBuilder()
            ..update(updates))
          ._build();

  _$GMyActiveConversationsData_myActiveConversations_counterpart._({
    required this.G__typename,
    required this.displayName,
    this.avatarUrl,
  }) : super._();
  @override
  GMyActiveConversationsData_myActiveConversations_counterpart rebuild(
    void Function(
      GMyActiveConversationsData_myActiveConversations_counterpartBuilder,
    )
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyActiveConversationsData_myActiveConversations_counterpartBuilder
  toBuilder() =>
      GMyActiveConversationsData_myActiveConversations_counterpartBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other
            is GMyActiveConversationsData_myActiveConversations_counterpart &&
        G__typename == other.G__typename &&
        displayName == other.displayName &&
        avatarUrl == other.avatarUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMyActiveConversationsData_myActiveConversations_counterpart',
          )
          ..add('G__typename', G__typename)
          ..add('displayName', displayName)
          ..add('avatarUrl', avatarUrl))
        .toString();
  }
}

class GMyActiveConversationsData_myActiveConversations_counterpartBuilder
    implements
        Builder<
          GMyActiveConversationsData_myActiveConversations_counterpart,
          GMyActiveConversationsData_myActiveConversations_counterpartBuilder
        > {
  _$GMyActiveConversationsData_myActiveConversations_counterpart? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  GMyActiveConversationsData_myActiveConversations_counterpartBuilder() {
    GMyActiveConversationsData_myActiveConversations_counterpart._initializeBuilder(
      this,
    );
  }

  GMyActiveConversationsData_myActiveConversations_counterpartBuilder
  get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _displayName = $v.displayName;
      _avatarUrl = $v.avatarUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(
    GMyActiveConversationsData_myActiveConversations_counterpart other,
  ) {
    _$v =
        other as _$GMyActiveConversationsData_myActiveConversations_counterpart;
  }

  @override
  void update(
    void Function(
      GMyActiveConversationsData_myActiveConversations_counterpartBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMyActiveConversationsData_myActiveConversations_counterpart build() =>
      _build();

  _$GMyActiveConversationsData_myActiveConversations_counterpart _build() {
    final _$result =
        _$v ??
        _$GMyActiveConversationsData_myActiveConversations_counterpart._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GMyActiveConversationsData_myActiveConversations_counterpart',
            'G__typename',
          ),
          displayName: BuiltValueNullFieldError.checkNotNull(
            displayName,
            r'GMyActiveConversationsData_myActiveConversations_counterpart',
            'displayName',
          ),
          avatarUrl: avatarUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
