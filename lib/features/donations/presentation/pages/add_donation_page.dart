import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/theme/app_colors.dart';

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
  String _selectedCategory = 'Fresh'; // Fresh, Dry Goods, Cooked, Bakery

  // Step 2 Data
  final TextEditingController _amountController = TextEditingController();
  String _selectedUnit = 'Items/Units';
  String _pickupPreference = 'Home'; // Home, Public Spot
  DateTime? _expirationDate;

  // Step 3 Data
  bool _safety1 = false;
  bool _safety2 = false;
  bool _safety3 = false;
  final TextEditingController _notesController = TextEditingController();

  final List<String> _categories = ['Fresh', 'Dry Goods', 'Cooked', 'Bakery'];
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
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded,
              color: AuthColors.headingText, size: 24.sp),
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
              physics:
                  const NeverScrollableScrollPhysics(), // Disable swipe to force using buttons
              onPageChanged: (index) {
                setState(() {
                  _currentStep = index;
                });
              },
              children: [
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActions(),
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
            onTap: () async {
              final picker = ImagePicker();
              await picker.pickImage(source: ImageSource.gallery);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 32.h),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                    color: const Color(0xFFCBD5E1),
                    width: 2,
                    style: BorderStyle.none),
              ),
              child: CustomPaint(
                painter: _DashedBorderPainter(
                    color: const Color(0xFF94A3B8), borderRadius: 12.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color:
                            AuthColors.primary.withOpacity(0.1), // 10% opacity
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/donations/upload_photo.svg',
                        width: 26.sp,
                        height: 26.sp,
                        colorFilter: ColorFilter.mode(
                            AuthColors.primary, BlendMode.srcIn),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Upload Photo',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AuthColors.headingText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Add a clear photo of the food item',
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
              hintText: 'e.g., Fresh Sourdough Bread'),
          SizedBox(height: 24.h),

          // Category Selection
          _buildLabel('Category'),
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
              final isSelected = _selectedCategory == _categories[index];
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedCategory = _categories[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AuthColors.primary.withOpacity(0.1)
                        : const Color(0xFFF1F5F9),
                    border: Border.all(
                      color:
                          isSelected ? AuthColors.primary : Colors.transparent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        _categoryIcons[index],
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
                        _categories[index],
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w600,
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
            children: [
              Expanded(
                flex: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Amount'),
                    _buildTextField(
                        controller: _amountController,
                        hintText: '1',
                        keyboardType: TextInputType.number),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                flex: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Unit'),
                    DropdownButtonFormField<String>(
                      value: _selectedUnit,
                      icon: Icon(Icons.keyboard_arrow_down_rounded,
                          color: AuthColors.subText),
                      style: TextStyle(
                          fontSize: 14.sp, color: AuthColors.headingText),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFF8FAFC),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 14.h),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                                color: AuthColors.primary, width: 1.5)),
                      ),
                      items:
                          ['Items/Units', 'kg', 'Liters'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AuthColors.headingText)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedUnit = val);
                      },
                    ),
                  ],
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
                  Icon(Icons.calendar_today_rounded,
                      color: AuthColors.subText, size: 20.sp),
                  SizedBox(width: 12.w),
                  Text(
                    _expirationDate == null
                        ? 'mm/dd/yyyy'
                        : '${_expirationDate!.month.toString().padLeft(2, '0')}/${_expirationDate!.day.toString().padLeft(2, '0')}/${_expirationDate!.year}',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: _expirationDate == null
                            ? AuthColors.inputText
                            : AuthColors.headingText),
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
                          Icon(Icons.home_rounded,
                              color: _pickupPreference == 'Home'
                                  ? Colors.white
                                  : AuthColors.subText,
                              size: 18.sp),
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
                          Icon(Icons.location_on_rounded,
                              color: _pickupPreference == 'Public Spot'
                                  ? Colors.white
                                  : AuthColors.subText,
                              size: 18.sp),
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

          // Pickup Location Map Placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel('Pickup Location'),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Opening Location Picker...')),
                  );
                },
                child: Text('Change',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AuthColors.primary)),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening Maps...')),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  // Map placeholder (clip)
                  Container(
                    height: 120.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E8F0),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12.r)),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            top: 40.h,
                            right: -20,
                            left: -20,
                            child: Container(height: 8.h, color: Colors.white)),
                        Positioned(
                            top: -20,
                            bottom: -20,
                            right: 100.w,
                            child: Container(width: 8.w, color: Colors.white)),
                        Icon(Icons.location_on,
                            color: AuthColors.primary, size: 48.sp),
                      ],
                    ),
                  ),
                  // Address Field
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.my_location_rounded,
                            color: AuthColors.subText, size: 20.sp),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            '742 Evergreen Terrace, Springfield',
                            style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: AuthColors.headingText,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                fontSize: 14.sp, color: const Color(0xFF6C7F76), height: 1.4),
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
                      height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===================== BOTTOM ACTIONS =====================
  Widget _buildBottomActions() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -4)),
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
                      side:
                          const BorderSide(color: Color(0xFFE2E8F0), width: 2),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text('Back',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AuthColors.headingText)),
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
                  onPressed: () {
                    if (_currentStep < 2) {
                      _nextStep();
                    } else {
                      // Publish
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text('Donation published successfully!'),
                          backgroundColor: AuthColors.primary,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AuthColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text(
                    _currentStep == 2 ? 'Publish Donation' : 'Next Step',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14.sp, color: AuthColors.headingText),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            GoogleFonts.inter(fontSize: 14.sp, color: AuthColors.inputText),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w, vertical: maxLines > 1 ? 16.h : 14.h),
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
                    width: 1.5),
              ),
              child: value
                  ? Icon(Icons.check, color: Colors.white, size: 16.sp)
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    color: AuthColors.headingText,
                    fontWeight: FontWeight.w500),
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
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius)));

    // Dash logic approximation
    double dashWidth = 8, dashSpace = 6;
    double distance = 0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        canvas.drawPath(
            pathMetric.extractPath(distance, distance + dashWidth), paint);
        distance += dashWidth + dashSpace;
      }
      distance = 0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
