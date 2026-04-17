// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'get_or_create_conversation.data.gql.g.dart';

abstract class GGetOrCreateConversationData
    implements
        Built<
          GGetOrCreateConversationData,
          GGetOrCreateConversationDataBuilder
        > {
  GGetOrCreateConversationData._();

  factory GGetOrCreateConversationData([
    void Function(GGetOrCreateConversationDataBuilder b) updates,
  ]) = _$GGetOrCreateConversationData;

  static void _initializeBuilder(GGetOrCreateConversationDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetOrCreateConversationData_getOrCreateConversation
  get getOrCreateConversation;
  static Serializer<GGetOrCreateConversationData> get serializer =>
      _$gGetOrCreateConversationDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetOrCreateConversationData.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetOrCreateConversationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetOrCreateConversationData.serializer,
        json,
      );
}

abstract class GGetOrCreateConversationData_getOrCreateConversation
    implements
        Built<
          GGetOrCreateConversationData_getOrCreateConversation,
          GGetOrCreateConversationData_getOrCreateConversationBuilder
        > {
  GGetOrCreateConversationData_getOrCreateConversation._();

  factory GGetOrCreateConversationData_getOrCreateConversation([
    void Function(GGetOrCreateConversationData_getOrCreateConversationBuilder b)
    updates,
  ]) = _$GGetOrCreateConversationData_getOrCreateConversation;

  static void _initializeBuilder(
    GGetOrCreateConversationData_getOrCreateConversationBuilder b,
  ) => b..G__typename = 'Conversation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  _i2.GDateTime get createdAt;
  _i2.GConversationStatus get status;
  String? get lastMessage;
  String get reservationId;
  static Serializer<GGetOrCreateConversationData_getOrCreateConversation>
  get serializer =>
      _$gGetOrCreateConversationDataGetOrCreateConversationSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetOrCreateConversationData_getOrCreateConversation.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetOrCreateConversationData_getOrCreateConversation? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GGetOrCreateConversationData_getOrCreateConversation.serializer,
    json,
  );
}
