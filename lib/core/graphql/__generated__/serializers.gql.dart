// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart' show StandardJsonPlugin;
import 'package:ferry_exec/ferry_exec.dart';
import 'package:gaspzero/core/graphql/__generated__/schema.schema.gql.dart'
    show
        GAdminCreateAccountInput,
        GAppearanceTheme,
        GCategorySensitivityValues,
        GChangePasswordInput,
        GCreateCategoryInput,
        GCreateDonationInput,
        GDateTime,
        GDonationStatusValues,
        GDonationUrgencyValues,
        GDonationsFilterInput,
        GJSON,
        GJSONObject,
        GLocationInput,
        GLoginInput,
        GPaginationInput,
        GPaginationQueryInput,
        GRegisterInput,
        GRegisterLocationInput,
        GReservationStatus,
        GResetPasswordInput,
        GSendNotificationInput,
        GUpdateCategoryInput,
        GUpdateDonationInput,
        GUpdateProfileInput,
        GUpdateReadNotificationsInput,
        GUploadStatusValues,
        GUserRole,
        GUserSettingsInput;
import 'package:gaspzero/core/network/graphql/__generated__/refresh_tokens_interceptor.data.gql.dart'
    show
        GRefreshTokensForInterceptorData,
        GRefreshTokensForInterceptorData_refreshTokens;
import 'package:gaspzero/core/network/graphql/__generated__/refresh_tokens_interceptor.req.gql.dart'
    show GRefreshTokensForInterceptorReq;
import 'package:gaspzero/core/network/graphql/__generated__/refresh_tokens_interceptor.var.gql.dart'
    show GRefreshTokensForInterceptorVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/change_password.data.gql.dart'
    show GChangePasswordData, GChangePasswordData_changePassword;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/change_password.req.gql.dart'
    show GChangePasswordReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/change_password.var.gql.dart'
    show GChangePasswordVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/delete_account.data.gql.dart'
    show GDeleteAccountData, GDeleteAccountData_deleteAccount;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/delete_account.req.gql.dart'
    show GDeleteAccountReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/delete_account.var.gql.dart'
    show GDeleteAccountVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/forgot_password.data.gql.dart'
    show GForgotPasswordData, GForgotPasswordData_forgotPassword;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/forgot_password.req.gql.dart'
    show GForgotPasswordReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/forgot_password.var.gql.dart'
    show GForgotPasswordVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/get_current_user.data.gql.dart'
    show
        GGetCurrentUserData,
        GGetCurrentUserData_currentUser,
        GGetCurrentUserData_currentUser_avatar,
        GGetCurrentUserData_currentUser_location;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/get_current_user.req.gql.dart'
    show GGetCurrentUserReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/get_current_user.var.gql.dart'
    show GGetCurrentUserVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/login.data.gql.dart'
    show
        GLoginData,
        GLoginData_login,
        GLoginData_login_user,
        GLoginData_login_user_avatar,
        GLoginData_login_user_location;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/login.req.gql.dart'
    show GLoginReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/login.var.gql.dart'
    show GLoginVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/logout_from_all_devices.data.gql.dart'
    show
        GLogoutFromAllDevicesData,
        GLogoutFromAllDevicesData_logoutFromAllDevices;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/logout_from_all_devices.req.gql.dart'
    show GLogoutFromAllDevicesReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/logout_from_all_devices.var.gql.dart'
    show GLogoutFromAllDevicesVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/refresh_tokens.data.gql.dart'
    show
        GRefreshTokensData,
        GRefreshTokensData_refreshTokens,
        GRefreshTokensData_refreshTokens_user,
        GRefreshTokensData_refreshTokens_user_avatar,
        GRefreshTokensData_refreshTokens_user_location;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/refresh_tokens.req.gql.dart'
    show GRefreshTokensReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/refresh_tokens.var.gql.dart'
    show GRefreshTokensVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/register.data.gql.dart'
    show GRegisterData, GRegisterData_register;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/register.req.gql.dart'
    show GRegisterReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/register.var.gql.dart'
    show GRegisterVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/reset_password.data.gql.dart'
    show GResetPasswordData, GResetPasswordData_resetPassword;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/reset_password.req.gql.dart'
    show GResetPasswordReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/reset_password.var.gql.dart'
    show GResetPasswordVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/send_verification.data.gql.dart'
    show GSendVerificationData, GSendVerificationData_sendVerification;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/send_verification.req.gql.dart'
    show GSendVerificationReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/send_verification.var.gql.dart'
    show GSendVerificationVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/update_profile.data.gql.dart'
    show
        GUpdateProfileData,
        GUpdateProfileData_updateProfile,
        GUpdateProfileData_updateProfile_avatar,
        GUpdateProfileData_updateProfile_location;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/update_profile.req.gql.dart'
    show GUpdateProfileReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/update_profile.var.gql.dart'
    show GUpdateProfileVars;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/user_fields.data.gql.dart'
    show GUserFieldsData, GUserFieldsData_avatar, GUserFieldsData_location;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/user_fields.req.gql.dart'
    show GUserFieldsReq;
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/user_fields.var.gql.dart'
    show GUserFieldsVars;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/create_donation.data.gql.dart'
    show
        GCreateDonationData,
        GCreateDonationData_createDonation,
        GCreateDonationData_createDonation_category,
        GCreateDonationData_createDonation_location,
        GCreateDonationData_createDonation_mainAttachment,
        GCreateDonationData_createDonation_user;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/create_donation.req.gql.dart'
    show GCreateDonationReq;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/create_donation.var.gql.dart'
    show GCreateDonationVars;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_categories.data.gql.dart'
    show
        GGetCategoriesData,
        GGetCategoriesData_categories,
        GGetCategoriesData_categories_items;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_categories.req.gql.dart'
    show GGetCategoriesReq;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_categories.var.gql.dart'
    show GGetCategoriesVars;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donation_by_id.data.gql.dart'
    show
        GGetDonationByIdData,
        GGetDonationByIdData_donation,
        GGetDonationByIdData_donation_category,
        GGetDonationByIdData_donation_location,
        GGetDonationByIdData_donation_mainAttachment,
        GGetDonationByIdData_donation_user;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donation_by_id.req.gql.dart'
    show GGetDonationByIdReq;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donation_by_id.var.gql.dart'
    show GGetDonationByIdVars;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donations.data.gql.dart'
    show
        GGetDonationsData,
        GGetDonationsData_donations,
        GGetDonationsData_donations_items,
        GGetDonationsData_donations_items_category,
        GGetDonationsData_donations_items_location,
        GGetDonationsData_donations_items_mainAttachment,
        GGetDonationsData_donations_items_user;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donations.req.gql.dart'
    show GGetDonationsReq;
import 'package:gaspzero/features/donations/data/sources/graphql/__generated__/get_donations.var.gql.dart'
    show GGetDonationsVars;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/delete_notification.data.gql.dart'
    show GDeleteNotificationData, GDeleteNotificationData_deleteNotification;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/delete_notification.req.gql.dart'
    show GDeleteNotificationReq;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/delete_notification.var.gql.dart'
    show GDeleteNotificationVars;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/get_notifications.data.gql.dart'
    show
        GGetNotificationsData,
        GGetNotificationsData_getNotifications,
        GGetNotificationsData_getNotifications_items;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/get_notifications.req.gql.dart'
    show GGetNotificationsReq;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/get_notifications.var.gql.dart'
    show GGetNotificationsVars;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/mark_notifications_as_read.data.gql.dart'
    show
        GMarkNotificationsAsReadData,
        GMarkNotificationsAsReadData_markNotificationsAsRead;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/mark_notifications_as_read.req.gql.dart'
    show GMarkNotificationsAsReadReq;
import 'package:gaspzero/features/notification/data/sources/graphql/__generated__/mark_notifications_as_read.var.gql.dart'
    show GMarkNotificationsAsReadVars;
import 'package:gaspzero/features/profile/data/datasources/graphql/__generated__/get_myDonations.data.gql.dart'
    show
        GMyDonationsData,
        GMyDonationsData_myDonations,
        GMyDonationsData_myDonations_items,
        GMyDonationsData_myDonations_items_category,
        GMyDonationsData_myDonations_items_location,
        GMyDonationsData_myDonations_items_mainAttachment,
        GMyDonationsData_myDonations_items_user;
import 'package:gaspzero/features/profile/data/datasources/graphql/__generated__/get_myDonations.req.gql.dart'
    show GMyDonationsReq;
import 'package:gaspzero/features/profile/data/datasources/graphql/__generated__/get_myDonations.var.gql.dart'
    show GMyDonationsVars;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/confirm_reservation.data.gql.dart'
    show
        GConfirmReservationData,
        GConfirmReservationData_confirmReservation,
        GConfirmReservationData_confirmReservation_beneficiary,
        GConfirmReservationData_confirmReservation_beneficiary_avatar,
        GConfirmReservationData_confirmReservation_beneficiary_location,
        GConfirmReservationData_confirmReservation_donation,
        GConfirmReservationData_confirmReservation_donation_category,
        GConfirmReservationData_confirmReservation_donation_location,
        GConfirmReservationData_confirmReservation_donation_mainAttachment,
        GConfirmReservationData_confirmReservation_donation_user;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/confirm_reservation.req.gql.dart'
    show GConfirmReservationReq;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/confirm_reservation.var.gql.dart'
    show GConfirmReservationVars;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservation.data.gql.dart'
    show
        GMyReservationData,
        GMyReservationData_myReservation,
        GMyReservationData_myReservation_donation,
        GMyReservationData_myReservation_donation_mainAttachment,
        GMyReservationData_myReservation_donation_user,
        GMyReservationData_myReservation_donation_user_avatar;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservation.req.gql.dart'
    show GMyReservationReq;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservation.var.gql.dart'
    show GMyReservationVars;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservations.data.gql.dart'
    show
        GMyReservationsData,
        GMyReservationsData_myReservations,
        GMyReservationsData_myReservations_items,
        GMyReservationsData_myReservations_items_donation,
        GMyReservationsData_myReservations_items_donation_mainAttachment;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservations.req.gql.dart'
    show GMyReservationsReq;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/my_reservations.var.gql.dart'
    show GMyReservationsVars;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.data.gql.dart'
    show
        GReservationFieldsData,
        GReservationFieldsData_beneficiary,
        GReservationFieldsData_beneficiary_avatar,
        GReservationFieldsData_beneficiary_location,
        GReservationFieldsData_donation,
        GReservationFieldsData_donation_category,
        GReservationFieldsData_donation_location,
        GReservationFieldsData_donation_mainAttachment,
        GReservationFieldsData_donation_user;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.req.gql.dart'
    show GReservationFieldsReq;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.var.gql.dart'
    show GReservationFieldsVars;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reserve_donation.data.gql.dart'
    show
        GReserveDonationData,
        GReserveDonationData_reserveDonation,
        GReserveDonationData_reserveDonation_beneficiary,
        GReserveDonationData_reserveDonation_beneficiary_avatar,
        GReserveDonationData_reserveDonation_beneficiary_location,
        GReserveDonationData_reserveDonation_donation,
        GReserveDonationData_reserveDonation_donation_category,
        GReserveDonationData_reserveDonation_donation_location,
        GReserveDonationData_reserveDonation_donation_mainAttachment,
        GReserveDonationData_reserveDonation_donation_user;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reserve_donation.req.gql.dart'
    show GReserveDonationReq;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reserve_donation.var.gql.dart'
    show GReserveDonationVars;
import 'package:gql_code_builder_serializers/gql_code_builder_serializers.dart'
    show OperationSerializer;

part 'serializers.gql.g.dart';

final SerializersBuilder _serializersBuilder = _$serializers.toBuilder()
  ..add(OperationSerializer())
  ..addPlugin(StandardJsonPlugin());
@SerializersFor([
  GAdminCreateAccountInput,
  GAppearanceTheme,
  GCategorySensitivityValues,
  GChangePasswordData,
  GChangePasswordData_changePassword,
  GChangePasswordInput,
  GChangePasswordReq,
  GChangePasswordVars,
  GConfirmReservationData,
  GConfirmReservationData_confirmReservation,
  GConfirmReservationData_confirmReservation_beneficiary,
  GConfirmReservationData_confirmReservation_beneficiary_avatar,
  GConfirmReservationData_confirmReservation_beneficiary_location,
  GConfirmReservationData_confirmReservation_donation,
  GConfirmReservationData_confirmReservation_donation_category,
  GConfirmReservationData_confirmReservation_donation_location,
  GConfirmReservationData_confirmReservation_donation_mainAttachment,
  GConfirmReservationData_confirmReservation_donation_user,
  GConfirmReservationReq,
  GConfirmReservationVars,
  GCreateCategoryInput,
  GCreateDonationData,
  GCreateDonationData_createDonation,
  GCreateDonationData_createDonation_category,
  GCreateDonationData_createDonation_location,
  GCreateDonationData_createDonation_mainAttachment,
  GCreateDonationData_createDonation_user,
  GCreateDonationInput,
  GCreateDonationReq,
  GCreateDonationVars,
  GDateTime,
  GDeleteAccountData,
  GDeleteAccountData_deleteAccount,
  GDeleteAccountReq,
  GDeleteAccountVars,
  GDeleteNotificationData,
  GDeleteNotificationData_deleteNotification,
  GDeleteNotificationReq,
  GDeleteNotificationVars,
  GDonationStatusValues,
  GDonationUrgencyValues,
  GDonationsFilterInput,
  GForgotPasswordData,
  GForgotPasswordData_forgotPassword,
  GForgotPasswordReq,
  GForgotPasswordVars,
  GGetCategoriesData,
  GGetCategoriesData_categories,
  GGetCategoriesData_categories_items,
  GGetCategoriesReq,
  GGetCategoriesVars,
  GGetCurrentUserData,
  GGetCurrentUserData_currentUser,
  GGetCurrentUserData_currentUser_avatar,
  GGetCurrentUserData_currentUser_location,
  GGetCurrentUserReq,
  GGetCurrentUserVars,
  GGetDonationByIdData,
  GGetDonationByIdData_donation,
  GGetDonationByIdData_donation_category,
  GGetDonationByIdData_donation_location,
  GGetDonationByIdData_donation_mainAttachment,
  GGetDonationByIdData_donation_user,
  GGetDonationByIdReq,
  GGetDonationByIdVars,
  GGetDonationsData,
  GGetDonationsData_donations,
  GGetDonationsData_donations_items,
  GGetDonationsData_donations_items_category,
  GGetDonationsData_donations_items_location,
  GGetDonationsData_donations_items_mainAttachment,
  GGetDonationsData_donations_items_user,
  GGetDonationsReq,
  GGetDonationsVars,
  GGetNotificationsData,
  GGetNotificationsData_getNotifications,
  GGetNotificationsData_getNotifications_items,
  GGetNotificationsReq,
  GGetNotificationsVars,
  GJSON,
  GJSONObject,
  GLocationInput,
  GLoginData,
  GLoginData_login,
  GLoginData_login_user,
  GLoginData_login_user_avatar,
  GLoginData_login_user_location,
  GLoginInput,
  GLoginReq,
  GLoginVars,
  GLogoutFromAllDevicesData,
  GLogoutFromAllDevicesData_logoutFromAllDevices,
  GLogoutFromAllDevicesReq,
  GLogoutFromAllDevicesVars,
  GMarkNotificationsAsReadData,
  GMarkNotificationsAsReadData_markNotificationsAsRead,
  GMarkNotificationsAsReadReq,
  GMarkNotificationsAsReadVars,
  GMyDonationsData,
  GMyDonationsData_myDonations,
  GMyDonationsData_myDonations_items,
  GMyDonationsData_myDonations_items_category,
  GMyDonationsData_myDonations_items_location,
  GMyDonationsData_myDonations_items_mainAttachment,
  GMyDonationsData_myDonations_items_user,
  GMyDonationsReq,
  GMyDonationsVars,
  GMyReservationData,
  GMyReservationData_myReservation,
  GMyReservationData_myReservation_donation,
  GMyReservationData_myReservation_donation_mainAttachment,
  GMyReservationData_myReservation_donation_user,
  GMyReservationData_myReservation_donation_user_avatar,
  GMyReservationReq,
  GMyReservationVars,
  GMyReservationsData,
  GMyReservationsData_myReservations,
  GMyReservationsData_myReservations_items,
  GMyReservationsData_myReservations_items_donation,
  GMyReservationsData_myReservations_items_donation_mainAttachment,
  GMyReservationsReq,
  GMyReservationsVars,
  GPaginationInput,
  GPaginationQueryInput,
  GRefreshTokensData,
  GRefreshTokensData_refreshTokens,
  GRefreshTokensData_refreshTokens_user,
  GRefreshTokensData_refreshTokens_user_avatar,
  GRefreshTokensData_refreshTokens_user_location,
  GRefreshTokensForInterceptorData,
  GRefreshTokensForInterceptorData_refreshTokens,
  GRefreshTokensForInterceptorReq,
  GRefreshTokensForInterceptorVars,
  GRefreshTokensReq,
  GRefreshTokensVars,
  GRegisterData,
  GRegisterData_register,
  GRegisterInput,
  GRegisterLocationInput,
  GRegisterReq,
  GRegisterVars,
  GReservationFieldsData,
  GReservationFieldsData_beneficiary,
  GReservationFieldsData_beneficiary_avatar,
  GReservationFieldsData_beneficiary_location,
  GReservationFieldsData_donation,
  GReservationFieldsData_donation_category,
  GReservationFieldsData_donation_location,
  GReservationFieldsData_donation_mainAttachment,
  GReservationFieldsData_donation_user,
  GReservationFieldsReq,
  GReservationFieldsVars,
  GReservationStatus,
  GReserveDonationData,
  GReserveDonationData_reserveDonation,
  GReserveDonationData_reserveDonation_beneficiary,
  GReserveDonationData_reserveDonation_beneficiary_avatar,
  GReserveDonationData_reserveDonation_beneficiary_location,
  GReserveDonationData_reserveDonation_donation,
  GReserveDonationData_reserveDonation_donation_category,
  GReserveDonationData_reserveDonation_donation_location,
  GReserveDonationData_reserveDonation_donation_mainAttachment,
  GReserveDonationData_reserveDonation_donation_user,
  GReserveDonationReq,
  GReserveDonationVars,
  GResetPasswordData,
  GResetPasswordData_resetPassword,
  GResetPasswordInput,
  GResetPasswordReq,
  GResetPasswordVars,
  GSendNotificationInput,
  GSendVerificationData,
  GSendVerificationData_sendVerification,
  GSendVerificationReq,
  GSendVerificationVars,
  GUpdateCategoryInput,
  GUpdateDonationInput,
  GUpdateProfileData,
  GUpdateProfileData_updateProfile,
  GUpdateProfileData_updateProfile_avatar,
  GUpdateProfileData_updateProfile_location,
  GUpdateProfileInput,
  GUpdateProfileReq,
  GUpdateProfileVars,
  GUpdateReadNotificationsInput,
  GUploadStatusValues,
  GUserFieldsData,
  GUserFieldsData_avatar,
  GUserFieldsData_location,
  GUserFieldsReq,
  GUserFieldsVars,
  GUserRole,
  GUserSettingsInput,
])
final Serializers serializers = _serializersBuilder.build();
