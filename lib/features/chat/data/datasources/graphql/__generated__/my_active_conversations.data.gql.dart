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

part 'my_active_conversations.data.gql.g.dart';

abstract class GMyActiveConversationsData
    implements
        Built<GMyActiveConversationsData, GMyActiveConversationsDataBuilder> {
  GMyActiveConversationsData._();

  factory GMyActiveConversationsData(
          [void Function(GMyActiveConversationsDataBuilder b) updates]) =
      _$GMyActiveConversationsData;

  static void _initializeBuilder(GMyActiveConversationsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GMyActiveConversationsData_myActiveConversations>
      get myActiveConversations;
  static Serializer<GMyActiveConversationsData> get serializer =>
      _$gMyActiveConversationsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyActiveConversationsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyActiveConversationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyActiveConversationsData.serializer,
        json,
      );
}

abstract class GMyActiveConversationsData_myActiveConversations
    implements
        Built<GMyActiveConversationsData_myActiveConversations,
            GMyActiveConversationsData_myActiveConversationsBuilder> {
  GMyActiveConversationsData_myActiveConversations._();

  factory GMyActiveConversationsData_myActiveConversations(
      [void Function(GMyActiveConversationsData_myActiveConversationsBuilder b)
          updates]) = _$GMyActiveConversationsData_myActiveConversations;

  static void _initializeBuilder(
          GMyActiveConversationsData_myActiveConversationsBuilder b) =>
      b..G__typename = 'ConversationPreview';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get reservationId;
  _i2.GConversationStatus get status;
  String? get lastMessage;
  _i2.GDateTime get createdAt;
  GMyActiveConversationsData_myActiveConversations_counterpart get counterpart;
  static Serializer<GMyActiveConversationsData_myActiveConversations>
      get serializer =>
          _$gMyActiveConversationsDataMyActiveConversationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyActiveConversationsData_myActiveConversations.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyActiveConversationsData_myActiveConversations? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyActiveConversationsData_myActiveConversations.serializer,
        json,
      );
}

abstract class GMyActiveConversationsData_myActiveConversations_counterpart
    implements
        Built<GMyActiveConversationsData_myActiveConversations_counterpart,
            GMyActiveConversationsData_myActiveConversations_counterpartBuilder> {
  GMyActiveConversationsData_myActiveConversations_counterpart._();

  factory GMyActiveConversationsData_myActiveConversations_counterpart(
          [void Function(
                  GMyActiveConversationsData_myActiveConversations_counterpartBuilder
                      b)
              updates]) =
      _$GMyActiveConversationsData_myActiveConversations_counterpart;

  static void _initializeBuilder(
          GMyActiveConversationsData_myActiveConversations_counterpartBuilder
              b) =>
      b..G__typename = 'ChatCounterpartPreview';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get displayName;
  String? get avatarUrl;
  static Serializer<
          GMyActiveConversationsData_myActiveConversations_counterpart>
      get serializer =>
          _$gMyActiveConversationsDataMyActiveConversationsCounterpartSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyActiveConversationsData_myActiveConversations_counterpart.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyActiveConversationsData_myActiveConversations_counterpart? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyActiveConversationsData_myActiveConversations_counterpart.serializer,
        json,
      );
}
