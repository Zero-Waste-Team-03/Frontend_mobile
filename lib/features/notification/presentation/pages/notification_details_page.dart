import 'package:flutter/material.dart' hide Notification;
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:gaspzero/core/theme/app_text_styles.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../../domain/entities/notification.dart';

class NotificationDetailsPage extends StatefulWidget {
  final Notification notification;

  const NotificationDetailsPage({Key? key, required this.notification})
    : super(key: key);

  @override
  State<NotificationDetailsPage> createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  late NotificationBloc _notificationBloc;
  bool _hasMarkedAsRead = false;

  @override
  void initState() {
    super.initState();
    _notificationBloc = getIt<NotificationBloc>();
  }

  void _markAsReadIfNeeded(Notification? notification) {
    if (notification != null && !notification.isRead && !_hasMarkedAsRead) {
      _hasMarkedAsRead = true;
      _notificationBloc.add(MarkNotificationsAsReadEvent([notification.id]));
    }
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
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

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
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

  Color _getAlertBackgroundColor(NotificationType type) {
    switch (type) {
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

  @override
  Widget build(BuildContext context) {
    final notification = widget.notification;

    // Mark as read when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _markAsReadIfNeeded(notification);
    });

    return _buildDetailsPage(context, notification);
  }

  Widget _buildDetailsPage(BuildContext context, Notification notification) {
    final formattedDate = DateFormat(
      'MMM d, yyyy • h:mm a',
    ).format(notification.createdAt);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
        ),
        title: Text(
          'Notification Details',
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and status
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: AppColors.notificationCardBorder,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56.0,
                      height: 56.0,
                      decoration: BoxDecoration(
                        color: _getAlertBackgroundColor(notification.type),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Center(
                        child: Icon(
                          _getTypeIcon(notification.type),
                          color: _getTypeColor(notification.type),
                          size: 28.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title,
                            style: AppTextStyles.titleMedium,
                          ),
                          const SizedBox(height: 6.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: notification.isRead
                                  ? Colors.grey.shade200
                                  : const Color(0xFFE6F7ED),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              notification.isRead ? 'Read' : 'Unread',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: notification.isRead
                                    ? Colors.grey.shade600
                                    : AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Message section
              Text('Message', style: AppTextStyles.titleMedium),
              const SizedBox(height: AppSpacing.md),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: AppColors.notificationCardBorder,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  notification.body,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Details section
              Text('Details', style: AppTextStyles.titleMedium),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(
                    color: AppColors.notificationCardBorder,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    _buildDetailRow(
                      'Type',
                      notification.type.toString().split('.').last,
                    ),
                    const Divider(height: 16),
                    _buildDetailRow('Date', formattedDate),
                    const Divider(height: 16),
                    _buildDetailRow(
                      'Status',
                      notification.isRead ? 'Read' : 'Unread',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Delete button
              SizedBox(
                width: double.infinity,
                height: 48.0,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Notification'),
                        content: const Text(
                          'Are you sure you want to delete this notification?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              _notificationBloc.add(
                                DeleteNotificationEvent(notification.id),
                              );
                              Navigator.pop(context);
                              context.pop();
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  ),
                  child: Text(
                    'Delete Notification',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
