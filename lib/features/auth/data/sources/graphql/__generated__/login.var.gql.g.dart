// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GLoginVars> _$gLoginVarsSerializer = _$GLoginVarsSerializer();

class _$GLoginVarsSerializer implements StructuredSerializer<GLoginVars> {
  @override
  final Iterable<Type> types = const [GLoginVars, _$GLoginVars];
  @override
  final String wireName = 'GLoginVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GLoginVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'loginInput',
      serializers.serialize(
        object.loginInput,
        specifiedType: const FullType(_i1.GLoginInput),
      ),
    ];

    return result;
  }

  @override
  GLoginVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GLoginVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'loginInput':
          result.loginInput.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GLoginInput),
                )!
                as _i1.GLoginInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GLoginVars extends GLoginVars {
  @override
  final _i1.GLoginInput loginInput;

  factory _$GLoginVars([void Function(GLoginVarsBuilder)? updates]) =>
      (GLoginVarsBuilder()..update(updates))._build();

  _$GLoginVars._({required this.loginInput}) : super._();
  @override
  GLoginVars rebuild(void Function(GLoginVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GLoginVarsBuilder toBuilder() => GLoginVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLoginVars && loginInput == other.loginInput;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, loginInput.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GLoginVars',
    )..add('loginInput', loginInput)).toString();
  }
}

class GLoginVarsBuilder implements Builder<GLoginVars, GLoginVarsBuilder> {
  _$GLoginVars? _$v;

  _i1.GLoginInputBuilder? _loginInput;
  _i1.GLoginInputBuilder get loginInput =>
      _$this._loginInput ??= _i1.GLoginInputBuilder();
  set loginInput(_i1.GLoginInputBuilder? loginInput) =>
      _$this._loginInput = loginInput;

  GLoginVarsBuilder();

  GLoginVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _loginInput = $v.loginInput.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GLoginVars other) {
    _$v = other as _$GLoginVars;
  }

  @override
  void update(void Function(GLoginVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLoginVars build() => _build();

  _$GLoginVars _build() {
    _$GLoginVars _$result;
    try {
      _$result = _$v ?? _$GLoginVars._(loginInput: loginInput.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'loginInput';
        loginInput.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GLoginVars',
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
