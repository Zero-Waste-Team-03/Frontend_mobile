// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'غاسپ زيرو';

  @override
  String get browseFeaturedSectionTitle => 'الأقرب والمميزة';

  @override
  String get browseFeaturedSectionSubtitle => 'تبرعات جديدة ضمن نطاقك';

  @override
  String get browseStandardSectionTitle => 'مزيد من التبرعات';

  @override
  String get browseStandardSectionSubtitle => 'كل الفرص المتاحة';

  @override
  String get browseFilterAll => 'الكل';

  @override
  String get browseFilterPublished => 'منشور';

  @override
  String get browseFilterReserved => 'محجوز';

  @override
  String get browseFilterCompleted => 'مكتمل';

  @override
  String get browseFilterDraft => 'مسودة';

  @override
  String get browseSearchHint => 'ابحث عن التبرعات...';

  @override
  String donationsNearbyCount(int count) {
    return '$count تبرع قريب';
  }

  @override
  String get browseEmptyTitle => 'لا توجد تبرعات';

  @override
  String get browseEmptyDescription => 'جرّب فلتر آخر أو عدّل البحث.';

  @override
  String get browseErrorRetry => 'إعادة المحاولة';

  @override
  String get featuredBadge => 'مميز';

  @override
  String donationCardDistanceKm(String value) {
    return '$value كم';
  }

  @override
  String donationCardQuantity(int count) {
    return '$count حصة';
  }

  @override
  String donationCardExpiresLabel(String date) {
    return 'ينتهي في $date';
  }

  @override
  String get donationCardAnonymousDonor => 'متبرع مجهول';

  @override
  String get statusDraft => 'مسودة';

  @override
  String get statusPublished => 'منشور';

  @override
  String get statusReserved => 'محجوز';

  @override
  String get statusCompleted => 'مكتمل';

  @override
  String get statusExpired => 'منتهي';

  @override
  String get statusUnknown => 'غير معروف';

  @override
  String get donationUrgencyHigh => 'مرتفع';

  @override
  String get donationUrgencyMedium => 'متوسط';

  @override
  String get donationUrgencyLow => 'منخفض';

  @override
  String get detailsPickupLocation => 'موقع الاستلام';

  @override
  String get detailsCategoryFallback => 'الفئة';

  @override
  String get detailsNoExpiry => 'بدون تاريخ انتهاء';

  @override
  String get detailsReserveNow => 'احجز الآن';

  @override
  String get addDonationLocationTitle => 'موقع التبرع';

  @override
  String get addDonationLocationSubtitle =>
      'حرّك الخريطة وضع المؤشر على النقطة الصحيحة.';

  @override
  String get addDonationLocationInstruction =>
      'ثبّت المؤشر على موقع الاستلام بدقة.';

  @override
  String get addDonationLocationConfirm => 'تأكيد الموقع';

  @override
  String get addDonationLocationChange => 'تغيير';

  @override
  String get addDonationLocationUseCurrent => 'استخدام موقعي';

  @override
  String get addDonationLocationSelected => 'الموقع المختار';

  @override
  String get mapLocationPermissionDenied => 'تم رفض إذن الموقع.';

  @override
  String get mapLocationPermissionDeniedForever => 'تم رفض إذن الموقع نهائيا.';

  @override
  String get mapLocationMyLocation => 'موقعي';

  @override
  String get mapLocationLoading => 'جاري تحميل الخريطة...';

  @override
  String get registerStep2DatePickerTitle => 'اختر تاريخ الميلاد';

  @override
  String get registerStep2PickerMonthLabel => 'الشهر';

  @override
  String get registerStep2PickerDayLabel => 'اليوم';

  @override
  String get registerStep2PickerYearLabel => 'السنة';

  @override
  String get registerStep2PickerConfirm => 'تأكيد';

  @override
  String get registerStep2MonthJan => 'ينا';

  @override
  String get registerStep2MonthFeb => 'فبر';

  @override
  String get registerStep2MonthMar => 'مار';

  @override
  String get registerStep2MonthApr => 'أبر';

  @override
  String get registerStep2MonthMay => 'ماي';

  @override
  String get registerStep2MonthJun => 'يون';

  @override
  String get registerStep2MonthJul => 'يول';

  @override
  String get registerStep2MonthAug => 'أغس';

  @override
  String get registerStep2MonthSep => 'سبت';

  @override
  String get registerStep2MonthOct => 'أكت';

  @override
  String get registerStep2MonthNov => 'نوف';

  @override
  String get registerStep2MonthDec => 'ديس';
}
