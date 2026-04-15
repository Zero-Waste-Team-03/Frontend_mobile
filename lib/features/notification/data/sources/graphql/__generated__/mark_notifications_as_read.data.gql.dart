// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'mark_notifications_as_read.data.gql.g.dart';

abstract class GMarkNotificationsAsReadData
    implements
        Built<GMarkNotificationsAsReadData,
            GMarkNotificationsAsReadDataBuilder> {
  GMarkNotificationsAsReadData._();

  factory GMarkNotificationsAsReadData(
          [void Function(GMarkNotificationsAsReadDataBuilder b) updates]) =
      _$GMarkNotificationsAsReadData;

  static void _initializeBuilder(GMarkNotificationsAsReadDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMarkNotificationsAsReadData_markNotificationsAsRead
      get markNotificationsAsRead;
  static Serializer<GMarkNotificationsAsReadData> get serializer =>
      _$gMarkNotificationsAsReadDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkNotificationsAsReadData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationsAsReadData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkNotificationsAsReadData.serializer,
        json,
      );
}

abstract class GMarkNotificationsAsReadData_markNotificationsAsRead
    implements
        Built<GMarkNotificationsAsReadData_markNotificationsAsRead,
            GMarkNotificationsAsReadData_markNotificationsAsReadBuilder> {
  GMarkNotificationsAsReadData_markNotificationsAsRead._();

  factory GMarkNotificationsAsReadData_markNotificationsAsRead(
      [void Function(
              GMarkNotificationsAsReadData_markNotificationsAsReadBuilder b)
          updates]) = _$GMarkNotificationsAsReadData_markNotificationsAsRead;

  static void _initializeBuilder(
          GMarkNotificationsAsReadData_markNotificationsAsReadBuilder b) =>
      b..G__typename = 'MessageResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get message;
  static Serializer<GMarkNotificationsAsReadData_markNotificationsAsRead>
      get serializer =>
          _$gMarkNotificationsAsReadDataMarkNotificationsAsReadSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMarkNotificationsAsReadData_markNotificationsAsRead.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMarkNotificationsAsReadData_markNotificationsAsRead? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkNotificationsAsReadData_markNotificationsAsRead.serializer,
        json,
      );
}
