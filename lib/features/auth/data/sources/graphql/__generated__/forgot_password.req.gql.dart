// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/forgot_password.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/forgot_password.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/forgot_password.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'forgot_password.req.gql.g.dart';

abstract class GForgotPasswordReq
    implements
        Built<GForgotPasswordReq, GForgotPasswordReqBuilder>,
        _i1.OperationRequest<_i2.GForgotPasswordData, _i3.GForgotPasswordVars> {
  GForgotPasswordReq._();

  factory GForgotPasswordReq([
    void Function(GForgotPasswordReqBuilder b) updates,
  ]) = _$GForgotPasswordReq;

  static void _initializeBuilder(GForgotPasswordReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ForgotPassword',
    )
    ..executeOnListen = true;

  @override
  _i3.GForgotPasswordVars get vars;
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
  _i2.GForgotPasswordData? Function(
    _i2.GForgotPasswordData?,
    _i2.GForgotPasswordData?,
  )?
  get updateResult;
  @override
  _i2.GForgotPasswordData? get optimisticResponse;
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
  _i2.GForgotPasswordData? parseData(Map<String, dynamic> json) =>
      _i2.GForgotPasswordData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GForgotPasswordData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GForgotPasswordData, _i3.GForgotPasswordVars>
  transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GForgotPasswordReq> get serializer =>
      _$gForgotPasswordReqSerializer;

  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GForgotPasswordReq.serializer, this)
          as Map<String, dynamic>);

  static GForgotPasswordReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GForgotPasswordReq.serializer, json);
}
