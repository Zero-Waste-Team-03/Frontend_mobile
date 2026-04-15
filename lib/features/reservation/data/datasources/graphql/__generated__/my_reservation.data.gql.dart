// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'my_reservation.data.gql.g.dart';

abstract class GMyReservationData
    implements Built<GMyReservationData, GMyReservationDataBuilder> {
  GMyReservationData._();

  factory GMyReservationData(
          [void Function(GMyReservationDataBuilder b) updates]) =
      _$GMyReservationData;

  static void _initializeBuilder(GMyReservationDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMyReservationData_myReservation get myReservation;
  static Serializer<GMyReservationData> get serializer =>
      _$gMyReservationDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationData.serializer,
        json,
      );
}

abstract class GMyReservationData_myReservation
    implements
        Built<GMyReservationData_myReservation,
            GMyReservationData_myReservationBuilder> {
  GMyReservationData_myReservation._();

  factory GMyReservationData_myReservation(
          [void Function(GMyReservationData_myReservationBuilder b) updates]) =
      _$GMyReservationData_myReservation;

  static void _initializeBuilder(GMyReservationData_myReservationBuilder b) =>
      b..G__typename = 'Reservation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  _i2.GReservationStatus get status;
  _i2.GDateTime get createdAt;
  _i2.GDateTime? get confirmedAt;
  _i2.GDateTime get updatedAt;
  GMyReservationData_myReservation_donation? get donation;
  static Serializer<GMyReservationData_myReservation> get serializer =>
      _$gMyReservationDataMyReservationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationData_myReservation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationData_myReservation? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationData_myReservation.serializer,
        json,
      );
}

abstract class GMyReservationData_myReservation_donation
    implements
        Built<GMyReservationData_myReservation_donation,
            GMyReservationData_myReservation_donationBuilder> {
  GMyReservationData_myReservation_donation._();

  factory GMyReservationData_myReservation_donation(
      [void Function(GMyReservationData_myReservation_donationBuilder b)
          updates]) = _$GMyReservationData_myReservation_donation;

  static void _initializeBuilder(
          GMyReservationData_myReservation_donationBuilder b) =>
      b..G__typename = 'Donation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get description;
  int get quantity;
  String get categoryId;
  _i2.GDonationStatusValues get status;
  _i2.GDonationUrgencyValues get urgency;
  _i2.GDateTime get expiryDate;
  _i2.GDateTime? get publishedAt;
  String? get locationId;
  String? get mainAttachmentId;
  BuiltList<String> get attachmentIds;
  String get userId;
  bool get safetyChecklistCompleted;
  _i2.GDateTime? get listingExpiresAt;
  _i2.GDateTime get updatedAt;
  GMyReservationData_myReservation_donation_mainAttachment? get mainAttachment;
  GMyReservationData_myReservation_donation_user get user;
  static Serializer<GMyReservationData_myReservation_donation> get serializer =>
      _$gMyReservationDataMyReservationDonationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationData_myReservation_donation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationData_myReservation_donation.serializer,
        json,
      );
}

abstract class GMyReservationData_myReservation_donation_mainAttachment
    implements
        Built<GMyReservationData_myReservation_donation_mainAttachment,
            GMyReservationData_myReservation_donation_mainAttachmentBuilder> {
  GMyReservationData_myReservation_donation_mainAttachment._();

  factory GMyReservationData_myReservation_donation_mainAttachment(
      [void Function(
              GMyReservationData_myReservation_donation_mainAttachmentBuilder b)
          updates]) = _$GMyReservationData_myReservation_donation_mainAttachment;

  static void _initializeBuilder(
          GMyReservationData_myReservation_donation_mainAttachmentBuilder b) =>
      b..G__typename = 'Attachment';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String? get url;
  String get fileName;
  String get fileType;
  double get fileSize;
  _i2.GDateTime get createdAt;
  _i2.GDateTime? get updatedAt;
  _i2.GUploadStatusValues? get uploadStatus;
  String? get jobId;
  String get uploadedById;
  static Serializer<GMyReservationData_myReservation_donation_mainAttachment>
      get serializer =>
          _$gMyReservationDataMyReservationDonationMainAttachmentSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationData_myReservation_donation_mainAttachment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation_mainAttachment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationData_myReservation_donation_mainAttachment.serializer,
        json,
      );
}

abstract class GMyReservationData_myReservation_donation_user
    implements
        Built<GMyReservationData_myReservation_donation_user,
            GMyReservationData_myReservation_donation_userBuilder> {
  GMyReservationData_myReservation_donation_user._();

  factory GMyReservationData_myReservation_donation_user(
      [void Function(GMyReservationData_myReservation_donation_userBuilder b)
          updates]) = _$GMyReservationData_myReservation_donation_user;

  static void _initializeBuilder(
          GMyReservationData_myReservation_donation_userBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get avatarAttachmentId;
  _i2.GDateTime get createdAt;
  String? get description;
  String? get displayName;
  String get email;
  String get id;
  bool get isMailVerified;
  _i2.GDateTime? get lastChangedPasswordDate;
  String? get locationId;
  String? get phoneNumber;
  int get reputationScore;
  _i2.GUserRole get role;
  String get status;
  _i2.GDateTime get updatedAt;
  GMyReservationData_myReservation_donation_user_avatar? get avatar;
  static Serializer<GMyReservationData_myReservation_donation_user>
      get serializer => _$gMyReservationDataMyReservationDonationUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationData_myReservation_donation_user.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationData_myReservation_donation_user.serializer,
        json,
      );
}

abstract class GMyReservationData_myReservation_donation_user_avatar
    implements
        Built<GMyReservationData_myReservation_donation_user_avatar,
            GMyReservationData_myReservation_donation_user_avatarBuilder> {
  GMyReservationData_myReservation_donation_user_avatar._();

  factory GMyReservationData_myReservation_donation_user_avatar(
      [void Function(
              GMyReservationData_myReservation_donation_user_avatarBuilder b)
          updates]) = _$GMyReservationData_myReservation_donation_user_avatar;

  static void _initializeBuilder(
          GMyReservationData_myReservation_donation_user_avatarBuilder b) =>
      b..G__typename = 'Attachment';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  _i2.GDateTime get createdAt;
  String get fileName;
  double get fileSize;
  String get fileType;
  String get id;
  String? get jobId;
  _i2.GDateTime? get updatedAt;
  _i2.GUploadStatusValues? get uploadStatus;
  String get uploadedById;
  String? get url;
  static Serializer<GMyReservationData_myReservation_donation_user_avatar>
      get serializer =>
          _$gMyReservationDataMyReservationDonationUserAvatarSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationData_myReservation_donation_user_avatar.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationData_myReservation_donation_user_avatar? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationData_myReservation_donation_user_avatar.serializer,
        json,
      );
}
