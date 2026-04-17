// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donation_by_id.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donation_by_id.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donation_by_id.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'get_donation_by_id.req.gql.g.dart';

abstract class GGetDonationByIdReq
    implements
        Built<GGetDonationByIdReq, GGetDonationByIdReqBuilder>,
        _i1.OperationRequest<
          _i2.GGetDonationByIdData,
          _i3.GGetDonationByIdVars
        > {
  GGetDonationByIdReq._();

  factory GGetDonationByIdReq([
    void Function(GGetDonationByIdReqBuilder b) updates,
  ]) = _$GGetDonationByIdReq;

  static void _initializeBuilder(GGetDonationByIdReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetDonationById',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetDonationByIdVars get vars;
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
  _i2.GGetDonationByIdData? Function(
    _i2.GGetDonationByIdData?,
    _i2.GGetDonationByIdData?,
  )?
  get updateResult;
  @override
  _i2.GGetDonationByIdData? get optimisticResponse;
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
  _i2.GGetDonationByIdData? parseData(Map<String, dynamic> json) =>
      _i2.GGetDonationByIdData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetDonationByIdData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetDonationByIdData, _i3.GGetDonationByIdVars>
  transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetDonationByIdReq> get serializer =>
      _$gGetDonationByIdReqSerializer;

  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GGetDonationByIdReq.serializer, this)
          as Map<String, dynamic>);

  static GGetDonationByIdReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GGetDonationByIdReq.serializer, json);
}
