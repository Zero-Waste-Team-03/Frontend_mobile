import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/map/map_config.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../favorites/domain/repositories/favorites_repository.dart';
import '../../../reservation/presentation/bloc/reservation_bloc.dart';
import '../../../reservation/presentation/bloc/reservation_event.dart';
import '../../../reservation/presentation/bloc/reservation_state.dart';
import '../../../reservation/presentation/widgets/api_error_dialog.dart';
import '../../../reservation/presentation/widgets/reservation_confirmed_dialog.dart';
import '../../domain/entities/donation.dart';

class DonationDetailsPage extends StatefulWidget {
  final Donation donation;

  const DonationDetailsPage({super.key, required this.donation});

  @override
  State<DonationDetailsPage> createState() => _DonationDetailsPageState();
}

class _DonationDetailsPageState extends State<DonationDetailsPage> {
  late Color tagTextColor;
  late bool _isLiked;
  bool _isLikeUpdating = false;
  final TextEditingController _reserveQuantityController =
      TextEditingController(text: '1');
  String? _reserveQuantityError;

  Offset _chatPos = const Offset(300, 500);
  final GlobalKey _stackKey = GlobalKey();
  static const double _chatButtonSize = 56;
  static const double _chatTopLimit = 116;
  static const double _chatBottomLimit = 118;

  late String _currentStyleUrl;
  late StreamSubscription<ThemeMode> _themeSubscription;

  @override
  void initState() {
    super.initState();
    _currentStyleUrl = MapConfig.styleUrl; // Default light style
    _isLiked = widget.donation.isLikedByMe ?? false;
    if (widget.donation.condition.toUpperCase() == 'DRY') {
      tagTextColor = const Color(0xFFE87C3E);
    } else if (widget.donation.condition.toUpperCase() == 'FRESH' ||
        widget.donation.condition.toUpperCase() == 'FRESH PRODUCE') {
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
    _reserveQuantityController.dispose();
    _themeSubscription.cancel();
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

  Future<void> _toggleFavorite() async {
    if (_isLikeUpdating) {
      return;
    }

    setState(() => _isLikeUpdating = true);

    try {
      final favoritesRepository = getIt<FavoritesRepository>();
      if (_isLiked) {
        await favoritesRepository.unlikeDonation(widget.donation.id);
      } else {
        await favoritesRepository.likeDonation(widget.donation.id);
      }

      if (!mounted) {
        return;
      }

      setState(() => _isLiked = !_isLiked);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update favorite: $e'),
          backgroundColor: context.themeColors.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLikeUpdating = false);
      }
    }
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
                  : 'N/A',
              reservation_id: state.reservation.id,
            );
          } else if (state is ReservationCreationError) {
            _showErrorDialog(context, state.message);
          }
        },
        child: Scaffold(
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
                          _buildReserveQuantitySection(),
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
                    color: colors.background,
                    border: Border(
                      top: BorderSide(color: colors.border, width: 1),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        SizedBox(width: 16.w),
                        Expanded(
                          child: BlocBuilder<ReservationBloc, ReservationState>(
                            builder: (context, state) {
                              final isReserving = state is ReservationCreating;
                              return ElevatedButton(
                                onPressed:
                                    isReserving ||
                                        widget.donation.quantity <= 0 ||
                                        widget.donation.isReservable == false
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
                                  backgroundColor: colors.primary,
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                ),
                                child: isReserving
                                    ? SizedBox(
                                        height: 20.h,
                                        width: 20.w,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                colors.onPrimary,
                                              ),
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(
                                        'Reserve Now',
                                        style: TextStyle(
                                          color: colors.onPrimary,
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

  Widget _buildReserveQuantitySection() {
    final colors = context.themeColors;
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reserve Quantity',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: colors.headingText,
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
            style: TextStyle(fontSize: 14.sp, color: colors.headingText),
            decoration: InputDecoration(
              hintText: 'Quantity',
              hintStyle: TextStyle(fontSize: 14.sp, color: colors.headingText),
              errorText: _reserveQuantityError,
              filled: true,
              fillColor: colors.inputBackground,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.background),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.background),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(color: colors.primary, width: 1.5),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Available quantity: ${widget.donation.quantity} items',
            style: TextStyle(fontSize: 12.sp, color: colors.subText),
          ),
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
              color: colors.onPrimary,
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
              tag: 'donation_img_${widget.donation.id}',
              child: CachedNetworkImage(
                imageUrl: widget.donation.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: colors.border),
                errorWidget: (context, url, error) => Container(
                  color: colors.border,
                  child: Icon(Icons.error, color: colors.border),
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
              color: colors.lightGrayBackground.withValues(alpha: 0.7),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_back, color: colors.onBackground),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
          child: GestureDetector(
            onTap: _toggleFavorite,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colors.lightGrayBackground.withValues(alpha: 0.7),
                shape: BoxShape.circle,
              ),
              child: _isLikeUpdating
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        color: colors.primary,
                        strokeWidth: 2,
                      ),
                    )
                  : Icon(
                      _isLiked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: _isLiked
                          ? const Color(0xFFFF6B6B)
                          : colors.onBackground,
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
            widget.donation.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
              color: colors.headingText,
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
                widget.donation.latitude != null &&
                        widget.donation.longitude != null
                    ? '${widget.donation.latitude!.toStringAsFixed(4)}, ${widget.donation.longitude!.toStringAsFixed(4)}'
                    : 'Location unavailable',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: colors.subText,
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
                    widget.donation.status,
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
            widget.donation.description.isEmpty
                ? 'No additional description provided by donor.'
                : widget.donation.description,
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
          _OwnerCard(donation: widget.donation),
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
                widget.donation.latitude != null &&
                        widget.donation.longitude != null
                    ? 'Lat ${widget.donation.latitude!.toStringAsFixed(3)}, Lng ${widget.donation.longitude!.toStringAsFixed(3)}'
                    : 'Coordinates unavailable',
                style: TextStyle(fontSize: 12.sp, color: colors.subText),
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
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        donation.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: colors.headingText,
                        ),
                      ),
                    ),
                    if (donation.authorDetails?.isVerified ?? false) ...[
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.verified_rounded,
                        color: Colors.blue,
                        size: 14.sp,
                      ),
                    ],
                  ],
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
                color: colors.onPrimary,
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
