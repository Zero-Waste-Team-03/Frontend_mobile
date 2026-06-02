import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../../core/map/map_config.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../donations/domain/entities/donation.dart';
import '../../../../core/enums/donation_status_value.dart';

class DonationDetailsFullPage extends StatefulWidget {
  final Donation donation;

  const DonationDetailsFullPage({super.key, required this.donation});

  @override
  State<DonationDetailsFullPage> createState() =>
      _DonationDetailsFullPageState();
}

class _DonationDetailsFullPageState extends State<DonationDetailsFullPage> {
  late Donation _donation;
  Offset _chatPos = const Offset(300, 500);
  final GlobalKey _stackKey = GlobalKey();
  static const double _chatButtonSize = 56;
  static const double _chatTopLimit = 116;
  static const double _chatBottomLimit = 118;
  late Color tagTextColor;
  late String _currentStyleUrl;
  late StreamSubscription<ThemeMode> _themeSubscription;

  @override
  void initState() {
    super.initState();
    _donation = widget.donation;
    _currentStyleUrl = MapConfig.styleUrl; // Default light style
    if (_donation.condition.toUpperCase() == 'DRY') {
      tagTextColor = const Color(0xFFE87C3E);
    } else if (_donation.condition.toUpperCase() == 'FRESH' ||
        _donation.condition.toUpperCase() == 'FRESH PRODUCE') {
      tagTextColor = const Color(0xFF2D6C50);
    } else {
      tagTextColor = const Color(0xFF3B82F6);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentStyleUrl = _getStyleUrl(context);
    _themeSubscription = context.read<ThemeCubit>().stream.listen((_) {
      _updateMapStyle();
    });
  }

  String _getStyleUrl(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return MapConfig.getStyleUrl(brightness);
  }

  Future<void> _updateMapStyle() async {
    final newUrl = _getStyleUrl(context);
    if (newUrl != _currentStyleUrl) {
      setState(() {
        _currentStyleUrl = newUrl;
      });
    }
  }

  @override
  void dispose() {
    _themeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    if (_chatPos == const Offset(300, 500)) {
      final size = MediaQuery.sizeOf(context);
      _chatPos = _clampChatPosition(
        Offset(size.width - 72.w, size.height - 180.h),
        size,
      );
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        key: _stackKey,
        children: [
          CustomScrollView(
            paintOrder: SliverPaintOrder.lastIsTop,
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: colors.background,
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
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ],
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
    );
  }

  Widget _buildSliverAppBar() {
    final colors = context.themeColors;
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      backgroundColor: colors.primary,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'donation_img_${_donation.id}',
              child: CachedNetworkImage(
                imageUrl: _donation.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  final colors = context.themeColors;
                  return Container(color: colors.lightGrayBackground);
                },
                errorWidget: (context, url, error) {
                  final colors = context.themeColors;
                  return Container(
                    color: colors.lightGrayBackground,
                    child: Icon(Icons.error, color: colors.divider),
                  );
                },
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
              color: colors.lightGrayBackground.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: colors.primary),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              final result = await context.push('/update-donation', extra: _donation);
              if (result == 'DELETED' && mounted) {
                context.pop();
              } else if (result is Donation && mounted) {
                setState(() {
                  _donation = result;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors.background,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.edit_rounded,
                color: colors.primary,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainInfoCard() {
    final colors = context.themeColors;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _donation.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: colors.textPrimary,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 16.sp,
                color: colors.textTertiary,
              ),
              SizedBox(width: 4.w),
              Text(
                _donation.latitude != null &&
                        _donation.longitude != null
                    ? '${_donation.latitude!.toStringAsFixed(4)}, ${_donation.longitude!.toStringAsFixed(4)}'
                    : 'Location unavailable',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: colors.textTertiary,
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
    final colors = context.themeColors;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: colors.statBackground,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colors.headingText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${_donation.quantity} units',
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
                color: colors.statBackground,
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
                        color: tagTextColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Status',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: tagTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _donation.status.toDonationStatusValue().friendlyName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: tagTextColor,
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
    final colors = context.themeColors;
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
              color: colors.headingText,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _donation.description.isEmpty
                ? 'No additional description provided.'
                : _donation.description,
            style: TextStyle(
              fontSize: 14.sp,
              color: colors.subText,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostedBySection() {
    final colors = context.themeColors;
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
              color: colors.headingText,
            ),
          ),
          SizedBox(height: 12.h),
          _OwnerCard(donation: _donation),
        ],
      ),
    );
  }

  Widget _buildPickupLocationSection() {
    final colors = context.themeColors;
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
                  color: colors.headingText,
                ),
              ),
              Text(
                _donation.latitude != null &&
                        _donation.longitude != null
                    ? 'Lat ${_donation.latitude!.toStringAsFixed(3)}, Lng ${_donation.longitude!.toStringAsFixed(3)}'
                    : 'Coordinates unavailable',
                style: TextStyle(fontSize: 12.sp, color: colors.subText),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _LocationMapCard(donation: _donation),
        ],
      ),
    );
  }

  Widget _buildChatButtonUI({required bool isDragging}) {
    final colors = context.themeColors;
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
            color: colors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: colors.primary.withValues(alpha: 0.3),
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

  Offset _clampChatPosition(Offset raw, Size size) {
    final maxX = size.width - _chatButtonSize;
    final maxY = size.height - _chatBottomLimit;
    final dx = raw.dx.clamp(0.0, maxX);
    final dy = raw.dy.clamp(_chatTopLimit, maxY);
    return Offset(dx, dy);
  }
}

class _OwnerCard extends StatelessWidget {
  final Donation donation;

  const _OwnerCard({required this.donation});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          donation.authorDetails != null &&
                  donation.authorDetails!.avatarUrl != null &&
                  donation.authorDetails!.avatarUrl!.isNotEmpty
              ? CircleAvatar(
                  radius: 20.r,
                  backgroundColor: colors.primary.withValues(alpha: 0.15),
                  backgroundImage: CachedNetworkImageProvider(
                    donation.authorDetails!.avatarUrl!,
                  ),
                )
              : CircleAvatar(
                  radius: 20.r,
                  backgroundColor: colors.primary.withValues(alpha: 0.15),
                  child: Icon(
                    Icons.person_rounded,
                    color: colors.primary,
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
                    color: colors.headingText,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Posted on ${donation.createdAt.toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 12.sp, color: colors.subText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LocationMapCard extends StatefulWidget {
  final Donation donation;

  const _LocationMapCard({required this.donation});

  @override
  State<_LocationMapCard> createState() => _LocationMapCardState();
}

class _LocationMapCardState extends State<_LocationMapCard> {
  late String _currentStyleUrl;
  late StreamSubscription<ThemeMode> _themeSubscription;

  @override
  void initState() {
    super.initState();
    _currentStyleUrl = MapConfig.styleUrl; // Default light style
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentStyleUrl = _getStyleUrl(context);
    _themeSubscription = context.read<ThemeCubit>().stream.listen((_) {
      _updateMapStyle();
    });
  }

  String _getStyleUrl(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return MapConfig.getStyleUrl(brightness);
  }

  void _updateMapStyle() {
    final newUrl = _getStyleUrl(context);
    if (newUrl != _currentStyleUrl) {
      setState(() {
        _currentStyleUrl = newUrl;
      });
    }
  }

  @override
  void dispose() {
    _themeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final hasLocation =
        widget.donation.latitude != null && widget.donation.longitude != null;
    final target = hasLocation
        ? LatLng(widget.donation.latitude!, widget.donation.longitude!)
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
              styleString: _currentStyleUrl,
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
                color: colors.primary,
                size: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
