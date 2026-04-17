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

part 'update_profile.data.gql.g.dart';

abstract class GUpdateProfileData
    implements Built<GUpdateProfileData, GUpdateProfileDataBuilder> {
  GUpdateProfileData._();

  factory GUpdateProfileData(
          [void Function(GUpdateProfileDataBuilder b) updates]) =
      _$GUpdateProfileData;

  static void _initializeBuilder(GUpdateProfileDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GUpdateProfileData_updateProfile get updateProfile;
  static Serializer<GUpdateProfileData> get serializer =>
      _$gUpdateProfileDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData.serializer,
        json,
      );
}

abstract class GUpdateProfileData_updateProfile
    implements
        Built<GUpdateProfileData_updateProfile,
            GUpdateProfileData_updateProfileBuilder>,
        _i2.GUserFields {
  GUpdateProfileData_updateProfile._();

  factory GUpdateProfileData_updateProfile(
          [void Function(GUpdateProfileData_updateProfileBuilder b) updates]) =
      _$GUpdateProfileData_updateProfile;

  static void _initializeBuilder(GUpdateProfileData_updateProfileBuilder b) =>
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
  GUpdateProfileData_updateProfile_location? get location;
  @override
  GUpdateProfileData_updateProfile_avatar? get avatar;
  static Serializer<GUpdateProfileData_updateProfile> get serializer =>
      _$gUpdateProfileDataUpdateProfileSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData_updateProfile.serializer,
        json,
      );
}

abstract class GUpdateProfileData_updateProfile_location
    implements
        Built<GUpdateProfileData_updateProfile_location,
            GUpdateProfileData_updateProfile_locationBuilder>,
        _i2.GUserFields_location {
  GUpdateProfileData_updateProfile_location._();

  factory GUpdateProfileData_updateProfile_location(
      [void Function(GUpdateProfileData_updateProfile_locationBuilder b)
          updates]) = _$GUpdateProfileData_updateProfile_location;

  static void _initializeBuilder(
          GUpdateProfileData_updateProfile_locationBuilder b) =>
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
  static Serializer<GUpdateProfileData_updateProfile_location> get serializer =>
      _$gUpdateProfileDataUpdateProfileLocationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile_location? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData_updateProfile_location.serializer,
        json,
      );
}

abstract class GUpdateProfileData_updateProfile_avatar
    implements
        Built<GUpdateProfileData_updateProfile_avatar,
            GUpdateProfileData_updateProfile_avatarBuilder>,
        _i2.GUserFields_avatar {
  GUpdateProfileData_updateProfile_avatar._();

  factory GUpdateProfileData_updateProfile_avatar(
      [void Function(GUpdateProfileData_updateProfile_avatarBuilder b)
          updates]) = _$GUpdateProfileData_updateProfile_avatar;

  static void _initializeBuilder(
          GUpdateProfileData_updateProfile_avatarBuilder b) =>
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
  static Serializer<GUpdateProfileData_updateProfile_avatar> get serializer =>
      _$gUpdateProfileDataUpdateProfileAvatarSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileData_updateProfile_avatar.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileData_updateProfile_avatar? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileData_updateProfile_avatar.serializer,
        json,
      );
}
