// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'my_active_conversations.var.gql.g.dart';

abstract class GMyActiveConversationsVars
    implements
        Built<GMyActiveConversationsVars, GMyActiveConversationsVarsBuilder> {
  GMyActiveConversationsVars._();

  factory GMyActiveConversationsVars(
          [void Function(GMyActiveConversationsVarsBuilder b) updates]) =
      _$GMyActiveConversationsVars;

  static Serializer<GMyActiveConversationsVars> get serializer =>
      _$gMyActiveConversationsVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyActiveConversationsVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyActiveConversationsVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyActiveConversationsVars.serializer,
        json,
      );
}
