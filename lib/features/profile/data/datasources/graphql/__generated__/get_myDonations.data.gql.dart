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

part 'get_myDonations.data.gql.g.dart';

abstract class GMyDonationsData
    implements Built<GMyDonationsData, GMyDonationsDataBuilder> {
  GMyDonationsData._();

  factory GMyDonationsData([void Function(GMyDonationsDataBuilder b) updates]) =
      _$GMyDonationsData;

  static void _initializeBuilder(GMyDonationsDataBuilder b) =>
      b..G__typename = 'Query';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GMyDonationsData_myDonations get myDonations;
  static Serializer<GMyDonationsData> get serializer =>
      _$gMyDonationsDataSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyDonationsData.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyDonationsData.serializer,
        json,
      );
}

abstract class GMyDonationsData_myDonations
    implements
        Built<GMyDonationsData_myDonations,
            GMyDonationsData_myDonationsBuilder> {
  GMyDonationsData_myDonations._();

  factory GMyDonationsData_myDonations(
          [void Function(GMyDonationsData_myDonationsBuilder b) updates]) =
      _$GMyDonationsData_myDonations;

  static void _initializeBuilder(GMyDonationsData_myDonationsBuilder b) =>
      b..G__typename = 'PaginatedDonations';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  bool get hasNextPage;
  bool get hasPreviousPage;
  int get limit;
  int get page;
  int get totalCount;
  BuiltList<GMyDonationsData_myDonations_items>? get items;
  static Serializer<GMyDonationsData_myDonations> get serializer =>
      _$gMyDonationsDataMyDonationsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyDonationsData_myDonations.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsData_myDonations? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyDonationsData_myDonations.serializer,
        json,
      );
}

abstract class GMyDonationsData_myDonations_items
    implements
        Built<GMyDonationsData_myDonations_items,
            GMyDonationsData_myDonations_itemsBuilder> {
  GMyDonationsData_myDonations_items._();

  factory GMyDonationsData_myDonations_items(
      [void Function(GMyDonationsData_myDonations_itemsBuilder b)
          updates]) = _$GMyDonationsData_myDonations_items;

  static void _initializeBuilder(GMyDonationsData_myDonations_itemsBuilder b) =>
      b..G__typename = 'Donation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get description;
  int get quantity;
  String get categoryId;
  GMyDonationsData_myDonations_items_category? get category;
  _i2.GDonationStatusValues get status;
  _i2.GDonationUrgencyValues get urgency;
  String? get mainAttachmentId;
  GMyDonationsData_myDonations_items_mainAttachment? get mainAttachment;
  String? get locationId;
  GMyDonationsData_myDonations_items_location? get location;
  GMyDonationsData_myDonations_items_user get user;
  static Serializer<GMyDonationsData_myDonations_items> get serializer =>
      _$gMyDonationsDataMyDonationsItemsSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyDonationsData_myDonations_items.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsData_myDonations_items? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyDonationsData_myDonations_items.serializer,
        json,
      );
}

abstract class GMyDonationsData_myDonations_items_category
    implements
        Built<GMyDonationsData_myDonations_items_category,
            GMyDonationsData_myDonations_items_categoryBuilder> {
  GMyDonationsData_myDonations_items_category._();

  factory GMyDonationsData_myDonations_items_category(
      [void Function(GMyDonationsData_myDonations_items_categoryBuilder b)
          updates]) = _$GMyDonationsData_myDonations_items_category;

  static void _initializeBuilder(
          GMyDonationsData_myDonations_items_categoryBuilder b) =>
      b..G__typename = 'Category';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  static Serializer<GMyDonationsData_myDonations_items_category>
      get serializer => _$gMyDonationsDataMyDonationsItemsCategorySerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyDonationsData_myDonations_items_category.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsData_myDonations_items_category? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyDonationsData_myDonations_items_category.serializer,
        json,
      );
}

abstract class GMyDonationsData_myDonations_items_mainAttachment
    implements
        Built<GMyDonationsData_myDonations_items_mainAttachment,
            GMyDonationsData_myDonations_items_mainAttachmentBuilder> {
  GMyDonationsData_myDonations_items_mainAttachment._();

  factory GMyDonationsData_myDonations_items_mainAttachment(
      [void Function(GMyDonationsData_myDonations_items_mainAttachmentBuilder b)
          updates]) = _$GMyDonationsData_myDonations_items_mainAttachment;

  static void _initializeBuilder(
          GMyDonationsData_myDonations_items_mainAttachmentBuilder b) =>
      b..G__typename = 'Attachment';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get url;
  static Serializer<GMyDonationsData_myDonations_items_mainAttachment>
      get serializer =>
          _$gMyDonationsDataMyDonationsItemsMainAttachmentSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyDonationsData_myDonations_items_mainAttachment.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsData_myDonations_items_mainAttachment? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyDonationsData_myDonations_items_mainAttachment.serializer,
        json,
      );
}

abstract class GMyDonationsData_myDonations_items_location
    implements
        Built<GMyDonationsData_myDonations_items_location,
            GMyDonationsData_myDonations_items_locationBuilder> {
  GMyDonationsData_myDonations_items_location._();

  factory GMyDonationsData_myDonations_items_location(
      [void Function(GMyDonationsData_myDonations_items_locationBuilder b)
          updates]) = _$GMyDonationsData_myDonations_items_location;

  static void _initializeBuilder(
          GMyDonationsData_myDonations_items_locationBuilder b) =>
      b..G__typename = 'Location';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  double? get latitude;
  double? get longitude;
  static Serializer<GMyDonationsData_myDonations_items_location>
      get serializer => _$gMyDonationsDataMyDonationsItemsLocationSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyDonationsData_myDonations_items_location.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsData_myDonations_items_location? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyDonationsData_myDonations_items_location.serializer,
        json,
      );
}

abstract class GMyDonationsData_myDonations_items_user
    implements
        Built<GMyDonationsData_myDonations_items_user,
            GMyDonationsData_myDonations_items_userBuilder> {
  GMyDonationsData_myDonations_items_user._();

  factory GMyDonationsData_myDonations_items_user(
      [void Function(GMyDonationsData_myDonations_items_userBuilder b)
          updates]) = _$GMyDonationsData_myDonations_items_user;

  static void _initializeBuilder(
          GMyDonationsData_myDonations_items_userBuilder b) =>
      b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get displayName;
  String get email;
  static Serializer<GMyDonationsData_myDonations_items_user> get serializer =>
      _$gMyDonationsDataMyDonationsItemsUserSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GMyDonationsData_myDonations_items_user.serializer,
        this,
      ) as Map<String, dynamic>);

  static GMyDonationsData_myDonations_items_user? fromJson(
          Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMyDonationsData_myDonations_items_user.serializer,
        json,
      );
}
