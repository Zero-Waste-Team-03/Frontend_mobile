// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GForgotPasswordData> _$gForgotPasswordDataSerializer =
    _$GForgotPasswordDataSerializer();
Serializer<GForgotPasswordData_forgotPassword>
_$gForgotPasswordDataForgotPasswordSerializer =
    _$GForgotPasswordData_forgotPasswordSerializer();

class _$GForgotPasswordDataSerializer
    implements StructuredSerializer<GForgotPasswordData> {
  @override
  final Iterable<Type> types = const [
    GForgotPasswordData,
    _$GForgotPasswordData,
  ];
  @override
  final String wireName = 'GForgotPasswordData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GForgotPasswordData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'forgotPassword',
      serializers.serialize(
        object.forgotPassword,
        specifiedType: const FullType(GForgotPasswordData_forgotPassword),
      ),
    ];

    return result;
  }

  @override
  GForgotPasswordData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GForgotPasswordDataBuilder();

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
        case 'forgotPassword':
          result.forgotPassword.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GForgotPasswordData_forgotPassword,
                  ),
                )!
                as GForgotPasswordData_forgotPassword,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GForgotPasswordData_forgotPasswordSerializer
    implements StructuredSerializer<GForgotPasswordData_forgotPassword> {
  @override
  final Iterable<Type> types = const [
    GForgotPasswordData_forgotPassword,
    _$GForgotPasswordData_forgotPassword,
  ];
  @override
  final String wireName = 'GForgotPasswordData_forgotPassword';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GForgotPasswordData_forgotPassword object, {
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
  GForgotPasswordData_forgotPassword deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GForgotPasswordData_forgotPasswordBuilder();

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

class _$GForgotPasswordData extends GForgotPasswordData {
  @override
  final String G__typename;
  @override
  final GForgotPasswordData_forgotPassword forgotPassword;

  factory _$GForgotPasswordData([
    void Function(GForgotPasswordDataBuilder)? updates,
  ]) => (GForgotPasswordDataBuilder()..update(updates))._build();

  _$GForgotPasswordData._({
    required this.G__typename,
    required this.forgotPassword,
  }) : super._();
  @override
  GForgotPasswordData rebuild(
    void Function(GForgotPasswordDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GForgotPasswordDataBuilder toBuilder() =>
      GForgotPasswordDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GForgotPasswordData &&
        G__typename == other.G__typename &&
        forgotPassword == other.forgotPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, forgotPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GForgotPasswordData')
          ..add('G__typename', G__typename)
          ..add('forgotPassword', forgotPassword))
        .toString();
  }
}

class GForgotPasswordDataBuilder
    implements Builder<GForgotPasswordData, GForgotPasswordDataBuilder> {
  _$GForgotPasswordData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GForgotPasswordData_forgotPasswordBuilder? _forgotPassword;
  GForgotPasswordData_forgotPasswordBuilder get forgotPassword =>
      _$this._forgotPassword ??= GForgotPasswordData_forgotPasswordBuilder();
  set forgotPassword(
    GForgotPasswordData_forgotPasswordBuilder? forgotPassword,
  ) => _$this._forgotPassword = forgotPassword;

  GForgotPasswordDataBuilder() {
    GForgotPasswordData._initializeBuilder(this);
  }

  GForgotPasswordDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _forgotPassword = $v.forgotPassword.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GForgotPasswordData other) {
    _$v = other as _$GForgotPasswordData;
  }

  @override
  void update(void Function(GForgotPasswordDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GForgotPasswordData build() => _build();

  _$GForgotPasswordData _build() {
    _$GForgotPasswordData _$result;
    try {
      _$result =
          _$v ??
          _$GForgotPasswordData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GForgotPasswordData',
              'G__typename',
            ),
            forgotPassword: forgotPassword.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'forgotPassword';
        forgotPassword.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GForgotPasswordData',
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

class _$GForgotPasswordData_forgotPassword
    extends GForgotPasswordData_forgotPassword {
  @override
  final String G__typename;
  @override
  final String message;

  factory _$GForgotPasswordData_forgotPassword([
    void Function(GForgotPasswordData_forgotPasswordBuilder)? updates,
  ]) => (GForgotPasswordData_forgotPasswordBuilder()..update(updates))._build();

  _$GForgotPasswordData_forgotPassword._({
    required this.G__typename,
    required this.message,
  }) : super._();
  @override
  GForgotPasswordData_forgotPassword rebuild(
    void Function(GForgotPasswordData_forgotPasswordBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GForgotPasswordData_forgotPasswordBuilder toBuilder() =>
      GForgotPasswordData_forgotPasswordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GForgotPasswordData_forgotPassword &&
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
    return (newBuiltValueToStringHelper(r'GForgotPasswordData_forgotPassword')
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GForgotPasswordData_forgotPasswordBuilder
    implements
        Builder<
          GForgotPasswordData_forgotPassword,
          GForgotPasswordData_forgotPasswordBuilder
        > {
  _$GForgotPasswordData_forgotPassword? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GForgotPasswordData_forgotPasswordBuilder() {
    GForgotPasswordData_forgotPassword._initializeBuilder(this);
  }

  GForgotPasswordData_forgotPasswordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GForgotPasswordData_forgotPassword other) {
    _$v = other as _$GForgotPasswordData_forgotPassword;
  }

  @override
  void update(
    void Function(GForgotPasswordData_forgotPasswordBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GForgotPasswordData_forgotPassword build() => _build();

  _$GForgotPasswordData_forgotPassword _build() {
    final _$result =
        _$v ??
        _$GForgotPasswordData_forgotPassword._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GForgotPasswordData_forgotPassword',
            'G__typename',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'GForgotPasswordData_forgotPassword',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
