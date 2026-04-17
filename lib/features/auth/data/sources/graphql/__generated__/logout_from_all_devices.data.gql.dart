// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'logout_from_all_devices.data.gql.g.dart';

abstract class GLogoutFromAllDevicesData
    implements
        Built<GLogoutFromAllDevicesData, GLogoutFromAllDevicesDataBuilder> {
  GLogoutFromAllDevicesData._();

  factory GLogoutFromAllDevicesData(
          [void Function(GLogoutFromAllDevicesDataBuilder b) updates]) =
      _$GLogoutFromAllDevicesData;

  static void _initializeBuilder(GLogoutFromAllDevicesDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GLogoutFromAllDevicesData_logoutFromAllDevices get logoutFromAllDevices;
  static Serializer<GLogoutFromAllDevicesData> get serializer =>
      _$gLogoutFromAllDevicesDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLogoutFromAllDevicesData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLogoutFromAllDevicesData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLogoutFromAllDevicesData.serializer,
        json,
      );
}

abstract class GLogoutFromAllDevicesData_logoutFromAllDevices
    implements
        Built<GLogoutFromAllDevicesData_logoutFromAllDevices,
            GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder> {
  GLogoutFromAllDevicesData_logoutFromAllDevices._();

  factory GLogoutFromAllDevicesData_logoutFromAllDevices(
      [void Function(GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder b)
          updates]) = _$GLogoutFromAllDevicesData_logoutFromAllDevices;

  static void _initializeBuilder(
          GLogoutFromAllDevicesData_logoutFromAllDevicesBuilder b) =>
      b..G__typename = 'MessageResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get message;
  static Serializer<GLogoutFromAllDevicesData_logoutFromAllDevices>
      get serializer =>
          _$gLogoutFromAllDevicesDataLogoutFromAllDevicesSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLogoutFromAllDevicesData_logoutFromAllDevices.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLogoutFromAllDevicesData_logoutFromAllDevices? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLogoutFromAllDevicesData_logoutFromAllDevices.serializer,
        json,
      );
}
