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

part 'my_reservations.data.gql.g.dart';

abstract class GMyReservationsData
    implements Built<GMyReservationsData, GMyReservationsDataBuilder> {
  GMyReservationsData._();

  factory GMyReservationsData(
          [void Function(GMyReservationsDataBuilder b) updates]) =
      _$GMyReservationsData;

  static void _initializeBuilder(GMyReservationsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMyReservationsData_myReservations get myReservations;
  static Serializer<GMyReservationsData> get serializer =>
      _$gMyReservationsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationsData.serializer,
        json,
      );
}

abstract class GMyReservationsData_myReservations
    implements
        Built<GMyReservationsData_myReservations,
            GMyReservationsData_myReservationsBuilder> {
  GMyReservationsData_myReservations._();

  factory GMyReservationsData_myReservations(
      [void Function(GMyReservationsData_myReservationsBuilder b)
          updates]) = _$GMyReservationsData_myReservations;

  static void _initializeBuilder(GMyReservationsData_myReservationsBuilder b) =>
      b..G__typename = 'PaginatedReservations';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get hasNextPage;
  bool get hasPreviousPage;
  int get totalCount;
  int get page;
  int get limit;
  BuiltList<GMyReservationsData_myReservations_items>? get items;
  static Serializer<GMyReservationsData_myReservations> get serializer =>
      _$gMyReservationsDataMyReservationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationsData_myReservations.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationsData_myReservations? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationsData_myReservations.serializer,
        json,
      );
}

abstract class GMyReservationsData_myReservations_items
    implements
        Built<GMyReservationsData_myReservations_items,
            GMyReservationsData_myReservations_itemsBuilder> {
  GMyReservationsData_myReservations_items._();

  factory GMyReservationsData_myReservations_items(
      [void Function(GMyReservationsData_myReservations_itemsBuilder b)
          updates]) = _$GMyReservationsData_myReservations_items;

  static void _initializeBuilder(
          GMyReservationsData_myReservations_itemsBuilder b) =>
      b..G__typename = 'Reservation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  _i2.GReservationStatus get status;
  _i2.GDateTime get createdAt;
  _i2.GDateTime? get confirmedAt;
  _i2.GDateTime get updatedAt;
  GMyReservationsData_myReservations_items_donation? get donation;
  static Serializer<GMyReservationsData_myReservations_items> get serializer =>
      _$gMyReservationsDataMyReservationsItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationsData_myReservations_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationsData_myReservations_items.serializer,
        json,
      );
}

abstract class GMyReservationsData_myReservations_items_donation
    implements
        Built<GMyReservationsData_myReservations_items_donation,
            GMyReservationsData_myReservations_items_donationBuilder> {
  GMyReservationsData_myReservations_items_donation._();

  factory GMyReservationsData_myReservations_items_donation(
      [void Function(GMyReservationsData_myReservations_items_donationBuilder b)
          updates]) = _$GMyReservationsData_myReservations_items_donation;

  static void _initializeBuilder(
          GMyReservationsData_myReservations_items_donationBuilder b) =>
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
  GMyReservationsData_myReservations_items_donation_mainAttachment?
      get mainAttachment;
  static Serializer<GMyReservationsData_myReservations_items_donation>
      get serializer =>
          _$gMyReservationsDataMyReservationsItemsDonationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationsData_myReservations_items_donation.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_donation? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyReservationsData_myReservations_items_donation.serializer,
        json,
      );
}

abstract class GMyReservationsData_myReservations_items_donation_mainAttachment
    implements
        Built<GMyReservationsData_myReservations_items_donation_mainAttachment,
            GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder> {
  GMyReservationsData_myReservations_items_donation_mainAttachment._();

  factory GMyReservationsData_myReservations_items_donation_mainAttachment(
          [void Function(
                  GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder
                      b)
              updates]) =
      _$GMyReservationsData_myReservations_items_donation_mainAttachment;

  static void _initializeBuilder(
          GMyReservationsData_myReservations_items_donation_mainAttachmentBuilder
              b) =>
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
  static Serializer<
          GMyReservationsData_myReservations_items_donation_mainAttachment>
      get serializer =>
          _$gMyReservationsDataMyReservationsItemsDonationMainAttachmentSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyReservationsData_myReservations_items_donation_mainAttachment
            .serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyReservationsData_myReservations_items_donation_mainAttachment?
      fromJson(Map<String, dynamic> json) => _i1.serializers.deserializeWith(
            GMyReservationsData_myReservations_items_donation_mainAttachment
                .serializer,
            json,
          );
}
