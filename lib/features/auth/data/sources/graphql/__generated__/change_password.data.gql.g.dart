// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GChangePasswordData> _$gChangePasswordDataSerializer =
    _$GChangePasswordDataSerializer();
Serializer<GChangePasswordData_changePassword>
_$gChangePasswordDataChangePasswordSerializer =
    _$GChangePasswordData_changePasswordSerializer();

class _$GChangePasswordDataSerializer
    implements StructuredSerializer<GChangePasswordData> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordData,
    _$GChangePasswordData,
  ];
  @override
  final String wireName = 'GChangePasswordData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GChangePasswordData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'changePassword',
      serializers.serialize(
        object.changePassword,
        specifiedType: const FullType(GChangePasswordData_changePassword),
      ),
    ];

    return result;
  }

  @override
  GChangePasswordData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GChangePasswordDataBuilder();

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
        case 'changePassword':
          result.changePassword.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GChangePasswordData_changePassword,
                  ),
                )!
                as GChangePasswordData_changePassword,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GChangePasswordData_changePasswordSerializer
    implements StructuredSerializer<GChangePasswordData_changePassword> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordData_changePassword,
    _$GChangePasswordData_changePassword,
  ];
  @override
  final String wireName = 'GChangePasswordData_changePassword';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GChangePasswordData_changePassword object, {
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
  GChangePasswordData_changePassword deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GChangePasswordData_changePasswordBuilder();

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

class _$GChangePasswordData extends GChangePasswordData {
  @override
  final String G__typename;
  @override
  final GChangePasswordData_changePassword changePassword;

  factory _$GChangePasswordData([
    void Function(GChangePasswordDataBuilder)? updates,
  ]) => (GChangePasswordDataBuilder()..update(updates))._build();

  _$GChangePasswordData._({
    required this.G__typename,
    required this.changePassword,
  }) : super._();
  @override
  GChangePasswordData rebuild(
    void Function(GChangePasswordDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GChangePasswordDataBuilder toBuilder() =>
      GChangePasswordDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChangePasswordData &&
        G__typename == other.G__typename &&
        changePassword == other.changePassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, changePassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GChangePasswordData')
          ..add('G__typename', G__typename)
          ..add('changePassword', changePassword))
        .toString();
  }
}

class GChangePasswordDataBuilder
    implements Builder<GChangePasswordData, GChangePasswordDataBuilder> {
  _$GChangePasswordData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GChangePasswordData_changePasswordBuilder? _changePassword;
  GChangePasswordData_changePasswordBuilder get changePassword =>
      _$this._changePassword ??= GChangePasswordData_changePasswordBuilder();
  set changePassword(
    GChangePasswordData_changePasswordBuilder? changePassword,
  ) => _$this._changePassword = changePassword;

  GChangePasswordDataBuilder() {
    GChangePasswordData._initializeBuilder(this);
  }

  GChangePasswordDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _changePassword = $v.changePassword.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GChangePasswordData other) {
    _$v = other as _$GChangePasswordData;
  }

  @override
  void update(void Function(GChangePasswordDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordData build() => _build();

  _$GChangePasswordData _build() {
    _$GChangePasswordData _$result;
    try {
      _$result =
          _$v ??
          _$GChangePasswordData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GChangePasswordData',
              'G__typename',
            ),
            changePassword: changePassword.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'changePassword';
        changePassword.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GChangePasswordData',
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

class _$GChangePasswordData_changePassword
    extends GChangePasswordData_changePassword {
  @override
  final String G__typename;
  @override
  final String message;

  factory _$GChangePasswordData_changePassword([
    void Function(GChangePasswordData_changePasswordBuilder)? updates,
  ]) => (GChangePasswordData_changePasswordBuilder()..update(updates))._build();

  _$GChangePasswordData_changePassword._({
    required this.G__typename,
    required this.message,
  }) : super._();
  @override
  GChangePasswordData_changePassword rebuild(
    void Function(GChangePasswordData_changePasswordBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GChangePasswordData_changePasswordBuilder toBuilder() =>
      GChangePasswordData_changePasswordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChangePasswordData_changePassword &&
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
    return (newBuiltValueToStringHelper(r'GChangePasswordData_changePassword')
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GChangePasswordData_changePasswordBuilder
    implements
        Builder<
          GChangePasswordData_changePassword,
          GChangePasswordData_changePasswordBuilder
        > {
  _$GChangePasswordData_changePassword? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GChangePasswordData_changePasswordBuilder() {
    GChangePasswordData_changePassword._initializeBuilder(this);
  }

  GChangePasswordData_changePasswordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GChangePasswordData_changePassword other) {
    _$v = other as _$GChangePasswordData_changePassword;
  }

  @override
  void update(
    void Function(GChangePasswordData_changePasswordBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordData_changePassword build() => _build();

  _$GChangePasswordData_changePassword _build() {
    final _$result =
        _$v ??
        _$GChangePasswordData_changePassword._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GChangePasswordData_changePassword',
            'G__typename',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'GChangePasswordData_changePassword',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
