// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_or_create_conversation.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetOrCreateConversationData>
_$gGetOrCreateConversationDataSerializer =
    _$GGetOrCreateConversationDataSerializer();
Serializer<GGetOrCreateConversationData_getOrCreateConversation>
_$gGetOrCreateConversationDataGetOrCreateConversationSerializer =
    _$GGetOrCreateConversationData_getOrCreateConversationSerializer();

class _$GGetOrCreateConversationDataSerializer
    implements StructuredSerializer<GGetOrCreateConversationData> {
  @override
  final Iterable<Type> types = const [
    GGetOrCreateConversationData,
    _$GGetOrCreateConversationData,
  ];
  @override
  final String wireName = 'GGetOrCreateConversationData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetOrCreateConversationData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'getOrCreateConversation',
      serializers.serialize(
        object.getOrCreateConversation,
        specifiedType: const FullType(
          GGetOrCreateConversationData_getOrCreateConversation,
        ),
      ),
    ];

    return result;
  }

  @override
  GGetOrCreateConversationData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetOrCreateConversationDataBuilder();

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
        case 'getOrCreateConversation':
          result.getOrCreateConversation.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetOrCreateConversationData_getOrCreateConversation,
                  ),
                )!
                as GGetOrCreateConversationData_getOrCreateConversation,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetOrCreateConversationData_getOrCreateConversationSerializer
    implements
        StructuredSerializer<
          GGetOrCreateConversationData_getOrCreateConversation
        > {
  @override
  final Iterable<Type> types = const [
    GGetOrCreateConversationData_getOrCreateConversation,
    _$GGetOrCreateConversationData_getOrCreateConversation,
  ];
  @override
  final String wireName =
      'GGetOrCreateConversationData_getOrCreateConversation';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetOrCreateConversationData_getOrCreateConversation object, {
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
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'status',
      serializers.serialize(
        object.status,
        specifiedType: const FullType(_i2.GConversationStatus),
      ),
      'reservationId',
      serializers.serialize(
        object.reservationId,
        specifiedType: const FullType(String),
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
  GGetOrCreateConversationData_getOrCreateConversation deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GGetOrCreateConversationData_getOrCreateConversationBuilder();

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
        case 'createdAt':
          result.createdAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
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
        case 'reservationId':
          result.reservationId =
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

class _$GGetOrCreateConversationData extends GGetOrCreateConversationData {
  @override
  final String G__typename;
  @override
  final GGetOrCreateConversationData_getOrCreateConversation
  getOrCreateConversation;

  factory _$GGetOrCreateConversationData([
    void Function(GGetOrCreateConversationDataBuilder)? updates,
  ]) => (GGetOrCreateConversationDataBuilder()..update(updates))._build();

  _$GGetOrCreateConversationData._({
    required this.G__typename,
    required this.getOrCreateConversation,
  }) : super._();
  @override
  GGetOrCreateConversationData rebuild(
    void Function(GGetOrCreateConversationDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetOrCreateConversationDataBuilder toBuilder() =>
      GGetOrCreateConversationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetOrCreateConversationData &&
        G__typename == other.G__typename &&
        getOrCreateConversation == other.getOrCreateConversation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, getOrCreateConversation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetOrCreateConversationData')
          ..add('G__typename', G__typename)
          ..add('getOrCreateConversation', getOrCreateConversation))
        .toString();
  }
}

class GGetOrCreateConversationDataBuilder
    implements
        Builder<
          GGetOrCreateConversationData,
          GGetOrCreateConversationDataBuilder
        > {
  _$GGetOrCreateConversationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetOrCreateConversationData_getOrCreateConversationBuilder?
  _getOrCreateConversation;
  GGetOrCreateConversationData_getOrCreateConversationBuilder
  get getOrCreateConversation => _$this._getOrCreateConversation ??=
      GGetOrCreateConversationData_getOrCreateConversationBuilder();
  set getOrCreateConversation(
    GGetOrCreateConversationData_getOrCreateConversationBuilder?
    getOrCreateConversation,
  ) => _$this._getOrCreateConversation = getOrCreateConversation;

  GGetOrCreateConversationDataBuilder() {
    GGetOrCreateConversationData._initializeBuilder(this);
  }

  GGetOrCreateConversationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _getOrCreateConversation = $v.getOrCreateConversation.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetOrCreateConversationData other) {
    _$v = other as _$GGetOrCreateConversationData;
  }

  @override
  void update(void Function(GGetOrCreateConversationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetOrCreateConversationData build() => _build();

  _$GGetOrCreateConversationData _build() {
    _$GGetOrCreateConversationData _$result;
    try {
      _$result =
          _$v ??
          _$GGetOrCreateConversationData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetOrCreateConversationData',
              'G__typename',
            ),
            getOrCreateConversation: getOrCreateConversation.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'getOrCreateConversation';
        getOrCreateConversation.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetOrCreateConversationData',
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

class _$GGetOrCreateConversationData_getOrCreateConversation
    extends GGetOrCreateConversationData_getOrCreateConversation {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GDateTime createdAt;
  @override
  final _i2.GConversationStatus status;
  @override
  final String? lastMessage;
  @override
  final String reservationId;

  factory _$GGetOrCreateConversationData_getOrCreateConversation([
    void Function(GGetOrCreateConversationData_getOrCreateConversationBuilder)?
    updates,
  ]) =>
      (GGetOrCreateConversationData_getOrCreateConversationBuilder()
            ..update(updates))
          ._build();

  _$GGetOrCreateConversationData_getOrCreateConversation._({
    required this.G__typename,
    required this.id,
    required this.createdAt,
    required this.status,
    this.lastMessage,
    required this.reservationId,
  }) : super._();
  @override
  GGetOrCreateConversationData_getOrCreateConversation rebuild(
    void Function(GGetOrCreateConversationData_getOrCreateConversationBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetOrCreateConversationData_getOrCreateConversationBuilder toBuilder() =>
      GGetOrCreateConversationData_getOrCreateConversationBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetOrCreateConversationData_getOrCreateConversation &&
        G__typename == other.G__typename &&
        id == other.id &&
        createdAt == other.createdAt &&
        status == other.status &&
        lastMessage == other.lastMessage &&
        reservationId == other.reservationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, lastMessage.hashCode);
    _$hash = $jc(_$hash, reservationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetOrCreateConversationData_getOrCreateConversation',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('status', status)
          ..add('lastMessage', lastMessage)
          ..add('reservationId', reservationId))
        .toString();
  }
}

class GGetOrCreateConversationData_getOrCreateConversationBuilder
    implements
        Builder<
          GGetOrCreateConversationData_getOrCreateConversation,
          GGetOrCreateConversationData_getOrCreateConversationBuilder
        > {
  _$GGetOrCreateConversationData_getOrCreateConversation? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  _i2.GConversationStatus? _status;
  _i2.GConversationStatus? get status => _$this._status;
  set status(_i2.GConversationStatus? status) => _$this._status = status;

  String? _lastMessage;
  String? get lastMessage => _$this._lastMessage;
  set lastMessage(String? lastMessage) => _$this._lastMessage = lastMessage;

  String? _reservationId;
  String? get reservationId => _$this._reservationId;
  set reservationId(String? reservationId) =>
      _$this._reservationId = reservationId;

  GGetOrCreateConversationData_getOrCreateConversationBuilder() {
    GGetOrCreateConversationData_getOrCreateConversation._initializeBuilder(
      this,
    );
  }

  GGetOrCreateConversationData_getOrCreateConversationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _createdAt = $v.createdAt.toBuilder();
      _status = $v.status;
      _lastMessage = $v.lastMessage;
      _reservationId = $v.reservationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetOrCreateConversationData_getOrCreateConversation other) {
    _$v = other as _$GGetOrCreateConversationData_getOrCreateConversation;
  }

  @override
  void update(
    void Function(GGetOrCreateConversationData_getOrCreateConversationBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetOrCreateConversationData_getOrCreateConversation build() => _build();

  _$GGetOrCreateConversationData_getOrCreateConversation _build() {
    _$GGetOrCreateConversationData_getOrCreateConversation _$result;
    try {
      _$result =
          _$v ??
          _$GGetOrCreateConversationData_getOrCreateConversation._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetOrCreateConversationData_getOrCreateConversation',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GGetOrCreateConversationData_getOrCreateConversation',
              'id',
            ),
            createdAt: createdAt.build(),
            status: BuiltValueNullFieldError.checkNotNull(
              status,
              r'GGetOrCreateConversationData_getOrCreateConversation',
              'status',
            ),
            lastMessage: lastMessage,
            reservationId: BuiltValueNullFieldError.checkNotNull(
              reservationId,
              r'GGetOrCreateConversationData_getOrCreateConversation',
              'reservationId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetOrCreateConversationData_getOrCreateConversation',
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
