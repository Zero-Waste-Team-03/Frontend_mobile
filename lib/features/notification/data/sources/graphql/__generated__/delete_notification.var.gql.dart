// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'delete_notification.var.gql.g.dart';

abstract class GDeleteNotificationVars
    implements Built<GDeleteNotificationVars, GDeleteNotificationVarsBuilder> {
  GDeleteNotificationVars._();

  factory GDeleteNotificationVars(
          [void Function(GDeleteNotificationVarsBuilder b) updates]) =
      _$GDeleteNotificationVars;

  String get id;
  static Serializer<GDeleteNotificationVars> get serializer =>
      _$gDeleteNotificationVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteNotificationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteNotificationVars.serializer,
        json,
      );
}
