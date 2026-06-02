import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/donation.dart';
import '../bloc/donations_bloc.dart';
import '../bloc/donations_event.dart';
import '../bloc/donations_state.dart';

class UpdateDeleteDonationPage extends StatefulWidget {
  final Donation donation;

  const UpdateDeleteDonationPage({super.key, required this.donation});

  @override
  State<UpdateDeleteDonationPage> createState() => _UpdateDeleteDonationPageState();
}

class _UpdateDeleteDonationPageState extends State<UpdateDeleteDonationPage> {
  late final TextEditingController _itemNameController;
  late final TextEditingController _quantityController;
  late final TextEditingController _descriptionController;
  DateTime? _expiryDate;

  @override
  void initState() {
    super.initState();
    _itemNameController = TextEditingController(text: widget.donation.title);
    _quantityController = TextEditingController(text: widget.donation.quantity.toString());
    _descriptionController = TextEditingController(text: widget.donation.description);
    _expiryDate = widget.donation.expiryDate;
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _getRelativeTime(DateTime? date) {
    if (date == null) return 'Unknown';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return 'Added ${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return 'Added ${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return 'Added ${difference.inMinutes} minutes ago';
    } else {
      return 'Added just now';
    }
  }

  Future<void> _selectExpiryDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _expiryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.themeColors.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _expiryDate) {
      setState(() {
        _expiryDate = picked;
      });
    }
  }

  void _onUpdate() {
    final title = _itemNameController.text.trim();
    final quantity = int.tryParse(_quantityController.text.trim()) ?? 0;
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Item name cannot be empty')),
      );
      return;
    }

    context.read<DonationsBloc>().add(
          UpdateDonationEvent(
            id: widget.donation.id,
            title: title,
            quantity: quantity,
            description: description,
            expiryDate: _expiryDate,
          ),
        );
  }

  void _onDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Listing'),
        content: const Text('Are you sure you want to delete this listing? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<DonationsBloc>().add(DeleteDonationEvent(widget.donation.id));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return BlocListener<DonationsBloc, DonationsState>(
      listener: (context, state) {
        if (state is DonationUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: const Text('Donation updated successfully'),
              backgroundColor: colors.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.pop(state.donation);
        } else if (state is DonationUpdateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is DonationDeleteSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: const Text('Donation deleted successfully'),
              backgroundColor: colors.primary,
              behavior: SnackBarBehavior.floating,
            ),
          );
          context.pop('DELETED');
        } else if (state is DonationDeleteError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF6F7F7),
          elevation: 0,
          leading: Center(
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: colors.primary, size: 20.sp),
              onPressed: () => context.pop(),
            ),
          ),
          title: Text(
            'Donation',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: colors.primary,
              letterSpacing: -0.45,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Item Selection Card
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFBBCCBF).withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 24,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          imageUrl: widget.donation.imageUrl,
                          width: 96.w,
                          height: 96.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: const Color(0xFFEDEEEF)),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Current Listing',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: colors.primary,
                                letterSpacing: 0.65,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              widget.donation.title,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF191C1D),
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _getRelativeTime(widget.donation.createdAt),
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF3C4A42),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Form
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Item Name'),
                    SizedBox(height: 8.h),
                    _buildTextField(
                      controller: _itemNameController,
                      hint: '3x Sesame Bagels',
                    ),
                    SizedBox(height: 24.h),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Quantity'),
                              SizedBox(height: 8.h),
                              _buildQuantityField(),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel('Expiry Time'),
                              SizedBox(height: 8.h),
                              _buildExpiryField(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    _buildLabel('Description (Optional)'),
                    SizedBox(height: 8.h),
                    _buildTextField(
                      controller: _descriptionController,
                      hint: 'Freshly baked this morning...',
                      maxLines: 4,
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Action Buttons
                BlocBuilder<DonationsBloc, DonationsState>(
                  builder: (context, state) {
                    final isLoading = state is DonationUpdateLoading || state is DonationDeleteLoading;

                    return Column(
                      children: [
                        ElevatedButton(
                          onPressed: isLoading ? null : _onUpdate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 56.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.r),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading && state is DonationUpdateLoading
                              ? SizedBox(
                                  width: 24.w,
                                  height: 24.w,
                                  child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/donations/update_check.svg',
                                      width: 18.w,
                                      height: 18.w,
                                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Update Donation',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: isLoading ? null : () => context.pop(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFE7E8E9),
                                  foregroundColor: const Color(0xFF3C4A42),
                                  minimumSize: Size(double.infinity, 56.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: isLoading || widget.donation.isDeletable == false ? null : _onDelete,
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: widget.donation.isDeletable == false
                                      ? Colors.grey.shade100
                                      : const Color(0xFFFFDAD6).withValues(alpha: 0.2),
                                  side: BorderSide(
                                    color: widget.donation.isDeletable == false
                                        ? Colors.grey.shade300
                                        : const Color(0xFFBA1A1A),
                                    width: 0.2,
                                  ),
                                  foregroundColor: widget.donation.isDeletable == false
                                      ? Colors.grey
                                      : const Color(0xFFBA1A1A),
                                  minimumSize: Size(double.infinity, 56.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.r),
                                  ),
                                ),
                                child: isLoading && state is DonationDeleteLoading
                                    ? SizedBox(
                                        width: 24.w,
                                        height: 24.w,
                                        child: const CircularProgressIndicator(color: Color(0xFFBA1A1A), strokeWidth: 2),
                                      )
                                    : FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/donations/delete_trash.svg',
                                              width: 12.w,
                                              height: 13.5.h,
                                              colorFilter: ColorFilter.mode(
                                                widget.donation.isDeletable == false
                                                    ? Colors.grey
                                                    : const Color(0xFFBA1A1A),
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(width: 6.w),
                                            Text(
                                              'Delete Listing',
                                              style: GoogleFonts.plusJakartaSans(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF3C4A42),
        letterSpacing: 0.65,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBBCCBF).withValues(alpha: 1),
            blurRadius: 0,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF191C1D),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF191C1D).withValues(alpha: 0.5),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.w),
        ),
      ),
    );
  }

  Widget _buildQuantityField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFBBCCBF).withValues(alpha: 1),
            blurRadius: 0,
            spreadRadius: 1,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF191C1D),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16.w),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Text(
              'units',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF3C4A42),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryField() {
    final dateStr = _expiryDate != null ? DateFormat('HH:mm').format(_expiryDate!) + ' Today' : 'Select Date';

    return GestureDetector(
      onTap: _selectExpiryDate,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFBBCCBF).withValues(alpha: 1),
              blurRadius: 0,
              spreadRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                dateStr,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF191C1D),
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/donations/expiry_calendar.svg',
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(context.themeColors.primary, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}
