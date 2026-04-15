// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/get_notifications.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/get_notifications.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/get_notifications.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'get_notifications.req.gql.g.dart';

abstract class GGetNotificationsReq
    implements
        Built<GGetNotificationsReq, GGetNotificationsReqBuilder>,
        _i1.OperationRequest<_i2.GGetNotificationsData,
            _i3.GGetNotificationsVars> {
  GGetNotificationsReq._();

  factory GGetNotificationsReq(
          [void Function(GGetNotificationsReqBuilder b) updates]) =
      _$GGetNotificationsReq;

  static void _initializeBuilder(GGetNotificationsReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetNotifications',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetNotificationsVars get vars;
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
  _i2.GGetNotificationsData? Function(
    _i2.GGetNotificationsData?,
    _i2.GGetNotificationsData?,
  )? get updateResult;
  @override
  _i2.GGetNotificationsData? get optimisticResponse;
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
  _i2.GGetNotificationsData? parseData(Map<String, dynamic> json) =>
      _i2.GGetNotificationsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetNotificationsData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetNotificationsData, _i3.GGetNotificationsVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetNotificationsReq> get serializer =>
      _$gGetNotificationsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetNotificationsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetNotificationsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetNotificationsReq.serializer,
        json,
      );
}
