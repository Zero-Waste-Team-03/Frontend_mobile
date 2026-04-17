// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/profile/data/datasources/graphql/__generated__/get_myDonations.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/profile/data/datasources/graphql/__generated__/get_myDonations.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/profile/data/datasources/graphql/__generated__/get_myDonations.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'get_myDonations.req.gql.g.dart';

abstract class GMyDonationsReq
    implements
        Built<GMyDonationsReq, GMyDonationsReqBuilder>,
        _i1.OperationRequest<_i2.GMyDonationsData, _i3.GMyDonationsVars> {
  GMyDonationsReq._();

  factory GMyDonationsReq([void Function(GMyDonationsReqBuilder b) updates]) =
      _$GMyDonationsReq;

  static void _initializeBuilder(GMyDonationsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'MyDonations',
    )
    ..executeOnListen = true;

  @override
  _i3.GMyDonationsVars get vars;
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
  _i2.GMyDonationsData? Function(
    _i2.GMyDonationsData?,
    _i2.GMyDonationsData?,
  )? get updateResult;
  @override
  _i2.GMyDonationsData? get optimisticResponse;
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
  _i2.GMyDonationsData? parseData(Map<String, dynamic> json) =>
      _i2.GMyDonationsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GMyDonationsData data) => data.toJson();

  @override
  _i1.OperationRequest<_i2.GMyDonationsData, _i3.GMyDonationsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GMyDonationsReq> get serializer =>
      _$gMyDonationsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GMyDonationsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GMyDonationsReq.serializer,
        json,
      );
}
