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

    final routeState = GoRouterState.of(context);
    final currentLocation = routeState.uri.path;

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
          // Push chat details only if not already showing same chat
          if (!currentLocation.startsWith('/chat')) {
            context.push(
              '/chat',
              extra: {
                'reservationId': reservationID,
                'conversationId': conversationID,
              },
            );
          }
        } else {
          if (currentLocation != '/chats') context.push('/chats');
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
            if (currentLocation != '/donation-details') {
              context.push('/donation-details', extra: donation);
            }
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
          if (currentLocation != '/reservation-details') {
            context.push('/reservation-details', extra: reservationId);
          }
          return;
        }
        print(
          'No reservationId found in notification meta for reservation.open action',
        );
        break;

      case 'account.open':
        print(
          'Handling account.open action for notification id: ${notification.id}',
        );
        // Use `go` to switch to the profile tab instead of pushing duplicate pages
        if (currentLocation != '/profile') context.go('/profile');
        return;

      case 'message.open':
        print(
          'Handling message.open action for notification id: ${notification.id}',
        );
        // Prefer reservationId, else open chats list
        final reservationID = meta['reservationId'] as String?;
        final conversationID = meta['conversationId'] as String?;
        print('Navigating to chat with reservation ID: $reservationID');
        print('Navigating to chat with conversation ID: $conversationID');
        final id = reservationID ?? conversationID;
        if (id != null && id.isNotEmpty) {
          if (!currentLocation.startsWith('/chat')) {
            context.push(
              '/chat',
              extra: {
                'reservationId': reservationID,
                'conversationId': conversationID,
              },
            );
          }
        } else {
          if (currentLocation != '/chats') context.push('/chats');
        }
        return;

      default:
        break;
    }
  }
}
