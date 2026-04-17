// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'refresh_tokens_interceptor.data.gql.g.dart';

abstract class GRefreshTokensForInterceptorData
    implements
        Built<
          GRefreshTokensForInterceptorData,
          GRefreshTokensForInterceptorDataBuilder
        > {
  GRefreshTokensForInterceptorData._();

  factory GRefreshTokensForInterceptorData([
    void Function(GRefreshTokensForInterceptorDataBuilder b) updates,
  ]) = _$GRefreshTokensForInterceptorData;

  static void _initializeBuilder(GRefreshTokensForInterceptorDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRefreshTokensForInterceptorData_refreshTokens get refreshTokens;
  static Serializer<GRefreshTokensForInterceptorData> get serializer =>
      _$gRefreshTokensForInterceptorDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GRefreshTokensForInterceptorData.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GRefreshTokensForInterceptorData? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GRefreshTokensForInterceptorData.serializer,
    json,
  );
}

abstract class GRefreshTokensForInterceptorData_refreshTokens
    implements
        Built<
          GRefreshTokensForInterceptorData_refreshTokens,
          GRefreshTokensForInterceptorData_refreshTokensBuilder
        > {
  GRefreshTokensForInterceptorData_refreshTokens._();

  factory GRefreshTokensForInterceptorData_refreshTokens([
    void Function(GRefreshTokensForInterceptorData_refreshTokensBuilder b)
    updates,
  ]) = _$GRefreshTokensForInterceptorData_refreshTokens;

  static void _initializeBuilder(
    GRefreshTokensForInterceptorData_refreshTokensBuilder b,
  ) => b..G__typename = 'AuthResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get accessToken;
  String get refreshToken;
  static Serializer<GRefreshTokensForInterceptorData_refreshTokens>
  get serializer => _$gRefreshTokensForInterceptorDataRefreshTokensSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GRefreshTokensForInterceptorData_refreshTokens.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GRefreshTokensForInterceptorData_refreshTokens? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GRefreshTokensForInterceptorData_refreshTokens.serializer,
    json,
  );
}
