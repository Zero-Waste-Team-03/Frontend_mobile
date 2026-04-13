import 'package:gaspzero/features/notification/domain/entities/notification.dart' show NotificationType, NotificationTypeExt;

import '../models/notification_model.dart';


abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({
    required String userId,
    int page = 1,
    int limit = 20,
  });

  Future<List<NotificationModel>> getFilteredNotifications({
    required String userId,
    String? typeFilter,
    bool? isReadFilter,
    int page = 1,
    int limit = 20,
  });

  Future<NotificationModel> markAsRead(String notificationId);

  Future<void> markAllAsRead(String userId);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  // TODO: Replace with actual HTTP client (Dio, etc.) when API is ready

  @override
  Future<List<NotificationModel>> getNotifications({
    required String userId,
    int page = 1,
    int limit = 20,
  }) async {
    // PLACEHOLDER: Replace with actual API call
    // Example: final response = await dio.get('/users/$userId/notifications');

    // Mock data for now
    await Future.delayed(const Duration(milliseconds: 500));

    return _generateMockNotifications(userId, limit);
  }

  @override
  Future<List<NotificationModel>> getFilteredNotifications({
    required String userId,
    String? typeFilter,
    bool? isReadFilter,
    int page = 1,
    int limit = 20,
  }) async {
    // PLACEHOLDER: Replace with actual API call when ready
    // Example: final response = await dio.get(
    //   '/users/$userId/notifications',
    //   queryParameters: {
    //     'type': typeFilter,
    //     'isRead': isReadFilter,
    //     'page': page,
    //     'limit': limit,
    //   },
    // );

    await Future.delayed(const Duration(milliseconds: 500));

    var notifications = _generateMockNotifications(userId, limit);

    // Apply filters locally until API is integrated
    if (typeFilter != null) {
      notifications = notifications
          .where((n) => n.type.value == typeFilter.toUpperCase())
          .toList();
    }

    if (isReadFilter != null) {
      notifications = notifications
          .where((n) => n.isRead == isReadFilter)
          .toList();
    }

    return notifications;
  }

  @override
  Future<NotificationModel> markAsRead(String notificationId) async {
    // PLACEHOLDER: Replace with actual API call
    // Example: final response = await dio.patch('/notifications/$notificationId/read');

    await Future.delayed(const Duration(milliseconds: 300));

    // Return updated notification (mock)
    return NotificationModel(
      id: notificationId,
      receiverId: 'user_123',
      title: 'Updated Notification',
      body: 'This is a test notification',
      type: NotificationType.alert,
      isRead: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    // PLACEHOLDER: Replace with actual API call
    // Example: await dio.patch('/users/$userId/notifications/read-all');

    await Future.delayed(const Duration(milliseconds: 300));
  }

  // Helper method to generate mock notifications
  List<NotificationModel> _generateMockNotifications(String userId, int count) {
    final now = DateTime.now();

    final types = ['ALERT', 'CONFIRMATION', 'DONATION', 'IMPACT'];
    final titles = [
      'URGENT ALERT',
      'Reservation Confirmed',
      'New Donation Nearby',
      'Impact Reached!',
    ];
    final bodies = [
      '3 items expiring soon! Save food in your area before it goes to waste.',
      'Your pickup at Baker\'s Delight is ready. Please arrive by 6:00 PM.',
      '5kg of apples available 200m away at Green Market.',
      'Amazing! You\'ve saved 10kg of CO2 this week by rescuing food.',
    ];

    return List.generate(count, (index) {
      final typeIndex = index % types.length;
      return NotificationModel(
        id: 'notif_$index',
        receiverId: userId,
        title: titles[typeIndex],
        body: bodies[typeIndex],
        type: NotificationTypeExt.fromString(types[typeIndex]),
        isRead: index > 2,
        createdAt: now.subtract(Duration(minutes: index * 15)),
        updatedAt: now.subtract(Duration(minutes: index * 15)),
      );
    });
  }
}
