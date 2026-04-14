// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'reservation_fields.var.gql.g.dart';

abstract class GReservationFieldsVars
    implements Built<GReservationFieldsVars, GReservationFieldsVarsBuilder> {
  GReservationFieldsVars._();

  factory GReservationFieldsVars(
          [void Function(GReservationFieldsVarsBuilder b) updates]) =
      _$GReservationFieldsVars;

  static Serializer<GReservationFieldsVars> get serializer =>
      _$gReservationFieldsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReservationFieldsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReservationFieldsVars.serializer,
        json,
      );
}
