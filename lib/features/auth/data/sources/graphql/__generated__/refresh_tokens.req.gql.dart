// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/refresh_tokens.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/refresh_tokens.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/refresh_tokens.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'refresh_tokens.req.gql.g.dart';

abstract class GRefreshTokensReq
    implements
        Built<GRefreshTokensReq, GRefreshTokensReqBuilder>,
        _i1.OperationRequest<_i2.GRefreshTokensData, _i3.GRefreshTokensVars> {
  GRefreshTokensReq._();

  factory GRefreshTokensReq(
          [void Function(GRefreshTokensReqBuilder b) updates]) =
      _$GRefreshTokensReq;

  static void _initializeBuilder(GRefreshTokensReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'RefreshTokens',
    )
    ..executeOnListen = true;

  @override
  _i3.GRefreshTokensVars get vars;
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
  _i2.GRefreshTokensData? Function(
    _i2.GRefreshTokensData?,
    _i2.GRefreshTokensData?,
  )? get updateResult;
  @override
  _i2.GRefreshTokensData? get optimisticResponse;
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
  _i2.GRefreshTokensData? parseData(Map<String, dynamic> json) =>
      _i2.GRefreshTokensData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GRefreshTokensData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GRefreshTokensData, _i3.GRefreshTokensVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GRefreshTokensReq> get serializer =>
      _$gRefreshTokensReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GRefreshTokensReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokensReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GRefreshTokensReq.serializer,
        json,
      );
}
