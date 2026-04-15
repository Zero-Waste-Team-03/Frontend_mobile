// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i3;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.data.gql.dart'
    as _i2;

part 'reserve_donation.data.gql.g.dart';

abstract class GReserveDonationData
    implements Built<GReserveDonationData, GReserveDonationDataBuilder> {
  GReserveDonationData._();

  factory GReserveDonationData(
          [void Function(GReserveDonationDataBuilder b) updates]) =
      _$GReserveDonationData;

  static void _initializeBuilder(GReserveDonationDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GReserveDonationData_reserveDonation get reserveDonation;
  static Serializer<GReserveDonationData> get serializer =>
      _$gReserveDonationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation
    implements
        Built<GReserveDonationData_reserveDonation,
            GReserveDonationData_reserveDonationBuilder>,
        _i2.GReservationFields {
  GReserveDonationData_reserveDonation._();

  factory GReserveDonationData_reserveDonation(
      [void Function(GReserveDonationData_reserveDonationBuilder b)
          updates]) = _$GReserveDonationData_reserveDonation;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonationBuilder b) =>
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
  _i3.GReservationStatus get status;
  @override
  _i3.GDateTime get createdAt;
  @override
  _i3.GDateTime? get confirmedAt;
  @override
  _i3.GDateTime get updatedAt;
  @override
  GReserveDonationData_reserveDonation_donation? get donation;
  @override
  GReserveDonationData_reserveDonation_beneficiary? get beneficiary;
  static Serializer<GReserveDonationData_reserveDonation> get serializer =>
      _$gReserveDonationDataReserveDonationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation_donation
    implements
        Built<GReserveDonationData_reserveDonation_donation,
            GReserveDonationData_reserveDonation_donationBuilder>,
        _i2.GReservationFields_donation {
  GReserveDonationData_reserveDonation_donation._();

  factory GReserveDonationData_reserveDonation_donation(
      [void Function(GReserveDonationData_reserveDonation_donationBuilder b)
          updates]) = _$GReserveDonationData_reserveDonation_donation;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonation_donationBuilder b) =>
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
  GReserveDonationData_reserveDonation_donation_category? get category;
  @override
  _i3.GDonationStatusValues get status;
  @override
  _i3.GDonationUrgencyValues get urgency;
  @override
  String? get mainAttachmentId;
  @override
  GReserveDonationData_reserveDonation_donation_mainAttachment?
      get mainAttachment;
  @override
  GReserveDonationData_reserveDonation_donation_location? get location;
  @override
  GReserveDonationData_reserveDonation_donation_user get user;
  static Serializer<GReserveDonationData_reserveDonation_donation>
      get serializer => _$gReserveDonationDataReserveDonationDonationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation_donation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation_donation? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation_donation.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation_donation_category
    implements
        Built<GReserveDonationData_reserveDonation_donation_category,
            GReserveDonationData_reserveDonation_donation_categoryBuilder>,
        _i2.GReservationFields_donation_category {
  GReserveDonationData_reserveDonation_donation_category._();

  factory GReserveDonationData_reserveDonation_donation_category(
      [void Function(
              GReserveDonationData_reserveDonation_donation_categoryBuilder b)
          updates]) = _$GReserveDonationData_reserveDonation_donation_category;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonation_donation_categoryBuilder b) =>
      b..G__typename = 'Category';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get name;
  static Serializer<GReserveDonationData_reserveDonation_donation_category>
      get serializer =>
          _$gReserveDonationDataReserveDonationDonationCategorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation_donation_category.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation_donation_category? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation_donation_category.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation_donation_mainAttachment
    implements
        Built<GReserveDonationData_reserveDonation_donation_mainAttachment,
            GReserveDonationData_reserveDonation_donation_mainAttachmentBuilder>,
        _i2.GReservationFields_donation_mainAttachment {
  GReserveDonationData_reserveDonation_donation_mainAttachment._();

  factory GReserveDonationData_reserveDonation_donation_mainAttachment(
          [void Function(
                  GReserveDonationData_reserveDonation_donation_mainAttachmentBuilder
                      b)
              updates]) =
      _$GReserveDonationData_reserveDonation_donation_mainAttachment;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonation_donation_mainAttachmentBuilder
              b) =>
      b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get url;
  static Serializer<
          GReserveDonationData_reserveDonation_donation_mainAttachment>
      get serializer =>
          _$gReserveDonationDataReserveDonationDonationMainAttachmentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation_donation_mainAttachment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation_donation_mainAttachment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation_donation_mainAttachment.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation_donation_location
    implements
        Built<GReserveDonationData_reserveDonation_donation_location,
            GReserveDonationData_reserveDonation_donation_locationBuilder>,
        _i2.GReservationFields_donation_location {
  GReserveDonationData_reserveDonation_donation_location._();

  factory GReserveDonationData_reserveDonation_donation_location(
      [void Function(
              GReserveDonationData_reserveDonation_donation_locationBuilder b)
          updates]) = _$GReserveDonationData_reserveDonation_donation_location;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonation_donation_locationBuilder b) =>
      b..G__typename = 'Location';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  double? get latitude;
  @override
  double? get longitude;
  static Serializer<GReserveDonationData_reserveDonation_donation_location>
      get serializer =>
          _$gReserveDonationDataReserveDonationDonationLocationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation_donation_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation_donation_location? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation_donation_location.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation_donation_user
    implements
        Built<GReserveDonationData_reserveDonation_donation_user,
            GReserveDonationData_reserveDonation_donation_userBuilder>,
        _i2.GReservationFields_donation_user {
  GReserveDonationData_reserveDonation_donation_user._();

  factory GReserveDonationData_reserveDonation_donation_user(
      [void Function(
              GReserveDonationData_reserveDonation_donation_userBuilder b)
          updates]) = _$GReserveDonationData_reserveDonation_donation_user;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonation_donation_userBuilder b) =>
      b..G__typename = 'User';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get displayName;
  @override
  String get email;
  static Serializer<GReserveDonationData_reserveDonation_donation_user>
      get serializer =>
          _$gReserveDonationDataReserveDonationDonationUserSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation_donation_user.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation_donation_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation_donation_user.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation_beneficiary
    implements
        Built<GReserveDonationData_reserveDonation_beneficiary,
            GReserveDonationData_reserveDonation_beneficiaryBuilder>,
        _i2.GReservationFields_beneficiary {
  GReserveDonationData_reserveDonation_beneficiary._();

  factory GReserveDonationData_reserveDonation_beneficiary(
      [void Function(GReserveDonationData_reserveDonation_beneficiaryBuilder b)
          updates]) = _$GReserveDonationData_reserveDonation_beneficiary;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonation_beneficiaryBuilder b) =>
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
  _i3.GUserRole get role;
  @override
  String? get description;
  @override
  bool get isMailVerified;
  @override
  int get reputationScore;
  @override
  String? get locationId;
  @override
  GReserveDonationData_reserveDonation_beneficiary_location? get location;
  @override
  GReserveDonationData_reserveDonation_beneficiary_avatar? get avatar;
  static Serializer<GReserveDonationData_reserveDonation_beneficiary>
      get serializer =>
          _$gReserveDonationDataReserveDonationBeneficiarySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation_beneficiary.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation_beneficiary? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation_beneficiary.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation_beneficiary_location
    implements
        Built<GReserveDonationData_reserveDonation_beneficiary_location,
            GReserveDonationData_reserveDonation_beneficiary_locationBuilder>,
        _i2.GReservationFields_beneficiary_location {
  GReserveDonationData_reserveDonation_beneficiary_location._();

  factory GReserveDonationData_reserveDonation_beneficiary_location(
      [void Function(
              GReserveDonationData_reserveDonation_beneficiary_locationBuilder
                  b)
          updates]) = _$GReserveDonationData_reserveDonation_beneficiary_location;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonation_beneficiary_locationBuilder b) =>
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
  static Serializer<GReserveDonationData_reserveDonation_beneficiary_location>
      get serializer =>
          _$gReserveDonationDataReserveDonationBeneficiaryLocationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation_beneficiary_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation_beneficiary_location? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation_beneficiary_location.serializer,
        json,
      );
}

abstract class GReserveDonationData_reserveDonation_beneficiary_avatar
    implements
        Built<GReserveDonationData_reserveDonation_beneficiary_avatar,
            GReserveDonationData_reserveDonation_beneficiary_avatarBuilder>,
        _i2.GReservationFields_beneficiary_avatar {
  GReserveDonationData_reserveDonation_beneficiary_avatar._();

  factory GReserveDonationData_reserveDonation_beneficiary_avatar(
      [void Function(
              GReserveDonationData_reserveDonation_beneficiary_avatarBuilder b)
          updates]) = _$GReserveDonationData_reserveDonation_beneficiary_avatar;

  static void _initializeBuilder(
          GReserveDonationData_reserveDonation_beneficiary_avatarBuilder b) =>
      b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get url;
  static Serializer<GReserveDonationData_reserveDonation_beneficiary_avatar>
      get serializer =>
          _$gReserveDonationDataReserveDonationBeneficiaryAvatarSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GReserveDonationData_reserveDonation_beneficiary_avatar.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReserveDonationData_reserveDonation_beneficiary_avatar? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GReserveDonationData_reserveDonation_beneficiary_avatar.serializer,
        json,
      );
}
