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

part 'login.data.gql.g.dart';

abstract class GLoginData implements Built<GLoginData, GLoginDataBuilder> {
  GLoginData._();

  factory GLoginData([void Function(GLoginDataBuilder b) updates]) =
      _$GLoginData;

  static void _initializeBuilder(GLoginDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GLoginData_login get login;
  static Serializer<GLoginData> get serializer => _$gLoginDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GLoginData.serializer, this)
          as Map<String, dynamic>);

  static GLoginData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GLoginData.serializer, json);
}

abstract class GLoginData_login
    implements Built<GLoginData_login, GLoginData_loginBuilder> {
  GLoginData_login._();

  factory GLoginData_login([void Function(GLoginData_loginBuilder b) updates]) =
      _$GLoginData_login;

  static void _initializeBuilder(GLoginData_loginBuilder b) =>
      b..G__typename = 'AuthResponse';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get accessToken;
  String get refreshToken;
  GLoginData_login_user get user;
  static Serializer<GLoginData_login> get serializer =>
      _$gLoginDataLoginSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GLoginData_login.serializer, this)
          as Map<String, dynamic>);

  static GLoginData_login? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GLoginData_login.serializer, json);
}

abstract class GLoginData_login_user
    implements
        Built<GLoginData_login_user, GLoginData_login_userBuilder>,
        _i2.GUserFields {
  GLoginData_login_user._();

  factory GLoginData_login_user([
    void Function(GLoginData_login_userBuilder b) updates,
  ]) = _$GLoginData_login_user;

  static void _initializeBuilder(GLoginData_login_userBuilder b) =>
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
  GLoginData_login_user_location? get location;
  @override
  GLoginData_login_user_avatar? get avatar;
  static Serializer<GLoginData_login_user> get serializer =>
      _$gLoginDataLoginUserSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GLoginData_login_user.serializer, this)
          as Map<String, dynamic>);

  static GLoginData_login_user? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GLoginData_login_user.serializer, json);
}

abstract class GLoginData_login_user_location
    implements
        Built<
          GLoginData_login_user_location,
          GLoginData_login_user_locationBuilder
        >,
        _i2.GUserFields_location {
  GLoginData_login_user_location._();

  factory GLoginData_login_user_location([
    void Function(GLoginData_login_user_locationBuilder b) updates,
  ]) = _$GLoginData_login_user_location;

  static void _initializeBuilder(GLoginData_login_user_locationBuilder b) =>
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
  static Serializer<GLoginData_login_user_location> get serializer =>
      _$gLoginDataLoginUserLocationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GLoginData_login_user_location.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GLoginData_login_user_location? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginData_login_user_location.serializer,
        json,
      );
}

abstract class GLoginData_login_user_avatar
    implements
        Built<
          GLoginData_login_user_avatar,
          GLoginData_login_user_avatarBuilder
        >,
        _i2.GUserFields_avatar {
  GLoginData_login_user_avatar._();

  factory GLoginData_login_user_avatar([
    void Function(GLoginData_login_user_avatarBuilder b) updates,
  ]) = _$GLoginData_login_user_avatar;

  static void _initializeBuilder(GLoginData_login_user_avatarBuilder b) =>
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
  static Serializer<GLoginData_login_user_avatar> get serializer =>
      _$gLoginDataLoginUserAvatarSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GLoginData_login_user_avatar.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GLoginData_login_user_avatar? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginData_login_user_avatar.serializer,
        json,
      );
}
