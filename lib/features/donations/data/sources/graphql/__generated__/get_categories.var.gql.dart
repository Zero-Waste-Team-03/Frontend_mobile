// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'get_categories.var.gql.g.dart';

abstract class GGetCategoriesVars
    implements Built<GGetCategoriesVars, GGetCategoriesVarsBuilder> {
  GGetCategoriesVars._();

  factory GGetCategoriesVars(
          [void Function(GGetCategoriesVarsBuilder b) updates]) =
      _$GGetCategoriesVars;

  _i1.GPaginationInput? get pagination;
  static Serializer<GGetCategoriesVars> get serializer =>
      _$gGetCategoriesVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GGetCategoriesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetCategoriesVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GGetCategoriesVars.serializer,
        json,
      );
}
