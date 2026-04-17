// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservation.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservation.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservation.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'my_reservation.req.gql.g.dart';

abstract class GMyReservationReq
    implements
        Built<GMyReservationReq, GMyReservationReqBuilder>,
        _i1.OperationRequest<_i2.GMyReservationData, _i3.GMyReservationVars> {
  GMyReservationReq._();

  factory GMyReservationReq(
          [void Function(GMyReservationReqBuilder b) updates]) =
      _$GMyReservationReq;

  static void _initializeBuilder(GMyReservationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MyReservation',
    )
    ..executeOnListen = true;

  @override
  _i3.GMyReservationVars get vars;
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
  _i2.GMyReservationData? Function(
    _i2.GMyReservationData?,
    _i2.GMyReservationData?,
  )? get updateResult;
  @override
  _i2.GMyReservationData? get optimisticResponse;
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
  _i2.GMyReservationData? parseData(Map<String, dynamic> json) =>
      _i2.GMyReservationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMyReservationData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GMyReservationData, _i3.GMyReservationVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMyReservationReq> get serializer =>
      _$gMyReservationReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMyReservationReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMyReservationReq.serializer,
        json,
      );
}
