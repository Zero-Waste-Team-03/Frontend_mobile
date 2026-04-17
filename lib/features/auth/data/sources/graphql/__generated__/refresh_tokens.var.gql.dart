// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'refresh_tokens.var.gql.g.dart';

abstract class GRefreshTokensVars
    implements Built<GRefreshTokensVars, GRefreshTokensVarsBuilder> {
  GRefreshTokensVars._();

  factory GRefreshTokensVars([
    void Function(GRefreshTokensVarsBuilder b) updates,
  ]) = _$GRefreshTokensVars;

  static Serializer<GRefreshTokensVars> get serializer =>
      _$gRefreshTokensVarsSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GRefreshTokensVars.serializer, this)
          as Map<String, dynamic>);

  static GRefreshTokensVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GRefreshTokensVars.serializer, json);
}
