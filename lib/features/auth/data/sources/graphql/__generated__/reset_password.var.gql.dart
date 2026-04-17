// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'reset_password.var.gql.g.dart';

abstract class GResetPasswordVars
    implements Built<GResetPasswordVars, GResetPasswordVarsBuilder> {
  GResetPasswordVars._();

  factory GResetPasswordVars([
    void Function(GResetPasswordVarsBuilder b) updates,
  ]) = _$GResetPasswordVars;

  _i1.GResetPasswordInput get resetPasswordInput;
  static Serializer<GResetPasswordVars> get serializer =>
      _$gResetPasswordVarsSerializer;

  Map<String, dynamic> toJson() =>
      (_i2.serializers.serializeWith(GResetPasswordVars.serializer, this)
          as Map<String, dynamic>);

  static GResetPasswordVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(GResetPasswordVars.serializer, json);
}
