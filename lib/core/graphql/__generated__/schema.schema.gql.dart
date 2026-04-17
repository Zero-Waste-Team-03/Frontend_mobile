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

  factory GAdminCreateAccountInput(
          [void Function(GAdminCreateAccountInputBuilder b) updates]) =
      _$GAdminCreateAccountInput;

  String get displayName;
  String get email;
  GUserRole get role;
  static Serializer<GAdminCreateAccountInput> get serializer =>
      _$gAdminCreateAccountInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GAdminCreateAccountInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GAdminCreateAccountInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GAdminCreateAccountInput.serializer,
        json,
      );
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

class GCategorySensitivityValues extends EnumClass {
  const GCategorySensitivityValues._(String name) : super(name);

  static const GCategorySensitivityValues HIGH =
      _$gCategorySensitivityValuesHIGH;

  static const GCategorySensitivityValues LOW = _$gCategorySensitivityValuesLOW;

  static const GCategorySensitivityValues MEDIUM =
      _$gCategorySensitivityValuesMEDIUM;

  static Serializer<GCategorySensitivityValues> get serializer =>
      _$gCategorySensitivityValuesSerializer;

  static BuiltSet<GCategorySensitivityValues> get values =>
      _$gCategorySensitivityValuesValues;

  static GCategorySensitivityValues valueOf(String name) =>
      _$gCategorySensitivityValuesValueOf(name);
}

abstract class GChangePasswordInput
    implements Built<GChangePasswordInput, GChangePasswordInputBuilder> {
  GChangePasswordInput._();

  factory GChangePasswordInput(
          [void Function(GChangePasswordInputBuilder b) updates]) =
      _$GChangePasswordInput;

  String get currentPassword;
  bool? get logoutFromOtherDevices;
  String get newPassword;
  static Serializer<GChangePasswordInput> get serializer =>
      _$gChangePasswordInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GChangePasswordInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GChangePasswordInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GChangePasswordInput.serializer,
        json,
      );
}

abstract class GCreateCategoryInput
    implements Built<GCreateCategoryInput, GCreateCategoryInputBuilder> {
  GCreateCategoryInput._();

  factory GCreateCategoryInput(
          [void Function(GCreateCategoryInputBuilder b) updates]) =
      _$GCreateCategoryInput;

  String get name;
  GCategorySensitivityValues? get sensitivity;
  static Serializer<GCreateCategoryInput> get serializer =>
      _$gCreateCategoryInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateCategoryInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateCategoryInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateCategoryInput.serializer,
        json,
      );
}

abstract class GCreateDonationInput
    implements Built<GCreateDonationInput, GCreateDonationInputBuilder> {
  GCreateDonationInput._();

  factory GCreateDonationInput(
          [void Function(GCreateDonationInputBuilder b) updates]) =
      _$GCreateDonationInput;

  BuiltList<String>? get attachmentIds;
  String get categoryId;
  String get description;
  GDateTime get expiryDate;
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

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GCreateDonationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GCreateDonationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GCreateDonationInput.serializer,
        json,
      );
}

abstract class GDateTime implements Built<GDateTime, GDateTimeBuilder> {
  GDateTime._();

  factory GDateTime([String? value]) =>
      _$GDateTime((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GDateTime> get serializer =>
      _i2.DefaultScalarSerializer<GDateTime>(
          (Object serialized) => GDateTime((serialized as String?)));
}

abstract class GDonationsFilterInput
    implements Built<GDonationsFilterInput, GDonationsFilterInputBuilder> {
  GDonationsFilterInput._();

  factory GDonationsFilterInput(
          [void Function(GDonationsFilterInputBuilder b) updates]) =
      _$GDonationsFilterInput;

  String? get categoryId;
  GDonationStatusValues? get status;
  GDonationUrgencyValues? get urgency;
  static Serializer<GDonationsFilterInput> get serializer =>
      _$gDonationsFilterInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GDonationsFilterInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GDonationsFilterInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GDonationsFilterInput.serializer,
        json,
      );
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
      (Object serialized) => GJSON((serialized as String?)));
}

abstract class GJSONObject implements Built<GJSONObject, GJSONObjectBuilder> {
  GJSONObject._();

  factory GJSONObject([String? value]) =>
      _$GJSONObject((b) => value != null ? (b..value = value) : b);

  String get value;
  @BuiltValueSerializer(custom: true)
  static Serializer<GJSONObject> get serializer =>
      _i2.DefaultScalarSerializer<GJSONObject>(
          (Object serialized) => GJSONObject((serialized as String?)));
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

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLocationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLocationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLocationInput.serializer,
        json,
      );
}

abstract class GLoginInput implements Built<GLoginInput, GLoginInputBuilder> {
  GLoginInput._();

  factory GLoginInput([void Function(GLoginInputBuilder b) updates]) =
      _$GLoginInput;

  String get email;
  String get password;
  static Serializer<GLoginInput> get serializer => _$gLoginInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GLoginInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GLoginInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GLoginInput.serializer,
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

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPaginationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPaginationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPaginationInput.serializer,
        json,
      );
}

abstract class GPaginationQueryInput
    implements Built<GPaginationQueryInput, GPaginationQueryInputBuilder> {
  GPaginationQueryInput._();

  factory GPaginationQueryInput(
          [void Function(GPaginationQueryInputBuilder b) updates]) =
      _$GPaginationQueryInput;

  int? get limit;
  int? get page;
  static Serializer<GPaginationQueryInput> get serializer =>
      _$gPaginationQueryInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GPaginationQueryInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GPaginationQueryInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GPaginationQueryInput.serializer,
        json,
      );
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

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterInput.serializer,
        json,
      );
}

abstract class GRegisterLocationInput
    implements Built<GRegisterLocationInput, GRegisterLocationInputBuilder> {
  GRegisterLocationInput._();

  factory GRegisterLocationInput(
          [void Function(GRegisterLocationInputBuilder b) updates]) =
      _$GRegisterLocationInput;

  String? get city;
  String? get country;
  double? get latitude;
  double? get longitude;
  String? get neighborhood;
  static Serializer<GRegisterLocationInput> get serializer =>
      _$gRegisterLocationInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GRegisterLocationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GRegisterLocationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GRegisterLocationInput.serializer,
        json,
      );
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

  factory GResetPasswordInput(
          [void Function(GResetPasswordInputBuilder b) updates]) =
      _$GResetPasswordInput;

  String get password;
  String get token;
  static Serializer<GResetPasswordInput> get serializer =>
      _$gResetPasswordInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GResetPasswordInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GResetPasswordInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GResetPasswordInput.serializer,
        json,
      );
}

abstract class GSendNotificationInput
    implements Built<GSendNotificationInput, GSendNotificationInputBuilder> {
  GSendNotificationInput._();

  factory GSendNotificationInput(
          [void Function(GSendNotificationInputBuilder b) updates]) =
      _$GSendNotificationInput;

  String get body;
  GJSON? get metaData;
  String get title;
  String get type;
  static Serializer<GSendNotificationInput> get serializer =>
      _$gSendNotificationInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GSendNotificationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GSendNotificationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GSendNotificationInput.serializer,
        json,
      );
}

abstract class GUpdateCategoryInput
    implements Built<GUpdateCategoryInput, GUpdateCategoryInputBuilder> {
  GUpdateCategoryInput._();

  factory GUpdateCategoryInput(
          [void Function(GUpdateCategoryInputBuilder b) updates]) =
      _$GUpdateCategoryInput;

  String? get name;
  GCategorySensitivityValues? get sensitivity;
  static Serializer<GUpdateCategoryInput> get serializer =>
      _$gUpdateCategoryInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateCategoryInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateCategoryInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateCategoryInput.serializer,
        json,
      );
}

abstract class GUpdateDonationInput
    implements Built<GUpdateDonationInput, GUpdateDonationInputBuilder> {
  GUpdateDonationInput._();

  factory GUpdateDonationInput(
          [void Function(GUpdateDonationInputBuilder b) updates]) =
      _$GUpdateDonationInput;

  BuiltList<String>? get attachmentIds;
  String? get categoryId;
  String? get description;
  GDateTime? get expiryDate;
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

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateDonationInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateDonationInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateDonationInput.serializer,
        json,
      );
}

abstract class GUpdateProfileInput
    implements Built<GUpdateProfileInput, GUpdateProfileInputBuilder> {
  GUpdateProfileInput._();

  factory GUpdateProfileInput(
          [void Function(GUpdateProfileInputBuilder b) updates]) =
      _$GUpdateProfileInput;

  String? get avatarAttachmentId;
  String? get displayName;
  String? get email;
  GLocationInput? get location;
  String? get phoneNumber;
  GUserSettingsInput? get settings;
  static Serializer<GUpdateProfileInput> get serializer =>
      _$gUpdateProfileInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateProfileInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUpdateProfileInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUpdateProfileInput.serializer,
        json,
      );
}

abstract class GUpdateReadNotificationsInput
    implements
        Built<GUpdateReadNotificationsInput,
            GUpdateReadNotificationsInputBuilder> {
  GUpdateReadNotificationsInput._();

  factory GUpdateReadNotificationsInput(
          [void Function(GUpdateReadNotificationsInputBuilder b) updates]) =
      _$GUpdateReadNotificationsInput;

  BuiltList<String> get ids;
  static Serializer<GUpdateReadNotificationsInput> get serializer =>
      _$gUpdateReadNotificationsInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUpdateReadNotificationsInput.serializer,
        this,
      ) as Map<String, dynamic>);

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

  factory GUserSettingsInput(
          [void Function(GUserSettingsInputBuilder b) updates]) =
      _$GUserSettingsInput;

  GAppearanceTheme? get appearance;
  bool? get isNewDonationsAlertsEnabled;
  bool? get isSystemReports;
  bool? get isUrgentAlertsEnabled;
  static Serializer<GUserSettingsInput> get serializer =>
      _$gUserSettingsInputSerializer;

  Map<String, dynamic> toJson() => (_i1.serializers.serializeWith(
        GUserSettingsInput.serializer,
        this,
      ) as Map<String, dynamic>);

  static GUserSettingsInput? fromJson(Map<String, dynamic> json) =>
      _i1.serializers.deserializeWith(
        GUserSettingsInput.serializer,
        json,
      );
}

const Map<String, Set<String>> possibleTypesMap = {};
