// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_notifications_as_read.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkNotificationsAsReadData>
_$gMarkNotificationsAsReadDataSerializer =
    _$GMarkNotificationsAsReadDataSerializer();
Serializer<GMarkNotificationsAsReadData_markNotificationsAsRead>
_$gMarkNotificationsAsReadDataMarkNotificationsAsReadSerializer =
    _$GMarkNotificationsAsReadData_markNotificationsAsReadSerializer();

class _$GMarkNotificationsAsReadDataSerializer
    implements StructuredSerializer<GMarkNotificationsAsReadData> {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationsAsReadData,
    _$GMarkNotificationsAsReadData,
  ];
  @override
  final String wireName = 'GMarkNotificationsAsReadData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMarkNotificationsAsReadData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'markNotificationsAsRead',
      serializers.serialize(
        object.markNotificationsAsRead,
        specifiedType: const FullType(
          GMarkNotificationsAsReadData_markNotificationsAsRead,
        ),
      ),
    ];

    return result;
  }

  @override
  GMarkNotificationsAsReadData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMarkNotificationsAsReadDataBuilder();

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
        case 'markNotificationsAsRead':
          result.markNotificationsAsRead.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GMarkNotificationsAsReadData_markNotificationsAsRead,
                  ),
                )!
                as GMarkNotificationsAsReadData_markNotificationsAsRead,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkNotificationsAsReadData_markNotificationsAsReadSerializer
    implements
        StructuredSerializer<
          GMarkNotificationsAsReadData_markNotificationsAsRead
        > {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationsAsReadData_markNotificationsAsRead,
    _$GMarkNotificationsAsReadData_markNotificationsAsRead,
  ];
  @override
  final String wireName =
      'GMarkNotificationsAsReadData_markNotificationsAsRead';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMarkNotificationsAsReadData_markNotificationsAsRead object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'message',
      serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GMarkNotificationsAsReadData_markNotificationsAsRead deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result =
        GMarkNotificationsAsReadData_markNotificationsAsReadBuilder();

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
        case 'message':
          result.message =
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

class _$GMarkNotificationsAsReadData extends GMarkNotificationsAsReadData {
  @override
  final String G__typename;
  @override
  final GMarkNotificationsAsReadData_markNotificationsAsRead
  markNotificationsAsRead;

  factory _$GMarkNotificationsAsReadData([
    void Function(GMarkNotificationsAsReadDataBuilder)? updates,
  ]) => (GMarkNotificationsAsReadDataBuilder()..update(updates))._build();

  _$GMarkNotificationsAsReadData._({
    required this.G__typename,
    required this.markNotificationsAsRead,
  }) : super._();
  @override
  GMarkNotificationsAsReadData rebuild(
    void Function(GMarkNotificationsAsReadDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationsAsReadDataBuilder toBuilder() =>
      GMarkNotificationsAsReadDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationsAsReadData &&
        G__typename == other.G__typename &&
        markNotificationsAsRead == other.markNotificationsAsRead;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, markNotificationsAsRead.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GMarkNotificationsAsReadData')
          ..add('G__typename', G__typename)
          ..add('markNotificationsAsRead', markNotificationsAsRead))
        .toString();
  }
}

class GMarkNotificationsAsReadDataBuilder
    implements
        Builder<
          GMarkNotificationsAsReadData,
          GMarkNotificationsAsReadDataBuilder
        > {
  _$GMarkNotificationsAsReadData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GMarkNotificationsAsReadData_markNotificationsAsReadBuilder?
  _markNotificationsAsRead;
  GMarkNotificationsAsReadData_markNotificationsAsReadBuilder
  get markNotificationsAsRead => _$this._markNotificationsAsRead ??=
      GMarkNotificationsAsReadData_markNotificationsAsReadBuilder();
  set markNotificationsAsRead(
    GMarkNotificationsAsReadData_markNotificationsAsReadBuilder?
    markNotificationsAsRead,
  ) => _$this._markNotificationsAsRead = markNotificationsAsRead;

  GMarkNotificationsAsReadDataBuilder() {
    GMarkNotificationsAsReadData._initializeBuilder(this);
  }

  GMarkNotificationsAsReadDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _markNotificationsAsRead = $v.markNotificationsAsRead.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkNotificationsAsReadData other) {
    _$v = other as _$GMarkNotificationsAsReadData;
  }

  @override
  void update(void Function(GMarkNotificationsAsReadDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationsAsReadData build() => _build();

  _$GMarkNotificationsAsReadData _build() {
    _$GMarkNotificationsAsReadData _$result;
    try {
      _$result =
          _$v ??
          _$GMarkNotificationsAsReadData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GMarkNotificationsAsReadData',
              'G__typename',
            ),
            markNotificationsAsRead: markNotificationsAsRead.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'markNotificationsAsRead';
        markNotificationsAsRead.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMarkNotificationsAsReadData',
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

class _$GMarkNotificationsAsReadData_markNotificationsAsRead
    extends GMarkNotificationsAsReadData_markNotificationsAsRead {
  @override
  final String G__typename;
  @override
  final String message;

  factory _$GMarkNotificationsAsReadData_markNotificationsAsRead([
    void Function(GMarkNotificationsAsReadData_markNotificationsAsReadBuilder)?
    updates,
  ]) =>
      (GMarkNotificationsAsReadData_markNotificationsAsReadBuilder()
            ..update(updates))
          ._build();

  _$GMarkNotificationsAsReadData_markNotificationsAsRead._({
    required this.G__typename,
    required this.message,
  }) : super._();
  @override
  GMarkNotificationsAsReadData_markNotificationsAsRead rebuild(
    void Function(GMarkNotificationsAsReadData_markNotificationsAsReadBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationsAsReadData_markNotificationsAsReadBuilder toBuilder() =>
      GMarkNotificationsAsReadData_markNotificationsAsReadBuilder()
        ..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationsAsReadData_markNotificationsAsRead &&
        G__typename == other.G__typename &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GMarkNotificationsAsReadData_markNotificationsAsRead',
          )
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GMarkNotificationsAsReadData_markNotificationsAsReadBuilder
    implements
        Builder<
          GMarkNotificationsAsReadData_markNotificationsAsRead,
          GMarkNotificationsAsReadData_markNotificationsAsReadBuilder
        > {
  _$GMarkNotificationsAsReadData_markNotificationsAsRead? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GMarkNotificationsAsReadData_markNotificationsAsReadBuilder() {
    GMarkNotificationsAsReadData_markNotificationsAsRead._initializeBuilder(
      this,
    );
  }

  GMarkNotificationsAsReadData_markNotificationsAsReadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkNotificationsAsReadData_markNotificationsAsRead other) {
    _$v = other as _$GMarkNotificationsAsReadData_markNotificationsAsRead;
  }

  @override
  void update(
    void Function(GMarkNotificationsAsReadData_markNotificationsAsReadBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationsAsReadData_markNotificationsAsRead build() => _build();

  _$GMarkNotificationsAsReadData_markNotificationsAsRead _build() {
    final _$result =
        _$v ??
        _$GMarkNotificationsAsReadData_markNotificationsAsRead._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GMarkNotificationsAsReadData_markNotificationsAsRead',
            'G__typename',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'GMarkNotificationsAsReadData_markNotificationsAsRead',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
