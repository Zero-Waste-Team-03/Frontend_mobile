import 'package:flutter/material.dart' hide Notification;
import 'package:go_router/go_router.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:gaspzero/features/notification/domain/entities/notification.dart'
    as N;
import 'package:gaspzero/features/donations/data/sources/donation_remote_data_source.dart';

class NotificationActionHandler {
  /// Handles notification tap actions based on `notification.meta.action`.
  /// Falls back to opening the notifications list when action is unknown.
  static Future<void> handle(
    BuildContext context,
    N.Notification notification,
  ) async {
    print(notification);
    final meta = notification.meta ?? <String, dynamic>{};
    final action = (meta['action'] as String?)?.trim() ?? 'notification.open';
    print(
      "Handling notification action for notification id: ${notification.id}",
    );
    print("Notification action: $action");
    print("Notification meta: $meta");
    switch (action) {
      case 'chat.open':
        print(
          'Handling chat.open action for notification id: ${notification.id}',
        );
        // Prefer reservationId, else open chats list
        final reservationID = meta['reservationId'] as String?;
        final conversationID = meta['conversationId'] as String?;
        print('Navigating to chat with reservation ID: $reservationID');
        print('Navigating to chat with conversation ID: $conversationID');
        final id = reservationID ?? conversationID;
        if (id != null && id.isNotEmpty) {
          context.push(
            '/chat',
            extra: {
              'reservationId': reservationID,
              'conversationId': conversationID,
            },
          );
        } else {
          context.push('/chats');
        }
        return;

      case 'donation.open':
        print(
          'Handling donation.open action for notification id: ${notification.id}',
        );
        final donationId = meta['donationId'] as String?;
        if (donationId != null && donationId.isNotEmpty) {
          try {
            final ds = getIt<DonationRemoteDataSource>();
            final donation = await ds.getDonationDetails(donationId);
            context.push('/donation-details', extra: donation);
            return;
          } catch (_) {
            // ignore and fallthrough to notifications list
            print('Failed to fetch donation details for id: $donationId');
          }
        }
        break;

      case 'reservation.open':
        print(
          'Handling reservation.open action for notification id: ${notification.id}',
        );
        final reservationId = meta['reservationId'] as String?;
        if (reservationId != null && reservationId.isNotEmpty) {
          context.push('/reservation-details', extra: reservationId);
          return;
        }
        print(
          'No reservationId found in notification meta for reservation.open action',
        );
        break;

      case 'report.open':
        print(
          'Handling report.open action for notification id: ${notification.id}',
        );
        final reportId = meta['reportId'] as String?;
        if (reportId != null && reportId.isNotEmpty) {
          context.push('/reports/$reportId');
          return;
        }
        print('No reportId found in notification meta for report.open action');
        break;

      case 'account.open':
        print(
          'Handling account.open action for notification id: ${notification.id}',
        );
        context.push('/profile/settings');
        return;

      case 'achievement.open':
        print(
          'Handling achievement.open action for notification id: ${notification.id}',
        );
        final achievementId = meta['achievementId'] as String?;
        if (achievementId != null && achievementId.isNotEmpty) {
          context.push('/profile/achievements/$achievementId');
          return;
        }
        print(
          'No achievementId found in notification meta for achievement.open action',
        );
        break;

      case 'post.open':
        print(
          'Handling post.open action for notification id: ${notification.id}',
        );
        final postId = meta['postId'] as String?;
        if (postId != null && postId.isNotEmpty) {
          context.push('/posts/$postId');
          return;
        }
        print('No postId found in notification meta for post.open action');
        break;

      case 'message.open':
        print(
          'Handling message.open action for notification id: ${notification.id}',
        );
        // route to chats list or specific thread if supplied
        final threadId =
            meta['threadId'] as String? ?? meta['senderId'] as String?;
        if (threadId != null && threadId.isNotEmpty) {
          context.push('/chats');
          return;
        }
        break;

      default:
        break;
    }

    // Default fallback: open notifications page
    //context.push('/notifications');
  }
}
