import 'dart:convert';

import 'package:logger/logger.dart';

import '../../domain/entities/notification.dart';
import '../../domain/entities/notification_type.dart';

class NotificationModel extends Notification {
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );
  const NotificationModel({
    required super.id,
    required super.receiverId,
    required super.title,
    required super.body,
    required super.type,
    required super.isRead,
    super.meta,
    required super.createdAt,
    required super.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    try {
      _logger.d(
        'NotificationModel.fromJson called with keys: ${json.keys.toList()}',
      );

      final id = json['id'] as String;
      final receiverId = json['receiverId'] as String;
      final title = json['title'] as String;
      final body = json['body'] as String;
      final typeStr = json['type'] as String? ?? 'TEST';
      final isRead = json['isRead'] as bool? ?? false;

      _logger.d('Parsed basic fields - id: $id, type: $typeStr');
      _logger.d(
        'Meta field type: ${json['meta']?.runtimeType}, value: ${json['meta']}',
      );

      final meta = _parseMetaField(json['meta']);
      _logger.d('Parsed meta field successfully: ${meta?.keys.toList()}');

      final createdAt = json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now();
      final updatedAt = json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now();

      return NotificationModel(
        id: id,
        receiverId: receiverId,
        title: title,
        body: body,
        type: NotificationTypeExt.fromString(typeStr),
        isRead: isRead,
        meta: meta,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
    } catch (e) {
      _logger.e(
        'Error in NotificationModel.fromJson: $e\nJSON data: $json',
        error: e,
      );
      rethrow;
    }
  }

  /// Helper to safely parse meta field which can be any JSON type
  static Map<String, dynamic>? _parseMetaField(dynamic meta) {
    try {
      _logger.d(
        '_parseMetaField called with type: ${meta?.runtimeType}, value: $meta',
      );

      if (meta == null) {
        _logger.d('Meta is null, returning null');
        return null;
      }

      if (meta is Map<String, dynamic>) {
        _logger.d('Meta is already Map<String, dynamic>');
        return meta;
      }

      if (meta is Map) {
        _logger.d('Meta is Map, converting to Map<String, dynamic>');
        return Map<String, dynamic>.from(meta);
      }

      // If meta is a JSON string, parse it
      if (meta is String) {
        try {
          _logger.d('Meta is String, attempting to parse as JSON');
          final decoded = jsonDecode(meta);
          if (decoded is Map<String, dynamic>) {
            _logger.d(
              'Successfully decoded meta string to Map<String, dynamic>',
            );
            return decoded;
          } else if (decoded is Map) {
            _logger.d(
              'Decoded meta string to Map, converting to Map<String, dynamic>',
            );
            return Map<String, dynamic>.from(decoded);
          } else {
            _logger.w(
              'Decoded meta string but result was ${decoded.runtimeType}',
            );
            return <String, dynamic>{'value': decoded};
          }
        } catch (e) {
          _logger.w('Failed to parse meta string as JSON: $e');
          return null;
        }
      }

      // If meta is a List or other type, wrap it in a map
      _logger.w(
        'Meta is ${meta.runtimeType}, wrapping in map with "value" key',
      );
      return <String, dynamic>{'value': meta};
    } catch (e) {
      _logger.e('Error in _parseMetaField: $e, meta: $meta', error: e);
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiverId': receiverId,
      'title': title,
      'body': body,
      'type': type.value,
      'isRead': isRead,
      'meta': meta,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Notification toEntity() {
    return Notification(
      id: id,
      receiverId: receiverId,
      title: title,
      body: body,
      type: type,
      isRead: isRead,
      meta: meta,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
