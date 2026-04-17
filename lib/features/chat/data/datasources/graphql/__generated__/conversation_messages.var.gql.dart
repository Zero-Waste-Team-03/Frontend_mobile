// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'conversation_messages.var.gql.g.dart';

abstract class GGetConversationMessagesVars
    implements
        Built<
          GGetConversationMessagesVars,
          GGetConversationMessagesVarsBuilder
        > {
  GGetConversationMessagesVars._();

  factory GGetConversationMessagesVars([
    void Function(GGetConversationMessagesVarsBuilder b) updates,
  ]) = _$GGetConversationMessagesVars;

  _i1.GConversationMessagesInput get input;
  static Serializer<GGetConversationMessagesVars> get serializer =>
      _$gGetConversationMessagesVarsSerializer;

  Map<String, dynamic> toJson() =>
      (_i2.serializers.serializeWith(
            GGetConversationMessagesVars.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetConversationMessagesVars? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GGetConversationMessagesVars.serializer,
        json,
      );
}
