// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'reset_password.data.gql.g.dart';

abstract class GResetPasswordData
    implements Built<GResetPasswordData, GResetPasswordDataBuilder> {
  GResetPasswordData._();

  factory GResetPasswordData([
    void Function(GResetPasswordDataBuilder b) updates,
  ]) = _$GResetPasswordData;

  static void _initializeBuilder(GResetPasswordDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GResetPasswordData_resetPassword get resetPassword;
  static Serializer<GResetPasswordData> get serializer =>
      _$gResetPasswordDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GResetPasswordData.serializer, this)
          as Map<String, dynamic>);

  static GResetPasswordData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GResetPasswordData.serializer, json);
}

abstract class GResetPasswordData_resetPassword
    implements
        Built<
          GResetPasswordData_resetPassword,
          GResetPasswordData_resetPasswordBuilder
        > {
  GResetPasswordData_resetPassword._();

  factory GResetPasswordData_resetPassword([
    void Function(GResetPasswordData_resetPasswordBuilder b) updates,
  ]) = _$GResetPasswordData_resetPassword;

  static void _initializeBuilder(GResetPasswordData_resetPasswordBuilder b) =>
      b..G__typename = 'MessageResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get message;
  static Serializer<GResetPasswordData_resetPassword> get serializer =>
      _$gResetPasswordDataResetPasswordSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GResetPasswordData_resetPassword.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GResetPasswordData_resetPassword? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GResetPasswordData_resetPassword.serializer,
    json,
  );
}
