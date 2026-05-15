import 'package:ferry/ferry.dart' hide ServerException;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
import '../models/notification_model.dart';
import 'graphql/__generated__/delete_notification.req.gql.dart';
import 'graphql/__generated__/delete_notification.var.gql.dart';
import 'graphql/__generated__/get_notification_stats.req.gql.dart';
import 'graphql/__generated__/get_notification_stats.var.gql.dart';
import 'graphql/__generated__/get_notifications.req.gql.dart';
import 'graphql/__generated__/get_notifications.var.gql.dart';
import 'graphql/__generated__/mark_notifications_as_read.req.gql.dart';
import 'graphql/__generated__/mark_notifications_as_read.var.gql.dart';
import '../../domain/entities/notification_stats.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 10,
  });

  Future<NotificationStats> getNotificationStats();

  Future<void> markNotificationsAsRead(List<String> notificationIds);

  Future<void> deleteNotification(String notificationId);
}

@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  NotificationRemoteDataSourceImpl(
    this._ferryClient,
    this._graphqlRequestExecutor,
  );

  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  @override
  Future<List<NotificationModel>> getNotifications({
    int page = 1,
    int limit = 10,
  }) async {
    _logger.i('getNotifications called with page=$page, limit=$limit');

    try {
      final varsMap = <String, dynamic>{
        'pagination': {'page': page, 'limit': limit},
      };

      _logger.d('Building getNotifications variables: $varsMap');

      final vars = GGetNotificationsVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e('Failed to build getNotifications variables from: $varsMap');
        throw ServerException('Failed to build getNotifications request');
      }

      _logger.d('Executing GraphQL getNotifications request');
      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GGetNotificationsReq(
          (b) => b
            ..vars = vars.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly
            ..requestId =
                'getNotifications-${DateTime.now().microsecondsSinceEpoch}',
        ),
        operationName: 'getNotifications',
      );

      final items = data.getNotifications.items;
      _logger.i('getNotifications returned ${items?.length ?? 0} items');

      if (items == null || items.isEmpty) {
        _logger.d('No notification items returned');
        return const [];
      }

      // Manually parse items with safe meta field handling
      final notificationModels = <NotificationModel>[];
      for (int i = 0; i < items.length; i++) {
        try {
          final item = items[i];
          _logger.d('Parsing notification item $i');

          final itemJson = Map<String, dynamic>.from(item.toJson());
          _logger.d('Item $i JSON keys: ${itemJson.keys.toList()}');
          _logger.d('Item $i meta type: ${itemJson['meta']?.runtimeType}');
          _logger.d('Item $i meta value: ${itemJson['meta']}');

          final model = NotificationModel.fromJson(itemJson);
          notificationModels.add(model);
          _logger.d('Successfully parsed notification item $i: ${model.id}');
        } catch (itemError) {
          _logger.e(
            'Error parsing notification item $i: $itemError',
            error: itemError,
          );
          // Log the problematic item and continue
          rethrow;
        }
      }

      _logger.i(
        'Successfully parsed ${notificationModels.length} notification items',
      );
      return notificationModels;
    } on ServerException {
      rethrow;
    } catch (e) {
      _logger.e('getNotifications error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<NotificationStats> getNotificationStats() async {
    _logger.i('getNotificationStats called');

    try {
      final vars = GGetNotificationStatsVars.fromJson(const {});
      if (vars == null) {
        throw ServerException('Failed to build getNotificationStats request');
      }

      final data = await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GGetNotificationStatsReq(
          (b) => b
            ..vars = vars.toBuilder()
            ..fetchPolicy = FetchPolicy.NetworkOnly,
        ),
        operationName: 'getNotificationStats',
      );

      return NotificationStats(
        unreadCount: data.getNotificationStats.unreadCount,
      );
    } catch (e) {
      _logger.e('getNotificationStats error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<void> markNotificationsAsRead(List<String> notificationIds) async {
    _logger.i(
      'markNotificationsAsRead called with ${notificationIds.length} notification(s)',
    );

    if (notificationIds.isEmpty) {
      _logger.w('markNotificationsAsRead called with empty notification list');
      return;
    }

    try {
      final varsMap = <String, dynamic>{
        'input': {'ids': notificationIds},
      };

      _logger.d(
        'Building markNotificationsAsRead variables with ${notificationIds.length} IDs: '
        '$notificationIds',
      );

      final vars = GMarkNotificationsAsReadVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e(
          'Failed to build markNotificationsAsRead variables from: $varsMap',
        );
        throw ServerException(
          'Failed to build markNotificationsAsRead request',
        );
      }

      await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GMarkNotificationsAsReadReq((b) => b.vars = vars.toBuilder()),
        operationName: 'markNotificationsAsRead',
      );

      _logger.i(
        'Successfully marked ${notificationIds.length} notification(s) as read',
      );
    } catch (e) {
      _logger.e('markNotificationsAsRead error: $e', error: e);
      rethrow;
    }
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    _logger.i('deleteNotification called with id=$notificationId');

    if (notificationId.isEmpty) {
      _logger.w('deleteNotification called with empty notification ID');
      throw ServerException('Notification ID cannot be empty');
    }

    try {
      final varsMap = <String, dynamic>{'id': notificationId};

      _logger.d('Building deleteNotification variables: $varsMap');

      final vars = GDeleteNotificationVars.fromJson(varsMap);
      if (vars == null) {
        _logger.e(
          'Failed to build deleteNotification variables from: $varsMap',
        );
        throw ServerException('Failed to build deleteNotification request');
      }

      await _graphqlRequestExecutor.execute(
        client: _ferryClient,
        request: GDeleteNotificationReq((b) => b.vars = vars.toBuilder()),
        operationName: 'deleteNotification',
      );

      _logger.i('Successfully deleted notification with id=$notificationId');
    } catch (e) {
      _logger.e('deleteNotification error: $e', error: e);
      rethrow;
    }
  }
}
