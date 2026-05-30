import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/core/app_icons.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:gaspzero/features/notification/presentation/bloc/notification_stats_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool compact;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;

  const NotificationButton({
    super.key,
    this.onPressed,
    this.compact = false,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
  });

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  late final NotificationStatsBloc _statsBloc;

  @override
  void initState() {
    super.initState();
    _statsBloc = getIt<NotificationStatsBloc>();
    if (_statsBloc.state is NotificationStatsInitial) {
      _statsBloc.add(const FetchNotificationStatsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final effectiveOnPressed =
        widget.onPressed ?? () => context.push('/notifications');

    return BlocProvider.value(
      value: _statsBloc,
      child: BlocBuilder<NotificationStatsBloc, NotificationStatsState>(
        builder: (context, state) {
          final unreadCount = state is NotificationStatsLoaded
              ? state.unreadCount
              : 0;

          final badge = unreadCount > 0
              ? Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 1.h,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        unreadCount > 9 ? '9+' : unreadCount.toString(),
                        style: TextStyle(
                          color: colors.onPrimary,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink();

          final icon = Icon(
            AppIcons.notifications,
            color: widget.iconColor ?? colors.primary,
            size: widget.iconSize ?? 24.sp,
          );

          final content = Stack(
            clipBehavior: Clip.none,
            children: [icon, badge],
          );

          if (widget.compact) {
            return IconButton(icon: content, onPressed: effectiveOnPressed);
          }

          return IconButton(
            icon: content,
            onPressed: effectiveOnPressed,
            style: IconButton.styleFrom(
              backgroundColor: widget.backgroundColor ?? colors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          );
        },
      ),
    );
  }
}
