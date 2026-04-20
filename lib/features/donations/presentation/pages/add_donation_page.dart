import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import '../../../../core/app_icons.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/app_location_picker.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../domain/entities/category.dart';
import '../bloc/donations_bloc.dart';
import '../bloc/donations_event.dart';
import '../bloc/donations_state.dart';

class AddDonationPage extends StatefulWidget {
  const AddDonationPage({super.key});

  @override
  State<AddDonationPage> createState() => _AddDonationPageState();
}

class _AddDonationPageState extends State<AddDonationPage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Step 1 Data
  final TextEditingController _itemNameController = TextEditingController();
  String? _selectedCategoryId;
  List<Category> _categories = const [];
  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;
  String? _uploadedAttachmentId;

  // Step 2 Data
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _selectedUnit = 'Items/Units';
  String _pickupPreference = 'Home'; // Home, Public Spot
  DateTime? _expirationDate;

  // Step 3 Data
  bool _safety1 = false;
  bool _safety2 = false;
  bool _safety3 = false;
  final TextEditingController _notesController = TextEditingController();

  double? _latitude;
  double? _longitude;

  final List<String> _categoryIcons = [
    'assets/icons/donations/category_fresh.svg',
    'assets/icons/donations/category_dry.svg',
    'assets/icons/donations/category_cooked.svg',
    'assets/icons/donations/category_bakery.svg',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _itemNameController.dispose();
    _weightController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _pickedImage = image;
      _uploadedAttachmentId = null;
    });
  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
        });
      }
    } catch (_) {}
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pop();
    }
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Basics';
      case 1:
        return 'Details';
      case 2:
        return 'Safety & Publish';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the donation form UI with 3 steps
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(AppIcons.back, color: AuthColors.headingText, size: 24.sp),
          onPressed: _prevStep,
        ),
        title: Text(
          'Add Donation',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AuthColors.headingText,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header with Title and Step Count
          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 16.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getStepTitle(),
                      style: GoogleFonts.inter(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: AuthColors.headingText,
                      ),
                    ),
                    Text(
                      'STEP ${_currentStep + 1} OF 3',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AuthColors.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999.r),
                  child: LinearProgressIndicator(
                    value: (_currentStep + 1) / 3,
                    backgroundColor: const Color(0xFFE2E8F0),
                    color: AuthColors.primary,
                    minHeight: 8.h,
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [_buildStep1(), _buildStep2(), _buildStep3()],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocConsumer<DonationsBloc, DonationsState>(
        listener: (context, state) {
          if (state is DonationsLoaded) {
            setState(() {
              _categories = state.categories;
              _selectedCategoryId ??= _categories.isNotEmpty
                  ? _categories.first.id
                  : null;
            });
          } else if (state is DonationImageUploadSuccess) {
            setState(() {
              _uploadedAttachmentId = state.attachmentId;
            });
            _nextStep();
          } else if (state is DonationImageUploadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Photo upload failed: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is DonationAddSuccess) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Donation published successfully!'),
                backgroundColor: AuthColors.primary,
              ),
            );
          } else if (state is DonationAddError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error publishing: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return _buildBottomActions(context, state);
        },
      ),
    );
  }

  // ===================== STEP 1: BASICS =====================
  Widget _buildStep1() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo Upload Area
          GestureDetector(
            onTap:
                context.read<DonationsBloc>().state
                    is DonationImageUploadLoading
                ? null
                : _pickImage,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 32.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFFCBD5E1),
                  width: 2,
                  style: BorderStyle.none,
                ),
              ),
              child: CustomPaint(
                painter: _DashedBorderPainter(
                  color: const Color(0xFF94A3B8),
                  borderRadius: 12.r,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.h),
                    if (_pickedImage != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.file(
                            File(_pickedImage!.path),
                            width: 96.w,
                            height: 96.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AuthColors.primary.withValues(
                          alpha: 0.1,
                        ), // 10% opacity
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/donations/upload_photo.svg',
                        width: 26.sp,
                        height: 26.sp,
                        colorFilter: ColorFilter.mode(
                          AuthColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      _pickedImage != null ? 'Photo Selected' : 'Upload Photo',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AuthColors.headingText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _pickedImage != null
                          ? 'Photo ready for upload'
                          : 'Add a clear photo of the food item',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AuthColors.subText,
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Item Name Field
          _buildLabel('What are you donating?'),
          _buildTextField(
            controller: _itemNameController,
            hintText: 'e.g., Fresh Sourdough Bread',
          ),
          SizedBox(height: 24.h),

          // Category Selection
          _buildLabel('Category'),
          if (_categories.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: const LinearProgressIndicator(color: AuthColors.primary),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.h,
                childAspectRatio: 1.55,
              ),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategoryId == category.id;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedCategoryId = category.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AuthColors.primary.withValues(alpha: 0.1)
                          : const Color(0xFFF1F5F9),
                      border: Border.all(
                        color: isSelected
                            ? AuthColors.primary
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          _categoryIcons[index % _categoryIcons.length],
                          width: 40.sp,
                          height: 40.sp,
                          colorFilter: ColorFilter.mode(
                            isSelected
                                ? AuthColors.primary
                                : const Color(0xFF64748B),
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          category.name,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w600,
                            color: isSelected
                                ? AuthColors.primary
                                : const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  // ===================== STEP 2: DETAILS =====================
  Widget _buildStep2() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16.w,
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _amountController,
                  label: 'Quantity',
                  hintText: 'Quantity',
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                ),
              ),
              Expanded(
                child: _buildTextField(
                  controller: _weightController,
                  label: 'Weight (kg)',
                  hintText: 'Weight (kg)',
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          _buildLabel('Best Before / Expiration'),
          GestureDetector(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: AuthColors.primary,
                        onPrimary: Colors.white,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (date != null) {
                setState(() => _expirationDate = date);
              }
            },
            child: Container(
              height: AppDimensions.inputHeight.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Icon(AppIcons.expiry, color: AuthColors.subText, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(
                    _expirationDate == null
                        ? 'mm/dd/yyyy'
                        : '${_expirationDate!.month.toString().padLeft(2, '0')}/${_expirationDate!.day.toString().padLeft(2, '0')}/${_expirationDate!.year}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: _expirationDate == null
                          ? AuthColors.inputText
                          : AuthColors.headingText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '* We cannot accept items that have already expired.',
            style: TextStyle(fontSize: 12.sp, color: const Color(0xFF64748B)),
          ),
          SizedBox(height: 24.h),

          _buildLabel('Pickup Preference'),
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _pickupPreference = 'Home'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: _pickupPreference == 'Home'
                            ? AuthColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AppIcons.home,
                            color: _pickupPreference == 'Home'
                                ? Colors.white
                                : AuthColors.subText,
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Home',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: _pickupPreference == 'Home'
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: _pickupPreference == 'Home'
                                  ? Colors.white
                                  : AuthColors.subText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _pickupPreference = 'Public Spot'),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: _pickupPreference == 'Public Spot'
                            ? AuthColors.primary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            AppIcons.locationPin,
                            color: _pickupPreference == 'Public Spot'
                                ? Colors.white
                                : AuthColors.subText,
                            size: 18.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Public Spot',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: _pickupPreference == 'Public Spot'
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: _pickupPreference == 'Public Spot'
                                  ? Colors.white
                                  : AuthColors.subText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Interactive location picker
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel(
                AppLocalizations.of(context).addDonationLocationTitle,
              ),
              Text(
                AppLocalizations.of(context).addDonationLocationSelected,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AuthColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          AppLocationPicker(
            initialLatitude: _latitude,
            initialLongitude: _longitude,
            onLocationConfirmed: (LatLng value) {
              setState(() {
                _latitude = value.latitude;
                _longitude = value.longitude;
              });
            },
          ),
        ],
      ),
    );
  }

  // ===================== STEP 3: SAFETY & PUBLISH =====================
  Widget _buildStep3() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please confirm the following safety protocols for your cooked food donation.',
            style: GoogleFonts.openSans(
              fontSize: 14.sp,
              color: const Color(0xFF6C7F76),
              height: 1.4,
            ),
          ),
          SizedBox(height: 24.h),

          _buildCheckboxTile(
            title: 'Stored at correct temperature',
            value: _safety1,
            onChanged: (val) => setState(() => _safety1 = val!),
          ),
          _buildCheckboxTile(
            title: 'Ingredients and allergens listed',
            value: _safety2,
            onChanged: (val) => setState(() => _safety2 = val!),
          ),
          _buildCheckboxTile(
            title: 'Packaging is sealed and hygienic',
            value: _safety3,
            onChanged: (val) => setState(() => _safety3 = val!),
          ),
          SizedBox(height: 24.h),

          _buildLabel('Additional Notes (Optional)'),
          _buildTextField(
            controller: _notesController,
            hintText: 'Any pickup instructions or storage needs?',
            maxLines: 3,
          ),
          SizedBox(height: 24.h),

          // Final Review Box
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF59E0B),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Final Review',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Once published, your donation will be visible to local community centers and individuals in need.',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===================== BOTTOM ACTIONS =====================
  Widget _buildBottomActions(BuildContext context, DonationsState state) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            if (_currentStep > 0) ...[
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 52.h,
                  child: OutlinedButton(
                    onPressed: _prevStep,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFE2E8F0),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Back',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AuthColors.headingText,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
            ],
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 52.h,
                child: ElevatedButton(
                  onPressed:
                      state is DonationAddLoading ||
                          state is DonationImageUploadLoading
                      ? null
                      : () {
                          if (_currentStep == 0) {
                            if (_pickedImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please upload an image first.',
                                  ),
                                ),
                              );
                              return;
                            }
                            if (_itemNameController.text.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter an item name.'),
                                ),
                              );
                              return;
                            }
                            if (_selectedCategoryId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a category.'),
                                ),
                              );
                              return;
                            }

                            if (_uploadedAttachmentId == null) {
                              context.read<DonationsBloc>().add(
                                UploadDonationImageEvent(
                                  File(_pickedImage!.path),
                                ),
                              );
                            } else {
                              _nextStep();
                            }
                          } else if (_currentStep == 1) {
                            if (_amountController.text.isEmpty ||
                                (double.tryParse(_amountController.text) ==
                                    null)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid amount.'),
                                ),
                              );
                              return;
                            }
                            if (_weightController.text.isEmpty ||
                                (double.tryParse(_weightController.text) ==
                                    null)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid weight.'),
                                ),
                              );
                              return;
                            }
                            if (_expirationDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please set an expiration date.',
                                  ),
                                ),
                              );
                              return;
                            }
                            if (_expirationDate == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please set an expiration date.',
                                  ),
                                ),
                              );
                              return;
                            }
                            _nextStep();
                          } else if (_currentStep == 2) {
                            if (!_safety1 || !_safety2 || !_safety3) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Please confirm all safety checklists to proceed.',
                                  ),
                                ),
                              );
                              return;
                            }
                            final amountStr = _amountController.text;
                            final quantity = int.tryParse(amountStr) ?? 1;
                            final double weight = _selectedUnit == 'kg'
                                ? (double.tryParse(amountStr) ?? 1.0)
                                : 1.0;

                            context.read<DonationsBloc>().add(
                              AddDonationEvent(
                                title: _itemNameController.text,
                                description: _notesController.text.isNotEmpty
                                    ? _notesController.text
                                    : 'No additional details provided.',
                                categoryId: _selectedCategoryId!,
                                quantity: quantity,
                                foodWeightKg: weight,
                                urgency: 'HIGH',
                                mainAttachmentId: _uploadedAttachmentId!,
                                attachmentIds: [],
                                expiryDate: _expirationDate!,
                                safetyChecklistCompleted: true,
                                latitude: _latitude,
                                longitude: _longitude,
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AuthColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child:
                      state is DonationAddLoading ||
                          state is DonationImageUploadLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          _currentStep == 0 && _uploadedAttachmentId == null
                              ? 'Upload & Continue'
                              : (_currentStep == 2
                                    ? 'Publish Donation'
                                    : 'Next Step'),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===================== HELPERS =====================
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AuthColors.labelText,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    String? label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14.sp, color: AuthColors.headingText),
      decoration: InputDecoration(
        label: label != null
            ? Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AuthColors.labelText,
                ),
              )
            : null,
        hintText: hintText,
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          color: AuthColors.inputText,
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: maxLines > 1 ? 16.h : 14.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AuthColors.primary, width: 1.5),
        ),
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () => onChanged(!value),
        child: Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: value ? AuthColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(
                  color: value ? AuthColors.primary : const Color(0xFFCBD5E1),
                  width: 1.5,
                ),
              ),
              child: value
                  ? Icon(AppIcons.check, color: Colors.white, size: 16.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.openSans(
                  fontSize: 14.sp,
                  color: AuthColors.headingText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for dashed border
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double borderRadius;

  _DashedBorderPainter({required this.color, required this.borderRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    // Dash logic approximation
    double dashWidth = 8, dashSpace = 6;
    double distance = 0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
      distance = 0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
