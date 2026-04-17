// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/get_or_create_conversation.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/get_or_create_conversation.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/get_or_create_conversation.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'get_or_create_conversation.req.gql.g.dart';

abstract class GGetOrCreateConversationReq
    implements
        Built<GGetOrCreateConversationReq, GGetOrCreateConversationReqBuilder>,
        _i1.OperationRequest<_i2.GGetOrCreateConversationData,
            _i3.GGetOrCreateConversationVars> {
  GGetOrCreateConversationReq._();

  factory GGetOrCreateConversationReq(
          [void Function(GGetOrCreateConversationReqBuilder b) updates]) =
      _$GGetOrCreateConversationReq;

  static void _initializeBuilder(GGetOrCreateConversationReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetOrCreateConversation',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetOrCreateConversationVars get vars;
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
  _i2.GGetOrCreateConversationData? Function(
    _i2.GGetOrCreateConversationData?,
    _i2.GGetOrCreateConversationData?,
  )? get updateResult;
  @override
  _i2.GGetOrCreateConversationData? get optimisticResponse;
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
  _i2.GGetOrCreateConversationData? parseData(Map<String, dynamic> json) =>
      _i2.GGetOrCreateConversationData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetOrCreateConversationData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetOrCreateConversationData,
      _i3.GGetOrCreateConversationVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetOrCreateConversationReq> get serializer =>
      _$gGetOrCreateConversationReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetOrCreateConversationReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetOrCreateConversationReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetOrCreateConversationReq.serializer,
        json,
      );
}
