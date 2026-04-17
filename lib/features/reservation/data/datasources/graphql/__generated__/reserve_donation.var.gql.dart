// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'reserve_donation.var.gql.g.dart';

abstract class GReserveDonationVars
    implements Built<GReserveDonationVars, GReserveDonationVarsBuilder> {
  GReserveDonationVars._();

  factory GReserveDonationVars(
          [void Function(GReserveDonationVarsBuilder b) updates]) =
      _$GReserveDonationVars;

  String get donationId;
  static Serializer<GReserveDonationVars> get serializer =>
      _$gReserveDonationVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationVars.serializer,
        json,
      );
}
