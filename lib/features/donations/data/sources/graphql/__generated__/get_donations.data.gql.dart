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

part 'get_donations.data.gql.g.dart';

abstract class GGetDonationsData
    implements Built<GGetDonationsData, GGetDonationsDataBuilder> {
  GGetDonationsData._();

  factory GGetDonationsData([
    void Function(GGetDonationsDataBuilder b) updates,
  ]) = _$GGetDonationsData;

  static void _initializeBuilder(GGetDonationsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GGetDonationsData_donations get donations;
  static Serializer<GGetDonationsData> get serializer =>
      _$gGetDonationsDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GGetDonationsData.serializer, this)
          as Map<String, dynamic>);

  static GGetDonationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GGetDonationsData.serializer, json);
}

abstract class GGetDonationsData_donations
    implements
        Built<GGetDonationsData_donations, GGetDonationsData_donationsBuilder> {
  GGetDonationsData_donations._();

  factory GGetDonationsData_donations([
    void Function(GGetDonationsData_donationsBuilder b) updates,
  ]) = _$GGetDonationsData_donations;

  static void _initializeBuilder(GGetDonationsData_donationsBuilder b) =>
      b..G__typename = 'PaginatedDonations';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  BuiltList<GGetDonationsData_donations_items>? get items;
  static Serializer<GGetDonationsData_donations> get serializer =>
      _$gGetDonationsDataDonationsSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetDonationsData_donations.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetDonationsData_donations? fromJson(Map<String, dynamic> json) => _i1
      .serializers
      .deserializeWith(GGetDonationsData_donations.serializer, json);
}

abstract class GGetDonationsData_donations_items
    implements
        Built<
          GGetDonationsData_donations_items,
          GGetDonationsData_donations_itemsBuilder
        > {
  GGetDonationsData_donations_items._();

  factory GGetDonationsData_donations_items([
    void Function(GGetDonationsData_donations_itemsBuilder b) updates,
  ]) = _$GGetDonationsData_donations_items;

  static void _initializeBuilder(GGetDonationsData_donations_itemsBuilder b) =>
      b..G__typename = 'Donation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get description;
  int get quantity;
  String get categoryId;
  GGetDonationsData_donations_items_category? get category;
  _i2.GDonationStatusValues get status;
  _i2.GDonationUrgencyValues get urgency;
  String? get mainAttachmentId;
  GGetDonationsData_donations_items_mainAttachment? get mainAttachment;
  String? get locationId;
  GGetDonationsData_donations_items_location? get location;
  GGetDonationsData_donations_items_user get user;
  static Serializer<GGetDonationsData_donations_items> get serializer =>
      _$gGetDonationsDataDonationsItemsSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetDonationsData_donations_items.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetDonationsData_donations_items? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GGetDonationsData_donations_items.serializer,
    json,
  );
}

abstract class GGetDonationsData_donations_items_category
    implements
        Built<
          GGetDonationsData_donations_items_category,
          GGetDonationsData_donations_items_categoryBuilder
        > {
  GGetDonationsData_donations_items_category._();

  factory GGetDonationsData_donations_items_category([
    void Function(GGetDonationsData_donations_items_categoryBuilder b) updates,
  ]) = _$GGetDonationsData_donations_items_category;

  static void _initializeBuilder(
    GGetDonationsData_donations_items_categoryBuilder b,
  ) => b..G__typename = 'Category';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  static Serializer<GGetDonationsData_donations_items_category>
  get serializer => _$gGetDonationsDataDonationsItemsCategorySerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetDonationsData_donations_items_category.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetDonationsData_donations_items_category? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GGetDonationsData_donations_items_category.serializer,
    json,
  );
}

abstract class GGetDonationsData_donations_items_mainAttachment
    implements
        Built<
          GGetDonationsData_donations_items_mainAttachment,
          GGetDonationsData_donations_items_mainAttachmentBuilder
        > {
  GGetDonationsData_donations_items_mainAttachment._();

  factory GGetDonationsData_donations_items_mainAttachment([
    void Function(GGetDonationsData_donations_items_mainAttachmentBuilder b)
    updates,
  ]) = _$GGetDonationsData_donations_items_mainAttachment;

  static void _initializeBuilder(
    GGetDonationsData_donations_items_mainAttachmentBuilder b,
  ) => b..G__typename = 'Attachment';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get url;
  static Serializer<GGetDonationsData_donations_items_mainAttachment>
  get serializer => _$gGetDonationsDataDonationsItemsMainAttachmentSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetDonationsData_donations_items_mainAttachment.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetDonationsData_donations_items_mainAttachment? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GGetDonationsData_donations_items_mainAttachment.serializer,
    json,
  );
}

abstract class GGetDonationsData_donations_items_location
    implements
        Built<
          GGetDonationsData_donations_items_location,
          GGetDonationsData_donations_items_locationBuilder
        > {
  GGetDonationsData_donations_items_location._();

  factory GGetDonationsData_donations_items_location([
    void Function(GGetDonationsData_donations_items_locationBuilder b) updates,
  ]) = _$GGetDonationsData_donations_items_location;

  static void _initializeBuilder(
    GGetDonationsData_donations_items_locationBuilder b,
  ) => b..G__typename = 'Location';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  double? get latitude;
  double? get longitude;
  static Serializer<GGetDonationsData_donations_items_location>
  get serializer => _$gGetDonationsDataDonationsItemsLocationSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetDonationsData_donations_items_location.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetDonationsData_donations_items_location? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GGetDonationsData_donations_items_location.serializer,
    json,
  );
}

abstract class GGetDonationsData_donations_items_user
    implements
        Built<
          GGetDonationsData_donations_items_user,
          GGetDonationsData_donations_items_userBuilder
        > {
  GGetDonationsData_donations_items_user._();

  factory GGetDonationsData_donations_items_user([
    void Function(GGetDonationsData_donations_items_userBuilder b) updates,
  ]) = _$GGetDonationsData_donations_items_user;

  static void _initializeBuilder(
    GGetDonationsData_donations_items_userBuilder b,
  ) => b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get displayName;
  String get email;
  static Serializer<GGetDonationsData_donations_items_user> get serializer =>
      _$gGetDonationsDataDonationsItemsUserSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GGetDonationsData_donations_items_user.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GGetDonationsData_donations_items_user? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GGetDonationsData_donations_items_user.serializer,
    json,
  );
}
