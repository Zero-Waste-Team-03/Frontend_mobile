// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'send_verification.data.gql.g.dart';

abstract class GSendVerificationData
    implements Built<GSendVerificationData, GSendVerificationDataBuilder> {
  GSendVerificationData._();

  factory GSendVerificationData(
          [void Function(GSendVerificationDataBuilder b) updates]) =
      _$GSendVerificationData;

  static void _initializeBuilder(GSendVerificationDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GSendVerificationData_sendVerification get sendVerification;
  static Serializer<GSendVerificationData> get serializer =>
      _$gSendVerificationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendVerificationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendVerificationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendVerificationData.serializer,
        json,
      );
}

abstract class GSendVerificationData_sendVerification
    implements
        Built<GSendVerificationData_sendVerification,
            GSendVerificationData_sendVerificationBuilder> {
  GSendVerificationData_sendVerification._();

  factory GSendVerificationData_sendVerification(
      [void Function(GSendVerificationData_sendVerificationBuilder b)
          updates]) = _$GSendVerificationData_sendVerification;

  static void _initializeBuilder(
          GSendVerificationData_sendVerificationBuilder b) =>
      b..G__typename = 'MessageResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get message;
  static Serializer<GSendVerificationData_sendVerification> get serializer =>
      _$gSendVerificationDataSendVerificationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendVerificationData_sendVerification.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendVerificationData_sendVerification? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendVerificationData_sendVerification.serializer,
        json,
      );
}
