// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'my_reservations.var.gql.g.dart';

abstract class GMyReservationsVars
    implements Built<GMyReservationsVars, GMyReservationsVarsBuilder> {
  GMyReservationsVars._();

  factory GMyReservationsVars([
    void Function(GMyReservationsVarsBuilder b) updates,
  ]) = _$GMyReservationsVars;

  _i1.GPaginationInput? get pagination;
  static Serializer<GMyReservationsVars> get serializer =>
      _$gMyReservationsVarsSerializer;

  Map<String, dynamic> toJson() =>
      (_i2.serializers.serializeWith(GMyReservationsVars.serializer, this)
          as Map<String, dynamic>);

  static GMyReservationsVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(GMyReservationsVars.serializer, json);
}
