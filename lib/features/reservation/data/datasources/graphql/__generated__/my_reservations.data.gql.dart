// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i3;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.data.gql.dart'
    as _i2;

part 'my_reservations.data.gql.g.dart';

abstract class GMyReservationsData
    implements Built<GMyReservationsData, GMyReservationsDataBuilder> {
  GMyReservationsData._();

  factory GMyReservationsData([
    void Function(GMyReservationsDataBuilder b) updates,
  ]) = _$GMyReservationsData;

  static void _initializeBuilder(GMyReservationsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMyReservationsData_myReservations get myReservations;
  static Serializer<GMyReservationsData> get serializer =>
      _$gMyReservationsDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GMyReservationsData.serializer, this)
          as Map<String, dynamic>);

  static GMyReservationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GMyReservationsData.serializer, json);
}

abstract class GMyReservationsData_myReservations
    implements
        Built<
          GMyReservationsData_myReservations,
          GMyReservationsData_myReservationsBuilder
        > {
  GMyReservationsData_myReservations._();

  factory GMyReservationsData_myReservations([
    void Function(GMyReservationsData_myReservationsBuilder b) updates,
  ]) = _$GMyReservationsData_myReservations;

  static void _initializeBuilder(GMyReservationsData_myReservationsBuilder b) =>
      b..G__typename = 'PaginatedReservations';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GMyReservationsData_myReservations_items>? get items;
  int get page;
  int get limit;
  int get totalCount;
  static Serializer<GMyReservationsData_myReservations> get serializer =>
      _$gMyReservationsDataMyReservationsSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items
    implements
        Built<
          GMyReservationsData_myReservations_items,
          GMyReservationsData_myReservations_itemsBuilder
        >,
        _i2.GReservationFields {
  GMyReservationsData_myReservations_items._();

  factory GMyReservationsData_myReservations_items([
    void Function(GMyReservationsData_myReservations_itemsBuilder b) updates,
  ]) = _$GMyReservationsData_myReservations_items;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_itemsBuilder b,
  ) => b..G__typename = 'Reservation';

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
  GMyReservationsData_myReservations_items_donation? get donation;
  @override
  GMyReservationsData_myReservations_items_beneficiary? get beneficiary;
  static Serializer<GMyReservationsData_myReservations_items> get serializer =>
      _$gMyReservationsDataMyReservationsItemsSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items_donation
    implements
        Built<
          GMyReservationsData_myReservations_items_donation,
          GMyReservationsData_myReservations_items_donationBuilder
        >,
        _i2.GReservationFields_donation {
  GMyReservationsData_myReservations_items_donation._();

  factory GMyReservationsData_myReservations_items_donation([
    void Function(GMyReservationsData_myReservations_items_donationBuilder b)
    updates,
  ]) = _$GMyReservationsData_myReservations_items_donation;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_items_donationBuilder b,
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
  GMyReservationsData_myReservations_items_donation_category? get category;
  @override
  _i3.GDonationStatusValues get status;
  @override
  _i3.GDonationUrgencyValues get urgency;
  @override
  String? get mainAttachmentId;
  @override
  GMyReservationsData_myReservations_items_donation_mainAttachment?
  get mainAttachment;
  @override
  GMyReservationsData_myReservations_items_donation_location? get location;
  @override
  GMyReservationsData_myReservations_items_donation_user get user;
  static Serializer<GMyReservationsData_myReservations_items_donation>
  get serializer => _$gMyReservationsDataMyReservationsItemsDonationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items_donation.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_donation? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items_donation.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items_donation_category
    implements
        Built<
          GMyReservationsData_myReservations_items_donation_category,
          GMyReservationsData_myReservations_items_donation_categoryBuilder
        >,
        _i2.GReservationFields_donation_category {
  GMyReservationsData_myReservations_items_donation_category._();

  factory GMyReservationsData_myReservations_items_donation_category([
    void Function(
      GMyReservationsData_myReservations_items_donation_categoryBuilder b,
    )
    updates,
  ]) = _$GMyReservationsData_myReservations_items_donation_category;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_items_donation_categoryBuilder b,
  ) => b..G__typename = 'Category';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String get name;
  static Serializer<GMyReservationsData_myReservations_items_donation_category>
  get serializer =>
      _$gMyReservationsDataMyReservationsItemsDonationCategorySerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items_donation_category
                .serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_donation_category? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items_donation_category.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items_donation_mainAttachment
    implements
        Built<
          GMyReservationsData_myReservations_items_donation_mainAttachment,
          GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder
        >,
        _i2.GReservationFields_donation_mainAttachment {
  GMyReservationsData_myReservations_items_donation_mainAttachment._();

  factory GMyReservationsData_myReservations_items_donation_mainAttachment([
    void Function(
      GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder b,
    )
    updates,
  ]) = _$GMyReservationsData_myReservations_items_donation_mainAttachment;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder b,
  ) => b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get url;
  static Serializer<
    GMyReservationsData_myReservations_items_donation_mainAttachment
  >
  get serializer =>
      _$gMyReservationsDataMyReservationsItemsDonationMainAttachmentSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items_donation_mainAttachment
                .serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_donation_mainAttachment?
  fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items_donation_mainAttachment.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items_donation_location
    implements
        Built<
          GMyReservationsData_myReservations_items_donation_location,
          GMyReservationsData_myReservations_items_donation_locationBuilder
        >,
        _i2.GReservationFields_donation_location {
  GMyReservationsData_myReservations_items_donation_location._();

  factory GMyReservationsData_myReservations_items_donation_location([
    void Function(
      GMyReservationsData_myReservations_items_donation_locationBuilder b,
    )
    updates,
  ]) = _$GMyReservationsData_myReservations_items_donation_location;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_items_donation_locationBuilder b,
  ) => b..G__typename = 'Location';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  double? get latitude;
  @override
  double? get longitude;
  static Serializer<GMyReservationsData_myReservations_items_donation_location>
  get serializer =>
      _$gMyReservationsDataMyReservationsItemsDonationLocationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items_donation_location
                .serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_donation_location? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items_donation_location.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items_donation_user
    implements
        Built<
          GMyReservationsData_myReservations_items_donation_user,
          GMyReservationsData_myReservations_items_donation_userBuilder
        >,
        _i2.GReservationFields_donation_user {
  GMyReservationsData_myReservations_items_donation_user._();

  factory GMyReservationsData_myReservations_items_donation_user([
    void Function(
      GMyReservationsData_myReservations_items_donation_userBuilder b,
    )
    updates,
  ]) = _$GMyReservationsData_myReservations_items_donation_user;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_items_donation_userBuilder b,
  ) => b..G__typename = 'User';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String? get displayName;
  @override
  String get email;
  static Serializer<GMyReservationsData_myReservations_items_donation_user>
  get serializer =>
      _$gMyReservationsDataMyReservationsItemsDonationUserSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items_donation_user.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_donation_user? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items_donation_user.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items_beneficiary
    implements
        Built<
          GMyReservationsData_myReservations_items_beneficiary,
          GMyReservationsData_myReservations_items_beneficiaryBuilder
        >,
        _i2.GReservationFields_beneficiary {
  GMyReservationsData_myReservations_items_beneficiary._();

  factory GMyReservationsData_myReservations_items_beneficiary([
    void Function(GMyReservationsData_myReservations_items_beneficiaryBuilder b)
    updates,
  ]) = _$GMyReservationsData_myReservations_items_beneficiary;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_items_beneficiaryBuilder b,
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
  GMyReservationsData_myReservations_items_beneficiary_location? get location;
  @override
  GMyReservationsData_myReservations_items_beneficiary_avatar? get avatar;
  static Serializer<GMyReservationsData_myReservations_items_beneficiary>
  get serializer =>
      _$gMyReservationsDataMyReservationsItemsBeneficiarySerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items_beneficiary.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_beneficiary? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items_beneficiary.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items_beneficiary_location
    implements
        Built<
          GMyReservationsData_myReservations_items_beneficiary_location,
          GMyReservationsData_myReservations_items_beneficiary_locationBuilder
        >,
        _i2.GReservationFields_beneficiary_location {
  GMyReservationsData_myReservations_items_beneficiary_location._();

  factory GMyReservationsData_myReservations_items_beneficiary_location([
    void Function(
      GMyReservationsData_myReservations_items_beneficiary_locationBuilder b,
    )
    updates,
  ]) = _$GMyReservationsData_myReservations_items_beneficiary_location;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_items_beneficiary_locationBuilder b,
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
  static Serializer<
    GMyReservationsData_myReservations_items_beneficiary_location
  >
  get serializer =>
      _$gMyReservationsDataMyReservationsItemsBeneficiaryLocationSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items_beneficiary_location
                .serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_beneficiary_location?
  fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items_beneficiary_location.serializer,
    json,
  );
}

abstract class GMyReservationsData_myReservations_items_beneficiary_avatar
    implements
        Built<
          GMyReservationsData_myReservations_items_beneficiary_avatar,
          GMyReservationsData_myReservations_items_beneficiary_avatarBuilder
        >,
        _i2.GReservationFields_beneficiary_avatar {
  GMyReservationsData_myReservations_items_beneficiary_avatar._();

  factory GMyReservationsData_myReservations_items_beneficiary_avatar([
    void Function(
      GMyReservationsData_myReservations_items_beneficiary_avatarBuilder b,
    )
    updates,
  ]) = _$GMyReservationsData_myReservations_items_beneficiary_avatar;

  static void _initializeBuilder(
    GMyReservationsData_myReservations_items_beneficiary_avatarBuilder b,
  ) => b..G__typename = 'Attachment';

  @override
  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  @override
  String get id;
  @override
  String? get url;
  static Serializer<GMyReservationsData_myReservations_items_beneficiary_avatar>
  get serializer =>
      _$gMyReservationsDataMyReservationsItemsBeneficiaryAvatarSerializer;

  @override
  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMyReservationsData_myReservations_items_beneficiary_avatar
                .serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_beneficiary_avatar? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GMyReservationsData_myReservations_items_beneficiary_avatar.serializer,
    json,
  );
}
