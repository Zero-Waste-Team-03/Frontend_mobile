// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reserve_donation.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reserve_donation.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reserve_donation.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'reserve_donation.req.gql.g.dart';

abstract class GReserveDonationReq
    implements
        Built<GReserveDonationReq, GReserveDonationReqBuilder>,
        _i1
        .OperationRequest<_i2.GReserveDonationData, _i3.GReserveDonationVars> {
  GReserveDonationReq._();

  factory GReserveDonationReq(
          [void Function(GReserveDonationReqBuilder b) updates]) =
      _$GReserveDonationReq;

  static void _initializeBuilder(GReserveDonationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'ReserveDonation',
    )
    ..executeOnListen = true;

  @override
  _i3.GReserveDonationVars get vars;
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
  _i2.GReserveDonationData? Function(
    _i2.GReserveDonationData?,
    _i2.GReserveDonationData?,
  )? get updateResult;
  @override
  _i2.GReserveDonationData? get optimisticResponse;
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
  _i2.GReserveDonationData? parseData(Map<String, dynamic> json) =>
      _i2.GReserveDonationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GReserveDonationData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GReserveDonationData, _i3.GReserveDonationVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GReserveDonationReq> get serializer =>
      _$gReserveDonationReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GReserveDonationReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GReserveDonationReq.serializer,
        json,
      );
}
