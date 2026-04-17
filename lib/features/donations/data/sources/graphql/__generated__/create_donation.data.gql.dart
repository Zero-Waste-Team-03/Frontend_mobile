// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    as _i2;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;

part 'create_donation.data.gql.g.dart';

abstract class GCreateDonationData
    implements Built<GCreateDonationData, GCreateDonationDataBuilder> {
  GCreateDonationData._();

  factory GCreateDonationData([
    void Function(GCreateDonationDataBuilder b) updates,
  ]) = _$GCreateDonationData;

  static void _initializeBuilder(GCreateDonationDataBuilder b) =>
      b..G__typename = 'Mutation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  GCreateDonationData_createDonation get createDonation;
  static Serializer<GCreateDonationData> get serializer =>
      _$gCreateDonationDataSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GCreateDonationData.serializer, this)
          as Map<String, dynamic>);

  static GCreateDonationData? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GCreateDonationData.serializer, json);
}

abstract class GCreateDonationData_createDonation
    implements
        Built<
          GCreateDonationData_createDonation,
          GCreateDonationData_createDonationBuilder
        > {
  GCreateDonationData_createDonation._();

  factory GCreateDonationData_createDonation([
    void Function(GCreateDonationData_createDonationBuilder b) updates,
  ]) = _$GCreateDonationData_createDonation;

  static void _initializeBuilder(GCreateDonationData_createDonationBuilder b) =>
      b..G__typename = 'Donation';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get title;
  String get description;
  int get quantity;
  String get categoryId;
  GCreateDonationData_createDonation_category? get category;
  _i2.GDonationStatusValues get status;
  _i2.GDonationUrgencyValues get urgency;
  String? get mainAttachmentId;
  GCreateDonationData_createDonation_mainAttachment? get mainAttachment;
  String? get locationId;
  GCreateDonationData_createDonation_location? get location;
  GCreateDonationData_createDonation_user get user;
  static Serializer<GCreateDonationData_createDonation> get serializer =>
      _$gCreateDonationDataCreateDonationSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GCreateDonationData_createDonation.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GCreateDonationData_createDonation? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GCreateDonationData_createDonation.serializer,
    json,
  );
}

abstract class GCreateDonationData_createDonation_category
    implements
        Built<
          GCreateDonationData_createDonation_category,
          GCreateDonationData_createDonation_categoryBuilder
        > {
  GCreateDonationData_createDonation_category._();

  factory GCreateDonationData_createDonation_category([
    void Function(GCreateDonationData_createDonation_categoryBuilder b) updates,
  ]) = _$GCreateDonationData_createDonation_category;

  static void _initializeBuilder(
    GCreateDonationData_createDonation_categoryBuilder b,
  ) => b..G__typename = 'Category';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String get id;
  String get name;
  static Serializer<GCreateDonationData_createDonation_category>
  get serializer => _$gCreateDonationDataCreateDonationCategorySerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GCreateDonationData_createDonation_category.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GCreateDonationData_createDonation_category? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GCreateDonationData_createDonation_category.serializer,
    json,
  );
}

abstract class GCreateDonationData_createDonation_mainAttachment
    implements
        Built<
          GCreateDonationData_createDonation_mainAttachment,
          GCreateDonationData_createDonation_mainAttachmentBuilder
        > {
  GCreateDonationData_createDonation_mainAttachment._();

  factory GCreateDonationData_createDonation_mainAttachment([
    void Function(GCreateDonationData_createDonation_mainAttachmentBuilder b)
    updates,
  ]) = _$GCreateDonationData_createDonation_mainAttachment;

  static void _initializeBuilder(
    GCreateDonationData_createDonation_mainAttachmentBuilder b,
  ) => b..G__typename = 'Attachment';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get url;
  static Serializer<GCreateDonationData_createDonation_mainAttachment>
  get serializer => _$gCreateDonationDataCreateDonationMainAttachmentSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GCreateDonationData_createDonation_mainAttachment.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GCreateDonationData_createDonation_mainAttachment? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GCreateDonationData_createDonation_mainAttachment.serializer,
    json,
  );
}

abstract class GCreateDonationData_createDonation_location
    implements
        Built<
          GCreateDonationData_createDonation_location,
          GCreateDonationData_createDonation_locationBuilder
        > {
  GCreateDonationData_createDonation_location._();

  factory GCreateDonationData_createDonation_location([
    void Function(GCreateDonationData_createDonation_locationBuilder b) updates,
  ]) = _$GCreateDonationData_createDonation_location;

  static void _initializeBuilder(
    GCreateDonationData_createDonation_locationBuilder b,
  ) => b..G__typename = 'Location';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  double? get latitude;
  double? get longitude;
  static Serializer<GCreateDonationData_createDonation_location>
  get serializer => _$gCreateDonationDataCreateDonationLocationSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GCreateDonationData_createDonation_location.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GCreateDonationData_createDonation_location? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GCreateDonationData_createDonation_location.serializer,
    json,
  );
}

abstract class GCreateDonationData_createDonation_user
    implements
        Built<
          GCreateDonationData_createDonation_user,
          GCreateDonationData_createDonation_userBuilder
        > {
  GCreateDonationData_createDonation_user._();

  factory GCreateDonationData_createDonation_user([
    void Function(GCreateDonationData_createDonation_userBuilder b) updates,
  ]) = _$GCreateDonationData_createDonation_user;

  static void _initializeBuilder(
    GCreateDonationData_createDonation_userBuilder b,
  ) => b..G__typename = 'User';

  @BuiltValueField(wireName: '__typename')
  String get G__typename;
  String? get displayName;
  String get email;
  static Serializer<GCreateDonationData_createDonation_user> get serializer =>
      _$gCreateDonationDataCreateDonationUserSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GCreateDonationData_createDonation_user.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GCreateDonationData_createDonation_user? fromJson(
    Map<String, dynamic> json,
  ) => _i1.serializers.deserializeWith(
    GCreateDonationData_createDonation_user.serializer,
    json,
  );
}
