// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/core/network/graphql/__generated__/refresh_tokens_interceptor.ast.gql.dart'
    as _i5;
import 'package:gaspzero/core/network/graphql/__generated__/refresh_tokens_interceptor.data.gql.dart'
    as _i2;
import 'package:gaspzero/core/network/graphql/__generated__/refresh_tokens_interceptor.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'refresh_tokens_interceptor.req.gql.g.dart';

abstract class GRefreshTokensForInterceptorReq
    implements
        Built<GRefreshTokensForInterceptorReq,
            GRefreshTokensForInterceptorReqBuilder>,
        _i1.OperationRequest<_i2.GRefreshTokensForInterceptorData,
            _i3.GRefreshTokensForInterceptorVars> {
  GRefreshTokensForInterceptorReq._();

  factory GRefreshTokensForInterceptorReq(
          [void Function(GRefreshTokensForInterceptorReqBuilder b) updates]) =
      _$GRefreshTokensForInterceptorReq;

  static void _initializeBuilder(GRefreshTokensForInterceptorReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'RefreshTokensForInterceptor',
    )
    ..executeOnListen = true;

  @override
  _i3.GRefreshTokensForInterceptorVars get vars;
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
  _i2.GRefreshTokensForInterceptorData? Function(
    _i2.GRefreshTokensForInterceptorData?,
    _i2.GRefreshTokensForInterceptorData?,
  )? get updateResult;
  @override
  _i2.GRefreshTokensForInterceptorData? get optimisticResponse;
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
  _i2.GRefreshTokensForInterceptorData? parseData(Map<String, dynamic> json) =>
      _i2.GRefreshTokensForInterceptorData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GRefreshTokensForInterceptorData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GRefreshTokensForInterceptorData,
      _i3.GRefreshTokensForInterceptorVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GRefreshTokensForInterceptorReq> get serializer =>
      _$gRefreshTokensForInterceptorReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GRefreshTokensForInterceptorReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokensForInterceptorReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GRefreshTokensForInterceptorReq.serializer,
        json,
      );
}
