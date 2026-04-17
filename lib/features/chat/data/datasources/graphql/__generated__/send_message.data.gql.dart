// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'send_message.data.gql.g.dart';

abstract class GSendMessageData
    implements Built<GSendMessageData, GSendMessageDataBuilder> {
  GSendMessageData._();

  factory GSendMessageData([void Function(GSendMessageDataBuilder b) updates]) =
      _$GSendMessageData;

  static void _initializeBuilder(GSendMessageDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSendMessageData_sendMessage get sendMessage;
  static Serializer<GSendMessageData> get serializer =>
      _$gSendMessageDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GSendMessageData.serializer, this)
          as Map<String, dynamic>);

  static GSendMessageData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GSendMessageData.serializer, json);
}

abstract class GSendMessageData_sendMessage
    implements
        Built<
          GSendMessageData_sendMessage,
          GSendMessageData_sendMessageBuilder
        > {
  GSendMessageData_sendMessage._();

  factory GSendMessageData_sendMessage([
    void Function(GSendMessageData_sendMessageBuilder b) updates,
  ]) = _$GSendMessageData_sendMessage;

  static void _initializeBuilder(GSendMessageData_sendMessageBuilder b) =>
      b..G__typename = 'ChatMessage';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get content;
  _i2.GDateTime get createdAt;
  bool get isModerated;
  String get senderId;
  String get conversationId;
  static Serializer<GSendMessageData_sendMessage> get serializer =>
      _$gSendMessageDataSendMessageSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GSendMessageData_sendMessage.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GSendMessageData_sendMessage? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendMessageData_sendMessage.serializer,
        json,
      );
}
