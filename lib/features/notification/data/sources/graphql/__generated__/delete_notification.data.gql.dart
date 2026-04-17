// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'delete_notification.data.gql.g.dart';

abstract class GDeleteNotificationData
    implements Built<GDeleteNotificationData, GDeleteNotificationDataBuilder> {
  GDeleteNotificationData._();

  factory GDeleteNotificationData(
          [void Function(GDeleteNotificationDataBuilder b) updates]) =
      _$GDeleteNotificationData;

  static void _initializeBuilder(GDeleteNotificationDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GDeleteNotificationData_deleteNotification get deleteNotification;
  static Serializer<GDeleteNotificationData> get serializer =>
      _$gDeleteNotificationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteNotificationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteNotificationData.serializer,
        json,
      );
}

abstract class GDeleteNotificationData_deleteNotification
    implements
        Built<GDeleteNotificationData_deleteNotification,
            GDeleteNotificationData_deleteNotificationBuilder> {
  GDeleteNotificationData_deleteNotification._();

  factory GDeleteNotificationData_deleteNotification(
      [void Function(GDeleteNotificationData_deleteNotificationBuilder b)
          updates]) = _$GDeleteNotificationData_deleteNotification;

  static void _initializeBuilder(
          GDeleteNotificationData_deleteNotificationBuilder b) =>
      b..G__typename = 'MessageResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get message;
  static Serializer<GDeleteNotificationData_deleteNotification>
      get serializer => _$gDeleteNotificationDataDeleteNotificationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDeleteNotificationData_deleteNotification.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationData_deleteNotification? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDeleteNotificationData_deleteNotification.serializer,
        json,
      );
}
