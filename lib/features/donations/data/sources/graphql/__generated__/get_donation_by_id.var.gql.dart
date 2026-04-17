// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'get_donation_by_id.var.gql.g.dart';

abstract class GGetDonationByIdVars
    implements Built<GGetDonationByIdVars, GGetDonationByIdVarsBuilder> {
  GGetDonationByIdVars._();

  factory GGetDonationByIdVars([
    void Function(GGetDonationByIdVarsBuilder b) updates,
  ]) = _$GGetDonationByIdVars;

  String get id;
  static Serializer<GGetDonationByIdVars> get serializer =>
      _$gGetDonationByIdVarsSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GGetDonationByIdVars.serializer, this)
          as Map<String, dynamic>);

  static GGetDonationByIdVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GGetDonationByIdVars.serializer, json);
}
