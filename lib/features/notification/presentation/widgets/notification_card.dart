import 'package:flutter/material.dart' hide Notification;
import 'package:intl/intl.dart';
import '../../domain/entities/notification.dart';
import '../../../../shared/theme/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final Notification notification;
  final VoidCallback onTap;
  final VoidCallback? onMarkAsRead;

  const NotificationCard({
    Key? key,
    required this.notification,
    required this.onTap,
    this.onMarkAsRead,
  }) : super(key: key);

  Color _getTypeColor() {
    switch (notification.type) {
      case NotificationType.alert:
        return const Color(0xFFFFA500); // Orange
      case NotificationType.confirmation:
        return AuthColors.statusCompletedText;
      case NotificationType.donation:
        return AuthColors.statusCompletedText;
      case NotificationType.impact:
        return AuthColors.statusCompletedText;
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

  Color _getAlertBackgroundColor() {
    switch (notification.type) {
      case NotificationType.alert:
        return const Color(0xFFFFA500).withAlpha(20);
      case NotificationType.confirmation:
        return AuthColors.statusCompletedBackground;
      case NotificationType.donation:
        return AuthColors.statusCompletedBackground;
      case NotificationType.impact:
        return AuthColors.statusCompletedBackground;
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
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.white : const Color(0xFFF5F7F6),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    color: _getAlertBackgroundColor(),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Icon(
                      _getTypeIcon(),
                      color: _getTypeColor(),
                      size: 24.0,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AuthColors.headingText,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8.0,
                              height: 8.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2D6C50),
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        notification.body,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AuthColors.subText,
                          height: 1.4,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        timeAgo,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
