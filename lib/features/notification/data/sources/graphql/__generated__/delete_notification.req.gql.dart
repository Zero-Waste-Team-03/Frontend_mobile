// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/delete_notification.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/delete_notification.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/delete_notification.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'delete_notification.req.gql.g.dart';

abstract class GDeleteNotificationReq
    implements
        Built<GDeleteNotificationReq, GDeleteNotificationReqBuilder>,
        _i1.OperationRequest<_i2.GDeleteNotificationData,
            _i3.GDeleteNotificationVars> {
  GDeleteNotificationReq._();

  factory GDeleteNotificationReq(
          [void Function(GDeleteNotificationReqBuilder b) updates]) =
      _$GDeleteNotificationReq;

  static void _initializeBuilder(GDeleteNotificationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'DeleteNotification',
    )
    ..executeOnListen = true;

  @override
  _i3.GDeleteNotificationVars get vars;
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
  _i2.GDeleteNotificationData? Function(
    _i2.GDeleteNotificationData?,
    _i2.GDeleteNotificationData?,
  )? get updateResult;
  @override
  _i2.GDeleteNotificationData? get optimisticResponse;
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
  _i2.GDeleteNotificationData? parseData(Map<String, dynamic> json) =>
      _i2.GDeleteNotificationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GDeleteNotificationData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GDeleteNotificationData, _i3.GDeleteNotificationVars>
      transformOperation(_i4.Operation Function(_i4.Operation) transform) =>
          this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GDeleteNotificationReq> get serializer =>
      _$gDeleteNotificationReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GDeleteNotificationReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDeleteNotificationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GDeleteNotificationReq.serializer,
        json,
      );
}
