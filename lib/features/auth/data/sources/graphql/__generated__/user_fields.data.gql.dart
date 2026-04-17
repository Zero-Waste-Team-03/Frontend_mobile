// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'user_fields.data.gql.g.dart';

abstract class GUserFields {
  String get G__typename;
  String get id;
  String get email;
  String? get displayName;
  _i1.GUserRole get role;
  String? get description;
  bool get isMailVerified;
  String? get phoneNumber;
  int get reputationScore;
  String? get locationId;
  GUserFields_location? get location;
  GUserFields_avatar? get avatar;
  Map<String, dynamic> toJson();
}

abstract class GUserFields_location {
  String get G__typename;
  String get id;
  String? get city;
  String? get country;
  double? get latitude;
  double? get longitude;
  String? get neighborhood;
  Map<String, dynamic> toJson();
}

abstract class GUserFields_avatar {
  String get G__typename;
  String get id;
  String? get url;
  String get fileType;
  Map<String, dynamic> toJson();
}

abstract class GUserFieldsData
    implements Built<GUserFieldsData, GUserFieldsDataBuilder>, GUserFields {
  GUserFieldsData._();

  factory GUserFieldsData([void Function(GUserFieldsDataBuilder b) updates]) =
      _$GUserFieldsData;

  static void _initializeBuilder(GUserFieldsDataBuilder b) =>
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
  _i1.GUserRole get role;
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
  GUserFieldsData_location? get location;
  @override
  GUserFieldsData_avatar? get avatar;
  static Serializer<GUserFieldsData> get serializer =>
      _$gUserFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i2.serializers.serializeWith(GUserFieldsData.serializer, this)
          as Map<String, dynamic>);

  static GUserFieldsData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(GUserFieldsData.serializer, json);
}

abstract class GUserFieldsData_location
    implements
        Built<GUserFieldsData_location, GUserFieldsData_locationBuilder>,
        GUserFields_location {
  GUserFieldsData_location._();

  factory GUserFieldsData_location([
    void Function(GUserFieldsData_locationBuilder b) updates,
  ]) = _$GUserFieldsData_location;

  static void _initializeBuilder(GUserFieldsData_locationBuilder b) =>
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
  static Serializer<GUserFieldsData_location> get serializer =>
      _$gUserFieldsDataLocationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i2.serializers.serializeWith(GUserFieldsData_location.serializer, this)
          as Map<String, dynamic>);

  static GUserFieldsData_location? fromJson(Map<String, dynamic> json) => _i2
      .serializers
      .deserializeWith(GUserFieldsData_location.serializer, json);
}

abstract class GUserFieldsData_avatar
    implements
        Built<GUserFieldsData_avatar, GUserFieldsData_avatarBuilder>,
        GUserFields_avatar {
  GUserFieldsData_avatar._();

  factory GUserFieldsData_avatar([
    void Function(GUserFieldsData_avatarBuilder b) updates,
  ]) = _$GUserFieldsData_avatar;

  static void _initializeBuilder(GUserFieldsData_avatarBuilder b) =>
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
  static Serializer<GUserFieldsData_avatar> get serializer =>
      _$gUserFieldsDataAvatarSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i2.serializers.serializeWith(GUserFieldsData_avatar.serializer, this)
          as Map<String, dynamic>);

  static GUserFieldsData_avatar? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(GUserFieldsData_avatar.serializer, json);
}
