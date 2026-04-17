// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_transaction_completed.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkTransactionCompletedData>
_$gMarkTransactionCompletedDataSerializer =
    _$GMarkTransactionCompletedDataSerializer();
Serializer<GMarkTransactionCompletedData_markTransactionCompleted>
_$gMarkTransactionCompletedDataMarkTransactionCompletedSerializer =
    _$GMarkTransactionCompletedData_markTransactionCompletedSerializer();

class _$GMarkTransactionCompletedDataSerializer
    implements StructuredSerializer<GMarkTransactionCompletedData> {
  @override
  final Iterable<Type> types = const [
    GMarkTransactionCompletedData,
    _$GMarkTransactionCompletedData,
  ];
  @override
  final String wireName = 'GMarkTransactionCompletedData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMarkTransactionCompletedData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'markTransactionCompleted',
      serializers.serialize(
        object.markTransactionCompleted,
        specifiedType: const FullType(
          GMarkTransactionCompletedData_markTransactionCompleted,
        ),
      ),
    ];

    return result;
  }

  @override
  GMarkTransactionCompletedData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMarkTransactionCompletedDataBuilder();

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
        case 'markTransactionCompleted':
          result.markTransactionCompleted.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMarkTransactionCompletedData_markTransactionCompleted,
                  ),
                )!
                as GMarkTransactionCompletedData_markTransactionCompleted,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkTransactionCompletedData_markTransactionCompletedSerializer
    implements
        StructuredSerializer<
          GMarkTransactionCompletedData_markTransactionCompleted
        > {
  @override
  final Iterable<Type> types = const [
    GMarkTransactionCompletedData_markTransactionCompleted,
    _$GMarkTransactionCompletedData_markTransactionCompleted,
  ];
  @override
  final String wireName =
      'GMarkTransactionCompletedData_markTransactionCompleted';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMarkTransactionCompletedData_markTransactionCompleted object, {
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
        specifiedType: const FullType(_i2.GConversationStatus),
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
  GMarkTransactionCompletedData_markTransactionCompleted deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GMarkTransactionCompletedData_markTransactionCompletedBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GMarkTransactionCompletedData extends GMarkTransactionCompletedData {
  @override
  final String G__typename;
  @override
  final GMarkTransactionCompletedData_markTransactionCompleted
  markTransactionCompleted;

  factory _$GMarkTransactionCompletedData([
    void Function(GMarkTransactionCompletedDataBuilder)? updates,
  ]) => (GMarkTransactionCompletedDataBuilder()..update(updates))._build();

  _$GMarkTransactionCompletedData._({
    required this.G__typename,
    required this.markTransactionCompleted,
  }) : super._();
  @override
  GMarkTransactionCompletedData rebuild(
    void Function(GMarkTransactionCompletedDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMarkTransactionCompletedDataBuilder toBuilder() =>
      GMarkTransactionCompletedDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkTransactionCompletedData &&
        G__typename == other.G__typename &&
        markTransactionCompleted == other.markTransactionCompleted;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, markTransactionCompleted.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkTransactionCompletedData')
          ..add('G__typename', G__typename)
          ..add('markTransactionCompleted', markTransactionCompleted))
        .toString();
  }
}

class GMarkTransactionCompletedDataBuilder
    implements
        Builder<
          GMarkTransactionCompletedData,
          GMarkTransactionCompletedDataBuilder
        > {
  _$GMarkTransactionCompletedData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMarkTransactionCompletedData_markTransactionCompletedBuilder?
  _markTransactionCompleted;
  GMarkTransactionCompletedData_markTransactionCompletedBuilder
  get markTransactionCompleted => _$this._markTransactionCompleted ??=
      GMarkTransactionCompletedData_markTransactionCompletedBuilder();
  set markTransactionCompleted(
    GMarkTransactionCompletedData_markTransactionCompletedBuilder?
    markTransactionCompleted,
  ) => _$this._markTransactionCompleted = markTransactionCompleted;

  GMarkTransactionCompletedDataBuilder() {
    GMarkTransactionCompletedData._initializeBuilder(this);
  }

  GMarkTransactionCompletedDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _markTransactionCompleted = $v.markTransactionCompleted.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkTransactionCompletedData other) {
    _$v = other as _$GMarkTransactionCompletedData;
  }

  @override
  void update(void Function(GMarkTransactionCompletedDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkTransactionCompletedData build() => _build();

  _$GMarkTransactionCompletedData _build() {
    _$GMarkTransactionCompletedData _$result;
    try {
      _$result =
          _$v ??
          _$GMarkTransactionCompletedData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMarkTransactionCompletedData',
              'G__typename',
            ),
            markTransactionCompleted: markTransactionCompleted.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'markTransactionCompleted';
        markTransactionCompleted.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMarkTransactionCompletedData',
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

class _$GMarkTransactionCompletedData_markTransactionCompleted
    extends GMarkTransactionCompletedData_markTransactionCompleted {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final _i2.GConversationStatus status;
  @override
  final String? lastMessage;

  factory _$GMarkTransactionCompletedData_markTransactionCompleted([
    void Function(
      GMarkTransactionCompletedData_markTransactionCompletedBuilder,
    )?
    updates,
  ]) =>
      (GMarkTransactionCompletedData_markTransactionCompletedBuilder()
            ..update(updates))
          ._build();

  _$GMarkTransactionCompletedData_markTransactionCompleted._({
    required this.G__typename,
    required this.id,
    required this.status,
    this.lastMessage,
  }) : super._();
  @override
  GMarkTransactionCompletedData_markTransactionCompleted rebuild(
    void Function(GMarkTransactionCompletedData_markTransactionCompletedBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMarkTransactionCompletedData_markTransactionCompletedBuilder toBuilder() =>
      GMarkTransactionCompletedData_markTransactionCompletedBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkTransactionCompletedData_markTransactionCompleted &&
        G__typename == other.G__typename &&
        id == other.id &&
        status == other.status &&
        lastMessage == other.lastMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, lastMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMarkTransactionCompletedData_markTransactionCompleted',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('status', status)
          ..add('lastMessage', lastMessage))
        .toString();
  }
}

class GMarkTransactionCompletedData_markTransactionCompletedBuilder
    implements
        Builder<
          GMarkTransactionCompletedData_markTransactionCompleted,
          GMarkTransactionCompletedData_markTransactionCompletedBuilder
        > {
  _$GMarkTransactionCompletedData_markTransactionCompleted? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  _i2.GConversationStatus? _status;
  _i2.GConversationStatus? get status => _$this._status;
  set status(_i2.GConversationStatus? status) => _$this._status = status;

  String? _lastMessage;
  String? get lastMessage => _$this._lastMessage;
  set lastMessage(String? lastMessage) => _$this._lastMessage = lastMessage;

  GMarkTransactionCompletedData_markTransactionCompletedBuilder() {
    GMarkTransactionCompletedData_markTransactionCompleted._initializeBuilder(
      this,
    );
  }

  GMarkTransactionCompletedData_markTransactionCompletedBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _status = $v.status;
      _lastMessage = $v.lastMessage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkTransactionCompletedData_markTransactionCompleted other) {
    _$v = other as _$GMarkTransactionCompletedData_markTransactionCompleted;
  }

  @override
  void update(
    void Function(
      GMarkTransactionCompletedData_markTransactionCompletedBuilder,
    )?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMarkTransactionCompletedData_markTransactionCompleted build() => _build();

  _$GMarkTransactionCompletedData_markTransactionCompleted _build() {
    final _$result =
        _$v ??
        _$GMarkTransactionCompletedData_markTransactionCompleted._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GMarkTransactionCompletedData_markTransactionCompleted',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GMarkTransactionCompletedData_markTransactionCompleted',
            'id',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'GMarkTransactionCompletedData_markTransactionCompleted',
            'status',
          ),
          lastMessage: lastMessage,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
