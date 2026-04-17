// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GResetPasswordData> _$gResetPasswordDataSerializer =
    _$GResetPasswordDataSerializer();
Serializer<GResetPasswordData_resetPassword>
_$gResetPasswordDataResetPasswordSerializer =
    _$GResetPasswordData_resetPasswordSerializer();

class _$GResetPasswordDataSerializer
    implements StructuredSerializer<GResetPasswordData> {
  @override
  final Iterable<Type> types = const [GResetPasswordData, _$GResetPasswordData];
  @override
  final String wireName = 'GResetPasswordData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GResetPasswordData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'resetPassword',
      serializers.serialize(
        object.resetPassword,
        specifiedType: const FullType(GResetPasswordData_resetPassword),
      ),
    ];

    return result;
  }

  @override
  GResetPasswordData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GResetPasswordDataBuilder();

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
        case 'resetPassword':
          result.resetPassword.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GResetPasswordData_resetPassword,
                  ),
                )!
                as GResetPasswordData_resetPassword,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GResetPasswordData_resetPasswordSerializer
    implements StructuredSerializer<GResetPasswordData_resetPassword> {
  @override
  final Iterable<Type> types = const [
    GResetPasswordData_resetPassword,
    _$GResetPasswordData_resetPassword,
  ];
  @override
  final String wireName = 'GResetPasswordData_resetPassword';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GResetPasswordData_resetPassword object, {
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
  GResetPasswordData_resetPassword deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GResetPasswordData_resetPasswordBuilder();

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

class _$GResetPasswordData extends GResetPasswordData {
  @override
  final String G__typename;
  @override
  final GResetPasswordData_resetPassword resetPassword;

  factory _$GResetPasswordData([
    void Function(GResetPasswordDataBuilder)? updates,
  ]) => (GResetPasswordDataBuilder()..update(updates))._build();

  _$GResetPasswordData._({
    required this.G__typename,
    required this.resetPassword,
  }) : super._();
  @override
  GResetPasswordData rebuild(
    void Function(GResetPasswordDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GResetPasswordDataBuilder toBuilder() =>
      GResetPasswordDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GResetPasswordData &&
        G__typename == other.G__typename &&
        resetPassword == other.resetPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, resetPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GResetPasswordData')
          ..add('G__typename', G__typename)
          ..add('resetPassword', resetPassword))
        .toString();
  }
}

class GResetPasswordDataBuilder
    implements Builder<GResetPasswordData, GResetPasswordDataBuilder> {
  _$GResetPasswordData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GResetPasswordData_resetPasswordBuilder? _resetPassword;
  GResetPasswordData_resetPasswordBuilder get resetPassword =>
      _$this._resetPassword ??= GResetPasswordData_resetPasswordBuilder();
  set resetPassword(GResetPasswordData_resetPasswordBuilder? resetPassword) =>
      _$this._resetPassword = resetPassword;

  GResetPasswordDataBuilder() {
    GResetPasswordData._initializeBuilder(this);
  }

  GResetPasswordDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _resetPassword = $v.resetPassword.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GResetPasswordData other) {
    _$v = other as _$GResetPasswordData;
  }

  @override
  void update(void Function(GResetPasswordDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GResetPasswordData build() => _build();

  _$GResetPasswordData _build() {
    _$GResetPasswordData _$result;
    try {
      _$result =
          _$v ??
          _$GResetPasswordData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GResetPasswordData',
              'G__typename',
            ),
            resetPassword: resetPassword.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'resetPassword';
        resetPassword.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GResetPasswordData',
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

class _$GResetPasswordData_resetPassword
    extends GResetPasswordData_resetPassword {
  @override
  final String G__typename;
  @override
  final String message;

  factory _$GResetPasswordData_resetPassword([
    void Function(GResetPasswordData_resetPasswordBuilder)? updates,
  ]) => (GResetPasswordData_resetPasswordBuilder()..update(updates))._build();

  _$GResetPasswordData_resetPassword._({
    required this.G__typename,
    required this.message,
  }) : super._();
  @override
  GResetPasswordData_resetPassword rebuild(
    void Function(GResetPasswordData_resetPasswordBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GResetPasswordData_resetPasswordBuilder toBuilder() =>
      GResetPasswordData_resetPasswordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GResetPasswordData_resetPassword &&
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
    return (newBuiltValueToStringHelper(r'GResetPasswordData_resetPassword')
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GResetPasswordData_resetPasswordBuilder
    implements
        Builder<
          GResetPasswordData_resetPassword,
          GResetPasswordData_resetPasswordBuilder
        > {
  _$GResetPasswordData_resetPassword? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GResetPasswordData_resetPasswordBuilder() {
    GResetPasswordData_resetPassword._initializeBuilder(this);
  }

  GResetPasswordData_resetPasswordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GResetPasswordData_resetPassword other) {
    _$v = other as _$GResetPasswordData_resetPassword;
  }

  @override
  void update(void Function(GResetPasswordData_resetPasswordBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GResetPasswordData_resetPassword build() => _build();

  _$GResetPasswordData_resetPassword _build() {
    final _$result =
        _$v ??
        _$GResetPasswordData_resetPassword._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GResetPasswordData_resetPassword',
            'G__typename',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'GResetPasswordData_resetPassword',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
