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
  BuiltList<GGetNotificationsData_notifications> get notifications;
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

abstract class GGetNotificationsData_notifications
    implements
        Built<GGetNotificationsData_notifications,
            GGetNotificationsData_notificationsBuilder> {
  GGetNotificationsData_notifications._();

  factory GGetNotificationsData_notifications(
      [void Function(GGetNotificationsData_notificationsBuilder b)
          updates]) = _$GGetNotificationsData_notifications;

  static void _initializeBuilder(
          GGetNotificationsData_notificationsBuilder b) =>
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
  static Serializer<GGetNotificationsData_notifications> get serializer =>
      _$gGetNotificationsDataNotificationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetNotificationsData_notifications.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsData_notifications? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetNotificationsData_notifications.serializer,
        json,
      );
}
