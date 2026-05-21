import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:intl/intl.dart';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:gaspzero/core/theme/app_text_styles.dart';
import '../../domain/entities/notification.dart';
import '../../domain/entities/notification_type.dart';

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
      case NotificationType.accountStatusAlert:
        return AppColors.notificationAlertBackground;
      case NotificationType.chatMessage:
      case NotificationType.message:
      case NotificationType.newAchievement:
      case NotificationType.newPost:
      case NotificationType.reportAlert:
      case NotificationType.reservationAlert:
      case NotificationType.test:
        return AppColors.statusCompletedText;
    }
  }

  Color _getTypeBackgroundColor() {
    switch (notification.type) {
      case NotificationType.accountStatusAlert:
        return AppColors.notificationAlertLight;
      case NotificationType.chatMessage:
      case NotificationType.message:
        return AppColors.notificationConfirmationBackground;
      case NotificationType.newAchievement:
      case NotificationType.newPost:
        return AppColors.notificationImpactBackground;
      case NotificationType.reportAlert:
      case NotificationType.reservationAlert:
        return AppColors.notificationDonationBackground;
      case NotificationType.test:
        return AppColors.notificationDonationBackground;
    }
  }

  IconData _getTypeIcon() {
    switch (notification.type) {
      case NotificationType.accountStatusAlert:
        return Icons.warning_rounded;
      case NotificationType.chatMessage:
        return Icons.chat_bubble_rounded;
      case NotificationType.message:
        return Icons.message_rounded;
      case NotificationType.newAchievement:
        return Icons.emoji_events_rounded;
      case NotificationType.newPost:
        return Icons.post_add_rounded;
      case NotificationType.reportAlert:
        return Icons.report_rounded;
      case NotificationType.reservationAlert:
        return Icons.event_available_rounded;
      case NotificationType.test:
        return Icons.notifications_rounded;
    }
  }

  bool _isMessageNotification() {
    final isMessage = notification.type == NotificationType.message;
    return isMessage;
  }

  Map<String, dynamic> _extractMeta(dynamic metaValue) {
    if (metaValue is Map<String, dynamic>) {
      return <String, dynamic>{...metaValue};
    }
    if (metaValue is Map) {
      try {
        return Map<String, dynamic>.from(metaValue);
      } catch (_) {
        return <String, dynamic>{};
      }
    }
    if (metaValue is String && metaValue.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(metaValue);
        if (decoded is Map<String, dynamic>)
          return <String, dynamic>{...decoded};
        if (decoded is Map) return Map<String, dynamic>.from(decoded);
      } catch (_) {
        return <String, dynamic>{};
      }
    }
    return <String, dynamic>{};
  }

  String? _resolveSenderAvatarUrl() {
    if (!_isMessageNotification()) return null;

    final meta = _extractMeta(notification.meta);
    final candidates = <String?>[
      meta['senderAvatarUrl']?.toString(),
      meta['avatarUrl']?.toString(),
      meta['senderPhotoUrl']?.toString(),
      meta['senderImageUrl']?.toString(),
    ];

    for (final candidate in candidates) {
      final url = candidate?.trim();
      if (url != null && url.isNotEmpty) {
        final uri = Uri.tryParse(url);
        if (uri != null && (uri.scheme == 'http' || uri.scheme == 'https'))
          return url;
      }
    }

    return null;
  }

  String _resolveBodyText() {
    if (!_isMessageNotification()) return notification.body ?? '';

    final meta = _extractMeta(notification.meta);
    final candidates = <String?>[
      meta['donationUrl']?.toString(),
      meta['donationLink']?.toString(),
      meta['url']?.toString(),
      meta['donationPageUrl']?.toString(),
      notification.body,
    ];

    for (final candidate in candidates) {
      final value = candidate?.trim();
      if (value != null && value.isNotEmpty) return value;
    }

    return notification.body ?? '';
  }

  Widget _buildLeadingIcon() {
    final avatarUrl = _resolveSenderAvatarUrl();

    if (avatarUrl != null) {
      return Container(
        margin: const EdgeInsets.all(AppSpacing.md),
        width: 48.0,
        height: 48.0,
        decoration: BoxDecoration(
          color: _getTypeBackgroundColor(),
          shape: BoxShape.circle,
        ),
        clipBehavior: Clip.antiAlias,
        child: CachedNetworkImage(
          imageUrl: avatarUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: Icon(
              Icons.person_rounded,
              color: _getTypeColor(),
              size: 22.0,
            ),
          ),
          errorWidget: (context, url, error) => Center(
            child: Icon(
              Icons.person_rounded,
              color: _getTypeColor(),
              size: 22.0,
            ),
          ),
        ),
      );
    }

    return Container(
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
    );
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
          color: !notification.isRead
              ? AppColors.surface
              : AppColors.notificationCardUnreadBackground,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: !notification.isRead
                ? Colors.grey.shade300
                : AppColors.notificationCardBorder,
            width: 1.0,
          ),
          boxShadow: !notification.isRead
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
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
            // Icon / avatar
            _buildLeadingIcon(),
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
                      _resolveBodyText(),
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
