// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'send_verification.var.gql.g.dart';

abstract class GSendVerificationVars
    implements Built<GSendVerificationVars, GSendVerificationVarsBuilder> {
  GSendVerificationVars._();

  factory GSendVerificationVars(
          [void Function(GSendVerificationVarsBuilder b) updates]) =
      _$GSendVerificationVars;

  String get email;
  static Serializer<GSendVerificationVars> get serializer =>
      _$gSendVerificationVarsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendVerificationVars.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendVerificationVars? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendVerificationVars.serializer,
        json,
      );
}
