// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'mark_notifications_as_read.var.gql.g.dart';

abstract class GMarkNotificationsAsReadVars
    implements
        Built<GMarkNotificationsAsReadVars,
            GMarkNotificationsAsReadVarsBuilder> {
  GMarkNotificationsAsReadVars._();

  factory GMarkNotificationsAsReadVars(
          [void Function(GMarkNotificationsAsReadVarsBuilder b) updates]) =
      _$GMarkNotificationsAsReadVars;

  _i1.GUpdateReadNotificationsInput get input;
  static Serializer<GMarkNotificationsAsReadVars> get serializer =>
      _$gMarkNotificationsAsReadVarsSerializer;

  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GMarkNotificationsAsReadVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationsAsReadVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GMarkNotificationsAsReadVars.serializer,
        json,
      );
}
