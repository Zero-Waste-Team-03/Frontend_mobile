// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'delete_account.data.gql.g.dart';

abstract class GDeleteAccountData
    implements Built<GDeleteAccountData, GDeleteAccountDataBuilder> {
  GDeleteAccountData._();

  factory GDeleteAccountData([
    void Function(GDeleteAccountDataBuilder b) updates,
  ]) = _$GDeleteAccountData;

  static void _initializeBuilder(GDeleteAccountDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GDeleteAccountData_deleteAccount get deleteAccount;
  static Serializer<GDeleteAccountData> get serializer =>
      _$gDeleteAccountDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GDeleteAccountData.serializer, this)
          as Map<String, dynamic>);

  static GDeleteAccountData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GDeleteAccountData.serializer, json);
}

abstract class GDeleteAccountData_deleteAccount
    implements
        Built<
          GDeleteAccountData_deleteAccount,
          GDeleteAccountData_deleteAccountBuilder
        > {
  GDeleteAccountData_deleteAccount._();

  factory GDeleteAccountData_deleteAccount([
    void Function(GDeleteAccountData_deleteAccountBuilder b) updates,
  ]) = _$GDeleteAccountData_deleteAccount;

  static void _initializeBuilder(GDeleteAccountData_deleteAccountBuilder b) =>
      b..G__typename = 'MessageResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get message;
  static Serializer<GDeleteAccountData_deleteAccount> get serializer =>
      _$gDeleteAccountDataDeleteAccountSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GDeleteAccountData_deleteAccount.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GDeleteAccountData_deleteAccount? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GDeleteAccountData_deleteAccount.serializer,
    json,
  );
}
