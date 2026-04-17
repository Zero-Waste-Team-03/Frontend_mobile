// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'get_myDonations.var.gql.g.dart';

abstract class GMyDonationsVars
    implements Built<GMyDonationsVars, GMyDonationsVarsBuilder> {
  GMyDonationsVars._();

  factory GMyDonationsVars([void Function(GMyDonationsVarsBuilder b) updates]) =
      _$GMyDonationsVars;

  _i1.GPaginationInput? get pagination;
  _i1.GDonationsFilterInput? get filter;
  static Serializer<GMyDonationsVars> get serializer =>
      _$gMyDonationsVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GMyDonationsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GMyDonationsVars.serializer,
        json,
      );
}
