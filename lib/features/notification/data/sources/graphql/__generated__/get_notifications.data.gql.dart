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

part 'get_notifications.data.gql.g.dart';

abstract class GGetNotificationsData
    implements Built<GGetNotificationsData, GGetNotificationsDataBuilder> {
  GGetNotificationsData._();

  factory GGetNotificationsData(
          [void Function(GGetNotificationsDataBuilder b) updates]) =
      _$GGetNotificationsData;

  static void _initializeBuilder(GGetNotificationsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetNotificationsData_getNotifications get getNotifications;
  static Serializer<GGetNotificationsData> get serializer =>
      _$gGetNotificationsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData.serializer,
        json,
      );
}

abstract class GGetNotificationsData_getNotifications
    implements
        Built<GGetNotificationsData_getNotifications,
            GGetNotificationsData_getNotificationsBuilder> {
  GGetNotificationsData_getNotifications._();

  factory GGetNotificationsData_getNotifications(
      [void Function(GGetNotificationsData_getNotificationsBuilder b)
          updates]) = _$GGetNotificationsData_getNotifications;

  static void _initializeBuilder(
          GGetNotificationsData_getNotificationsBuilder b) =>
      b..G__typename = 'PaginatedNotifications';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get hasNextPage;
  bool get hasPreviousPage;
  int get limit;
  int get page;
  int get totalCount;
  BuiltList<GGetNotificationsData_getNotifications_items>? get items;
  static Serializer<GGetNotificationsData_getNotifications> get serializer =>
      _$gGetNotificationsDataGetNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData_getNotifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData_getNotifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData_getNotifications.serializer,
        json,
      );
}

abstract class GGetNotificationsData_getNotifications_items
    implements
        Built<GGetNotificationsData_getNotifications_items,
            GGetNotificationsData_getNotifications_itemsBuilder> {
  GGetNotificationsData_getNotifications_items._();

  factory GGetNotificationsData_getNotifications_items(
      [void Function(GGetNotificationsData_getNotifications_itemsBuilder b)
          updates]) = _$GGetNotificationsData_getNotifications_items;

  static void _initializeBuilder(
          GGetNotificationsData_getNotifications_itemsBuilder b) =>
      b..G__typename = 'Notification';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get body;
  _i2.GDateTime get createdAt;
  String get id;
  bool get isRead;
  String get receiverId;
  String get title;
  String get type;
  _i2.GDateTime get updatedAt;
  static Serializer<GGetNotificationsData_getNotifications_items>
      get serializer => _$gGetNotificationsDataGetNotificationsItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData_getNotifications_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData_getNotifications_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData_getNotifications_items.serializer,
        json,
      );
}
