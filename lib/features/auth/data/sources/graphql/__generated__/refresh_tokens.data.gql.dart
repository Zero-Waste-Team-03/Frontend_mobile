// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i3;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/user_fields.data.gql.dart'
    as _i2;

part 'refresh_tokens.data.gql.g.dart';

abstract class GRefreshTokensData
    implements Built<GRefreshTokensData, GRefreshTokensDataBuilder> {
  GRefreshTokensData._();

  factory GRefreshTokensData(
          [void Function(GRefreshTokensDataBuilder b) updates]) =
      _$GRefreshTokensData;

  static void _initializeBuilder(GRefreshTokensDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GRefreshTokensData_refreshTokens get refreshTokens;
  static Serializer<GRefreshTokensData> get serializer =>
      _$gRefreshTokensDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokensData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokensData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokensData.serializer,
        json,
      );
}

abstract class GRefreshTokensData_refreshTokens
    implements
        Built<GRefreshTokensData_refreshTokens,
            GRefreshTokensData_refreshTokensBuilder> {
  GRefreshTokensData_refreshTokens._();

  factory GRefreshTokensData_refreshTokens(
          [void Function(GRefreshTokensData_refreshTokensBuilder b) updates]) =
      _$GRefreshTokensData_refreshTokens;

  static void _initializeBuilder(GRefreshTokensData_refreshTokensBuilder b) =>
      b..G__typename = 'AuthResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get accessToken;
  String get refreshToken;
  GRefreshTokensData_refreshTokens_user get user;
  static Serializer<GRefreshTokensData_refreshTokens> get serializer =>
      _$gRefreshTokensDataRefreshTokensSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokensData_refreshTokens.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokensData_refreshTokens? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokensData_refreshTokens.serializer,
        json,
      );
}

abstract class GRefreshTokensData_refreshTokens_user
    implements
        Built<GRefreshTokensData_refreshTokens_user,
            GRefreshTokensData_refreshTokens_userBuilder>,
        _i2.GUserFields {
  GRefreshTokensData_refreshTokens_user._();

  factory GRefreshTokensData_refreshTokens_user(
      [void Function(GRefreshTokensData_refreshTokens_userBuilder b)
          updates]) = _$GRefreshTokensData_refreshTokens_user;

  static void _initializeBuilder(
          GRefreshTokensData_refreshTokens_userBuilder b) =>
      b..G__typename = 'User';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get email;
  @override
  String? get displayName;
  @override
  _i3.GUserRole get role;
  @override
  String? get description;
  @override
  bool get isMailVerified;
  @override
  String? get phoneNumber;
  @override
  int get reputationScore;
  @override
  String? get locationId;
  @override
  GRefreshTokensData_refreshTokens_user_location? get location;
  @override
  GRefreshTokensData_refreshTokens_user_avatar? get avatar;
  static Serializer<GRefreshTokensData_refreshTokens_user> get serializer =>
      _$gRefreshTokensDataRefreshTokensUserSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokensData_refreshTokens_user.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokensData_refreshTokens_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokensData_refreshTokens_user.serializer,
        json,
      );
}

abstract class GRefreshTokensData_refreshTokens_user_location
    implements
        Built<GRefreshTokensData_refreshTokens_user_location,
            GRefreshTokensData_refreshTokens_user_locationBuilder>,
        _i2.GUserFields_location {
  GRefreshTokensData_refreshTokens_user_location._();

  factory GRefreshTokensData_refreshTokens_user_location(
      [void Function(GRefreshTokensData_refreshTokens_user_locationBuilder b)
          updates]) = _$GRefreshTokensData_refreshTokens_user_location;

  static void _initializeBuilder(
          GRefreshTokensData_refreshTokens_user_locationBuilder b) =>
      b..G__typename = 'Location';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get city;
  @override
  String? get country;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  String? get neighborhood;
  static Serializer<GRefreshTokensData_refreshTokens_user_location>
      get serializer => _$gRefreshTokensDataRefreshTokensUserLocationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokensData_refreshTokens_user_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokensData_refreshTokens_user_location? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokensData_refreshTokens_user_location.serializer,
        json,
      );
}

abstract class GRefreshTokensData_refreshTokens_user_avatar
    implements
        Built<GRefreshTokensData_refreshTokens_user_avatar,
            GRefreshTokensData_refreshTokens_user_avatarBuilder>,
        _i2.GUserFields_avatar {
  GRefreshTokensData_refreshTokens_user_avatar._();

  factory GRefreshTokensData_refreshTokens_user_avatar(
      [void Function(GRefreshTokensData_refreshTokens_user_avatarBuilder b)
          updates]) = _$GRefreshTokensData_refreshTokens_user_avatar;

  static void _initializeBuilder(
          GRefreshTokensData_refreshTokens_user_avatarBuilder b) =>
      b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get url;
  @override
  String get fileType;
  static Serializer<GRefreshTokensData_refreshTokens_user_avatar>
      get serializer => _$gRefreshTokensDataRefreshTokensUserAvatarSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRefreshTokensData_refreshTokens_user_avatar.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRefreshTokensData_refreshTokens_user_avatar? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRefreshTokensData_refreshTokens_user_avatar.serializer,
        json,
      );
}
