import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'auth_colors.dart';

class RegisterStep2Page extends StatefulWidget {
  final Map<String, String> formData;
  final VoidCallback onNext;
  final VoidCallback? onOtpSent;

  const RegisterStep2Page({
    super.key,
    required this.formData,
    required this.onNext,
    this.onOtpSent,
  });

  @override
  State<RegisterStep2Page> createState() => _RegisterStep2PageState();
}

class _RegisterStep2PageState extends State<RegisterStep2Page> {
  late final TextEditingController _locationController;
  final List<String> _months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  late final List<int> _years;
  late final FixedExtentScrollController _monthScrollController;
  late final FixedExtentScrollController _dayScrollController;
  late final FixedExtentScrollController _yearScrollController;
  int _monthIndex = 1;
  int _dayIndex = 15;
  int _yearIndex = 34;
  bool _isFetchingLocation = false;

  @override
  void initState() {
    super.initState();
    _locationController =
        TextEditingController(text: widget.formData['location'] ?? '');
    final currentYear = DateTime.now().year;
    _years = List<int>.generate(100, (index) => currentYear - 99 + index);
    _hydrateBirthdayFromFormData();
    _monthScrollController =
        FixedExtentScrollController(initialItem: _monthIndex);
    _dayScrollController = FixedExtentScrollController(initialItem: _dayIndex);
    _yearScrollController =
        FixedExtentScrollController(initialItem: _yearIndex);
  }

  @override
  void dispose() {
    _monthScrollController.dispose();
    _dayScrollController.dispose();
    _yearScrollController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _hydrateBirthdayFromFormData() {
    final saved = widget.formData['birthday'];
    if (saved == null || saved.isEmpty) {
      final defaultYear = 1991;
      _yearIndex = _years.indexOf(defaultYear);
      if (_yearIndex < 0) _yearIndex = _years.length ~/ 2;
      return;
    }

    final parsed = DateTime.tryParse(saved);
    if (parsed == null) return;

    _monthIndex = parsed.month - 1;
    _dayIndex = parsed.day - 1;
    final yearIndex = _years.indexOf(parsed.year);
    if (yearIndex >= 0) _yearIndex = yearIndex;
  }

  DateTime _selectedBirthDate() {
    final year = _years[_yearIndex];
    final month = _monthIndex + 1;
    final selectedDay = _dayIndex + 1;
    final maxDay = DateUtils.getDaysInMonth(year, month);
    final safeDay = selectedDay > maxDay ? maxDay : selectedDay;
    return DateTime(year, month, safeDay);
  }

  Future<void> _fillCurrentLocation() async {
    if (_isFetchingLocation) return;
    setState(() => _isFetchingLocation = true);

    try {
      final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enable location services.')),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission is required.')),
        );
        return;
      }

      Position? position;
      try {
        position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          ),
        );
      } on TimeoutException {
        position = await Geolocator.getLastKnownPosition();
      } on LocationServiceDisabledException {
        rethrow;
      } catch (_) {
        position = await Geolocator.getLastKnownPosition();
      }

      if (position == null) {
        throw Exception('No location available');
      }

      List<Placemark> placemarks = const [];
      try {
        placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );
      } catch (_) {
        placemarks = const [];
      }

      if (!mounted) return;

      String value;
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final city = (place.locality ?? '').trim();
        final subArea = (place.subAdministrativeArea ?? '').trim();
        final country = (place.country ?? '').trim();
        final zip = (place.postalCode ?? '').trim();
        if (city.isNotEmpty && zip.isNotEmpty) {
          value = '$city, $zip';
        } else if (city.isNotEmpty) {
          value = city;
        } else if (subArea.isNotEmpty && country.isNotEmpty) {
          value = '$subArea, $country';
        } else if (subArea.isNotEmpty) {
          value = subArea;
        } else if (zip.isNotEmpty) {
          value = zip;
        } else {
          value =
              '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}';
        }
      } else {
        value =
            '${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)}';
      }

      _locationController.text = value;
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location detected: $value')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to fetch your location.')),
      );
    } finally {
      if (mounted) setState(() => _isFetchingLocation = false);
    }
  }

  void _onSubmit() {
    final location = _locationController.text.trim();
    final birthday = DateFormat('yyyy-MM-dd').format(_selectedBirthDate());

    if (location.isNotEmpty) {
      widget.formData['birthday'] = birthday;
      widget.formData['location'] = location;

      // Dispatch the action to send OTP
      context.read<AuthBloc>().add(
            AuthSignUpRequested(
              firstName: widget.formData['firstName'] ?? '',
              lastName: widget.formData['lastName'] ?? '',
              email: widget.formData['email'] ?? '',
              password: widget.formData['password'] ?? '',
            ),
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your city')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthOtpSentSuccess) {
          // Move to OTP step via parent callback
          widget.onNext();
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Builder(
        builder: (context) {
          final isLoading = context.watch<AuthBloc>().state is AuthLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: AppDimensions.paddingExtraLarge.h),
                Text(
                  'A bit more about you',
                  style: TextStyle(
                    fontSize: AppDimensions.titleSize.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.025 * AppDimensions.titleSize.sp,
                    color: AuthColors.headingText,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingLarge.h),
                _buildLabel('Date of Birth'),
                SizedBox(height: AppDimensions.paddingSmall.h),
                _buildDateOfBirthPicker(),
                SizedBox(height: AppDimensions.paddingLarge.h),
                _buildLabel('Location'),
                SizedBox(height: AppDimensions.paddingSmall.h),
                _buildLocationField(),
                SizedBox(height: AppDimensions.paddingSmall.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(
                    'Used to find local community challenges and initiatives.',
                    style: TextStyle(
                      fontSize: AppDimensions.captionSize.sp,
                      color: AuthColors.inputText,
                      height: 1.33,
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
                ElevatedButton(
                  onPressed: isLoading ? null : _onSubmit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 56.h),
                    backgroundColor: AuthColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusLarge.r),
                    ),
                    elevation: 0,
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: AppDimensions.iconSize.w,
                          height: AppDimensions.iconSize.h,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          'Send Verification OTP',
                          style: TextStyle(
                            fontSize: AppDimensions.buttonTextSize.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AuthColors.labelText,
        fontWeight: FontWeight.w500,
        fontSize: AppDimensions.bodySize.sp,
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: AuthColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
            color: AuthColors.headingText,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: AuthColors.inputText,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium.w,
            vertical: 18.h,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return Stack(
      children: [
        _buildTextField(_locationController, 'Enter your city or zip code'),
        Positioned(
          right: 8.w,
          top: 8.h,
          child: SizedBox(
            width: 40.w,
            height: 40.h,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AuthColors.primary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                iconSize: 20.sp,
                splashRadius: 22.r,
                onPressed: _isFetchingLocation ? null : _fillCurrentLocation,
                color: Colors.white,
                icon: _isFetchingLocation
                    ? SizedBox(
                        width: 16.w,
                        height: 16.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.my_location_rounded),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateOfBirthPicker() {
    final dayItems = List<int>.generate(
      DateUtils.getDaysInMonth(_years[_yearIndex], _monthIndex + 1),
      (index) => index + 1,
    );
    if (_dayIndex >= dayItems.length) {
      _dayIndex = dayItems.length - 1;
    }

    return SizedBox(
      height: 132.h,
      child: Row(
        children: [
          Expanded(
            child: _buildPickerColumn(
              title: 'Month',
              values: _months,
              controller: _monthScrollController,
              selectedIndex: _monthIndex,
              onSelected: (index) {
                setState(() {
                  _monthIndex = index;
                  final maxDay = DateUtils.getDaysInMonth(
                      _years[_yearIndex], _monthIndex + 1);
                  if (_dayIndex + 1 > maxDay) {
                    _dayIndex = maxDay - 1;
                    _dayScrollController.jumpToItem(_dayIndex);
                  }
                });
              },
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildPickerColumn(
              title: 'Day',
              values:
                  dayItems.map((d) => d.toString().padLeft(2, '0')).toList(),
              controller: _dayScrollController,
              selectedIndex: _dayIndex,
              onSelected: (index) => setState(() => _dayIndex = index),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _buildPickerColumn(
              title: 'Year',
              values: _years.map((y) => y.toString()).toList(),
              controller: _yearScrollController,
              selectedIndex: _yearIndex,
              onSelected: (index) {
                setState(() {
                  _yearIndex = index;
                  final maxDay = DateUtils.getDaysInMonth(
                      _years[_yearIndex], _monthIndex + 1);
                  if (_dayIndex + 1 > maxDay) {
                    _dayIndex = maxDay - 1;
                    _dayScrollController.jumpToItem(_dayIndex);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickerColumn({
    required String title,
    required List<String> values,
    required FixedExtentScrollController controller,
    required int selectedIndex,
    required ValueChanged<int> onSelected,
  }) {
    final effectiveIndex = selectedIndex.clamp(0, values.length - 1);

    return Container(
      decoration: BoxDecoration(
        color: AuthColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
            child: Text(
              title.toUpperCase(),
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: AuthColors.inputText,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 28.h,
              scrollController: controller,
              selectionOverlay: const SizedBox.shrink(),
              onSelectedItemChanged: onSelected,
              children: values.asMap().entries.map((entry) {
                final index = entry.key;
                final value = entry.value;
                final isSelected = index == effectiveIndex;
                return Center(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 6.w),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AuthColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w400,
                        color: isSelected ? Colors.white : AuthColors.inputText,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
