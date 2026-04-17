// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/send_verification.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/send_verification.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/send_verification.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'send_verification.req.gql.g.dart';

abstract class GSendVerificationReq
    implements
        Built<GSendVerificationReq, GSendVerificationReqBuilder>,
        _i1.OperationRequest<
          _i2.GSendVerificationData,
          _i3.GSendVerificationVars
        > {
  GSendVerificationReq._();

  factory GSendVerificationReq([
    void Function(GSendVerificationReqBuilder b) updates,
  ]) = _$GSendVerificationReq;

  static void _initializeBuilder(GSendVerificationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'SendVerification',
    )
    ..executeOnListen = true;

  @override
  _i3.GSendVerificationVars get vars;
  @override
  _i4.Operation get operation;
  @override
  _i4.Request get execRequest => _i4.Request(
    operation: operation,
    variables: vars.toJson(),
    context: context ?? const _i4.Context(),
  );

  @override
  String? get requestId;
  @override
  @BuiltValueField(serialize: false)
  _i2.GSendVerificationData? Function(
    _i2.GSendVerificationData?,
    _i2.GSendVerificationData?,
  )?
  get updateResult;
  @override
  _i2.GSendVerificationData? get optimisticResponse;
  @override
  String? get updateCacheHandlerKey;
  @override
  Map<String, dynamic>? get updateCacheHandlerContext;
  @override
  _i1.FetchPolicy? get fetchPolicy;
  @override
  bool get executeOnListen;
  @override
  @BuiltValueField(serialize: false)
  _i4.Context? get context;
  @override
  _i2.GSendVerificationData? parseData(Map<String, dynamic> json) =>
      _i2.GSendVerificationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GSendVerificationData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GSendVerificationData, _i3.GSendVerificationVars>
  transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GSendVerificationReq> get serializer =>
      _$gSendVerificationReqSerializer;

  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GSendVerificationReq.serializer, this)
          as Map<String, dynamic>);

  static GSendVerificationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GSendVerificationReq.serializer, json);
}
