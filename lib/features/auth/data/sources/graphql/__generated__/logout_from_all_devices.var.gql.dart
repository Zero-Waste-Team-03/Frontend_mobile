// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'logout_from_all_devices.var.gql.g.dart';

abstract class GLogoutFromAllDevicesVars
    implements
        Built<GLogoutFromAllDevicesVars, GLogoutFromAllDevicesVarsBuilder> {
  GLogoutFromAllDevicesVars._();

  factory GLogoutFromAllDevicesVars(
          [void Function(GLogoutFromAllDevicesVarsBuilder b) updates]) =
      _$GLogoutFromAllDevicesVars;

  static Serializer<GLogoutFromAllDevicesVars> get serializer =>
      _$gLogoutFromAllDevicesVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLogoutFromAllDevicesVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLogoutFromAllDevicesVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLogoutFromAllDevicesVars.serializer,
        json,
      );
}
