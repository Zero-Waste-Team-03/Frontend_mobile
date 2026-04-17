// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i2;

part 'reservation_fields.data.gql.g.dart';

abstract class GReservationFields {
  String get G__typename;
  String get id;
  String get donationId;
  String get beneficiaryId;
  _i1.GReservationStatus get status;
  _i1.GDateTime get createdAt;
  _i1.GDateTime? get confirmedAt;
  _i1.GDateTime get updatedAt;
  GReservationFields_donation? get donation;
  GReservationFields_beneficiary? get beneficiary;
  Map<String, dynamic> toJson();
}

abstract class GReservationFields_donation {
  String get G__typename;
  String get id;
  String get title;
  String get description;
  int get quantity;
  String get categoryId;
  GReservationFields_donation_category? get category;
  _i1.GDonationStatusValues get status;
  _i1.GDonationUrgencyValues get urgency;
  String? get mainAttachmentId;
  GReservationFields_donation_mainAttachment? get mainAttachment;
  GReservationFields_donation_location? get location;
  GReservationFields_donation_user get user;
  Map<String, dynamic> toJson();
}

abstract class GReservationFields_donation_category {
  String get G__typename;
  String get id;
  String get name;
  Map<String, dynamic> toJson();
}

abstract class GReservationFields_donation_mainAttachment {
  String get G__typename;
  String? get url;
  Map<String, dynamic> toJson();
}

abstract class GReservationFields_donation_location {
  String get G__typename;
  double? get latitude;
  double? get longitude;
  Map<String, dynamic> toJson();
}

abstract class GReservationFields_donation_user {
  String get G__typename;
  String? get displayName;
  String get email;
  Map<String, dynamic> toJson();
}

abstract class GReservationFields_beneficiary {
  String get G__typename;
  String get id;
  String get email;
  String? get displayName;
  String? get phoneNumber;
  _i1.GUserRole get role;
  String? get description;
  bool get isMailVerified;
  int get reputationScore;
  String? get locationId;
  GReservationFields_beneficiary_location? get location;
  GReservationFields_beneficiary_avatar? get avatar;
  Map<String, dynamic> toJson();
}

abstract class GReservationFields_beneficiary_location {
  String get G__typename;
  String? get city;
  String? get country;
  double? get latitude;
  double? get longitude;
  String? get neighborhood;
  Map<String, dynamic> toJson();
}

abstract class GReservationFields_beneficiary_avatar {
  String get G__typename;
  String get id;
  String? get url;
  Map<String, dynamic> toJson();
}

abstract class GReservationFieldsData
    implements
        Built<GReservationFieldsData, GReservationFieldsDataBuilder>,
        GReservationFields {
  GReservationFieldsData._();

  factory GReservationFieldsData(
          [void Function(GReservationFieldsDataBuilder b) updates]) =
      _$GReservationFieldsData;

  static void _initializeBuilder(GReservationFieldsDataBuilder b) =>
      b..G__typename = 'Reservation';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get donationId;
  @override
  String get beneficiaryId;
  @override
  _i1.GReservationStatus get status;
  @override
  _i1.GDateTime get createdAt;
  @override
  _i1.GDateTime? get confirmedAt;
  @override
  _i1.GDateTime get updatedAt;
  @override
  GReservationFieldsData_donation? get donation;
  @override
  GReservationFieldsData_beneficiary? get beneficiary;
  static Serializer<GReservationFieldsData> get serializer =>
      _$gReservationFieldsDataSerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData.serializer,
        json,
      );
}

abstract class GReservationFieldsData_donation
    implements
        Built<GReservationFieldsData_donation,
            GReservationFieldsData_donationBuilder>,
        GReservationFields_donation {
  GReservationFieldsData_donation._();

  factory GReservationFieldsData_donation(
          [void Function(GReservationFieldsData_donationBuilder b) updates]) =
      _$GReservationFieldsData_donation;

  static void _initializeBuilder(GReservationFieldsData_donationBuilder b) =>
      b..G__typename = 'Donation';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get quantity;
  @override
  String get categoryId;
  @override
  GReservationFieldsData_donation_category? get category;
  @override
  _i1.GDonationStatusValues get status;
  @override
  _i1.GDonationUrgencyValues get urgency;
  @override
  String? get mainAttachmentId;
  @override
  GReservationFieldsData_donation_mainAttachment? get mainAttachment;
  @override
  GReservationFieldsData_donation_location? get location;
  @override
  GReservationFieldsData_donation_user get user;
  static Serializer<GReservationFieldsData_donation> get serializer =>
      _$gReservationFieldsDataDonationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData_donation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData_donation? fromJson(Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData_donation.serializer,
        json,
      );
}

abstract class GReservationFieldsData_donation_category
    implements
        Built<GReservationFieldsData_donation_category,
            GReservationFieldsData_donation_categoryBuilder>,
        GReservationFields_donation_category {
  GReservationFieldsData_donation_category._();

  factory GReservationFieldsData_donation_category(
      [void Function(GReservationFieldsData_donation_categoryBuilder b)
          updates]) = _$GReservationFieldsData_donation_category;

  static void _initializeBuilder(
          GReservationFieldsData_donation_categoryBuilder b) =>
      b..G__typename = 'Category';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get name;
  static Serializer<GReservationFieldsData_donation_category> get serializer =>
      _$gReservationFieldsDataDonationCategorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData_donation_category.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData_donation_category? fromJson(
          Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData_donation_category.serializer,
        json,
      );
}

abstract class GReservationFieldsData_donation_mainAttachment
    implements
        Built<GReservationFieldsData_donation_mainAttachment,
            GReservationFieldsData_donation_mainAttachmentBuilder>,
        GReservationFields_donation_mainAttachment {
  GReservationFieldsData_donation_mainAttachment._();

  factory GReservationFieldsData_donation_mainAttachment(
      [void Function(GReservationFieldsData_donation_mainAttachmentBuilder b)
          updates]) = _$GReservationFieldsData_donation_mainAttachment;

  static void _initializeBuilder(
          GReservationFieldsData_donation_mainAttachmentBuilder b) =>
      b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get url;
  static Serializer<GReservationFieldsData_donation_mainAttachment>
      get serializer =>
          _$gReservationFieldsDataDonationMainAttachmentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData_donation_mainAttachment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData_donation_mainAttachment? fromJson(
          Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData_donation_mainAttachment.serializer,
        json,
      );
}

abstract class GReservationFieldsData_donation_location
    implements
        Built<GReservationFieldsData_donation_location,
            GReservationFieldsData_donation_locationBuilder>,
        GReservationFields_donation_location {
  GReservationFieldsData_donation_location._();

  factory GReservationFieldsData_donation_location(
      [void Function(GReservationFieldsData_donation_locationBuilder b)
          updates]) = _$GReservationFieldsData_donation_location;

  static void _initializeBuilder(
          GReservationFieldsData_donation_locationBuilder b) =>
      b..G__typename = 'Location';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  double? get latitude;
  @override
  double? get longitude;
  static Serializer<GReservationFieldsData_donation_location> get serializer =>
      _$gReservationFieldsDataDonationLocationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData_donation_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData_donation_location? fromJson(
          Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData_donation_location.serializer,
        json,
      );
}

abstract class GReservationFieldsData_donation_user
    implements
        Built<GReservationFieldsData_donation_user,
            GReservationFieldsData_donation_userBuilder>,
        GReservationFields_donation_user {
  GReservationFieldsData_donation_user._();

  factory GReservationFieldsData_donation_user(
      [void Function(GReservationFieldsData_donation_userBuilder b)
          updates]) = _$GReservationFieldsData_donation_user;

  static void _initializeBuilder(
          GReservationFieldsData_donation_userBuilder b) =>
      b..G__typename = 'User';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get displayName;
  @override
  String get email;
  static Serializer<GReservationFieldsData_donation_user> get serializer =>
      _$gReservationFieldsDataDonationUserSerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData_donation_user.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData_donation_user? fromJson(
          Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData_donation_user.serializer,
        json,
      );
}

abstract class GReservationFieldsData_beneficiary
    implements
        Built<GReservationFieldsData_beneficiary,
            GReservationFieldsData_beneficiaryBuilder>,
        GReservationFields_beneficiary {
  GReservationFieldsData_beneficiary._();

  factory GReservationFieldsData_beneficiary(
      [void Function(GReservationFieldsData_beneficiaryBuilder b)
          updates]) = _$GReservationFieldsData_beneficiary;

  static void _initializeBuilder(GReservationFieldsData_beneficiaryBuilder b) =>
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
  String? get phoneNumber;
  @override
  _i1.GUserRole get role;
  @override
  String? get description;
  @override
  bool get isMailVerified;
  @override
  int get reputationScore;
  @override
  String? get locationId;
  @override
  GReservationFieldsData_beneficiary_location? get location;
  @override
  GReservationFieldsData_beneficiary_avatar? get avatar;
  static Serializer<GReservationFieldsData_beneficiary> get serializer =>
      _$gReservationFieldsDataBeneficiarySerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData_beneficiary.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData_beneficiary? fromJson(
          Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData_beneficiary.serializer,
        json,
      );
}

abstract class GReservationFieldsData_beneficiary_location
    implements
        Built<GReservationFieldsData_beneficiary_location,
            GReservationFieldsData_beneficiary_locationBuilder>,
        GReservationFields_beneficiary_location {
  GReservationFieldsData_beneficiary_location._();

  factory GReservationFieldsData_beneficiary_location(
      [void Function(GReservationFieldsData_beneficiary_locationBuilder b)
          updates]) = _$GReservationFieldsData_beneficiary_location;

  static void _initializeBuilder(
          GReservationFieldsData_beneficiary_locationBuilder b) =>
      b..G__typename = 'Location';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
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
  static Serializer<GReservationFieldsData_beneficiary_location>
      get serializer => _$gReservationFieldsDataBeneficiaryLocationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData_beneficiary_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData_beneficiary_location? fromJson(
          Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData_beneficiary_location.serializer,
        json,
      );
}

abstract class GReservationFieldsData_beneficiary_avatar
    implements
        Built<GReservationFieldsData_beneficiary_avatar,
            GReservationFieldsData_beneficiary_avatarBuilder>,
        GReservationFields_beneficiary_avatar {
  GReservationFieldsData_beneficiary_avatar._();

  factory GReservationFieldsData_beneficiary_avatar(
      [void Function(GReservationFieldsData_beneficiary_avatarBuilder b)
          updates]) = _$GReservationFieldsData_beneficiary_avatar;

  static void _initializeBuilder(
          GReservationFieldsData_beneficiary_avatarBuilder b) =>
      b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get url;
  static Serializer<GReservationFieldsData_beneficiary_avatar> get serializer =>
      _$gReservationFieldsDataBeneficiaryAvatarSerializer;

  @override
  Map<String, dynamic> toJson() => (_i2.serializers.serializeWith(
        GReservationFieldsData_beneficiary_avatar.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsData_beneficiary_avatar? fromJson(
          Map<String, dynamic> json) =>
      _i2.serializers.deserializeWith(
        GReservationFieldsData_beneficiary_avatar.serializer,
        json,
      );
}
