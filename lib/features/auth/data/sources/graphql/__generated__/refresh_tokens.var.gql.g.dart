// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_tokens.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRefreshTokensVars> _$gRefreshTokensVarsSerializer =
    _$GRefreshTokensVarsSerializer();

class _$GRefreshTokensVarsSerializer
    implements StructuredSerializer<GRefreshTokensVars> {
  @override
  final Iterable<Type> types = const [GRefreshTokensVars, _$GRefreshTokensVars];
  @override
  final String wireName = 'GRefreshTokensVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GRefreshTokensVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GRefreshTokensVarsBuilder().build();
  }
}

class _$GRefreshTokensVars extends GRefreshTokensVars {
  factory _$GRefreshTokensVars([
    void Function(GRefreshTokensVarsBuilder)? updates,
  ]) => (GRefreshTokensVarsBuilder()..update(updates))._build();

  _$GRefreshTokensVars._() : super._();
  @override
  GRefreshTokensVars rebuild(
    void Function(GRefreshTokensVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensVarsBuilder toBuilder() =>
      GRefreshTokensVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensVars;
  }

  @override
  int get hashCode {
    return 172779464;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GRefreshTokensVars').toString();
  }
}

class GRefreshTokensVarsBuilder
    implements Builder<GRefreshTokensVars, GRefreshTokensVarsBuilder> {
  _$GRefreshTokensVars? _$v;

  GRefreshTokensVarsBuilder();

  @override
  void replace(GRefreshTokensVars other) {
    _$v = other as _$GRefreshTokensVars;
  }

  @override
  void update(void Function(GRefreshTokensVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensVars build() => _build();

  _$GRefreshTokensVars _build() {
    final _$result = _$v ?? _$GRefreshTokensVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
