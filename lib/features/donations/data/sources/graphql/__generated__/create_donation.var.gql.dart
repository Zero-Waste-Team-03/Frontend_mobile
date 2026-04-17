// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'create_donation.var.gql.g.dart';

abstract class GCreateDonationVars
    implements Built<GCreateDonationVars, GCreateDonationVarsBuilder> {
  GCreateDonationVars._();

  factory GCreateDonationVars(
          [void Function(GCreateDonationVarsBuilder b) updates]) =
      _$GCreateDonationVars;

  _i1.GCreateDonationInput get input;
  static Serializer<GCreateDonationVars> get serializer =>
      _$gCreateDonationVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GCreateDonationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateDonationVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GCreateDonationVars.serializer,
        json,
      );
}
