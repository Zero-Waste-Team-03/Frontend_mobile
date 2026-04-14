// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_tokens_interceptor.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRefreshTokensForInterceptorVars>
_$gRefreshTokensForInterceptorVarsSerializer =
    _$GRefreshTokensForInterceptorVarsSerializer();

class _$GRefreshTokensForInterceptorVarsSerializer
    implements StructuredSerializer<GRefreshTokensForInterceptorVars> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokensForInterceptorVars,
    _$GRefreshTokensForInterceptorVars,
  ];
  @override
  final String wireName = 'GRefreshTokensForInterceptorVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensForInterceptorVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GRefreshTokensForInterceptorVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GRefreshTokensForInterceptorVarsBuilder().build();
  }
}

class _$GRefreshTokensForInterceptorVars
    extends GRefreshTokensForInterceptorVars {
  factory _$GRefreshTokensForInterceptorVars([
    void Function(GRefreshTokensForInterceptorVarsBuilder)? updates,
  ]) => (GRefreshTokensForInterceptorVarsBuilder()..update(updates))._build();

  _$GRefreshTokensForInterceptorVars._() : super._();
  @override
  GRefreshTokensForInterceptorVars rebuild(
    void Function(GRefreshTokensForInterceptorVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensForInterceptorVarsBuilder toBuilder() =>
      GRefreshTokensForInterceptorVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensForInterceptorVars;
  }

  @override
  int get hashCode {
    return 176909678;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(
      r'GRefreshTokensForInterceptorVars',
    ).toString();
  }
}

class GRefreshTokensForInterceptorVarsBuilder
    implements
        Builder<
          GRefreshTokensForInterceptorVars,
          GRefreshTokensForInterceptorVarsBuilder
        > {
  _$GRefreshTokensForInterceptorVars? _$v;

  GRefreshTokensForInterceptorVarsBuilder();

  @override
  void replace(GRefreshTokensForInterceptorVars other) {
    _$v = other as _$GRefreshTokensForInterceptorVars;
  }

  @override
  void update(void Function(GRefreshTokensForInterceptorVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensForInterceptorVars build() => _build();

  _$GRefreshTokensForInterceptorVars _build() {
    final _$result = _$v ?? _$GRefreshTokensForInterceptorVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
