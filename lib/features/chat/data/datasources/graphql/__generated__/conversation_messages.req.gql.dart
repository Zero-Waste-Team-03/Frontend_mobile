// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/conversation_messages.ast.gql.dart'
    as _i5;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/conversation_messages.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/chat/data/datasources/graphql/__generated__/conversation_messages.var.gql.dart'
    as _i3;
import 'package:gql_exec/gql_exec.dart' as _i4;

part 'conversation_messages.req.gql.g.dart';

abstract class GGetConversationMessagesReq
    implements
        Built<GGetConversationMessagesReq, GGetConversationMessagesReqBuilder>,
        _i1.OperationRequest<_i2.GGetConversationMessagesData,
            _i3.GGetConversationMessagesVars> {
  GGetConversationMessagesReq._();

  factory GGetConversationMessagesReq(
          [void Function(GGetConversationMessagesReqBuilder b) updates]) =
      _$GGetConversationMessagesReq;

  static void _initializeBuilder(GGetConversationMessagesReqBuilder b) => b
    ..operation = _i4.Operation(
      document: _i5.document,
      operationName: 'GetConversationMessages',
    )
    ..executeOnListen = true;

  @override
  _i3.GGetConversationMessagesVars get vars;
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
  _i2.GGetConversationMessagesData? Function(
    _i2.GGetConversationMessagesData?,
    _i2.GGetConversationMessagesData?,
  )? get updateResult;
  @override
  _i2.GGetConversationMessagesData? get optimisticResponse;
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
  _i2.GGetConversationMessagesData? parseData(Map<String, dynamic> json) =>
      _i2.GGetConversationMessagesData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GGetConversationMessagesData data) =>
      data.toJson();

  @override
  _i1.OperationRequest<_i2.GGetConversationMessagesData,
      _i3.GGetConversationMessagesVars> transformOperation(
          _i4.Operation Function(_i4.Operation) transform) =>
      this.rebuild((b) => b..operation = transform(operation));

  static Serializer<GGetConversationMessagesReq> get serializer =>
      _$gGetConversationMessagesReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GGetConversationMessagesReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetConversationMessagesReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GGetConversationMessagesReq.serializer,
        json,
      );
}
