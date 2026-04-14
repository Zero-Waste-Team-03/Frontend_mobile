// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'login.var.gql.g.dart';

abstract class GLoginVars implements Built<GLoginVars, GLoginVarsBuilder> {
  GLoginVars._();

  factory GLoginVars([void Function(GLoginVarsBuilder b) updates]) =
      _$GLoginVars;

  _i1.GLoginInput get loginInput;
  static Serializer<GLoginVars> get serializer => _$gLoginVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GLoginVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GLoginVars.serializer,
        json,
      );
}
