// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'forgot_password.var.gql.g.dart';

abstract class GForgotPasswordVars
    implements Built<GForgotPasswordVars, GForgotPasswordVarsBuilder> {
  GForgotPasswordVars._();

  factory GForgotPasswordVars(
          [void Function(GForgotPasswordVarsBuilder b) updates]) =
      _$GForgotPasswordVars;

  String get email;
  static Serializer<GForgotPasswordVars> get serializer =>
      _$gForgotPasswordVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GForgotPasswordVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GForgotPasswordVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GForgotPasswordVars.serializer,
        json,
      );
}
