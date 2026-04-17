// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'get_notifications.var.gql.g.dart';

abstract class GGetNotificationsVars
    implements Built<GGetNotificationsVars, GGetNotificationsVarsBuilder> {
  GGetNotificationsVars._();

  factory GGetNotificationsVars(
          [void Function(GGetNotificationsVarsBuilder b) updates]) =
      _$GGetNotificationsVars;

  _i1.GPaginationQueryInput? get pagination;
  static Serializer<GGetNotificationsVars> get serializer =>
      _$gGetNotificationsVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GGetNotificationsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GGetNotificationsVars.serializer,
        json,
      );
}
