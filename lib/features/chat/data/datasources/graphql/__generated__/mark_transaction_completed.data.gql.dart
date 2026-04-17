// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'mark_transaction_completed.data.gql.g.dart';

abstract class GMarkTransactionCompletedData
    implements
        Built<
          GMarkTransactionCompletedData,
          GMarkTransactionCompletedDataBuilder
        > {
  GMarkTransactionCompletedData._();

  factory GMarkTransactionCompletedData([
    void Function(GMarkTransactionCompletedDataBuilder b) updates,
  ]) = _$GMarkTransactionCompletedData;

  static void _initializeBuilder(GMarkTransactionCompletedDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMarkTransactionCompletedData_markTransactionCompleted
  get markTransactionCompleted;
  static Serializer<GMarkTransactionCompletedData> get serializer =>
      _$gMarkTransactionCompletedDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMarkTransactionCompletedData.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMarkTransactionCompletedData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkTransactionCompletedData.serializer,
        json,
      );
}

abstract class GMarkTransactionCompletedData_markTransactionCompleted
    implements
        Built<
          GMarkTransactionCompletedData_markTransactionCompleted,
          GMarkTransactionCompletedData_markTransactionCompletedBuilder
        > {
  GMarkTransactionCompletedData_markTransactionCompleted._();

  factory GMarkTransactionCompletedData_markTransactionCompleted([
    void Function(
      GMarkTransactionCompletedData_markTransactionCompletedBuilder b,
    )
    updates,
  ]) = _$GMarkTransactionCompletedData_markTransactionCompleted;

  static void _initializeBuilder(
    GMarkTransactionCompletedData_markTransactionCompletedBuilder b,
  ) => b..G__typename = 'Conversation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  _i2.GConversationStatus get status;
  String? get lastMessage;
  static Serializer<GMarkTransactionCompletedData_markTransactionCompleted>
  get serializer =>
      _$gMarkTransactionCompletedDataMarkTransactionCompletedSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMarkTransactionCompletedData_markTransactionCompleted.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMarkTransactionCompletedData_markTransactionCompleted? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMarkTransactionCompletedData_markTransactionCompleted.serializer,
    json,
  );
}
