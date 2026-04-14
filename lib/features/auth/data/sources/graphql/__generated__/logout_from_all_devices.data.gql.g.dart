// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_from_all_devices.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GLogoutFromAllDevicesData> _$gLogoutFromAllDevicesDataSerializer =
    _$GLogoutFromAllDevicesDataSerializer();
Serializer<GLogoutFromAllDevicesData_logoutFromAllDevices>
_$gLogoutFromAllDevicesDataLogoutFromAllDevicesSerializer =
    _$GLogoutFromAllDevicesData_logoutFromAllDevicesSerializer();

class _$GLogoutFromAllDevicesDataSerializer
    implements StructuredSerializer<GLogoutFromAllDevicesData> {
  @override
  final Iterable<Type> types = const [
    GLogoutFromAllDevicesData,
    _$GLogoutFromAllDevicesData,
  ];
  @override
  final String wireName = 'GLogoutFromAllDevicesData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GLogoutFromAllDevicesData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'logoutFromAllDevices',
      serializers.serialize(
        object.logoutFromAllDevices,
        specifiedType: const FullType(
          GLogoutFromAllDevicesData_logoutFromAllDevices,
        ),
      ),
    ];

    return result;
  }

  @override
  GLogoutFromAllDevicesData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GLogoutFromAllDevicesDataBuilder();

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
        case 'logoutFromAllDevices':
          result.logoutFromAllDevices.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GLogoutFromAllDevicesData_logoutFromAllDevices,
                  ),
                )!
                as GLogoutFromAllDevicesData_logoutFromAllDevices,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GLogoutFromAllDevicesData_logoutFromAllDevicesSerializer
    implements
        StructuredSerializer<GLogoutFromAllDevicesData_logoutFromAllDevices> {
  @override
  final Iterable<Type> types = const [
    GLogoutFromAllDevicesData_logoutFromAllDevices,
    _$GLogoutFromAllDevicesData_logoutFromAllDevices,
  ];
  @override
  final String wireName = 'GLogoutFromAllDevicesData_logoutFromAllDevices';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GLogoutFromAllDevicesData_logoutFromAllDevices object, {
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
  GLogoutFromAllDevicesData_logoutFromAllDevices deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder();

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

class _$GLogoutFromAllDevicesData extends GLogoutFromAllDevicesData {
  @override
  final String G__typename;
  @override
  final GLogoutFromAllDevicesData_logoutFromAllDevices logoutFromAllDevices;

  factory _$GLogoutFromAllDevicesData([
    void Function(GLogoutFromAllDevicesDataBuilder)? updates,
  ]) => (GLogoutFromAllDevicesDataBuilder()..update(updates))._build();

  _$GLogoutFromAllDevicesData._({
    required this.G__typename,
    required this.logoutFromAllDevices,
  }) : super._();
  @override
  GLogoutFromAllDevicesData rebuild(
    void Function(GLogoutFromAllDevicesDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GLogoutFromAllDevicesDataBuilder toBuilder() =>
      GLogoutFromAllDevicesDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLogoutFromAllDevicesData &&
        G__typename == other.G__typename &&
        logoutFromAllDevices == other.logoutFromAllDevices;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, logoutFromAllDevices.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GLogoutFromAllDevicesData')
          ..add('G__typename', G__typename)
          ..add('logoutFromAllDevices', logoutFromAllDevices))
        .toString();
  }
}

class GLogoutFromAllDevicesDataBuilder
    implements
        Builder<GLogoutFromAllDevicesData, GLogoutFromAllDevicesDataBuilder> {
  _$GLogoutFromAllDevicesData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder? _logoutFromAllDevices;
  GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder
  get logoutFromAllDevices => _$this._logoutFromAllDevices ??=
      GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder();
  set logoutFromAllDevices(
    GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder? logoutFromAllDevices,
  ) => _$this._logoutFromAllDevices = logoutFromAllDevices;

  GLogoutFromAllDevicesDataBuilder() {
    GLogoutFromAllDevicesData._initializeBuilder(this);
  }

  GLogoutFromAllDevicesDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _logoutFromAllDevices = $v.logoutFromAllDevices.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLogoutFromAllDevicesData other) {
    _$v = other as _$GLogoutFromAllDevicesData;
  }

  @override
  void update(void Function(GLogoutFromAllDevicesDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLogoutFromAllDevicesData build() => _build();

  _$GLogoutFromAllDevicesData _build() {
    _$GLogoutFromAllDevicesData _$result;
    try {
      _$result =
          _$v ??
          _$GLogoutFromAllDevicesData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GLogoutFromAllDevicesData',
              'G__typename',
            ),
            logoutFromAllDevices: logoutFromAllDevices.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'logoutFromAllDevices';
        logoutFromAllDevices.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GLogoutFromAllDevicesData',
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

class _$GLogoutFromAllDevicesData_logoutFromAllDevices
    extends GLogoutFromAllDevicesData_logoutFromAllDevices {
  @override
  final String G__typename;
  @override
  final String message;

  factory _$GLogoutFromAllDevicesData_logoutFromAllDevices([
    void Function(GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder)?
    updates,
  ]) =>
      (GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder()..update(updates))
          ._build();

  _$GLogoutFromAllDevicesData_logoutFromAllDevices._({
    required this.G__typename,
    required this.message,
  }) : super._();
  @override
  GLogoutFromAllDevicesData_logoutFromAllDevices rebuild(
    void Function(GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder toBuilder() =>
      GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLogoutFromAllDevicesData_logoutFromAllDevices &&
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
            r'GLogoutFromAllDevicesData_logoutFromAllDevices',
          )
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder
    implements
        Builder<
          GLogoutFromAllDevicesData_logoutFromAllDevices,
          GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder
        > {
  _$GLogoutFromAllDevicesData_logoutFromAllDevices? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder() {
    GLogoutFromAllDevicesData_logoutFromAllDevices._initializeBuilder(this);
  }

  GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLogoutFromAllDevicesData_logoutFromAllDevices other) {
    _$v = other as _$GLogoutFromAllDevicesData_logoutFromAllDevices;
  }

  @override
  void update(
    void Function(GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GLogoutFromAllDevicesData_logoutFromAllDevices build() => _build();

  _$GLogoutFromAllDevicesData_logoutFromAllDevices _build() {
    final _$result =
        _$v ??
        _$GLogoutFromAllDevicesData_logoutFromAllDevices._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GLogoutFromAllDevicesData_logoutFromAllDevices',
            'G__typename',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'GLogoutFromAllDevicesData_logoutFromAllDevices',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
