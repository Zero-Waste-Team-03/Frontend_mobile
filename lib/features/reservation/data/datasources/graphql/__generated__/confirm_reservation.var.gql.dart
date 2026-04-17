// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'confirm_reservation.var.gql.g.dart';

abstract class GConfirmReservationVars
    implements Built<GConfirmReservationVars, GConfirmReservationVarsBuilder> {
  GConfirmReservationVars._();

  factory GConfirmReservationVars([
    void Function(GConfirmReservationVarsBuilder b) updates,
  ]) = _$GConfirmReservationVars;

  String get id;
  static Serializer<GConfirmReservationVars> get serializer =>
      _$gConfirmReservationVarsSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GConfirmReservationVars.serializer, this)
          as Map<String, dynamic>);

  static GConfirmReservationVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GConfirmReservationVars.serializer, json);
}
