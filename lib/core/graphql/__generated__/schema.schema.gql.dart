// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i1;
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    as _i2;

part 'schema.schema.gql.g.dart';

abstract class GAdminCreateAccountInput
    implements
        Built<GAdminCreateAccountInput, GAdminCreateAccountInputBuilder> {
  GAdminCreateAccountInput._();

  factory GAdminCreateAccountInput([
    void Function(GAdminCreateAccountInputBuilder b) updates,
  ]) = _$GAdminCreateAccountInput;

  String get displayName;
  String get email;
  GUserRole get role;
  static Serializer<GAdminCreateAccountInput> get serializer =>
      _$gAdminCreateAccountInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GAdminCreateAccountInput.serializer, this)
          as Map<String, dynamic>);

  static GAdminCreateAccountInput? fromJson(Map<String, dynamic> json) => _i1
      .serializers
      .deserializeWith(GAdminCreateAccountInput.serializer, json);
}

abstract class GAdminDashboardStatsInput
    implements
        Built<GAdminDashboardStatsInput, GAdminDashboardStatsInputBuilder> {
  GAdminDashboardStatsInput._();

  factory GAdminDashboardStatsInput([
    void Function(GAdminDashboardStatsInputBuilder b) updates,
  ]) = _$GAdminDashboardStatsInput;

  bool? get applyDonationStatusFilter;
  static Serializer<GAdminDashboardStatsInput> get serializer =>
      _$gAdminDashboardStatsInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GAdminDashboardStatsInput.serializer, this)
          as Map<String, dynamic>);

  static GAdminDashboardStatsInput? fromJson(Map<String, dynamic> json) => _i1
      .serializers
      .deserializeWith(GAdminDashboardStatsInput.serializer, json);
}

class GAppearanceTheme extends EnumClass {
  const GAppearanceTheme._(String name) : super(name);

  static const GAppearanceTheme DARK = _$gAppearanceThemeDARK;

  static const GAppearanceTheme LIGHT = _$gAppearanceThemeLIGHT;

  static const GAppearanceTheme SYSTEM = _$gAppearanceThemeSYSTEM;

  static Serializer<GAppearanceTheme> get serializer =>
      _$gAppearanceThemeSerializer;

  static BuiltSet<GAppearanceTheme> get values => _$gAppearanceThemeValues;

  static GAppearanceTheme valueOf(String name) =>
      _$gAppearanceThemeValueOf(name);
}

abstract class GApproveSensitiveMessageInput
    implements
        Built<
          GApproveSensitiveMessageInput,
          GApproveSensitiveMessageInputBuilder
        > {
  GApproveSensitiveMessageInput._();

  factory GApproveSensitiveMessageInput([
    void Function(GApproveSensitiveMessageInputBuilder b) updates,
  ]) = _$GApproveSensitiveMessageInput;

  String get conversationId;
  String get messageId;
  static Serializer<GApproveSensitiveMessageInput> get serializer =>
      _$gApproveSensitiveMessageInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GApproveSensitiveMessageInput.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GApproveSensitiveMessageInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GApproveSensitiveMessageInput.serializer,
        json,
      );
}

class GCategorySensitivity extends EnumClass {
  const GCategorySensitivity._(String name) : super(name);

  static const GCategorySensitivity HIGH = _$gCategorySensitivityHIGH;

  static const GCategorySensitivity LOW = _$gCategorySensitivityLOW;

  static const GCategorySensitivity MEDIUM = _$gCategorySensitivityMEDIUM;

  static Serializer<GCategorySensitivity> get serializer =>
      _$gCategorySensitivitySerializer;

  static BuiltSet<GCategorySensitivity> get values =>
      _$gCategorySensitivityValues;

  static GCategorySensitivity valueOf(String name) =>
      _$gCategorySensitivityValueOf(name);
}

abstract class GChangePasswordInput
    implements Built<GChangePasswordInput, GChangePasswordInputBuilder> {
  GChangePasswordInput._();

  factory GChangePasswordInput([
    void Function(GChangePasswordInputBuilder b) updates,
  ]) = _$GChangePasswordInput;

  String get currentPassword;
  bool? get logoutFromOtherDevices;
  String get newPassword;
  static Serializer<GChangePasswordInput> get serializer =>
      _$gChangePasswordInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GChangePasswordInput.serializer, this)
          as Map<String, dynamic>);

  static GChangePasswordInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GChangePasswordInput.serializer, json);
}

abstract class GConversationMessagesInput
    implements
        Built<GConversationMessagesInput, GConversationMessagesInputBuilder> {
  GConversationMessagesInput._();

  factory GConversationMessagesInput([
    void Function(GConversationMessagesInputBuilder b) updates,
  ]) = _$GConversationMessagesInput;

  String get conversationId;
  GPaginationInput? get pagination;
  static Serializer<GConversationMessagesInput> get serializer =>
      _$gConversationMessagesInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GConversationMessagesInput.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GConversationMessagesInput? fromJson(Map<String, dynamic> json) => _i1
      .serializers
      .deserializeWith(GConversationMessagesInput.serializer, json);
}

class GConversationStatus extends EnumClass {
  const GConversationStatus._(String name) : super(name);

  static const GConversationStatus ACTIVE = _$gConversationStatusACTIVE;

  static const GConversationStatus ARCHIVED = _$gConversationStatusARCHIVED;

  static const GConversationStatus LOCKED = _$gConversationStatusLOCKED;

  static Serializer<GConversationStatus> get serializer =>
      _$gConversationStatusSerializer;

  static BuiltSet<GConversationStatus> get values =>
      _$gConversationStatusValues;

  static GConversationStatus valueOf(String name) =>
      _$gConversationStatusValueOf(name);
}

abstract class GCoordinateInput
    implements Built<GCoordinateInput, GCoordinateInputBuilder> {
  GCoordinateInput._();

  factory GCoordinateInput([void Function(GCoordinateInputBuilder b) updates]) =
      _$GCoordinateInput;

  double get latitude;
  double get longitude;
  static Serializer<GCoordinateInput> get serializer =>
      _$gCoordinateInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GCoordinateInput.serializer, this)
          as Map<String, dynamic>);

  static GCoordinateInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GCoordinateInput.serializer, json);
}

abstract class GCreateBadgeInput
    implements Built<GCreateBadgeInput, GCreateBadgeInputBuilder> {
  GCreateBadgeInput._();

  factory GCreateBadgeInput([
    void Function(GCreateBadgeInputBuilder b) updates,
  ]) = _$GCreateBadgeInput;

  String get code;
  String get description;
  String? get iconAttachmentId;
  bool? get isActive;
  String get name;
  int? get sortOrder;
  static Serializer<GCreateBadgeInput> get serializer =>
      _$gCreateBadgeInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GCreateBadgeInput.serializer, this)
          as Map<String, dynamic>);

  static GCreateBadgeInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GCreateBadgeInput.serializer, json);
}

abstract class GCreateCategoryInput
    implements Built<GCreateCategoryInput, GCreateCategoryInputBuilder> {
  GCreateCategoryInput._();

  factory GCreateCategoryInput([
    void Function(GCreateCategoryInputBuilder b) updates,
  ]) = _$GCreateCategoryInput;

  String get name;
  GCategorySensitivity? get sensitivity;
  static Serializer<GCreateCategoryInput> get serializer =>
      _$gCreateCategoryInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GCreateCategoryInput.serializer, this)
          as Map<String, dynamic>);

  static GCreateCategoryInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GCreateCategoryInput.serializer, json);
}

abstract class GCreateDonationInput
    implements Built<GCreateDonationInput, GCreateDonationInputBuilder> {
  GCreateDonationInput._();

  factory GCreateDonationInput([
    void Function(GCreateDonationInputBuilder b) updates,
  ]) = _$GCreateDonationInput;

  BuiltList<String>? get attachmentIds;
  String get categoryId;
  String get description;
  GDateTime get expiryDate;
  double get foodWeightKg;
  GDateTime? get listingExpiresAt;
  String? get locationId;
  GLocationInput? get locationInput;
  String get mainAttachmentId;
  int get quantity;
  bool? get safetyChecklistCompleted;
  GJSONObject? get specification;
  String get title;
  GDonationUrgencyValues? get urgency;
  static Serializer<GCreateDonationInput> get serializer =>
      _$gCreateDonationInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GCreateDonationInput.serializer, this)
          as Map<String, dynamic>);

  static GCreateDonationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GCreateDonationInput.serializer, json);
}

abstract class GCreateReportInput
    implements Built<GCreateReportInput, GCreateReportInputBuilder> {
  GCreateReportInput._();

  factory GCreateReportInput([
    void Function(GCreateReportInputBuilder b) updates,
  ]) = _$GCreateReportInput;

  String? get description;
  String get reason;
  String get targetId;
  GReportTargetType get targetType;
  static Serializer<GCreateReportInput> get serializer =>
      _$gCreateReportInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GCreateReportInput.serializer, this)
          as Map<String, dynamic>);

  static GCreateReportInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GCreateReportInput.serializer, json);
}

abstract class GDateRangeInput
    implements Built<GDateRangeInput, GDateRangeInputBuilder> {
  GDateRangeInput._();

  factory GDateRangeInput([void Function(GDateRangeInputBuilder b) updates]) =
      _$GDateRangeInput;

  GDateTime get from;
  GDateTime get to;
  static Serializer<GDateRangeInput> get serializer =>
      _$gDateRangeInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GDateRangeInput.serializer, this)
          as Map<String, dynamic>);

  static GDateRangeInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GDateRangeInput.serializer, json);
}

abstract class GDateTime implements Built<GDateTime, GDateTimeBuilder> {
  GDateTime._();

  factory GDateTime([String? value]) =>
      _$GDateTime((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GDateTime> get serializer =>
      _i2.DefaultScalarSerializer<GDateTime>(
        (Object serialized) => GDateTime((serialized as String?)),
      );
}

abstract class GDonationBehaviorContextInput
    implements
        Built<
          GDonationBehaviorContextInput,
          GDonationBehaviorContextInputBuilder
        > {
  GDonationBehaviorContextInput._();

  factory GDonationBehaviorContextInput([
    void Function(GDonationBehaviorContextInputBuilder b) updates,
  ]) = _$GDonationBehaviorContextInput;

  String? get distanceBucket;
  String? get origin;
  static Serializer<GDonationBehaviorContextInput> get serializer =>
      _$gDonationBehaviorContextInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GDonationBehaviorContextInput.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GDonationBehaviorContextInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDonationBehaviorContextInput.serializer,
        json,
      );
}

abstract class GDonationsFilterInput
    implements Built<GDonationsFilterInput, GDonationsFilterInputBuilder> {
  GDonationsFilterInput._();

  factory GDonationsFilterInput([
    void Function(GDonationsFilterInputBuilder b) updates,
  ]) = _$GDonationsFilterInput;

  String? get categoryId;
  GDonationStatusValues? get status;
  GDonationUrgencyValues? get urgency;
  static Serializer<GDonationsFilterInput> get serializer =>
      _$gDonationsFilterInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GDonationsFilterInput.serializer, this)
          as Map<String, dynamic>);

  static GDonationsFilterInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GDonationsFilterInput.serializer, json);
}

abstract class GDonationsHeatmapInput
    implements Built<GDonationsHeatmapInput, GDonationsHeatmapInputBuilder> {
  GDonationsHeatmapInput._();

  factory GDonationsHeatmapInput([
    void Function(GDonationsHeatmapInputBuilder b) updates,
  ]) = _$GDonationsHeatmapInput;

  GMapBoundsInput get bounds;
  BuiltList<String>? get categories;
  GDateRangeInput? get dateRange;
  double? get gridSize;
  static Serializer<GDonationsHeatmapInput> get serializer =>
      _$gDonationsHeatmapInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GDonationsHeatmapInput.serializer, this)
          as Map<String, dynamic>);

  static GDonationsHeatmapInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GDonationsHeatmapInput.serializer, json);
}

abstract class GDonationsMapInput
    implements Built<GDonationsMapInput, GDonationsMapInputBuilder> {
  GDonationsMapInput._();

  factory GDonationsMapInput([
    void Function(GDonationsMapInputBuilder b) updates,
  ]) = _$GDonationsMapInput;

  double get latitude;
  double get longitude;
  double get radius;
  static Serializer<GDonationsMapInput> get serializer =>
      _$gDonationsMapInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GDonationsMapInput.serializer, this)
          as Map<String, dynamic>);

  static GDonationsMapInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GDonationsMapInput.serializer, json);
}

class GDonationStatusValues extends EnumClass {
  const GDonationStatusValues._(String name) : super(name);

  static const GDonationStatusValues COMPLETED =
      _$gDonationStatusValuesCOMPLETED;

  static const GDonationStatusValues DRAFT = _$gDonationStatusValuesDRAFT;

  static const GDonationStatusValues EXPIRED = _$gDonationStatusValuesEXPIRED;

  static const GDonationStatusValues PUBLISHED =
      _$gDonationStatusValuesPUBLISHED;

  static const GDonationStatusValues RESERVED = _$gDonationStatusValuesRESERVED;

  static Serializer<GDonationStatusValues> get serializer =>
      _$gDonationStatusValuesSerializer;

  static BuiltSet<GDonationStatusValues> get values =>
      _$gDonationStatusValuesValues;

  static GDonationStatusValues valueOf(String name) =>
      _$gDonationStatusValuesValueOf(name);
}

class GDonationUrgencyValues extends EnumClass {
  const GDonationUrgencyValues._(String name) : super(name);

  static const GDonationUrgencyValues HIGH = _$gDonationUrgencyValuesHIGH;

  static const GDonationUrgencyValues LOW = _$gDonationUrgencyValuesLOW;

  static const GDonationUrgencyValues MEDIUM = _$gDonationUrgencyValuesMEDIUM;

  static Serializer<GDonationUrgencyValues> get serializer =>
      _$gDonationUrgencyValuesSerializer;

  static BuiltSet<GDonationUrgencyValues> get values =>
      _$gDonationUrgencyValuesValues;

  static GDonationUrgencyValues valueOf(String name) =>
      _$gDonationUrgencyValuesValueOf(name);
}

abstract class GJSON implements Built<GJSON, GJSONBuilder> {
  GJSON._();

  factory GJSON([String? value]) =>
      _$GJSON((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GJSON> get serializer => _i2.DefaultScalarSerializer<GJSON>(
    (Object serialized) => GJSON((serialized as String?)),
  );
}

abstract class GJSONObject implements Built<GJSONObject, GJSONObjectBuilder> {
  GJSONObject._();

  factory GJSONObject([String? value]) =>
      _$GJSONObject((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GJSONObject> get serializer =>
      _i2.DefaultScalarSerializer<GJSONObject>(
        (Object serialized) => GJSONObject((serialized as String?)),
      );
}

abstract class GLocationInput
    implements Built<GLocationInput, GLocationInputBuilder> {
  GLocationInput._();

  factory GLocationInput([void Function(GLocationInputBuilder b) updates]) =
      _$GLocationInput;

  String? get city;
  String? get country;
  double? get latitude;
  double? get longitude;
  String? get neighborhood;
  static Serializer<GLocationInput> get serializer =>
      _$gLocationInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GLocationInput.serializer, this)
          as Map<String, dynamic>);

  static GLocationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GLocationInput.serializer, json);
}

abstract class GLoginInput implements Built<GLoginInput, GLoginInputBuilder> {
  GLoginInput._();

  factory GLoginInput([void Function(GLoginInputBuilder b) updates]) =
      _$GLoginInput;

  String get email;
  String get password;
  static Serializer<GLoginInput> get serializer => _$gLoginInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GLoginInput.serializer, this)
          as Map<String, dynamic>);

  static GLoginInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GLoginInput.serializer, json);
}

abstract class GMapBoundsInput
    implements Built<GMapBoundsInput, GMapBoundsInputBuilder> {
  GMapBoundsInput._();

  factory GMapBoundsInput([void Function(GMapBoundsInputBuilder b) updates]) =
      _$GMapBoundsInput;

  GCoordinateInput get northEast;
  GCoordinateInput get southWest;
  static Serializer<GMapBoundsInput> get serializer =>
      _$gMapBoundsInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GMapBoundsInput.serializer, this)
          as Map<String, dynamic>);

  static GMapBoundsInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GMapBoundsInput.serializer, json);
}

class GMarkerColorValues extends EnumClass {
  const GMarkerColorValues._(String name) : super(name);

  static const GMarkerColorValues GREEN = _$gMarkerColorValuesGREEN;

  static const GMarkerColorValues ORANGE = _$gMarkerColorValuesORANGE;

  static const GMarkerColorValues RED = _$gMarkerColorValuesRED;

  static Serializer<GMarkerColorValues> get serializer =>
      _$gMarkerColorValuesSerializer;

  static BuiltSet<GMarkerColorValues> get values => _$gMarkerColorValuesValues;

  static GMarkerColorValues valueOf(String name) =>
      _$gMarkerColorValuesValueOf(name);
}

abstract class GMarkTransactionCompletedInput
    implements
        Built<
          GMarkTransactionCompletedInput,
          GMarkTransactionCompletedInputBuilder
        > {
  GMarkTransactionCompletedInput._();

  factory GMarkTransactionCompletedInput([
    void Function(GMarkTransactionCompletedInputBuilder b) updates,
  ]) = _$GMarkTransactionCompletedInput;

  String get conversationId;
  static Serializer<GMarkTransactionCompletedInput> get serializer =>
      _$gMarkTransactionCompletedInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GMarkTransactionCompletedInput.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GMarkTransactionCompletedInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GMarkTransactionCompletedInput.serializer,
        json,
      );
}

abstract class GPaginationInput
    implements Built<GPaginationInput, GPaginationInputBuilder> {
  GPaginationInput._();

  factory GPaginationInput([void Function(GPaginationInputBuilder b) updates]) =
      _$GPaginationInput;

  int? get limit;
  int? get page;
  static Serializer<GPaginationInput> get serializer =>
      _$gPaginationInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GPaginationInput.serializer, this)
          as Map<String, dynamic>);

  static GPaginationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GPaginationInput.serializer, json);
}

abstract class GPaginationQueryInput
    implements Built<GPaginationQueryInput, GPaginationQueryInputBuilder> {
  GPaginationQueryInput._();

  factory GPaginationQueryInput([
    void Function(GPaginationQueryInputBuilder b) updates,
  ]) = _$GPaginationQueryInput;

  int? get limit;
  int? get page;
  static Serializer<GPaginationQueryInput> get serializer =>
      _$gPaginationQueryInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GPaginationQueryInput.serializer, this)
          as Map<String, dynamic>);

  static GPaginationQueryInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GPaginationQueryInput.serializer, json);
}

abstract class GRegisterInput
    implements Built<GRegisterInput, GRegisterInputBuilder> {
  GRegisterInput._();

  factory GRegisterInput([void Function(GRegisterInputBuilder b) updates]) =
      _$GRegisterInput;

  String? get displayName;
  String get email;
  GRegisterLocationInput get location;
  String get password;
  String? get phoneNumber;
  static Serializer<GRegisterInput> get serializer =>
      _$gRegisterInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GRegisterInput.serializer, this)
          as Map<String, dynamic>);

  static GRegisterInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GRegisterInput.serializer, json);
}

abstract class GRegisterLocationInput
    implements Built<GRegisterLocationInput, GRegisterLocationInputBuilder> {
  GRegisterLocationInput._();

  factory GRegisterLocationInput([
    void Function(GRegisterLocationInputBuilder b) updates,
  ]) = _$GRegisterLocationInput;

  String? get city;
  String? get country;
  double? get latitude;
  double? get longitude;
  String? get neighborhood;
  static Serializer<GRegisterLocationInput> get serializer =>
      _$gRegisterLocationInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GRegisterLocationInput.serializer, this)
          as Map<String, dynamic>);

  static GRegisterLocationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GRegisterLocationInput.serializer, json);
}

abstract class GReportStatsInput
    implements Built<GReportStatsInput, GReportStatsInputBuilder> {
  GReportStatsInput._();

  factory GReportStatsInput([
    void Function(GReportStatsInputBuilder b) updates,
  ]) = _$GReportStatsInput;

  GReportStatsPeriod get period;
  GReportStatsStatusFilter? get statusFilter;
  static Serializer<GReportStatsInput> get serializer =>
      _$gReportStatsInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GReportStatsInput.serializer, this)
          as Map<String, dynamic>);

  static GReportStatsInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GReportStatsInput.serializer, json);
}

class GReportStatsPeriod extends EnumClass {
  const GReportStatsPeriod._(String name) : super(name);

  static const GReportStatsPeriod LAST_MONTH = _$gReportStatsPeriodLAST_MONTH;

  static const GReportStatsPeriod LAST_WEEK = _$gReportStatsPeriodLAST_WEEK;

  static const GReportStatsPeriod LAST_YEAR = _$gReportStatsPeriodLAST_YEAR;

  static Serializer<GReportStatsPeriod> get serializer =>
      _$gReportStatsPeriodSerializer;

  static BuiltSet<GReportStatsPeriod> get values => _$gReportStatsPeriodValues;

  static GReportStatsPeriod valueOf(String name) =>
      _$gReportStatsPeriodValueOf(name);
}

class GReportStatsStatusFilter extends EnumClass {
  const GReportStatsStatusFilter._(String name) : super(name);

  static const GReportStatsStatusFilter ACCEPTED =
      _$gReportStatsStatusFilterACCEPTED;

  static const GReportStatsStatusFilter ALL = _$gReportStatsStatusFilterALL;

  static const GReportStatsStatusFilter OPEN = _$gReportStatsStatusFilterOPEN;

  static const GReportStatsStatusFilter REJECTED =
      _$gReportStatsStatusFilterREJECTED;

  static const GReportStatsStatusFilter RESOLVED =
      _$gReportStatsStatusFilterRESOLVED;

  static const GReportStatsStatusFilter UNDER_REVIEW =
      _$gReportStatsStatusFilterUNDER_REVIEW;

  static Serializer<GReportStatsStatusFilter> get serializer =>
      _$gReportStatsStatusFilterSerializer;

  static BuiltSet<GReportStatsStatusFilter> get values =>
      _$gReportStatsStatusFilterValues;

  static GReportStatsStatusFilter valueOf(String name) =>
      _$gReportStatsStatusFilterValueOf(name);
}

class GReportStatus extends EnumClass {
  const GReportStatus._(String name) : super(name);

  static const GReportStatus OPEN = _$gReportStatusOPEN;

  static const GReportStatus REJECTED = _$gReportStatusREJECTED;

  static const GReportStatus RESOLVED = _$gReportStatusRESOLVED;

  static const GReportStatus UNDER_REVIEW = _$gReportStatusUNDER_REVIEW;

  static Serializer<GReportStatus> get serializer => _$gReportStatusSerializer;

  static BuiltSet<GReportStatus> get values => _$gReportStatusValues;

  static GReportStatus valueOf(String name) => _$gReportStatusValueOf(name);
}

class GReportTargetType extends EnumClass {
  const GReportTargetType._(String name) : super(name);

  static const GReportTargetType DONATION = _$gReportTargetTypeDONATION;

  static const GReportTargetType MESSAGE = _$gReportTargetTypeMESSAGE;

  static const GReportTargetType USER = _$gReportTargetTypeUSER;

  static Serializer<GReportTargetType> get serializer =>
      _$gReportTargetTypeSerializer;

  static BuiltSet<GReportTargetType> get values => _$gReportTargetTypeValues;

  static GReportTargetType valueOf(String name) =>
      _$gReportTargetTypeValueOf(name);
}

abstract class GReservationsFilterInput
    implements
        Built<GReservationsFilterInput, GReservationsFilterInputBuilder> {
  GReservationsFilterInput._();

  factory GReservationsFilterInput([
    void Function(GReservationsFilterInputBuilder b) updates,
  ]) = _$GReservationsFilterInput;

  GReservationStatus? get status;
  static Serializer<GReservationsFilterInput> get serializer =>
      _$gReservationsFilterInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GReservationsFilterInput.serializer, this)
          as Map<String, dynamic>);

  static GReservationsFilterInput? fromJson(Map<String, dynamic> json) => _i1
      .serializers
      .deserializeWith(GReservationsFilterInput.serializer, json);
}

class GReservationStatus extends EnumClass {
  const GReservationStatus._(String name) : super(name);

  static const GReservationStatus CANCELLED = _$gReservationStatusCANCELLED;

  static const GReservationStatus COMPLETED = _$gReservationStatusCOMPLETED;

  static const GReservationStatus CONFIRMED = _$gReservationStatusCONFIRMED;

  static const GReservationStatus PENDING = _$gReservationStatusPENDING;

  static Serializer<GReservationStatus> get serializer =>
      _$gReservationStatusSerializer;

  static BuiltSet<GReservationStatus> get values => _$gReservationStatusValues;

  static GReservationStatus valueOf(String name) =>
      _$gReservationStatusValueOf(name);
}

abstract class GResetPasswordInput
    implements Built<GResetPasswordInput, GResetPasswordInputBuilder> {
  GResetPasswordInput._();

  factory GResetPasswordInput([
    void Function(GResetPasswordInputBuilder b) updates,
  ]) = _$GResetPasswordInput;

  String get password;
  String get token;
  static Serializer<GResetPasswordInput> get serializer =>
      _$gResetPasswordInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GResetPasswordInput.serializer, this)
          as Map<String, dynamic>);

  static GResetPasswordInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GResetPasswordInput.serializer, json);
}

abstract class GReviewReportInput
    implements Built<GReviewReportInput, GReviewReportInputBuilder> {
  GReviewReportInput._();

  factory GReviewReportInput([
    void Function(GReviewReportInputBuilder b) updates,
  ]) = _$GReviewReportInput;

  String get reportId;
  GReportStatus get status;
  static Serializer<GReviewReportInput> get serializer =>
      _$gReviewReportInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GReviewReportInput.serializer, this)
          as Map<String, dynamic>);

  static GReviewReportInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GReviewReportInput.serializer, json);
}

abstract class GSendMessageInput
    implements Built<GSendMessageInput, GSendMessageInputBuilder> {
  GSendMessageInput._();

  factory GSendMessageInput([
    void Function(GSendMessageInputBuilder b) updates,
  ]) = _$GSendMessageInput;

  String get content;
  String get conversationId;
  static Serializer<GSendMessageInput> get serializer =>
      _$gSendMessageInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GSendMessageInput.serializer, this)
          as Map<String, dynamic>);

  static GSendMessageInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GSendMessageInput.serializer, json);
}

abstract class GSendNotificationInput
    implements Built<GSendNotificationInput, GSendNotificationInputBuilder> {
  GSendNotificationInput._();

  factory GSendNotificationInput([
    void Function(GSendNotificationInputBuilder b) updates,
  ]) = _$GSendNotificationInput;

  String get body;
  GJSON? get metaData;
  String get title;
  String get type;
  static Serializer<GSendNotificationInput> get serializer =>
      _$gSendNotificationInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GSendNotificationInput.serializer, this)
          as Map<String, dynamic>);

  static GSendNotificationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GSendNotificationInput.serializer, json);
}

abstract class GStatsGrowthInput
    implements Built<GStatsGrowthInput, GStatsGrowthInputBuilder> {
  GStatsGrowthInput._();

  factory GStatsGrowthInput([
    void Function(GStatsGrowthInputBuilder b) updates,
  ]) = _$GStatsGrowthInput;

  bool? get applyDonationStatusFilter;
  GStatsGrowthPeriod get period;
  static Serializer<GStatsGrowthInput> get serializer =>
      _$gStatsGrowthInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GStatsGrowthInput.serializer, this)
          as Map<String, dynamic>);

  static GStatsGrowthInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GStatsGrowthInput.serializer, json);
}

class GStatsGrowthPeriod extends EnumClass {
  const GStatsGrowthPeriod._(String name) : super(name);

  static const GStatsGrowthPeriod LAST_MONTH = _$gStatsGrowthPeriodLAST_MONTH;

  static const GStatsGrowthPeriod LAST_WEEK = _$gStatsGrowthPeriodLAST_WEEK;

  static const GStatsGrowthPeriod LAST_YEAR = _$gStatsGrowthPeriodLAST_YEAR;

  static Serializer<GStatsGrowthPeriod> get serializer =>
      _$gStatsGrowthPeriodSerializer;

  static BuiltSet<GStatsGrowthPeriod> get values => _$gStatsGrowthPeriodValues;

  static GStatsGrowthPeriod valueOf(String name) =>
      _$gStatsGrowthPeriodValueOf(name);
}

abstract class GUpdateBadgeInput
    implements Built<GUpdateBadgeInput, GUpdateBadgeInputBuilder> {
  GUpdateBadgeInput._();

  factory GUpdateBadgeInput([
    void Function(GUpdateBadgeInputBuilder b) updates,
  ]) = _$GUpdateBadgeInput;

  String? get code;
  String? get description;
  String? get iconAttachmentId;
  bool? get isActive;
  String? get name;
  int? get sortOrder;
  static Serializer<GUpdateBadgeInput> get serializer =>
      _$gUpdateBadgeInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GUpdateBadgeInput.serializer, this)
          as Map<String, dynamic>);

  static GUpdateBadgeInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GUpdateBadgeInput.serializer, json);
}

abstract class GUpdateCategoryInput
    implements Built<GUpdateCategoryInput, GUpdateCategoryInputBuilder> {
  GUpdateCategoryInput._();

  factory GUpdateCategoryInput([
    void Function(GUpdateCategoryInputBuilder b) updates,
  ]) = _$GUpdateCategoryInput;

  String? get name;
  GCategorySensitivity? get sensitivity;
  static Serializer<GUpdateCategoryInput> get serializer =>
      _$gUpdateCategoryInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GUpdateCategoryInput.serializer, this)
          as Map<String, dynamic>);

  static GUpdateCategoryInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GUpdateCategoryInput.serializer, json);
}

abstract class GUpdateDonationInput
    implements Built<GUpdateDonationInput, GUpdateDonationInputBuilder> {
  GUpdateDonationInput._();

  factory GUpdateDonationInput([
    void Function(GUpdateDonationInputBuilder b) updates,
  ]) = _$GUpdateDonationInput;

  BuiltList<String>? get attachmentIds;
  String? get categoryId;
  String? get description;
  GDateTime? get expiryDate;
  double? get foodWeightKg;
  GDateTime? get listingExpiresAt;
  String? get locationId;
  GLocationInput? get locationInput;
  String? get mainAttachmentId;
  int? get quantity;
  bool? get safetyChecklistCompleted;
  GJSONObject? get specification;
  String? get title;
  GDonationUrgencyValues? get urgency;
  static Serializer<GUpdateDonationInput> get serializer =>
      _$gUpdateDonationInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GUpdateDonationInput.serializer, this)
          as Map<String, dynamic>);

  static GUpdateDonationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GUpdateDonationInput.serializer, json);
}

abstract class GUpdateProfileInput
    implements Built<GUpdateProfileInput, GUpdateProfileInputBuilder> {
  GUpdateProfileInput._();

  factory GUpdateProfileInput([
    void Function(GUpdateProfileInputBuilder b) updates,
  ]) = _$GUpdateProfileInput;

  String? get avatarAttachmentId;
  String? get displayName;
  String? get email;
  GLocationInput? get location;
  String? get phoneNumber;
  GUserSettingsInput? get settings;
  static Serializer<GUpdateProfileInput> get serializer =>
      _$gUpdateProfileInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GUpdateProfileInput.serializer, this)
          as Map<String, dynamic>);

  static GUpdateProfileInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GUpdateProfileInput.serializer, json);
}

abstract class GUpdateReadNotificationsInput
    implements
        Built<
          GUpdateReadNotificationsInput,
          GUpdateReadNotificationsInputBuilder
        > {
  GUpdateReadNotificationsInput._();

  factory GUpdateReadNotificationsInput([
    void Function(GUpdateReadNotificationsInputBuilder b) updates,
  ]) = _$GUpdateReadNotificationsInput;

  BuiltList<String> get ids;
  static Serializer<GUpdateReadNotificationsInput> get serializer =>
      _$gUpdateReadNotificationsInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(
            GUpdateReadNotificationsInput.serializer,
            this,
          )
          as Map<String, dynamic>);

  static GUpdateReadNotificationsInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateReadNotificationsInput.serializer,
        json,
      );
}

class GUploadStatusValues extends EnumClass {
  const GUploadStatusValues._(String name) : super(name);

  static const GUploadStatusValues COMPLETED = _$gUploadStatusValuesCOMPLETED;

  static const GUploadStatusValues FAILED = _$gUploadStatusValuesFAILED;

  static const GUploadStatusValues PENDING = _$gUploadStatusValuesPENDING;

  static const GUploadStatusValues UPLOADING = _$gUploadStatusValuesUPLOADING;

  static Serializer<GUploadStatusValues> get serializer =>
      _$gUploadStatusValuesSerializer;

  static BuiltSet<GUploadStatusValues> get values =>
      _$gUploadStatusValuesValues;

  static GUploadStatusValues valueOf(String name) =>
      _$gUploadStatusValuesValueOf(name);
}

class GUserRole extends EnumClass {
  const GUserRole._(String name) : super(name);

  static const GUserRole ADMINISTRATOR = _$gUserRoleADMINISTRATOR;

  static const GUserRole LOCAL_AUTHORITY = _$gUserRoleLOCAL_AUTHORITY;

  static const GUserRole ORGANIZATION = _$gUserRoleORGANIZATION;

  static const GUserRole STORE = _$gUserRoleSTORE;

  static const GUserRole USER = _$gUserRoleUSER;

  static Serializer<GUserRole> get serializer => _$gUserRoleSerializer;

  static BuiltSet<GUserRole> get values => _$gUserRoleValues;

  static GUserRole valueOf(String name) => _$gUserRoleValueOf(name);
}

abstract class GUserSettingsInput
    implements Built<GUserSettingsInput, GUserSettingsInputBuilder> {
  GUserSettingsInput._();

  factory GUserSettingsInput([
    void Function(GUserSettingsInputBuilder b) updates,
  ]) = _$GUserSettingsInput;

  GAppearanceTheme? get appearance;
  bool? get isNewDonationsAlertsEnabled;
  bool? get isSystemReports;
  bool? get isUrgentAlertsEnabled;
  static Serializer<GUserSettingsInput> get serializer =>
      _$gUserSettingsInputSerializer;

  Map<String, dynamic> toJson() =>
      (_i1.serializers.serializeWith(GUserSettingsInput.serializer, this)
          as Map<String, dynamic>);

  static GUserSettingsInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(GUserSettingsInput.serializer, json);
}

const Map<String, Set<String>> possibleTypesMap = {};
