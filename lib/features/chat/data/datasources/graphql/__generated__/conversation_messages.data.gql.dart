// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'conversation_messages.data.gql.g.dart';

abstract class GGetConversationMessagesData
    implements
        Built<GGetConversationMessagesData,
            GGetConversationMessagesDataBuilder> {
  GGetConversationMessagesData._();

  factory GGetConversationMessagesData(
          [void Function(GGetConversationMessagesDataBuilder b) updates]) =
      _$GGetConversationMessagesData;

  static void _initializeBuilder(GGetConversationMessagesDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetConversationMessagesData_conversationMessages get conversationMessages;
  static Serializer<GGetConversationMessagesData> get serializer =>
      _$gGetConversationMessagesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetConversationMessagesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetConversationMessagesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetConversationMessagesData.serializer,
        json,
      );
}

abstract class GGetConversationMessagesData_conversationMessages
    implements
        Built<GGetConversationMessagesData_conversationMessages,
            GGetConversationMessagesData_conversationMessagesBuilder> {
  GGetConversationMessagesData_conversationMessages._();

  factory GGetConversationMessagesData_conversationMessages(
      [void Function(GGetConversationMessagesData_conversationMessagesBuilder b)
          updates]) = _$GGetConversationMessagesData_conversationMessages;

  static void _initializeBuilder(
          GGetConversationMessagesData_conversationMessagesBuilder b) =>
      b..G__typename = 'PaginatedMessages';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  int get totalCount;
  int get page;
  int get limit;
  bool get hasNextPage;
  bool get hasPreviousPage;
  BuiltList<GGetConversationMessagesData_conversationMessages_items> get items;
  static Serializer<GGetConversationMessagesData_conversationMessages>
      get serializer =>
          _$gGetConversationMessagesDataConversationMessagesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetConversationMessagesData_conversationMessages.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetConversationMessagesData_conversationMessages? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetConversationMessagesData_conversationMessages.serializer,
        json,
      );
}

abstract class GGetConversationMessagesData_conversationMessages_items
    implements
        Built<GGetConversationMessagesData_conversationMessages_items,
            GGetConversationMessagesData_conversationMessages_itemsBuilder> {
  GGetConversationMessagesData_conversationMessages_items._();

  factory GGetConversationMessagesData_conversationMessages_items(
      [void Function(
              GGetConversationMessagesData_conversationMessages_itemsBuilder b)
          updates]) = _$GGetConversationMessagesData_conversationMessages_items;

  static void _initializeBuilder(
          GGetConversationMessagesData_conversationMessages_itemsBuilder b) =>
      b..G__typename = 'ChatMessage';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get content;
  _i2.GDateTime get createdAt;
  bool get isModerated;
  String get senderId;
  String get conversationId;
  static Serializer<GGetConversationMessagesData_conversationMessages_items>
      get serializer =>
          _$gGetConversationMessagesDataConversationMessagesItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetConversationMessagesData_conversationMessages_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetConversationMessagesData_conversationMessages_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetConversationMessagesData_conversationMessages_items.serializer,
        json,
      );
}
