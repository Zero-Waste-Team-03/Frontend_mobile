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

part 'my_reservation.data.gql.g.dart';

abstract class GMyReservationData
    implements Built<GMyReservationData, GMyReservationDataBuilder> {
  GMyReservationData._();

  factory GMyReservationData([
    void Function(GMyReservationDataBuilder b) updates,
  ]) = _$GMyReservationData;

  static void _initializeBuilder(GMyReservationDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMyReservationData_myReservation get myReservation;
  static Serializer<GMyReservationData> get serializer =>
      _$gMyReservationDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GMyReservationData.serializer, this)
          as Map<String, dynamic>);

  static GMyReservationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GMyReservationData.serializer, json);
}

abstract class GMyReservationData_myReservation
    implements
        Built<
          GMyReservationData_myReservation,
          GMyReservationData_myReservationBuilder
        >,
        _i2.GReservationFields {
  GMyReservationData_myReservation._();

  factory GMyReservationData_myReservation([
    void Function(GMyReservationData_myReservationBuilder b) updates,
  ]) = _$GMyReservationData_myReservation;

  static void _initializeBuilder(GMyReservationData_myReservationBuilder b) =>
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
  GMyReservationData_myReservation_donation? get donation;
  @override
  GMyReservationData_myReservation_beneficiary? get beneficiary;
  static Serializer<GMyReservationData_myReservation> get serializer =>
      _$gMyReservationDataMyReservationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation.serializer,
    json,
  );
}

abstract class GMyReservationData_myReservation_donation
    implements
        Built<
          GMyReservationData_myReservation_donation,
          GMyReservationData_myReservation_donationBuilder
        >,
        _i2.GReservationFields_donation {
  GMyReservationData_myReservation_donation._();

  factory GMyReservationData_myReservation_donation([
    void Function(GMyReservationData_myReservation_donationBuilder b) updates,
  ]) = _$GMyReservationData_myReservation_donation;

  static void _initializeBuilder(
    GMyReservationData_myReservation_donationBuilder b,
  ) => b..G__typename = 'Donation';

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
  GMyReservationData_myReservation_donation_category? get category;
  @override
  _i3.GDonationStatusValues get status;
  @override
  _i3.GDonationUrgencyValues get urgency;
  @override
  String? get mainAttachmentId;
  @override
  GMyReservationData_myReservation_donation_mainAttachment? get mainAttachment;
  @override
  GMyReservationData_myReservation_donation_location? get location;
  @override
  GMyReservationData_myReservation_donation_user get user;
  static Serializer<GMyReservationData_myReservation_donation> get serializer =>
      _$gMyReservationDataMyReservationDonationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation_donation.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation_donation.serializer,
    json,
  );
}

abstract class GMyReservationData_myReservation_donation_category
    implements
        Built<
          GMyReservationData_myReservation_donation_category,
          GMyReservationData_myReservation_donation_categoryBuilder
        >,
        _i2.GReservationFields_donation_category {
  GMyReservationData_myReservation_donation_category._();

  factory GMyReservationData_myReservation_donation_category([
    void Function(GMyReservationData_myReservation_donation_categoryBuilder b)
    updates,
  ]) = _$GMyReservationData_myReservation_donation_category;

  static void _initializeBuilder(
    GMyReservationData_myReservation_donation_categoryBuilder b,
  ) => b..G__typename = 'Category';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get name;
  static Serializer<GMyReservationData_myReservation_donation_category>
  get serializer => _$gMyReservationDataMyReservationDonationCategorySerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation_donation_category.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation_category? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation_donation_category.serializer,
    json,
  );
}

abstract class GMyReservationData_myReservation_donation_mainAttachment
    implements
        Built<
          GMyReservationData_myReservation_donation_mainAttachment,
          GMyReservationData_myReservation_donation_mainAttachmentBuilder
        >,
        _i2.GReservationFields_donation_mainAttachment {
  GMyReservationData_myReservation_donation_mainAttachment._();

  factory GMyReservationData_myReservation_donation_mainAttachment([
    void Function(
      GMyReservationData_myReservation_donation_mainAttachmentBuilder b,
    )
    updates,
  ]) = _$GMyReservationData_myReservation_donation_mainAttachment;

  static void _initializeBuilder(
    GMyReservationData_myReservation_donation_mainAttachmentBuilder b,
  ) => b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get url;
  static Serializer<GMyReservationData_myReservation_donation_mainAttachment>
  get serializer =>
      _$gMyReservationDataMyReservationDonationMainAttachmentSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation_donation_mainAttachment.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation_mainAttachment? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation_donation_mainAttachment.serializer,
    json,
  );
}

abstract class GMyReservationData_myReservation_donation_location
    implements
        Built<
          GMyReservationData_myReservation_donation_location,
          GMyReservationData_myReservation_donation_locationBuilder
        >,
        _i2.GReservationFields_donation_location {
  GMyReservationData_myReservation_donation_location._();

  factory GMyReservationData_myReservation_donation_location([
    void Function(GMyReservationData_myReservation_donation_locationBuilder b)
    updates,
  ]) = _$GMyReservationData_myReservation_donation_location;

  static void _initializeBuilder(
    GMyReservationData_myReservation_donation_locationBuilder b,
  ) => b..G__typename = 'Location';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  double? get latitude;
  @override
  double? get longitude;
  static Serializer<GMyReservationData_myReservation_donation_location>
  get serializer => _$gMyReservationDataMyReservationDonationLocationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation_donation_location.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation_location? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation_donation_location.serializer,
    json,
  );
}

abstract class GMyReservationData_myReservation_donation_user
    implements
        Built<
          GMyReservationData_myReservation_donation_user,
          GMyReservationData_myReservation_donation_userBuilder
        >,
        _i2.GReservationFields_donation_user {
  GMyReservationData_myReservation_donation_user._();

  factory GMyReservationData_myReservation_donation_user([
    void Function(GMyReservationData_myReservation_donation_userBuilder b)
    updates,
  ]) = _$GMyReservationData_myReservation_donation_user;

  static void _initializeBuilder(
    GMyReservationData_myReservation_donation_userBuilder b,
  ) => b..G__typename = 'User';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get displayName;
  @override
  String get email;
  static Serializer<GMyReservationData_myReservation_donation_user>
  get serializer => _$gMyReservationDataMyReservationDonationUserSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation_donation_user.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation_user? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation_donation_user.serializer,
    json,
  );
}

abstract class GMyReservationData_myReservation_beneficiary
    implements
        Built<
          GMyReservationData_myReservation_beneficiary,
          GMyReservationData_myReservation_beneficiaryBuilder
        >,
        _i2.GReservationFields_beneficiary {
  GMyReservationData_myReservation_beneficiary._();

  factory GMyReservationData_myReservation_beneficiary([
    void Function(GMyReservationData_myReservation_beneficiaryBuilder b)
    updates,
  ]) = _$GMyReservationData_myReservation_beneficiary;

  static void _initializeBuilder(
    GMyReservationData_myReservation_beneficiaryBuilder b,
  ) => b..G__typename = 'User';

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
  GMyReservationData_myReservation_beneficiary_location? get location;
  @override
  GMyReservationData_myReservation_beneficiary_avatar? get avatar;
  static Serializer<GMyReservationData_myReservation_beneficiary>
  get serializer => _$gMyReservationDataMyReservationBeneficiarySerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation_beneficiary.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation_beneficiary? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation_beneficiary.serializer,
    json,
  );
}

abstract class GMyReservationData_myReservation_beneficiary_location
    implements
        Built<
          GMyReservationData_myReservation_beneficiary_location,
          GMyReservationData_myReservation_beneficiary_locationBuilder
        >,
        _i2.GReservationFields_beneficiary_location {
  GMyReservationData_myReservation_beneficiary_location._();

  factory GMyReservationData_myReservation_beneficiary_location([
    void Function(
      GMyReservationData_myReservation_beneficiary_locationBuilder b,
    )
    updates,
  ]) = _$GMyReservationData_myReservation_beneficiary_location;

  static void _initializeBuilder(
    GMyReservationData_myReservation_beneficiary_locationBuilder b,
  ) => b..G__typename = 'Location';

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
  static Serializer<GMyReservationData_myReservation_beneficiary_location>
  get serializer =>
      _$gMyReservationDataMyReservationBeneficiaryLocationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation_beneficiary_location.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation_beneficiary_location? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation_beneficiary_location.serializer,
    json,
  );
}

abstract class GMyReservationData_myReservation_beneficiary_avatar
    implements
        Built<
          GMyReservationData_myReservation_beneficiary_avatar,
          GMyReservationData_myReservation_beneficiary_avatarBuilder
        >,
        _i2.GReservationFields_beneficiary_avatar {
  GMyReservationData_myReservation_beneficiary_avatar._();

  factory GMyReservationData_myReservation_beneficiary_avatar([
    void Function(GMyReservationData_myReservation_beneficiary_avatarBuilder b)
    updates,
  ]) = _$GMyReservationData_myReservation_beneficiary_avatar;

  static void _initializeBuilder(
    GMyReservationData_myReservation_beneficiary_avatarBuilder b,
  ) => b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get url;
  static Serializer<GMyReservationData_myReservation_beneficiary_avatar>
  get serializer =>
      _$gMyReservationDataMyReservationBeneficiaryAvatarSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationData_myReservation_beneficiary_avatar.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationData_myReservation_beneficiary_avatar? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationData_myReservation_beneficiary_avatar.serializer,
    json,
  );
}
