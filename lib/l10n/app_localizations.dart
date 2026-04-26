import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Gasp\'Zero'**
  String get appTitle;

  /// No description provided for @browseFeaturedSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured nearby'**
  String get browseFeaturedSectionTitle;

  /// No description provided for @browseFeaturedSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fresh donations that match your area'**
  String get browseFeaturedSectionSubtitle;

  /// No description provided for @browseStandardSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'More donations'**
  String get browseStandardSectionTitle;

  /// No description provided for @browseStandardSectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All available opportunities'**
  String get browseStandardSectionSubtitle;

  /// No description provided for @browseFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get browseFilterAll;

  /// No description provided for @browseFilterPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get browseFilterPublished;

  /// No description provided for @browseFilterReserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get browseFilterReserved;

  /// No description provided for @browseFilterCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get browseFilterCompleted;

  /// No description provided for @browseFilterDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get browseFilterDraft;

  /// No description provided for @browseSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search donations...'**
  String get browseSearchHint;

  /// Nearby donations count label
  ///
  /// In en, this message translates to:
  /// **'{count} donations nearby'**
  String donationsNearbyCount(int count);

  /// No description provided for @browseEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No donations found'**
  String get browseEmptyTitle;

  /// No description provided for @browseEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Try another filter or adjust your search.'**
  String get browseEmptyDescription;

  /// No description provided for @browseErrorRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get browseErrorRetry;

  /// No description provided for @featuredBadge.
  ///
  /// In en, this message translates to:
  /// **'Featured'**
  String get featuredBadge;

  /// Distance in kilometers for a donation card
  ///
  /// In en, this message translates to:
  /// **'{value} km'**
  String donationCardDistanceKm(String value);

  /// Available quantity for a donation card
  ///
  /// In en, this message translates to:
  /// **'{count} portions'**
  String donationCardQuantity(int count);

  /// Expiry label on a donation card
  ///
  /// In en, this message translates to:
  /// **'Expires {date}'**
  String donationCardExpiresLabel(String date);

  /// No description provided for @donationCardAnonymousDonor.
  ///
  /// In en, this message translates to:
  /// **'Anonymous donor'**
  String get donationCardAnonymousDonor;

  /// No description provided for @statusDraft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get statusDraft;

  /// No description provided for @statusPublished.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get statusPublished;

  /// No description provided for @statusReserved.
  ///
  /// In en, this message translates to:
  /// **'Reserved'**
  String get statusReserved;

  /// No description provided for @statusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get statusCompleted;

  /// No description provided for @statusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get statusExpired;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @donationUrgencyHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get donationUrgencyHigh;

  /// No description provided for @donationUrgencyMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get donationUrgencyMedium;

  /// No description provided for @donationUrgencyLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get donationUrgencyLow;

  /// No description provided for @detailsPickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup location'**
  String get detailsPickupLocation;

  /// No description provided for @detailsCategoryFallback.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get detailsCategoryFallback;

  /// No description provided for @detailsNoExpiry.
  ///
  /// In en, this message translates to:
  /// **'No expiry'**
  String get detailsNoExpiry;

  /// No description provided for @detailsReserveNow.
  ///
  /// In en, this message translates to:
  /// **'Reserve now'**
  String get detailsReserveNow;

  /// No description provided for @addDonationLocationTitle.
  ///
  /// In en, this message translates to:
  /// **'Donation location'**
  String get addDonationLocationTitle;

  /// No description provided for @addDonationLocationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap and drag the map to place your pin.'**
  String get addDonationLocationSubtitle;

  /// No description provided for @addDonationLocationInstruction.
  ///
  /// In en, this message translates to:
  /// **'Keep the pin on the exact pickup point.'**
  String get addDonationLocationInstruction;

  /// No description provided for @addDonationLocationConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm location'**
  String get addDonationLocationConfirm;

  /// No description provided for @addDonationLocationChange.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get addDonationLocationChange;

  /// No description provided for @addDonationLocationUseCurrent.
  ///
  /// In en, this message translates to:
  /// **'Use my location'**
  String get addDonationLocationUseCurrent;

  /// No description provided for @addDonationLocationSelected.
  ///
  /// In en, this message translates to:
  /// **'Selected location'**
  String get addDonationLocationSelected;

  /// No description provided for @mapLocationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Location permission is denied.'**
  String get mapLocationPermissionDenied;

  /// No description provided for @mapLocationPermissionDeniedForever.
  ///
  /// In en, this message translates to:
  /// **'Location permission is permanently denied.'**
  String get mapLocationPermissionDeniedForever;

  /// No description provided for @mapLocationMyLocation.
  ///
  /// In en, this message translates to:
  /// **'My location'**
  String get mapLocationMyLocation;

  /// No description provided for @mapLocationLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading map...'**
  String get mapLocationLoading;

  /// No description provided for @registerStep2DatePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select date of birth'**
  String get registerStep2DatePickerTitle;

  /// No description provided for @registerStep2PickerMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get registerStep2PickerMonthLabel;

  /// No description provided for @registerStep2PickerDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get registerStep2PickerDayLabel;

  /// No description provided for @registerStep2PickerYearLabel.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get registerStep2PickerYearLabel;

  /// No description provided for @registerStep2PickerConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get registerStep2PickerConfirm;

  /// No description provided for @registerStep2MonthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get registerStep2MonthJan;

  /// No description provided for @registerStep2MonthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get registerStep2MonthFeb;

  /// No description provided for @registerStep2MonthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get registerStep2MonthMar;

  /// No description provided for @registerStep2MonthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get registerStep2MonthApr;

  /// No description provided for @registerStep2MonthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get registerStep2MonthMay;

  /// No description provided for @registerStep2MonthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get registerStep2MonthJun;

  /// No description provided for @registerStep2MonthJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get registerStep2MonthJul;

  /// No description provided for @registerStep2MonthAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get registerStep2MonthAug;

  /// No description provided for @registerStep2MonthSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get registerStep2MonthSep;

  /// No description provided for @registerStep2MonthOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get registerStep2MonthOct;

  /// No description provided for @registerStep2MonthNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get registerStep2MonthNov;

  /// No description provided for @registerStep2MonthDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get registerStep2MonthDec;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
