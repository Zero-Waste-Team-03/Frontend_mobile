// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/mark_transaction_completed.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/mark_transaction_completed.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/mark_transaction_completed.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'mark_transaction_completed.req.gql.g.dart';

abstract class GMarkTransactionCompletedReq
    implements
        Built<
          GMarkTransactionCompletedReq,
          GMarkTransactionCompletedReqBuilder
        >,
        _i1.OperationRequest<
          _i2.GMarkTransactionCompletedData,
          _i3.GMarkTransactionCompletedVars
        > {
  GMarkTransactionCompletedReq._();

  factory GMarkTransactionCompletedReq([
    void Function(GMarkTransactionCompletedReqBuilder b) updates,
  ]) = _$GMarkTransactionCompletedReq;

  static void _initializeBuilder(GMarkTransactionCompletedReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MarkTransactionCompleted',
    )
    ..executeOnListen = true;

  @override
  _i3.GMarkTransactionCompletedVars get vars;
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
  _i2.GMarkTransactionCompletedData? Function(
    _i2.GMarkTransactionCompletedData?,
    _i2.GMarkTransactionCompletedData?,
  )?
  get updateResult;
  @override
  _i2.GMarkTransactionCompletedData? get optimisticResponse;
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
  _i2.GMarkTransactionCompletedData? parseData(Map<String, dynamic> json) =>
      _i2.GMarkTransactionCompletedData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMarkTransactionCompletedData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<
    _i2.GMarkTransactionCompletedData,
    _i3.GMarkTransactionCompletedVars
  >
  transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMarkTransactionCompletedReq> get serializer =>
      _$gMarkTransactionCompletedReqSerializer;

  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(
            GMarkTransactionCompletedReq.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMarkTransactionCompletedReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMarkTransactionCompletedReq.serializer,
        json,
      );
}
