// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'get_donation_by_id.data.gql.g.dart';

abstract class GGetDonationByIdData
    implements Built<GGetDonationByIdData, GGetDonationByIdDataBuilder> {
  GGetDonationByIdData._();

  factory GGetDonationByIdData(
          [void Function(GGetDonationByIdDataBuilder b) updates]) =
      _$GGetDonationByIdData;

  static void _initializeBuilder(GGetDonationByIdDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetDonationByIdData_donation get donation;
  static Serializer<GGetDonationByIdData> get serializer =>
      _$gGetDonationByIdDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetDonationByIdData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetDonationByIdData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetDonationByIdData.serializer,
        json,
      );
}

abstract class GGetDonationByIdData_donation
    implements
        Built<GGetDonationByIdData_donation,
            GGetDonationByIdData_donationBuilder> {
  GGetDonationByIdData_donation._();

  factory GGetDonationByIdData_donation(
          [void Function(GGetDonationByIdData_donationBuilder b) updates]) =
      _$GGetDonationByIdData_donation;

  static void _initializeBuilder(GGetDonationByIdData_donationBuilder b) =>
      b..G__typename = 'Donation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get description;
  int get quantity;
  String get categoryId;
  GGetDonationByIdData_donation_category? get category;
  _i2.GDonationStatusValues get status;
  _i2.GDonationUrgencyValues get urgency;
  String? get mainAttachmentId;
  GGetDonationByIdData_donation_mainAttachment? get mainAttachment;
  String? get locationId;
  GGetDonationByIdData_donation_location? get location;
  GGetDonationByIdData_donation_user get user;
  static Serializer<GGetDonationByIdData_donation> get serializer =>
      _$gGetDonationByIdDataDonationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetDonationByIdData_donation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetDonationByIdData_donation? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetDonationByIdData_donation.serializer,
        json,
      );
}

abstract class GGetDonationByIdData_donation_category
    implements
        Built<GGetDonationByIdData_donation_category,
            GGetDonationByIdData_donation_categoryBuilder> {
  GGetDonationByIdData_donation_category._();

  factory GGetDonationByIdData_donation_category(
      [void Function(GGetDonationByIdData_donation_categoryBuilder b)
          updates]) = _$GGetDonationByIdData_donation_category;

  static void _initializeBuilder(
          GGetDonationByIdData_donation_categoryBuilder b) =>
      b..G__typename = 'Category';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  static Serializer<GGetDonationByIdData_donation_category> get serializer =>
      _$gGetDonationByIdDataDonationCategorySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetDonationByIdData_donation_category.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetDonationByIdData_donation_category? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetDonationByIdData_donation_category.serializer,
        json,
      );
}

abstract class GGetDonationByIdData_donation_mainAttachment
    implements
        Built<GGetDonationByIdData_donation_mainAttachment,
            GGetDonationByIdData_donation_mainAttachmentBuilder> {
  GGetDonationByIdData_donation_mainAttachment._();

  factory GGetDonationByIdData_donation_mainAttachment(
      [void Function(GGetDonationByIdData_donation_mainAttachmentBuilder b)
          updates]) = _$GGetDonationByIdData_donation_mainAttachment;

  static void _initializeBuilder(
          GGetDonationByIdData_donation_mainAttachmentBuilder b) =>
      b..G__typename = 'Attachment';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get url;
  static Serializer<GGetDonationByIdData_donation_mainAttachment>
      get serializer => _$gGetDonationByIdDataDonationMainAttachmentSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetDonationByIdData_donation_mainAttachment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetDonationByIdData_donation_mainAttachment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetDonationByIdData_donation_mainAttachment.serializer,
        json,
      );
}

abstract class GGetDonationByIdData_donation_location
    implements
        Built<GGetDonationByIdData_donation_location,
            GGetDonationByIdData_donation_locationBuilder> {
  GGetDonationByIdData_donation_location._();

  factory GGetDonationByIdData_donation_location(
      [void Function(GGetDonationByIdData_donation_locationBuilder b)
          updates]) = _$GGetDonationByIdData_donation_location;

  static void _initializeBuilder(
          GGetDonationByIdData_donation_locationBuilder b) =>
      b..G__typename = 'Location';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  double? get latitude;
  double? get longitude;
  static Serializer<GGetDonationByIdData_donation_location> get serializer =>
      _$gGetDonationByIdDataDonationLocationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetDonationByIdData_donation_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetDonationByIdData_donation_location? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetDonationByIdData_donation_location.serializer,
        json,
      );
}

abstract class GGetDonationByIdData_donation_user
    implements
        Built<GGetDonationByIdData_donation_user,
            GGetDonationByIdData_donation_userBuilder> {
  GGetDonationByIdData_donation_user._();

  factory GGetDonationByIdData_donation_user(
      [void Function(GGetDonationByIdData_donation_userBuilder b)
          updates]) = _$GGetDonationByIdData_donation_user;

  static void _initializeBuilder(GGetDonationByIdData_donation_userBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get displayName;
  String get email;
  static Serializer<GGetDonationByIdData_donation_user> get serializer =>
      _$gGetDonationByIdDataDonationUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GGetDonationByIdData_donation_user.serializer,
        this,
      ) as Map<String, dynamic>);

  static GGetDonationByIdData_donation_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GGetDonationByIdData_donation_user.serializer,
        json,
      );
}
