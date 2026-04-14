// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GChangePasswordVars> _$gChangePasswordVarsSerializer =
    _$GChangePasswordVarsSerializer();

class _$GChangePasswordVarsSerializer
    implements StructuredSerializer<GChangePasswordVars> {
  @override
  final Iterable<Type> types = const [
    GChangePasswordVars,
    _$GChangePasswordVars,
  ];
  @override
  final String wireName = 'GChangePasswordVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GChangePasswordVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'changePasswordInput',
      serializers.serialize(
        object.changePasswordInput,
        specifiedType: const FullType(_i1.GChangePasswordInput),
      ),
    ];

    return result;
  }

  @override
  GChangePasswordVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GChangePasswordVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'changePasswordInput':
          result.changePasswordInput.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GChangePasswordInput),
                )!
                as _i1.GChangePasswordInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GChangePasswordVars extends GChangePasswordVars {
  @override
  final _i1.GChangePasswordInput changePasswordInput;

  factory _$GChangePasswordVars([
    void Function(GChangePasswordVarsBuilder)? updates,
  ]) => (GChangePasswordVarsBuilder()..update(updates))._build();

  _$GChangePasswordVars._({required this.changePasswordInput}) : super._();
  @override
  GChangePasswordVars rebuild(
    void Function(GChangePasswordVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GChangePasswordVarsBuilder toBuilder() =>
      GChangePasswordVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GChangePasswordVars &&
        changePasswordInput == other.changePasswordInput;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, changePasswordInput.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GChangePasswordVars',
    )..add('changePasswordInput', changePasswordInput)).toString();
  }
}

class GChangePasswordVarsBuilder
    implements Builder<GChangePasswordVars, GChangePasswordVarsBuilder> {
  _$GChangePasswordVars? _$v;

  _i1.GChangePasswordInputBuilder? _changePasswordInput;
  _i1.GChangePasswordInputBuilder get changePasswordInput =>
      _$this._changePasswordInput ??= _i1.GChangePasswordInputBuilder();
  set changePasswordInput(
    _i1.GChangePasswordInputBuilder? changePasswordInput,
  ) => _$this._changePasswordInput = changePasswordInput;

  GChangePasswordVarsBuilder();

  GChangePasswordVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _changePasswordInput = $v.changePasswordInput.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GChangePasswordVars other) {
    _$v = other as _$GChangePasswordVars;
  }

  @override
  void update(void Function(GChangePasswordVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GChangePasswordVars build() => _build();

  _$GChangePasswordVars _build() {
    _$GChangePasswordVars _$result;
    try {
      _$result =
          _$v ??
          _$GChangePasswordVars._(
            changePasswordInput: changePasswordInput.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'changePasswordInput';
        changePasswordInput.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GChangePasswordVars',
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
