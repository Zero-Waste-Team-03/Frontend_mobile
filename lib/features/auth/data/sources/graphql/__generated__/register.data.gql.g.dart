// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRegisterData> _$gRegisterDataSerializer =
    _$GRegisterDataSerializer();
Serializer<GRegisterData_register> _$gRegisterDataRegisterSerializer =
    _$GRegisterData_registerSerializer();

class _$GRegisterDataSerializer implements StructuredSerializer<GRegisterData> {
  @override
  final Iterable<Type> types = const [GRegisterData, _$GRegisterData];
  @override
  final String wireName = 'GRegisterData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'register',
      serializers.serialize(
        object.register,
        specifiedType: const FullType(GRegisterData_register),
      ),
    ];

    return result;
  }

  @override
  GRegisterData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRegisterDataBuilder();

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
        case 'register':
          result.register.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GRegisterData_register),
                )!
                as GRegisterData_register,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GRegisterData_registerSerializer
    implements StructuredSerializer<GRegisterData_register> {
  @override
  final Iterable<Type> types = const [
    GRegisterData_register,
    _$GRegisterData_register,
  ];
  @override
  final String wireName = 'GRegisterData_register';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRegisterData_register object, {
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
  GRegisterData_register deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRegisterData_registerBuilder();

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

class _$GRegisterData extends GRegisterData {
  @override
  final String G__typename;
  @override
  final GRegisterData_register register;

  factory _$GRegisterData([void Function(GRegisterDataBuilder)? updates]) =>
      (GRegisterDataBuilder()..update(updates))._build();

  _$GRegisterData._({required this.G__typename, required this.register})
    : super._();
  @override
  GRegisterData rebuild(void Function(GRegisterDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GRegisterDataBuilder toBuilder() => GRegisterDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterData &&
        G__typename == other.G__typename &&
        register == other.register;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, register.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRegisterData')
          ..add('G__typename', G__typename)
          ..add('register', register))
        .toString();
  }
}

class GRegisterDataBuilder
    implements Builder<GRegisterData, GRegisterDataBuilder> {
  _$GRegisterData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRegisterData_registerBuilder? _register;
  GRegisterData_registerBuilder get register =>
      _$this._register ??= GRegisterData_registerBuilder();
  set register(GRegisterData_registerBuilder? register) =>
      _$this._register = register;

  GRegisterDataBuilder() {
    GRegisterData._initializeBuilder(this);
  }

  GRegisterDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _register = $v.register.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterData other) {
    _$v = other as _$GRegisterData;
  }

  @override
  void update(void Function(GRegisterDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterData build() => _build();

  _$GRegisterData _build() {
    _$GRegisterData _$result;
    try {
      _$result =
          _$v ??
          _$GRegisterData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRegisterData',
              'G__typename',
            ),
            register: register.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'register';
        register.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GRegisterData',
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

class _$GRegisterData_register extends GRegisterData_register {
  @override
  final String G__typename;
  @override
  final String message;

  factory _$GRegisterData_register([
    void Function(GRegisterData_registerBuilder)? updates,
  ]) => (GRegisterData_registerBuilder()..update(updates))._build();

  _$GRegisterData_register._({required this.G__typename, required this.message})
    : super._();
  @override
  GRegisterData_register rebuild(
    void Function(GRegisterData_registerBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRegisterData_registerBuilder toBuilder() =>
      GRegisterData_registerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRegisterData_register &&
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
    return (newBuiltValueToStringHelper(r'GRegisterData_register')
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GRegisterData_registerBuilder
    implements Builder<GRegisterData_register, GRegisterData_registerBuilder> {
  _$GRegisterData_register? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GRegisterData_registerBuilder() {
    GRegisterData_register._initializeBuilder(this);
  }

  GRegisterData_registerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRegisterData_register other) {
    _$v = other as _$GRegisterData_register;
  }

  @override
  void update(void Function(GRegisterData_registerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRegisterData_register build() => _build();

  _$GRegisterData_register _build() {
    final _$result =
        _$v ??
        _$GRegisterData_register._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GRegisterData_register',
            'G__typename',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'GRegisterData_register',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
