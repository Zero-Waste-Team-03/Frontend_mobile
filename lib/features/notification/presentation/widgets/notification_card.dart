import 'package:flutter/material.dart' hide Notification;
import 'package:intl/intl.dart';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:gaspzero/core/theme/app_text_styles.dart';
import '../../domain/entities/notification.dart';

class NotificationCard extends StatelessWidget {
  final Notification notification;
  final VoidCallback onTap;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onDelete;

  const NotificationCard({
    Key? key,
    required this.notification,
    required this.onTap,
    this.onMarkAsRead,
    this.onDelete,
  }) : super(key: key);

  Color _getTypeColor() {
    switch (notification.type) {
      case NotificationType.alert:
        return AppColors.notificationAlertBackground;
      case NotificationType.confirmation:
        return AppColors.statusCompletedText;
      case NotificationType.donation:
        return AppColors.statusCompletedText;
      case NotificationType.impact:
        return AppColors.statusCompletedText;
    }
  }

  Color _getTypeBackgroundColor() {
    switch (notification.type) {
      case NotificationType.alert:
        return AppColors.notificationAlertLight;
      case NotificationType.confirmation:
        return AppColors.notificationConfirmationBackground;
      case NotificationType.donation:
        return AppColors.notificationDonationBackground;
      case NotificationType.impact:
        return AppColors.notificationImpactBackground;
    }
  }

  IconData _getTypeIcon() {
    switch (notification.type) {
      case NotificationType.alert:
        return Icons.warning_rounded;
      case NotificationType.confirmation:
        return Icons.check_circle_rounded;
      case NotificationType.donation:
        return Icons.favorite_rounded;
      case NotificationType.impact:
        return Icons.eco_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeAgo = _getTimeAgo(notification.createdAt);

    return GestureDetector(
      onTap: () {
        if (!notification.isRead) {
          onMarkAsRead?.call();
        }
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: notification.isRead
              ? AppColors.surface
              : AppColors.notificationCardUnreadBackground,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: AppColors.notificationCardBorder,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left indicator border
            Container(
              width: 4.0,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppRadius.md),
                  bottomLeft: Radius.circular(AppRadius.md),
                ),
              ),
            ),
            // Icon container with badge
            Container(
              margin: const EdgeInsets.all(AppSpacing.md),
              width: 48.0,
              height: 48.0,
              decoration: BoxDecoration(
                color: _getTypeBackgroundColor(),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Center(
                child: Icon(_getTypeIcon(), color: _getTypeColor(), size: 24.0),
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.md,
                  horizontal: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTextStyles.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          timeAgo,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      notification.body,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!notification.isRead)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            Container(
                              width: 6.0,
                              height: 6.0,
                              decoration: const BoxDecoration(
                                color: AppColors.notificationUnreadIndicator,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              'Unread',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // Delete button
            GestureDetector(
              onTap: onDelete,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: AppSpacing.md,
                  top: AppSpacing.md,
                ),
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.textMuted,
                  size: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(dateTime);
    }
  }
}
