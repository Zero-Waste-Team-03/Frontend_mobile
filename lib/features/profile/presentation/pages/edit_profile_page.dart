import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/permissions/permission_request_coordinator.dart';
import '../../../../shared/theme/app_colors.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;
  late TextEditingController _neighborhoodController;
  late TextEditingController _zipCodeController;
  double? _latitude;
  double? _longitude;

  bool _isInitialized = false;
  bool _isFetchingLocation = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _phoneController = TextEditingController();
    _cityController = TextEditingController();
    _neighborhoodController = TextEditingController();
    _zipCodeController = TextEditingController();
  }

  void _populateFields(dynamic user) {
    _fullNameController.text = user.name ?? '';
    _phoneController.text = user.phoneNumber ?? '';
    _cityController.text = user.location?['city'] ?? '';
    _neighborhoodController.text = user.location?['neighborhood'] ?? '';
    _zipCodeController.text = user.location?['zipCode'] ?? '';
    _latitude = user.location?['latitude'] is num
        ? (user.location?['latitude'] as num).toDouble()
        : null;
    _longitude = user.location?['longitude'] is num
        ? (user.location?['longitude'] as num).toDouble()
        : null;
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _neighborhoodController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final profileBloc = context.read<ProfileBloc>();
      final currentState = profileBloc.state;
      if (currentState is ProfileLoaded || currentState is ProfileUpdating) {
        final fullName = _fullNameController.text.trim();
        final phone = _phoneController.text.trim();
        final city = _cityController.text.trim();
        final neighborhood = _neighborhoodController.text.trim();
        final zipCode = _zipCodeController.text.trim();

        profileBloc.add(
          ProfileUpdateRequested(
            displayName: fullName,
            phoneNumber: phone,
            location: {
              if (city.isNotEmpty) 'city': city,
              if (neighborhood.isNotEmpty) 'neighborhood': neighborhood,
              if (zipCode.isNotEmpty) 'zipCode': zipCode,
              if (_latitude != null) 'latitude': _latitude,
              if (_longitude != null) 'longitude': _longitude,
            },
          ),
        );
      }
    }
  }

  Future<void> _fillCurrentLocation() async {
    if (_isFetchingLocation) return;
    setState(() => _isFetchingLocation = true);

    try {
      final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isServiceEnabled) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enable location services.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await PermissionRequestCoordinator.runLocationRequest(
          Geolocator.requestPermission,
        );
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permission is required.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
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

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _cityController.text = (place.locality ?? '').trim();
          _neighborhoodController.text = (place.subLocality ?? place.name ?? '')
              .trim();
          _zipCodeController.text = (place.postalCode ?? '').trim();
          _latitude = position!.latitude;
          _longitude = position.longitude;
        });
      } else {
        setState(() {
          _latitude = position!.latitude;
          _longitude = position.longitude;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location updated'),
          backgroundColor: context.themeColors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to fetch location: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) setState(() => _isFetchingLocation = false);
    }
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    // Remove all non-digit characters for validation
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? _validateRequired(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text('Profile updated successfully'),
              backgroundColor: colors.primary,
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) context.pop();
          });
        } else if (state is ProfileError && state is! ProfileUpdating) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: colors.primary,
              fontSize: AppDimensions.appBarTitleSize.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: colors.primary,
              size: AppDimensions.iconSize.sp,
            ),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              // Get user initials for avatar
              String getInitials(String? name) {
                if (name == null || name.isEmpty) return '--';
                final parts = name.split(' ');
                if (parts.length >= 2) {
                  return '${parts[0][0].toUpperCase()}${parts[1][0].toUpperCase()}';
                }
                return name.substring(0, 2).toUpperCase();
              }

              final user = state is ProfileLoaded
                  ? state.user
                  : (state is ProfileUpdating
                        ? state.currentUser
                        : (state is ProfileUpdateSuccess ? state.user : null));
              final isUpdating =
                  state is ProfileUpdating || state is ProfileUpdateSuccess;

              if (!_isInitialized && user != null) {
                _populateFields(user);
                _isInitialized = true;
              }

              return SingleChildScrollView(
                padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Avatar with camera icon
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colors.primary.withValues(alpha: 0.1),
                                border: Border.all(
                                  color: colors.border,
                                  width: 2.w,
                                ),
                              ),
                              child:
                                  (user != null &&
                                      user.avatarUrl != null &&
                                      user.avatarUrl!.isNotEmpty)
                                  ? ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: user.avatarUrl!,
                                        key: ValueKey(user.avatarUrl),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: colors.primary,
                                            ),
                                          );
                                        },
                                        errorWidget: (context, url, error) {
                                          return Center(
                                            child: Text(
                                              getInitials(user.name),
                                              style: TextStyle(
                                                fontSize: 40.sp,
                                                fontWeight: FontWeight.w700,
                                               
                                                color: colors.primary,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        getInitials(user?.name),
                                        style: TextStyle(
                                          fontSize: 40.sp,
                                          fontWeight: FontWeight.w700,
                                          color: colors.primary,
                                        ),
                                      ),
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: isUpdating
                                    ? null
                                    : () => _pickAndUploadAvatar(context),
                                child: Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colors.primary,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.w,
                                    ),
                                  ),
                                  child: isUpdating
                                      ? SizedBox(
                                          width: 12.w,
                                          height: 12.w,
                                          child:
                                              const CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(Colors.white),
                                              ),
                                        )
                                      : Icon(
                                          Icons.camera_alt_rounded,
                                          color: Colors.white,
                                          size: 16.sp,
                                        ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingExtraLarge.h),

                      // Personal Information Header
                      Text(
                        'PERSONAL INFORMATION',
                        style: TextStyle(
                          fontSize: AppDimensions.subtitleSize.sp,
                          fontWeight: FontWeight.w700,
                          color: colors.headingText,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: AppDimensions.paddingMedium.h),

                      // Full Name Field
                      _buildLabel('Full Name'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildFormField(
                        controller: _fullNameController,
                        hint: 'Enter your full name',
                        validator: _validateRequired,
                        keyboardType: TextInputType.name,
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Phone Number Field
                      _buildLabel('Phone Number'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildFormField(
                        controller: _phoneController,
                        hint: 'Enter your phone number',
                        validator: _validatePhoneNumber,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Primary Location Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PRIMARY LOCATION',
                            style: TextStyle(
                              fontSize: AppDimensions.subtitleSize.sp,
                              fontWeight: FontWeight.w700,
                              color: colors.headingText,
                              letterSpacing: 0.5,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _isFetchingLocation
                                ? null
                                : _fillCurrentLocation,
                            icon: _isFetchingLocation
                                ? SizedBox(
                                    width: 14.w,
                                    height: 14.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: colors.primary,
                                    ),
                                  )
                                : Icon(Icons.my_location, size: 14.sp),
                            label: Text(
                              'Use Current',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: colors.primary,
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimensions.paddingSmall.h),

                      // City Field
                      _buildLabel('City'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildFormField(
                        controller: _cityController,
                        hint: 'Enter your city',
                        validator: _validateRequired,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Neighborhood Field
                      _buildLabel('Neighborhood'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildFormField(
                        controller: _neighborhoodController,
                        hint: 'Enter your neighborhood',
                        validator: (value) => null, // Optional
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Zip Code Field
                      _buildLabel('Zip Code'),
                      SizedBox(height: AppDimensions.paddingSmall.h),
                      _buildFormField(
                        controller: _zipCodeController,
                        hint: 'Enter your zip code',
                        validator: _validateRequired,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),

                      // Save Button
                      ElevatedButton(
                        onPressed: isUpdating ? null : _onSave,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 56.h),
                          backgroundColor: colors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusLarge.r,
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: isUpdating
                            ? SizedBox(
                                width: AppDimensions.iconSize.w,
                                height: AppDimensions.iconSize.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: AppDimensions.buttonTextSize.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      SizedBox(height: AppDimensions.paddingLarge.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: context.themeColors.headingText,
        fontWeight: FontWeight.w500,
        fontSize: AppDimensions.bodySize.sp,
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String hint,
    required String? Function(String?) validator,
    required TextInputType keyboardType,
  }) {
    final colors = context.themeColors;
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: colors.textSecondary,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: colors.textSecondary.withValues(alpha: 0.7),
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusLarge.r,
          ),
          borderSide: BorderSide(color: colors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusLarge.r,
          ),
          borderSide: BorderSide(color: colors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusLarge.r,
          ),
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusLarge.r,
          ),
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusLarge.r,
          ),
          borderSide: BorderSide(color: colors.error, width: 2),
        ),
        filled: true,
        fillColor: colors.inputBackground,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium.w,
          vertical: AppDimensions.paddingMedium.h,
        ),
        errorStyle: TextStyle(
          fontSize: AppDimensions.captionSize.sp,
          color: Colors.red,
          height: 1.4,
        ),
      ),
    );
  }

  Future<void> _pickAndUploadAvatar(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        if (mounted) {
          context.read<ProfileBloc>().add(
            ProfileAvatarUploadRequested(filePath: image.path),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}


