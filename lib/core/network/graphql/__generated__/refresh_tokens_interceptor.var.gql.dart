// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'refresh_tokens_interceptor.var.gql.g.dart';

abstract class GRefreshTokensForInterceptorVars
    implements
        Built<
          GRefreshTokensForInterceptorVars,
          GRefreshTokensForInterceptorVarsBuilder
        > {
  GRefreshTokensForInterceptorVars._();

  factory GRefreshTokensForInterceptorVars([
    void Function(GRefreshTokensForInterceptorVarsBuilder b) updates,
  ]) = _$GRefreshTokensForInterceptorVars;

  static Serializer<GRefreshTokensForInterceptorVars> get serializer =>
      _$gRefreshTokensForInterceptorVarsSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GRefreshTokensForInterceptorVars.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GRefreshTokensForInterceptorVars? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GRefreshTokensForInterceptorVars.serializer,
    json,
  );
}
