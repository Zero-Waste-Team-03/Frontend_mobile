import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspzero/core/di/injection.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../donations/domain/entities/donation.dart';
import '../widgets/status_badge.dart';
import '../widgets/reservation_confirmed_dialog.dart';
import '../widgets/api_error_dialog.dart';
import '../bloc/reservation_bloc.dart';
import '../bloc/reservation_event.dart';
import '../bloc/reservation_state.dart';
import 'dart:convert';

class DonationDetailsFullPage extends StatefulWidget {
  final Donation donation;

  const DonationDetailsFullPage({super.key, required this.donation});

  @override
  State<DonationDetailsFullPage> createState() =>
      _DonationDetailsFullPageState();
}

class _DonationDetailsFullPageState extends State<DonationDetailsFullPage> {
  final TextEditingController _reserveQuantityController =
      TextEditingController(text: '1');
  String? _reserveQuantityError;

  @override
  void dispose() {
    _reserveQuantityController.dispose();
    super.dispose();
  }

  int? _validateReserveQuantity() {
    final raw = _reserveQuantityController.text.trim();
    final parsed = int.tryParse(raw);

    if (parsed == null) {
      setState(() {
        _reserveQuantityError = 'Enter a valid quantity';
      });
      return null;
    }

    if (parsed <= 0) {
      setState(() {
        _reserveQuantityError = 'Please enter a valid quantity';
      });
      return null;
    }

    if (parsed > widget.donation.quantity) {
      setState(() {
        _reserveQuantityError =
            'Only ${widget.donation.quantity} units available';
      });
      return null;
    }

    setState(() {
      _reserveQuantityError = null;
    });
    return parsed;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReservationBloc>(),
      child: BlocListener<ReservationBloc, ReservationState>(
        listener: (context, state) {
          if (state is ReservationCreated) {
            showReservationConfirmedDialog(
              context,
              onDismiss: () {
                Navigator.of(context).pop();
              },
              donationTitle: widget.donation.title,
              expiryAt: state.reservation.expiresAt != null
                  ? state.reservation.expiresAt!.toLocal().toString().split(
                      '.',
                    )[0]
                  : null,
            );
          } else if (state is ReservationCreationError) {
            _showErrorDialog(context, state.message);
          }
        },
        child: Scaffold(
          backgroundColor: AuthColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AuthColors.headingText),
              onPressed: () => context.pop(),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: AppDimensions.paddingMedium.w),
                child: IconButton(
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: AuthColors.primary,
                    size: AppDimensions.iconSize.sp,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: AuthColors.lightGrayBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    context.push('/notifications');
                  },
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Image
                  Container(
                    width: double.infinity,
                    height: 250.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.donation.imageUrl),
                        fit: BoxFit.cover,
                        onError: (_, __) {},
                      ),
                    ),
                    child: widget.donation.imageUrl.isEmpty
                        ? Container(
                            color: AuthColors.lightGrayBackground,
                            child: Icon(
                              Icons.image_not_supported,
                              color: AuthColors.inputText,
                              size: 48.sp,
                            ),
                          )
                        : null,
                  ),

                  // Content
                  Container(
                    padding: EdgeInsets.all(AppDimensions.paddingLarge.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.donation.title,
                                style: TextStyle(
                                  fontSize: AppDimensions.titleSize.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AuthColors.headingText,
                                  fontFamily: AppFonts.primaryFont,
                                ),
                              ),
                            ),
                            SizedBox(width: AppDimensions.paddingMedium.w),
                            StatusBadge(
                              status: widget.donation.status,
                              label: _getStatusLabel(widget.donation.status),
                            ),
                          ],
                        ),
                        SizedBox(height: AppDimensions.paddingLarge.h),

                        // Donation Details
                        _DetailRow(
                          icon: Icons.category,
                          label: 'Category',
                          value: widget.donation.category?.name ?? 'N/A',
                        ),
                        SizedBox(height: AppDimensions.paddingMedium.h),

                        _DetailRow(
                          icon: Icons.shopping_bag,
                          label: 'Quantity',
                          value: '${widget.donation.quantity} items',
                        ),
                        SizedBox(height: AppDimensions.paddingMedium.h),

                        _DetailRow(
                          icon: Icons.info_outline,
                          label: 'Condition',
                          value: widget.donation.condition,
                        ),
                        SizedBox(height: AppDimensions.paddingLarge.h),

                        // Description
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: AppDimensions.subtitleSize.sp,
                            fontWeight: FontWeight.bold,
                            color: AuthColors.headingText,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                        SizedBox(height: AppDimensions.paddingMedium.h),

                        Text(
                          widget.donation.description,
                          style: TextStyle(
                            fontSize: AppDimensions.bodySize.sp,
                            color: AuthColors.subText,
                            fontFamily: AppFonts.primaryFont,
                            height: 1.6,
                          ),
                        ),
                        SizedBox(height: AppDimensions.paddingLarge.h),

                        // Donor Info
                        Text(
                          'Donor',
                          style: TextStyle(
                            fontSize: AppDimensions.subtitleSize.sp,
                            fontWeight: FontWeight.bold,
                            color: AuthColors.headingText,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                        SizedBox(height: AppDimensions.paddingMedium.h),

                        Container(
                          padding: EdgeInsets.all(
                            AppDimensions.paddingMedium.w,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusMedium,
                            ),
                            border: Border.all(color: AuthColors.dividerColor),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 48.w,
                                height: 48.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AuthColors.lightGrayBackground,
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: AuthColors.inputText,
                                ),
                              ),
                              SizedBox(width: AppDimensions.paddingMedium.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.donation.author,
                                      style: TextStyle(
                                        fontSize: AppDimensions.bodySize.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AuthColors.headingText,
                                        fontFamily: AppFonts.primaryFont,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Verified Donor',
                                      style: TextStyle(
                                        fontSize: AppDimensions.captionSize.sp,
                                        color: AuthColors.subText,
                                        fontFamily: AppFonts.primaryFont,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: AppDimensions.paddingLarge.h),

                        Text(
                          'Reserve Quantity',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AuthColors.labelText,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextField(
                          controller: _reserveQuantityController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: false,
                            signed: false,
                          ),
                          onChanged: (_) {
                            if (_reserveQuantityError != null) {
                              _validateReserveQuantity();
                            }
                          },
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AuthColors.headingText,
                            fontFamily: AppFonts.primaryFont,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Quantity',
                            errorText: _reserveQuantityError,
                            filled: true,
                            fillColor: const Color(0xFFF8FAFC),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 14.h,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                color: Color(0xFFE2E8F0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: const BorderSide(
                                color: Color(0xFFE2E8F0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: AuthColors.primary,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Available quantity: ${widget.donation.quantity} items',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF64748B),
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                        SizedBox(height: AppDimensions.paddingLarge.h),

                        // Action Button
                        if (widget.donation.status == 'PUBLISHED')
                          SizedBox(
                            width: double.infinity,
                            child: BlocBuilder<ReservationBloc, ReservationState>(
                              builder: (context, state) {
                                final isReserving =
                                    state is ReservationCreating;
                                return ElevatedButton(
                                  onPressed:
                                      isReserving ||
                                          widget.donation.quantity <= 0
                                      ? null
                                      : () {
                                          final quantity =
                                              _validateReserveQuantity();
                                          if (quantity == null) {
                                            return;
                                          }
                                          context.read<ReservationBloc>().add(
                                            CreateReservationEvent(
                                              donationId: widget.donation.id,
                                              quantity: quantity,
                                            ),
                                          );
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AuthColors.primary,
                                    padding: EdgeInsets.symmetric(
                                      vertical: AppDimensions.paddingMedium.h,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppDimensions.borderRadiusLarge,
                                      ),
                                    ),
                                  ),
                                  child: isReserving
                                      ? SizedBox(
                                          height: 20.h,
                                          width: 20.w,
                                          child:
                                              const CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(Colors.white),
                                                strokeWidth: 2,
                                              ),
                                        )
                                      : Text(
                                          'Reserve Now',
                                          style: TextStyle(
                                            fontSize:
                                                AppDimensions.buttonTextSize.sp,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontFamily: AppFonts.primaryFont,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    // Try to parse error message if it's a JSON error response
    String displayMessage = errorMessage;
    String? statusCode;
    String? timestamp;

    try {
      // Check if error message contains JSON
      if (errorMessage.contains('{') && errorMessage.contains('}')) {
        final jsonStr = errorMessage.substring(
          errorMessage.indexOf('{'),
          errorMessage.lastIndexOf('}') + 1,
        );
        final jsonData = jsonDecode(jsonStr);

        displayMessage = jsonData['message'] ?? errorMessage;
        statusCode = jsonData['statusCode']?.toString() ?? 'Unknown';
        timestamp = jsonData['timestamp'];
      }
    } catch (e) {
      // If parsing fails, use the original message
      displayMessage = errorMessage;
    }

    showApiErrorDialog(
      context,
      message: displayMessage,
      statusCode: statusCode,
      timestamp: timestamp,
      onRetry: () {
        final quantity = _validateReserveQuantity();
        if (quantity == null) {
          return;
        }
        context.read<ReservationBloc>().add(
          CreateReservationEvent(
            donationId: widget.donation.id,
            quantity: quantity,
          ),
        );
      },
    );
  }

  String _getStatusLabel(String status) {
    switch (status.toUpperCase()) {
      case 'ACTIVE':
      case 'PUBLISHED':
        return 'ACTIVE';
      case 'RESERVED':
        return 'RESERVED';
      case 'COMPLETED':
        return 'COMPLETED';
      case 'EXPIRED':
      case 'DRAFT':
        return 'EXPIRED';
      default:
        return status;
    }
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AuthColors.primary, size: AppDimensions.iconSize.sp),
        SizedBox(width: AppDimensions.paddingMedium.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.captionSize.sp,
                color: AuthColors.labelText,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              value,
              style: TextStyle(
                fontSize: AppDimensions.bodySize.sp,
                color: AuthColors.subText,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
