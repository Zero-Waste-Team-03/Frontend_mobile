import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class AndroidNotificationDisplayService {
  AndroidNotificationDisplayService._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static final AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'gaspzero_foreground_notifications',
    'Foreground notifications',
    description: 'Shows rich Android notifications while the app is open',
    importance: Importance.high,
  );

  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 12),
      responseType: ResponseType.bytes,
    ),
  );

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) {
      return;
    }

    if (!Platform.isAndroid) {
      _initialized = true;
      return;
    }

    try {
      final androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      final initializationSettings = InitializationSettings(
        android: androidSettings,
      );

      await _plugin.initialize(settings: initializationSettings);

      final androidPlugin = _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();
      await androidPlugin?.createNotificationChannel(_channel);

      _initialized = true;
      _logger.i(
        '✅ AndroidNotificationDisplayService: local notifications initialized',
      );
    } catch (e, stackTrace) {
      _logger.e(
        '❌ AndroidNotificationDisplayService: failed to initialize',
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<void> showForegroundNotification(RemoteMessage message) async {
    if (!Platform.isAndroid) {
      return;
    }

    await initialize();
    if (!_initialized) {
      _logger.w(
        '⚠️ AndroidNotificationDisplayService: cannot show notification because initialization failed',
      );
      return;
    }

    final notification = message.notification;
    final data = message.data;
    final isMessageNotification = _isMessageNotification(data);
    final hasVisibleContent =
        (notification?.title?.isNotEmpty ?? false) ||
        (notification?.body?.isNotEmpty ?? false) ||
        data.isNotEmpty;

    if (!hasVisibleContent) {
      _logger.w(
        '⚠️ AndroidNotificationDisplayService: skipping notification with no visible content',
      );
      return;
    }

    final title =
        notification?.title ?? data['title']?.toString() ?? 'Notification';
    final body = isMessageNotification
        ? _resolveDonationUrl(message) ??
              notification?.body ??
              data['body']?.toString() ??
              ''
        : notification?.body ?? data['body']?.toString() ?? '';
    final imageUrl = isMessageNotification
        ? _resolveSenderAvatarUrl(message)
        : _resolveImageUrl(message);
    final largeIcon = imageUrl == null ? null : await _downloadBitmap(imageUrl);

    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      largeIcon: largeIcon,
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: title,
        summaryText: _summaryText(data),
      ),
    );

    await _plugin.show(
      id: _buildNotificationId(message),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(android: androidDetails),
      payload: _safeJsonEncode(data),
    );
  }

  static Future<void> showBackgroundNotification(RemoteMessage message) async {
    if (!Platform.isAndroid) {
      return;
    }

    await initialize();
    if (!_initialized) {
      _logger.w(
        '⚠️ AndroidNotificationDisplayService: cannot show background notification because initialization failed',
      );
      return;
    }

    final notification = message.notification;
    final data = message.data;
    final isMessageNotification = _isMessageNotification(data);
    final hasVisibleContent =
        (notification?.title?.isNotEmpty ?? false) ||
        (notification?.body?.isNotEmpty ?? false) ||
        data.isNotEmpty;

    if (!hasVisibleContent) {
      _logger.w(
        '⚠️ AndroidNotificationDisplayService: skipping background notification with no visible content',
      );
      return;
    }

    if (!isMessageNotification) {
      await _showStandardNotification(message);
      return;
    }

    final title =
        notification?.title ?? data['title']?.toString() ?? 'Notification';
    final body = notification?.body ?? data['body']?.toString() ?? '';

    final avatarUrl = _resolveAvatarUrl(message);
    final imageUrl = _resolveImageUrl(message);

    final avatarBitmap = avatarUrl == null
        ? null
        : await _downloadBitmap(avatarUrl);
    final bigPictureBitmap = imageUrl == null
        ? null
        : await _downloadBitmap(imageUrl);

    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      largeIcon: avatarBitmap,
      styleInformation: bigPictureBitmap == null
          ? BigTextStyleInformation(
              body,
              contentTitle: title,
              summaryText: body,
            )
          : BigPictureStyleInformation(
              bigPictureBitmap,
              largeIcon: avatarBitmap,
              contentTitle: title,
              summaryText: body,
              hideExpandedLargeIcon: false,
            ),
    );

    await _plugin.show(
      id: _buildNotificationId(message),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(android: androidDetails),
      payload: _safeJsonEncode(data),
    );
  }

  static String _safeJsonEncode(Object? data) {
    try {
      return jsonEncode(data);
    } catch (e, st) {
      _logger.w(
        'AndroidNotificationDisplayService: failed to encode payload',
        error: e,
        stackTrace: st,
      );
      try {
        if (data is Map) return jsonEncode(Map.from(data));
      } catch (_) {
        // ignore
      }
      return '{}';
    }
  }

  static String? _resolveImageUrl(RemoteMessage message) {
    final data = message.data;
    final meta = _extractMeta(data);

    final candidates = <dynamic>[
      meta['imageUrl'],
      meta['donationImageUrl'],
      meta['senderAvatarUrl'],
      data['imageUrl'],
      data['donationImageUrl'],
      data['senderAvatarUrl'],
      message.notification?.android?.imageUrl,
    ];

    for (final candidate in candidates) {
      final url = candidate?.toString().trim();
      if (_isHttpUrl(url)) {
        return url;
      }
    }

    return null;
  }

  static bool _isMessageNotification(Map<String, dynamic> data) {
    final typeValue = data['type']?.toString().trim().toUpperCase();
    if (typeValue == 'MESSAGE' || typeValue == 'CHAT_MESSAGE') {
      _logger.i(
        'AndroidNotificationDisplayService: identified message notification by type field',
      );
      return true;
    }

    final meta = _extractMeta(data);
    final metaTypeValue = meta['type']?.toString().trim().toUpperCase();
    final isMessageType =
        metaTypeValue == 'MESSAGE' || metaTypeValue == 'CHAT_MESSAGE';
    if (isMessageType) {
      _logger.i(
        'AndroidNotificationDisplayService: identified message notification by meta field',
      );
    }
    return isMessageType;
  }

  static String? _resolveSenderAvatarUrl(RemoteMessage message) {
    final data = message.data;
    final meta = _extractMeta(data);

    final candidates = <dynamic>[
      meta['senderAvatarUrl'],
      meta['avatarUrl'],
      meta['senderPhotoUrl'],
      meta['senderImageUrl'],
      data['senderAvatarUrl'],
      data['avatarUrl'],
      data['senderPhotoUrl'],
      data['senderImageUrl'],
    ];

    for (final candidate in candidates) {
      final url = candidate?.toString().trim();
      if (_isHttpUrl(url)) {
        return url;
      }
    }

    return null;
  }

  static String? _resolveDonationUrl(RemoteMessage message) {
    final data = message.data;
    final meta = _extractMeta(data);

    final candidates = <dynamic>[
      meta['donationUrl'],
      meta['donationLink'],
      meta['url'],
      meta['donationPageUrl'],
      data['donationUrl'],
      data['donationLink'],
      data['url'],
      data['donationPageUrl'],
    ];

    for (final candidate in candidates) {
      final value = candidate?.toString().trim();
      if (value != null && value.isNotEmpty) {
        return value;
      }
    }

    return null;
  }

  static Map<String, dynamic> _extractMeta(Map<String, dynamic> data) {
    final metaValue = data['meta'];

    if (metaValue is Map<String, dynamic>) {
      return <String, dynamic>{...metaValue};
    }

    if (metaValue is Map) {
      return Map<String, dynamic>.from(metaValue);
    }

    if (metaValue is String && metaValue.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(metaValue);
        if (decoded is Map<String, dynamic>) {
          return <String, dynamic>{...decoded};
        }
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (_) {
        // Fall back to the flattened payload below.
      }
    }

    final flattened = <String, dynamic>{};
    for (final entry in data.entries) {
      if (entry.key == 'meta') {
        continue;
      }
      flattened[entry.key] = entry.value;
    }
    return flattened;
  }

  static bool _isHttpUrl(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    final uri = Uri.tryParse(value);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  static Future<AndroidBitmap<Object>?> _downloadBitmap(String imageUrl) async {
    try {
      final response = await _dio.get<List<int>>(imageUrl);
      final bytes = response.data;
      if (bytes == null || bytes.isEmpty) {
        return null;
      }

      final tempDirectory = await getTemporaryDirectory();
      final filePath =
          '${tempDirectory.path}${Platform.pathSeparator}fcm_${DateTime.now().microsecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(bytes, flush: true);

      return FilePathAndroidBitmap(file.path);
    } catch (e, stackTrace) {
      _logger.w(
        '⚠️ AndroidNotificationDisplayService: failed to download notification image',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  static Future<void> _showStandardNotification(RemoteMessage message) async {
    final notification = message.notification;
    final data = message.data;
    final title =
        notification?.title ?? data['title']?.toString() ?? 'Notification';
    final body = notification?.body ?? data['body']?.toString() ?? '';

    final androidDetails = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      styleInformation: BigTextStyleInformation(
        body,
        contentTitle: title,
        summaryText: _summaryText(data),
      ),
    );

    await _plugin.show(
      id: _buildNotificationId(message),
      title: title,
      body: body,
      notificationDetails: NotificationDetails(android: androidDetails),
      payload: _safeJsonEncode(data),
    );
  }

  static int _buildNotificationId(RemoteMessage message) {
    final seed =
        message.messageId ??
        message.data['id']?.toString() ??
        DateTime.now().millisecondsSinceEpoch.toString();
    return seed.hashCode & 0x7fffffff;
  }

  static String _summaryText(Map<String, dynamic> data) {
    final sender = data['senderName']?.toString().trim();
    if (sender != null && sender.isNotEmpty) {
      return sender;
    }

    final donation = data['donationTitle']?.toString().trim();
    if (donation != null && donation.isNotEmpty) {
      return donation;
    }

    return '';
  }

  static String? _resolveAvatarUrl(RemoteMessage message) {
    final data = message.data;
    final meta = _extractMeta(data);

    final candidates = <dynamic>[
      meta['avatarUrl'],
      meta['senderAvatarUrl'],
      meta['senderPhotoUrl'],
      meta['senderImageUrl'],
      data['avatarUrl'],
      data['senderAvatarUrl'],
      data['senderPhotoUrl'],
      data['senderImageUrl'],
    ];

    for (final candidate in candidates) {
      final url = candidate?.toString().trim();
      if (_isHttpUrl(url)) {
        return url;
      }
    }

    return null;
  }
}
