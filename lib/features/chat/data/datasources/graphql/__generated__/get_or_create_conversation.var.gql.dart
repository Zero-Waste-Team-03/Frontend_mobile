// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'get_or_create_conversation.var.gql.g.dart';

abstract class GGetOrCreateConversationVars
    implements
        Built<GGetOrCreateConversationVars,
            GGetOrCreateConversationVarsBuilder> {
  GGetOrCreateConversationVars._();

  factory GGetOrCreateConversationVars(
          [void Function(GGetOrCreateConversationVarsBuilder b) updates]) =
      _$GGetOrCreateConversationVars;

  String get reservationId;
  static Serializer<GGetOrCreateConversationVars> get serializer =>
      _$gGetOrCreateConversationVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetOrCreateConversationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOrCreateConversationVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOrCreateConversationVars.serializer,
        json,
      );
}
