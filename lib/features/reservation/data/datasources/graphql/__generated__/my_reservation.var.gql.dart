// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'my_reservation.var.gql.g.dart';

abstract class GMyReservationVars
    implements Built<GMyReservationVars, GMyReservationVarsBuilder> {
  GMyReservationVars._();

  factory GMyReservationVars(
          [void Function(GMyReservationVarsBuilder b) updates]) =
      _$GMyReservationVars;

  String get id;
  static Serializer<GMyReservationVars> get serializer =>
      _$gMyReservationVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationVars.serializer,
        json,
      );
}
