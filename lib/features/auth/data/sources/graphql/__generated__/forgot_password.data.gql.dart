// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'forgot_password.data.gql.g.dart';

abstract class GForgotPasswordData
    implements Built<GForgotPasswordData, GForgotPasswordDataBuilder> {
  GForgotPasswordData._();

  factory GForgotPasswordData(
          [void Function(GForgotPasswordDataBuilder b) updates]) =
      _$GForgotPasswordData;

  static void _initializeBuilder(GForgotPasswordDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GForgotPasswordData_forgotPassword get forgotPassword;
  static Serializer<GForgotPasswordData> get serializer =>
      _$gForgotPasswordDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GForgotPasswordData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GForgotPasswordData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GForgotPasswordData.serializer,
        json,
      );
}

abstract class GForgotPasswordData_forgotPassword
    implements
        Built<GForgotPasswordData_forgotPassword,
            GForgotPasswordData_forgotPasswordBuilder> {
  GForgotPasswordData_forgotPassword._();

  factory GForgotPasswordData_forgotPassword(
      [void Function(GForgotPasswordData_forgotPasswordBuilder b)
          updates]) = _$GForgotPasswordData_forgotPassword;

  static void _initializeBuilder(GForgotPasswordData_forgotPasswordBuilder b) =>
      b..G__typename = 'MessageResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get message;
  static Serializer<GForgotPasswordData_forgotPassword> get serializer =>
      _$gForgotPasswordDataForgotPasswordSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GForgotPasswordData_forgotPassword.serializer,
        this,
      ) as Map<String, dynamic>);

  static GForgotPasswordData_forgotPassword? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GForgotPasswordData_forgotPassword.serializer,
        json,
      );
}
