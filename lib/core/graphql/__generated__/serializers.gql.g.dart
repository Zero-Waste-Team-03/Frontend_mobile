// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers =
    (Serializers().toBuilder()
          ..add(FetchPolicy.serializer)
          ..add(GAdminCreateAccountInput.serializer)
          ..add(GAdminDashboardStatsInput.serializer)
          ..add(GAppearanceTheme.serializer)
          ..add(GApproveSensitiveMessageInput.serializer)
          ..add(GCategorySensitivity.serializer)
          ..add(GChangePasswordData.serializer)
          ..add(GChangePasswordData_changePassword.serializer)
          ..add(GChangePasswordInput.serializer)
          ..add(GChangePasswordReq.serializer)
          ..add(GChangePasswordVars.serializer)
          ..add(GConfirmReservationData.serializer)
          ..add(GConfirmReservationData_confirmReservation.serializer)
          ..add(
            GConfirmReservationData_confirmReservation_beneficiary.serializer,
          )
          ..add(
            GConfirmReservationData_confirmReservation_beneficiary_avatar
                .serializer,
          )
          ..add(
            GConfirmReservationData_confirmReservation_beneficiary_location
                .serializer,
          )
          ..add(GConfirmReservationData_confirmReservation_donation.serializer)
          ..add(
            GConfirmReservationData_confirmReservation_donation_category
                .serializer,
          )
          ..add(
            GConfirmReservationData_confirmReservation_donation_location
                .serializer,
          )
          ..add(
            GConfirmReservationData_confirmReservation_donation_mainAttachment
                .serializer,
          )
          ..add(
            GConfirmReservationData_confirmReservation_donation_user.serializer,
          )
          ..add(GConfirmReservationReq.serializer)
          ..add(GConfirmReservationVars.serializer)
          ..add(GConversationMessagesInput.serializer)
          ..add(GConversationStatus.serializer)
          ..add(GCoordinateInput.serializer)
          ..add(GCreateBadgeInput.serializer)
          ..add(GCreateCategoryInput.serializer)
          ..add(GCreateDonationData.serializer)
          ..add(GCreateDonationData_createDonation.serializer)
          ..add(GCreateDonationData_createDonation_category.serializer)
          ..add(GCreateDonationData_createDonation_location.serializer)
          ..add(GCreateDonationData_createDonation_mainAttachment.serializer)
          ..add(GCreateDonationData_createDonation_user.serializer)
          ..add(GCreateDonationInput.serializer)
          ..add(GCreateDonationReq.serializer)
          ..add(GCreateDonationVars.serializer)
          ..add(GCreateReportInput.serializer)
          ..add(GDateRangeInput.serializer)
          ..add(GDateTime.serializer)
          ..add(GDeleteAccountData.serializer)
          ..add(GDeleteAccountData_deleteAccount.serializer)
          ..add(GDeleteAccountReq.serializer)
          ..add(GDeleteAccountVars.serializer)
          ..add(GDeleteNotificationData.serializer)
          ..add(GDeleteNotificationData_deleteNotification.serializer)
          ..add(GDeleteNotificationReq.serializer)
          ..add(GDeleteNotificationVars.serializer)
          ..add(GDonationBehaviorContextInput.serializer)
          ..add(GDonationStatusValues.serializer)
          ..add(GDonationUrgencyValues.serializer)
          ..add(GDonationsFilterInput.serializer)
          ..add(GDonationsHeatmapInput.serializer)
          ..add(GDonationsMapInput.serializer)
          ..add(GForgotPasswordData.serializer)
          ..add(GForgotPasswordData_forgotPassword.serializer)
          ..add(GForgotPasswordReq.serializer)
          ..add(GForgotPasswordVars.serializer)
          ..add(GGetCategoriesData.serializer)
          ..add(GGetCategoriesData_categories.serializer)
          ..add(GGetCategoriesData_categories_items.serializer)
          ..add(GGetCategoriesReq.serializer)
          ..add(GGetCategoriesVars.serializer)
          ..add(GGetConversationMessagesData.serializer)
          ..add(GGetConversationMessagesData_conversationMessages.serializer)
          ..add(
            GGetConversationMessagesData_conversationMessages_items.serializer,
          )
          ..add(GGetConversationMessagesReq.serializer)
          ..add(GGetConversationMessagesVars.serializer)
          ..add(GGetCurrentUserData.serializer)
          ..add(GGetCurrentUserData_currentUser.serializer)
          ..add(GGetCurrentUserData_currentUser_avatar.serializer)
          ..add(GGetCurrentUserData_currentUser_location.serializer)
          ..add(GGetCurrentUserReq.serializer)
          ..add(GGetCurrentUserVars.serializer)
          ..add(GGetDonationByIdData.serializer)
          ..add(GGetDonationByIdData_donation.serializer)
          ..add(GGetDonationByIdData_donation_category.serializer)
          ..add(GGetDonationByIdData_donation_location.serializer)
          ..add(GGetDonationByIdData_donation_mainAttachment.serializer)
          ..add(GGetDonationByIdData_donation_user.serializer)
          ..add(GGetDonationByIdReq.serializer)
          ..add(GGetDonationByIdVars.serializer)
          ..add(GGetDonationsData.serializer)
          ..add(GGetDonationsData_donations.serializer)
          ..add(GGetDonationsData_donations_items.serializer)
          ..add(GGetDonationsData_donations_items_category.serializer)
          ..add(GGetDonationsData_donations_items_location.serializer)
          ..add(GGetDonationsData_donations_items_mainAttachment.serializer)
          ..add(GGetDonationsData_donations_items_user.serializer)
          ..add(GGetDonationsReq.serializer)
          ..add(GGetDonationsVars.serializer)
          ..add(GGetNotificationsData.serializer)
          ..add(GGetNotificationsData_getNotifications.serializer)
          ..add(GGetNotificationsData_getNotifications_items.serializer)
          ..add(GGetNotificationsReq.serializer)
          ..add(GGetNotificationsVars.serializer)
          ..add(GGetOrCreateConversationData.serializer)
          ..add(GGetOrCreateConversationData_getOrCreateConversation.serializer)
          ..add(GGetOrCreateConversationReq.serializer)
          ..add(GGetOrCreateConversationVars.serializer)
          ..add(GJSON.serializer)
          ..add(GJSONObject.serializer)
          ..add(GLocationInput.serializer)
          ..add(GLoginData.serializer)
          ..add(GLoginData_login.serializer)
          ..add(GLoginData_login_user.serializer)
          ..add(GLoginData_login_user_avatar.serializer)
          ..add(GLoginData_login_user_location.serializer)
          ..add(GLoginInput.serializer)
          ..add(GLoginReq.serializer)
          ..add(GLoginVars.serializer)
          ..add(GLogoutFromAllDevicesData.serializer)
          ..add(GLogoutFromAllDevicesData_logoutFromAllDevices.serializer)
          ..add(GLogoutFromAllDevicesReq.serializer)
          ..add(GLogoutFromAllDevicesVars.serializer)
          ..add(GMapBoundsInput.serializer)
          ..add(GMarkNotificationsAsReadData.serializer)
          ..add(GMarkNotificationsAsReadData_markNotificationsAsRead.serializer)
          ..add(GMarkNotificationsAsReadReq.serializer)
          ..add(GMarkNotificationsAsReadVars.serializer)
          ..add(GMarkTransactionCompletedData.serializer)
          ..add(
            GMarkTransactionCompletedData_markTransactionCompleted.serializer,
          )
          ..add(GMarkTransactionCompletedInput.serializer)
          ..add(GMarkTransactionCompletedReq.serializer)
          ..add(GMarkTransactionCompletedVars.serializer)
          ..add(GMarkerColorValues.serializer)
          ..add(GMyActiveConversationsData.serializer)
          ..add(GMyActiveConversationsData_myActiveConversations.serializer)
          ..add(
            GMyActiveConversationsData_myActiveConversations_counterpart
                .serializer,
          )
          ..add(GMyActiveConversationsReq.serializer)
          ..add(GMyActiveConversationsVars.serializer)
          ..add(GMyReservationData.serializer)
          ..add(GMyReservationData_myReservation.serializer)
          ..add(GMyReservationData_myReservation_donation.serializer)
          ..add(
            GMyReservationData_myReservation_donation_mainAttachment.serializer,
          )
          ..add(GMyReservationData_myReservation_donation_user.serializer)
          ..add(
            GMyReservationData_myReservation_donation_user_avatar.serializer,
          )
          ..add(GMyReservationReq.serializer)
          ..add(GMyReservationVars.serializer)
          ..add(GMyReservationsData.serializer)
          ..add(GMyReservationsData_myReservations.serializer)
          ..add(GMyReservationsData_myReservations_items.serializer)
          ..add(GMyReservationsData_myReservations_items_donation.serializer)
          ..add(
            GMyReservationsData_myReservations_items_donation_mainAttachment
                .serializer,
          )
          ..add(GMyReservationsReq.serializer)
          ..add(GMyReservationsVars.serializer)
          ..add(GPaginationInput.serializer)
          ..add(GPaginationQueryInput.serializer)
          ..add(GRefreshTokensData.serializer)
          ..add(GRefreshTokensData_refreshTokens.serializer)
          ..add(GRefreshTokensData_refreshTokens_user.serializer)
          ..add(GRefreshTokensData_refreshTokens_user_avatar.serializer)
          ..add(GRefreshTokensData_refreshTokens_user_location.serializer)
          ..add(GRefreshTokensForInterceptorData.serializer)
          ..add(GRefreshTokensForInterceptorData_refreshTokens.serializer)
          ..add(GRefreshTokensForInterceptorReq.serializer)
          ..add(GRefreshTokensForInterceptorVars.serializer)
          ..add(GRefreshTokensReq.serializer)
          ..add(GRefreshTokensVars.serializer)
          ..add(GRegisterData.serializer)
          ..add(GRegisterData_register.serializer)
          ..add(GRegisterInput.serializer)
          ..add(GRegisterLocationInput.serializer)
          ..add(GRegisterReq.serializer)
          ..add(GRegisterVars.serializer)
          ..add(GReportStatsInput.serializer)
          ..add(GReportStatsPeriod.serializer)
          ..add(GReportStatsStatusFilter.serializer)
          ..add(GReportStatus.serializer)
          ..add(GReportTargetType.serializer)
          ..add(GReservationFieldsData.serializer)
          ..add(GReservationFieldsData_beneficiary.serializer)
          ..add(GReservationFieldsData_beneficiary_avatar.serializer)
          ..add(GReservationFieldsData_beneficiary_location.serializer)
          ..add(GReservationFieldsData_donation.serializer)
          ..add(GReservationFieldsData_donation_category.serializer)
          ..add(GReservationFieldsData_donation_location.serializer)
          ..add(GReservationFieldsData_donation_mainAttachment.serializer)
          ..add(GReservationFieldsData_donation_user.serializer)
          ..add(GReservationFieldsReq.serializer)
          ..add(GReservationFieldsVars.serializer)
          ..add(GReservationStatus.serializer)
          ..add(GReservationsFilterInput.serializer)
          ..add(GReserveDonationData.serializer)
          ..add(GReserveDonationData_reserveDonation.serializer)
          ..add(GReserveDonationData_reserveDonation_beneficiary.serializer)
          ..add(
            GReserveDonationData_reserveDonation_beneficiary_avatar.serializer,
          )
          ..add(
            GReserveDonationData_reserveDonation_beneficiary_location
                .serializer,
          )
          ..add(GReserveDonationData_reserveDonation_donation.serializer)
          ..add(
            GReserveDonationData_reserveDonation_donation_category.serializer,
          )
          ..add(
            GReserveDonationData_reserveDonation_donation_location.serializer,
          )
          ..add(
            GReserveDonationData_reserveDonation_donation_mainAttachment
                .serializer,
          )
          ..add(GReserveDonationData_reserveDonation_donation_user.serializer)
          ..add(GReserveDonationReq.serializer)
          ..add(GReserveDonationVars.serializer)
          ..add(GResetPasswordData.serializer)
          ..add(GResetPasswordData_resetPassword.serializer)
          ..add(GResetPasswordInput.serializer)
          ..add(GResetPasswordReq.serializer)
          ..add(GResetPasswordVars.serializer)
          ..add(GReviewReportInput.serializer)
          ..add(GSendMessageData.serializer)
          ..add(GSendMessageData_sendMessage.serializer)
          ..add(GSendMessageInput.serializer)
          ..add(GSendMessageReq.serializer)
          ..add(GSendMessageVars.serializer)
          ..add(GSendNotificationInput.serializer)
          ..add(GSendVerificationData.serializer)
          ..add(GSendVerificationData_sendVerification.serializer)
          ..add(GSendVerificationReq.serializer)
          ..add(GSendVerificationVars.serializer)
          ..add(GStatsGrowthInput.serializer)
          ..add(GStatsGrowthPeriod.serializer)
          ..add(GUpdateBadgeInput.serializer)
          ..add(GUpdateCategoryInput.serializer)
          ..add(GUpdateDonationInput.serializer)
          ..add(GUpdateProfileData.serializer)
          ..add(GUpdateProfileData_updateProfile.serializer)
          ..add(GUpdateProfileData_updateProfile_avatar.serializer)
          ..add(GUpdateProfileData_updateProfile_location.serializer)
          ..add(GUpdateProfileInput.serializer)
          ..add(GUpdateProfileReq.serializer)
          ..add(GUpdateProfileVars.serializer)
          ..add(GUpdateReadNotificationsInput.serializer)
          ..add(GUploadStatusValues.serializer)
          ..add(GUserFieldsData.serializer)
          ..add(GUserFieldsData_avatar.serializer)
          ..add(GUserFieldsData_location.serializer)
          ..add(GUserFieldsReq.serializer)
          ..add(GUserFieldsVars.serializer)
          ..add(GUserRole.serializer)
          ..add(GUserSettingsInput.serializer)
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(GGetCategoriesData_categories_items),
            ]),
            () => ListBuilder<GGetCategoriesData_categories_items>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(
                GGetConversationMessagesData_conversationMessages_items,
              ),
            ]),
            () =>
                ListBuilder<
                  GGetConversationMessagesData_conversationMessages_items
                >(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(GGetDonationsData_donations_items),
            ]),
            () => ListBuilder<GGetDonationsData_donations_items>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(GGetNotificationsData_getNotifications_items),
            ]),
            () => ListBuilder<GGetNotificationsData_getNotifications_items>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(GMyActiveConversationsData_myActiveConversations),
            ]),
            () =>
                ListBuilder<GMyActiveConversationsData_myActiveConversations>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [
              const FullType(GMyReservationsData_myReservations_items),
            ]),
            () => ListBuilder<GMyReservationsData_myReservations_items>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          )
          ..addBuilderFactory(
            const FullType(BuiltList, const [const FullType(String)]),
            () => ListBuilder<String>(),
          ))
        .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
