// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/logout_from_all_devices.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/logout_from_all_devices.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/logout_from_all_devices.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'logout_from_all_devices.req.gql.g.dart';

abstract class GLogoutFromAllDevicesReq
    implements
        Built<GLogoutFromAllDevicesReq, GLogoutFromAllDevicesReqBuilder>,
        _i1.OperationRequest<_i2.GLogoutFromAllDevicesData,
            _i3.GLogoutFromAllDevicesVars> {
  GLogoutFromAllDevicesReq._();

  factory GLogoutFromAllDevicesReq(
          [void Function(GLogoutFromAllDevicesReqBuilder b) updates]) =
      _$GLogoutFromAllDevicesReq;

  static void _initializeBuilder(GLogoutFromAllDevicesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'LogoutFromAllDevices',
    )
    ..executeOnListen = true;

  @override
  _i3.GLogoutFromAllDevicesVars get vars;
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
  _i2.GLogoutFromAllDevicesData? Function(
    _i2.GLogoutFromAllDevicesData?,
    _i2.GLogoutFromAllDevicesData?,
  )? get updateResult;
  @override
  _i2.GLogoutFromAllDevicesData? get optimisticResponse;
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
  _i2.GLogoutFromAllDevicesData? parseData(Map<String, dynamic> json) =>
      _i2.GLogoutFromAllDevicesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GLogoutFromAllDevicesData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GLogoutFromAllDevicesData,
      _i3.GLogoutFromAllDevicesVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GLogoutFromAllDevicesReq> get serializer =>
      _$gLogoutFromAllDevicesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GLogoutFromAllDevicesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLogoutFromAllDevicesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GLogoutFromAllDevicesReq.serializer,
        json,
      );
}
