// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservations.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservations.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservations.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'my_reservations.req.gql.g.dart';

abstract class GMyReservationsReq
    implements
        Built<GMyReservationsReq, GMyReservationsReqBuilder>,
        _i1.OperationRequest<_i2.GMyReservationsData, _i3.GMyReservationsVars> {
  GMyReservationsReq._();

  factory GMyReservationsReq([
    void Function(GMyReservationsReqBuilder b) updates,
  ]) = _$GMyReservationsReq;

  static void _initializeBuilder(GMyReservationsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MyReservations',
    )
    ..executeOnListen = true;

  @override
  _i3.GMyReservationsVars get vars;
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
  _i2.GMyReservationsData? Function(
    _i2.GMyReservationsData?,
    _i2.GMyReservationsData?,
  )?
  get updateResult;
  @override
  _i2.GMyReservationsData? get optimisticResponse;
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
  _i2.GMyReservationsData? parseData(Map<String, dynamic> json) =>
      _i2.GMyReservationsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMyReservationsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GMyReservationsData, _i3.GMyReservationsVars>
  transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMyReservationsReq> get serializer =>
      _$gMyReservationsReqSerializer;

  Map<String, dynamic> toJson() =>
      (_i6.serializers.serializeWith(GMyReservationsReq.serializer, this)
          as Map<String, dynamic>);

  static GMyReservationsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(GMyReservationsReq.serializer, json);
}
