import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/map/map_config.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../reservation/presentation/bloc/reservation_bloc.dart';
import '../../../reservation/presentation/bloc/reservation_event.dart';
import '../../../reservation/presentation/bloc/reservation_state.dart';
import '../../../reservation/presentation/widgets/api_error_dialog.dart';
import '../../../reservation/presentation/widgets/reservation_pending_dialog.dart';
import '../../domain/entities/donation.dart';

class DonationDetailsPage extends StatefulWidget {
  final Donation donation;

  const DonationDetailsPage({super.key, required this.donation});

  @override
  State<DonationDetailsPage> createState() => _DonationDetailsPageState();
}

class _DonationDetailsPageState extends State<DonationDetailsPage> {
  late Color tagBgColor;
  late Color tagTextColor;

  Offset _chatPos = const Offset(300, 500);

  @override
  void initState() {
    super.initState();
    if (widget.donation.condition.toUpperCase() == 'DRY') {
      tagBgColor = const Color(0xFFFFF0E6);
      tagTextColor = const Color(0xFFE87C3E);
    } else if (widget.donation.condition.toUpperCase() == 'FRESH' ||
        widget.donation.condition.toUpperCase() == 'FRESH PRODUCE') {
      tagBgColor = const Color(0xFFE6F7ED);
      tagTextColor = const Color(0xFF2D6C50);
    } else {
      tagBgColor = const Color(0xFFE6F0FF);
      tagTextColor = const Color(0xFF3B82F6);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_chatPos == const Offset(300, 500)) {
      final size = MediaQuery.sizeOf(context);
      _chatPos = Offset(size.width - 72.w, size.height - 180.h);
    }

    return BlocProvider(
      create: (context) => getIt<ReservationBloc>(),
      child: BlocListener<ReservationBloc, ReservationState>(
        listener: (context, state) {
          if (state is ReservationCreated) {
            showReservationPendingDialog(
              context,
              onDismiss: () {
                Navigator.of(context).pop();
              },
              donationTitle: widget.donation.title,
            );
          } else if (state is ReservationCreationError) {
            _showErrorDialog(context, state.message);
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: Stack(
            children: [
              CustomScrollView(
                paintOrder: SliverPaintOrder.lastIsTop,
                slivers: [
                  _buildSliverAppBar(),
                  SliverToBoxAdapter(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24.r),
                        ),
                      ),
                      transform: Matrix4.translationValues(0, -32.h, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildMainInfoCard(),
                          _buildKeyMetricsRow(),
                          _buildDescriptionSection(),
                          _buildPostedBySection(),
                          _buildPickupLocationSection(),
                          SizedBox(height: 120.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade200, width: 1),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        Container(
                          width: 56.w,
                          height: 56.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AuthColors.primary,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.chat_bubble_outline_rounded,
                              color: AuthColors.primary,
                              size: 24.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: BlocBuilder<ReservationBloc, ReservationState>(
                            builder: (context, state) {
                              final isReserving = state is ReservationCreating;
                              return ElevatedButton(
                                onPressed: isReserving
                                    ? null
                                    : () {
                                        context.read<ReservationBloc>().add(
                                          CreateReservationEvent(
                                            donationId: widget.donation.id,
                                          ),
                                        );
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AuthColors.primary,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                child: isReserving
                                    ? SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        'Reserve Now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _chatPos.dx,
                top: _chatPos.dy,
                child: Draggable(
                  feedback: _buildChatButtonUI(isDragging: true),
                  childWhenDragging: const SizedBox.shrink(),
                  onDragEnd: (details) {
                    setState(() {
                      double dx = details.offset.dx;
                      double dy = details.offset.dy;
                      final screenSize = MediaQuery.sizeOf(context);
                      if (dx < 0) dx = 0;
                      if (dx > screenSize.width - 64) {
                        dx = screenSize.width - 64;
                      }
                      if (dy < kToolbarHeight) dy = kToolbarHeight;
                      if (dy > screenSize.height - 100) {
                        dy = screenSize.height - 100;
                      }
                      _chatPos = Offset(dx, dy);
                    });
                  },
                  child: _buildChatButtonUI(isDragging: false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    String displayMessage = errorMessage;
    String? statusCode;
    String? timestamp;

    try {
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
    } catch (_) {
      displayMessage = errorMessage;
    }

    showApiErrorDialog(
      context,
      message: displayMessage,
      statusCode: statusCode,
      timestamp: timestamp,
      onRetry: () {
        context.read<ReservationBloc>().add(
          CreateReservationEvent(donationId: widget.donation.id),
        );
      },
    );
  }

  Widget _buildChatButtonUI({required bool isDragging}) {
    return GestureDetector(
      onTap: () {
        context.push('/chats');
      },
      child: Material(
        color: Colors.transparent,
        elevation: isDragging ? 10 : 6,
        shape: const CircleBorder(),
        child: Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            color: AuthColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AuthColors.primary.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      backgroundColor: AuthColors.primary,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'donation_img_${widget.donation.id}',
              child: CachedNetworkImage(
                imageUrl: widget.donation.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    Container(color: Colors.grey[200]),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[200],
                  child: const Icon(Icons.error, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF131615).withValues(alpha: 0.4),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              context.push('/notifications');
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF131615).withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF131615).withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.share_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF131615).withValues(alpha: 0.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainInfoCard() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.donation.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF131615),
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: const Color(0xFF64748B),
              ),
              SizedBox(width: 4.w),
              Text(
                widget.donation.latitude != null &&
                        widget.donation.longitude != null
                    ? '${widget.donation.latitude!.toStringAsFixed(4)}, ${widget.donation.longitude!.toStringAsFixed(4)}'
                    : 'Location unavailable',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMetricsRow() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF15803D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${widget.donation.quantity} units',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF15803D),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 14.sp,
                        color: const Color(0xFFEA580C),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFFEA580C),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.donation.status,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFFEA580C),
                      fontWeight: FontWeight.w700,
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

  Widget _buildDescriptionSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF131615),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            widget.donation.description.isEmpty
                ? 'No additional description provided by donor.'
                : widget.donation.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF4A5550),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostedBySection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Posted By',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF131615),
            ),
          ),
          SizedBox(height: 12.h),
          _OwnerCard(donation: widget.donation),
        ],
      ),
    );
  }

  Widget _buildPickupLocationSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pickup Location',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF131615),
                ),
              ),
              Text(
                widget.donation.latitude != null &&
                        widget.donation.longitude != null
                    ? 'Lat ${widget.donation.latitude!.toStringAsFixed(3)}, Lng ${widget.donation.longitude!.toStringAsFixed(3)}'
                    : 'Coordinates unavailable',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _LocationMapCard(donation: widget.donation),
        ],
      ),
    );
  }
}

class _OwnerCard extends StatelessWidget {
  final Donation donation;

  const _OwnerCard({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AuthColors.primary.withValues(alpha: 0.15),
            child: Icon(
              Icons.person_rounded,
              color: AuthColors.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donation.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF131615),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  donation.status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationMapCard extends StatelessWidget {
  final Donation donation;

  const _LocationMapCard({required this.donation});

  @override
  Widget build(BuildContext context) {
    final hasLocation = donation.latitude != null && donation.longitude != null;
    final target = hasLocation
        ? LatLng(donation.latitude!, donation.longitude!)
        : MapConfig.defaultTarget;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: SizedBox(
        height: 120.h,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            MapLibreMap(
              styleString: MapConfig.styleUrl,
              initialCameraPosition: MapConfig.cameraPosition(
                target: target,
                zoom: hasLocation ? 14 : MapConfig.defaultZoom,
              ),
              compassEnabled: false,
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              tiltGesturesEnabled: false,
              attributionButtonMargins: Point<double>(12.w, 12.h),
            ),
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.location_on,
                color: AuthColors.primary,
                size: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
