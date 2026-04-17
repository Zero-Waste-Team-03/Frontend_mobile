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

part 'confirm_reservation.data.gql.g.dart';

abstract class GConfirmReservationData
    implements Built<GConfirmReservationData, GConfirmReservationDataBuilder> {
  GConfirmReservationData._();

  factory GConfirmReservationData(
          [void Function(GConfirmReservationDataBuilder b) updates]) =
      _$GConfirmReservationData;

  static void _initializeBuilder(GConfirmReservationDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GConfirmReservationData_confirmReservation get confirmReservation;
  static Serializer<GConfirmReservationData> get serializer =>
      _$gConfirmReservationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GConfirmReservationData.serializer,
        json,
      );
}

abstract class GConfirmReservationData_confirmReservation
    implements
        Built<GConfirmReservationData_confirmReservation,
            GConfirmReservationData_confirmReservationBuilder>,
        _i2.GReservationFields {
  GConfirmReservationData_confirmReservation._();

  factory GConfirmReservationData_confirmReservation(
      [void Function(GConfirmReservationData_confirmReservationBuilder b)
          updates]) = _$GConfirmReservationData_confirmReservation;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservationBuilder b) =>
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
  GConfirmReservationData_confirmReservation_donation? get donation;
  @override
  GConfirmReservationData_confirmReservation_beneficiary? get beneficiary;
  static Serializer<GConfirmReservationData_confirmReservation>
      get serializer => _$gConfirmReservationDataConfirmReservationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GConfirmReservationData_confirmReservation.serializer,
        json,
      );
}

abstract class GConfirmReservationData_confirmReservation_donation
    implements
        Built<GConfirmReservationData_confirmReservation_donation,
            GConfirmReservationData_confirmReservation_donationBuilder>,
        _i2.GReservationFields_donation {
  GConfirmReservationData_confirmReservation_donation._();

  factory GConfirmReservationData_confirmReservation_donation(
      [void Function(
              GConfirmReservationData_confirmReservation_donationBuilder b)
          updates]) = _$GConfirmReservationData_confirmReservation_donation;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservation_donationBuilder b) =>
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
  GConfirmReservationData_confirmReservation_donation_category? get category;
  @override
  _i3.GDonationStatusValues get status;
  @override
  _i3.GDonationUrgencyValues get urgency;
  @override
  String? get mainAttachmentId;
  @override
  GConfirmReservationData_confirmReservation_donation_mainAttachment?
      get mainAttachment;
  @override
  GConfirmReservationData_confirmReservation_donation_location? get location;
  @override
  GConfirmReservationData_confirmReservation_donation_user get user;
  static Serializer<GConfirmReservationData_confirmReservation_donation>
      get serializer =>
          _$gConfirmReservationDataConfirmReservationDonationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation_donation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation_donation? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GConfirmReservationData_confirmReservation_donation.serializer,
        json,
      );
}

abstract class GConfirmReservationData_confirmReservation_donation_category
    implements
        Built<GConfirmReservationData_confirmReservation_donation_category,
            GConfirmReservationData_confirmReservation_donation_categoryBuilder>,
        _i2.GReservationFields_donation_category {
  GConfirmReservationData_confirmReservation_donation_category._();

  factory GConfirmReservationData_confirmReservation_donation_category(
          [void Function(
                  GConfirmReservationData_confirmReservation_donation_categoryBuilder
                      b)
              updates]) =
      _$GConfirmReservationData_confirmReservation_donation_category;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservation_donation_categoryBuilder
              b) =>
      b..G__typename = 'Category';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get name;
  static Serializer<
          GConfirmReservationData_confirmReservation_donation_category>
      get serializer =>
          _$gConfirmReservationDataConfirmReservationDonationCategorySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation_donation_category.serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation_donation_category? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GConfirmReservationData_confirmReservation_donation_category.serializer,
        json,
      );
}

abstract class GConfirmReservationData_confirmReservation_donation_mainAttachment
    implements
        Built<
            GConfirmReservationData_confirmReservation_donation_mainAttachment,
            GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder>,
        _i2.GReservationFields_donation_mainAttachment {
  GConfirmReservationData_confirmReservation_donation_mainAttachment._();

  factory GConfirmReservationData_confirmReservation_donation_mainAttachment(
          [void Function(
                  GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder
                      b)
              updates]) =
      _$GConfirmReservationData_confirmReservation_donation_mainAttachment;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservation_donation_mainAttachmentBuilder
              b) =>
      b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get url;
  static Serializer<
          GConfirmReservationData_confirmReservation_donation_mainAttachment>
      get serializer =>
          _$gConfirmReservationDataConfirmReservationDonationMainAttachmentSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation_donation_mainAttachment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation_donation_mainAttachment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GConfirmReservationData_confirmReservation_donation_mainAttachment
                .serializer,
            json,
          );
}

abstract class GConfirmReservationData_confirmReservation_donation_location
    implements
        Built<GConfirmReservationData_confirmReservation_donation_location,
            GConfirmReservationData_confirmReservation_donation_locationBuilder>,
        _i2.GReservationFields_donation_location {
  GConfirmReservationData_confirmReservation_donation_location._();

  factory GConfirmReservationData_confirmReservation_donation_location(
          [void Function(
                  GConfirmReservationData_confirmReservation_donation_locationBuilder
                      b)
              updates]) =
      _$GConfirmReservationData_confirmReservation_donation_location;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservation_donation_locationBuilder
              b) =>
      b..G__typename = 'Location';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  double? get latitude;
  @override
  double? get longitude;
  static Serializer<
          GConfirmReservationData_confirmReservation_donation_location>
      get serializer =>
          _$gConfirmReservationDataConfirmReservationDonationLocationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation_donation_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation_donation_location? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GConfirmReservationData_confirmReservation_donation_location.serializer,
        json,
      );
}

abstract class GConfirmReservationData_confirmReservation_donation_user
    implements
        Built<GConfirmReservationData_confirmReservation_donation_user,
            GConfirmReservationData_confirmReservation_donation_userBuilder>,
        _i2.GReservationFields_donation_user {
  GConfirmReservationData_confirmReservation_donation_user._();

  factory GConfirmReservationData_confirmReservation_donation_user(
      [void Function(
              GConfirmReservationData_confirmReservation_donation_userBuilder b)
          updates]) = _$GConfirmReservationData_confirmReservation_donation_user;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservation_donation_userBuilder b) =>
      b..G__typename = 'User';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get displayName;
  @override
  String get email;
  static Serializer<GConfirmReservationData_confirmReservation_donation_user>
      get serializer =>
          _$gConfirmReservationDataConfirmReservationDonationUserSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation_donation_user.serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation_donation_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GConfirmReservationData_confirmReservation_donation_user.serializer,
        json,
      );
}

abstract class GConfirmReservationData_confirmReservation_beneficiary
    implements
        Built<GConfirmReservationData_confirmReservation_beneficiary,
            GConfirmReservationData_confirmReservation_beneficiaryBuilder>,
        _i2.GReservationFields_beneficiary {
  GConfirmReservationData_confirmReservation_beneficiary._();

  factory GConfirmReservationData_confirmReservation_beneficiary(
      [void Function(
              GConfirmReservationData_confirmReservation_beneficiaryBuilder b)
          updates]) = _$GConfirmReservationData_confirmReservation_beneficiary;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservation_beneficiaryBuilder b) =>
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
  GConfirmReservationData_confirmReservation_beneficiary_location? get location;
  @override
  GConfirmReservationData_confirmReservation_beneficiary_avatar? get avatar;
  static Serializer<GConfirmReservationData_confirmReservation_beneficiary>
      get serializer =>
          _$gConfirmReservationDataConfirmReservationBeneficiarySerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation_beneficiary.serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation_beneficiary? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GConfirmReservationData_confirmReservation_beneficiary.serializer,
        json,
      );
}

abstract class GConfirmReservationData_confirmReservation_beneficiary_location
    implements
        Built<GConfirmReservationData_confirmReservation_beneficiary_location,
            GConfirmReservationData_confirmReservation_beneficiary_locationBuilder>,
        _i2.GReservationFields_beneficiary_location {
  GConfirmReservationData_confirmReservation_beneficiary_location._();

  factory GConfirmReservationData_confirmReservation_beneficiary_location(
          [void Function(
                  GConfirmReservationData_confirmReservation_beneficiary_locationBuilder
                      b)
              updates]) =
      _$GConfirmReservationData_confirmReservation_beneficiary_location;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservation_beneficiary_locationBuilder
              b) =>
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
  static Serializer<
          GConfirmReservationData_confirmReservation_beneficiary_location>
      get serializer =>
          _$gConfirmReservationDataConfirmReservationBeneficiaryLocationSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation_beneficiary_location
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation_beneficiary_location?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GConfirmReservationData_confirmReservation_beneficiary_location
                .serializer,
            json,
          );
}

abstract class GConfirmReservationData_confirmReservation_beneficiary_avatar
    implements
        Built<GConfirmReservationData_confirmReservation_beneficiary_avatar,
            GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder>,
        _i2.GReservationFields_beneficiary_avatar {
  GConfirmReservationData_confirmReservation_beneficiary_avatar._();

  factory GConfirmReservationData_confirmReservation_beneficiary_avatar(
          [void Function(
                  GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder
                      b)
              updates]) =
      _$GConfirmReservationData_confirmReservation_beneficiary_avatar;

  static void _initializeBuilder(
          GConfirmReservationData_confirmReservation_beneficiary_avatarBuilder
              b) =>
      b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get url;
  static Serializer<
          GConfirmReservationData_confirmReservation_beneficiary_avatar>
      get serializer =>
          _$gConfirmReservationDataConfirmReservationBeneficiaryAvatarSerializer;

  @override
  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GConfirmReservationData_confirmReservation_beneficiary_avatar
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GConfirmReservationData_confirmReservation_beneficiary_avatar?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GConfirmReservationData_confirmReservation_beneficiary_avatar
                .serializer,
            json,
          );
}
