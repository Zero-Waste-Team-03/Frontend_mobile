// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GResetPasswordVars> _$gResetPasswordVarsSerializer =
    _$GResetPasswordVarsSerializer();

class _$GResetPasswordVarsSerializer
    implements StructuredSerializer<GResetPasswordVars> {
  @override
  final Iterable<Type> types = const [GResetPasswordVars, _$GResetPasswordVars];
  @override
  final String wireName = 'GResetPasswordVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GResetPasswordVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'resetPasswordInput',
      serializers.serialize(
        object.resetPasswordInput,
        specifiedType: const FullType(_i1.GResetPasswordInput),
      ),
    ];

    return result;
  }

  @override
  GResetPasswordVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GResetPasswordVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'resetPasswordInput':
          result.resetPasswordInput.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GResetPasswordInput),
                )!
                as _i1.GResetPasswordInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GResetPasswordVars extends GResetPasswordVars {
  @override
  final _i1.GResetPasswordInput resetPasswordInput;

  factory _$GResetPasswordVars([
    void Function(GResetPasswordVarsBuilder)? updates,
  ]) => (GResetPasswordVarsBuilder()..update(updates))._build();

  _$GResetPasswordVars._({required this.resetPasswordInput}) : super._();
  @override
  GResetPasswordVars rebuild(
    void Function(GResetPasswordVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GResetPasswordVarsBuilder toBuilder() =>
      GResetPasswordVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GResetPasswordVars &&
        resetPasswordInput == other.resetPasswordInput;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, resetPasswordInput.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GResetPasswordVars',
    )..add('resetPasswordInput', resetPasswordInput)).toString();
  }
}

class GResetPasswordVarsBuilder
    implements Builder<GResetPasswordVars, GResetPasswordVarsBuilder> {
  _$GResetPasswordVars? _$v;

  _i1.GResetPasswordInputBuilder? _resetPasswordInput;
  _i1.GResetPasswordInputBuilder get resetPasswordInput =>
      _$this._resetPasswordInput ??= _i1.GResetPasswordInputBuilder();
  set resetPasswordInput(_i1.GResetPasswordInputBuilder? resetPasswordInput) =>
      _$this._resetPasswordInput = resetPasswordInput;

  GResetPasswordVarsBuilder();

  GResetPasswordVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _resetPasswordInput = $v.resetPasswordInput.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GResetPasswordVars other) {
    _$v = other as _$GResetPasswordVars;
  }

  @override
  void update(void Function(GResetPasswordVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GResetPasswordVars build() => _build();

  _$GResetPasswordVars _build() {
    _$GResetPasswordVars _$result;
    try {
      _$result =
          _$v ??
          _$GResetPasswordVars._(
            resetPasswordInput: resetPasswordInput.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'resetPasswordInput';
        resetPasswordInput.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GResetPasswordVars',
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
