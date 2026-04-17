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

part 'get_current_user.data.gql.g.dart';

abstract class GGetCurrentUserData
    implements Built<GGetCurrentUserData, GGetCurrentUserDataBuilder> {
  GGetCurrentUserData._();

  factory GGetCurrentUserData([
    void Function(GGetCurrentUserDataBuilder b) updates,
  ]) = _$GGetCurrentUserData;

  static void _initializeBuilder(GGetCurrentUserDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetCurrentUserData_currentUser get currentUser;
  static Serializer<GGetCurrentUserData> get serializer =>
      _$gGetCurrentUserDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GGetCurrentUserData.serializer, this)
          as Map<String, dynamic>);

  static GGetCurrentUserData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GGetCurrentUserData.serializer, json);
}

abstract class GGetCurrentUserData_currentUser
    implements
        Built<
          GGetCurrentUserData_currentUser,
          GGetCurrentUserData_currentUserBuilder
        >,
        _i2.GUserFields {
  GGetCurrentUserData_currentUser._();

  factory GGetCurrentUserData_currentUser([
    void Function(GGetCurrentUserData_currentUserBuilder b) updates,
  ]) = _$GGetCurrentUserData_currentUser;

  static void _initializeBuilder(GGetCurrentUserData_currentUserBuilder b) =>
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
  GGetCurrentUserData_currentUser_location? get location;
  @override
  GGetCurrentUserData_currentUser_avatar? get avatar;
  static Serializer<GGetCurrentUserData_currentUser> get serializer =>
      _$gGetCurrentUserDataCurrentUserSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetCurrentUserData_currentUser.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetCurrentUserData_currentUser? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetCurrentUserData_currentUser.serializer,
        json,
      );
}

abstract class GGetCurrentUserData_currentUser_location
    implements
        Built<
          GGetCurrentUserData_currentUser_location,
          GGetCurrentUserData_currentUser_locationBuilder
        >,
        _i2.GUserFields_location {
  GGetCurrentUserData_currentUser_location._();

  factory GGetCurrentUserData_currentUser_location([
    void Function(GGetCurrentUserData_currentUser_locationBuilder b) updates,
  ]) = _$GGetCurrentUserData_currentUser_location;

  static void _initializeBuilder(
    GGetCurrentUserData_currentUser_locationBuilder b,
  ) => b..G__typename = 'Location';

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
  static Serializer<GGetCurrentUserData_currentUser_location> get serializer =>
      _$gGetCurrentUserDataCurrentUserLocationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetCurrentUserData_currentUser_location.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetCurrentUserData_currentUser_location? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GGetCurrentUserData_currentUser_location.serializer,
    json,
  );
}

abstract class GGetCurrentUserData_currentUser_avatar
    implements
        Built<
          GGetCurrentUserData_currentUser_avatar,
          GGetCurrentUserData_currentUser_avatarBuilder
        >,
        _i2.GUserFields_avatar {
  GGetCurrentUserData_currentUser_avatar._();

  factory GGetCurrentUserData_currentUser_avatar([
    void Function(GGetCurrentUserData_currentUser_avatarBuilder b) updates,
  ]) = _$GGetCurrentUserData_currentUser_avatar;

  static void _initializeBuilder(
    GGetCurrentUserData_currentUser_avatarBuilder b,
  ) => b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get url;
  @override
  String get fileType;
  static Serializer<GGetCurrentUserData_currentUser_avatar> get serializer =>
      _$gGetCurrentUserDataCurrentUserAvatarSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetCurrentUserData_currentUser_avatar.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetCurrentUserData_currentUser_avatar? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GGetCurrentUserData_currentUser_avatar.serializer,
    json,
  );
}
