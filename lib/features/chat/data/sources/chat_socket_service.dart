import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../core/exceptions/exceptions.dart';
import '../../../auth/data/sources/auth_local_data_source.dart';
import '../../../../core/env.dart';

class ChatSocketService {
  final AuthLocalDataSource authLocalDataSource;
  IO.Socket? _socket;

  final _messageCreatedController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _sensitiveMessageApprovedController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _transactionCompletedController =
      StreamController<Map<String, dynamic>>.broadcast();
  final _errorController = StreamController<Map<String, dynamic>>.broadcast();

  ChatSocketService(this.authLocalDataSource);

  Stream<Map<String, dynamic>> get onMessageCreated =>
      _messageCreatedController.stream;
  Stream<Map<String, dynamic>> get onSensitiveMessageApproved =>
      _sensitiveMessageApprovedController.stream;
  Stream<Map<String, dynamic>> get onTransactionCompleted =>
      _transactionCompletedController.stream;
  Stream<Map<String, dynamic>> get onError => _errorController.stream;

  Future<void> initSocket() async {
    final token = await authLocalDataSource.getAccessToken();
    if (token == null) {
      throw ServerException('No auth token available for socket connection');
    }

    final baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.gaspzero.qzz.io/',
    );
    final envBaseUrl = Env.get('API_BASE_URL') ?? baseUrl;

    _socket = IO.io(
      '$envBaseUrl/chat',
      IO.OptionBuilder().setTransports(['websocket']).setAuth({
        'token': 'Bearer $token',
      }).build(),
    );

    _socket?.onConnect((_) {
      debugPrint('Chat Socket connected');
    });

    _socket?.on('chat:message-created', (data) {
      if (data != null)
        _messageCreatedController.add(Map<String, dynamic>.from(data));
    });

    _socket?.on('chat:sensitive-message-approved', (data) {
      if (data != null)
        _sensitiveMessageApprovedController.add(
          Map<String, dynamic>.from(data),
        );
    });

    _socket?.on('chat:transaction-completed', (data) {
      if (data != null)
        _transactionCompletedController.add(Map<String, dynamic>.from(data));
    });

    _socket?.on('chat:error', (data) {
      if (data != null) _errorController.add(Map<String, dynamic>.from(data));
    });

    _socket?.onDisconnect((_) {
      debugPrint('Chat Socket disconnected');
    });
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
    _messageCreatedController.close();
    _sensitiveMessageApprovedController.close();
    _transactionCompletedController.close();
    _errorController.close();
  }

  Future<void> joinConversation(String conversationId) async {
    final completer = Completer<void>();
    _socket?.emitWithAck(
      'chat:join-conversation',
      {'conversationId': conversationId},
      ack: (dynamic response) {
        if (response is Map && response['ok'] == true) {
          completer.complete();
        } else {
          final errorMsg = response is Map && response['error'] != null
              ? response['error']['message']
              : 'Failed to join conversation';
          completer.completeError(ServerException(errorMsg));
        }
      },
    );
    return completer.future;
  }

  Future<void> leaveConversation(String conversationId) async {
    _socket?.emit('chat:leave-conversation', {
      'conversationId': conversationId,
    });
  }

  Future<void> approveSensitiveMessage(
    String conversationId,
    String messageId,
  ) async {
    final completer = Completer<void>();
    _socket?.emitWithAck(
      'chat:approve-sensitive-message',
      {'conversationId': conversationId, 'messageId': messageId},
      ack: (dynamic response) {
        if (response is Map && response['ok'] == true) {
          completer.complete();
        } else {
          final errorMsg = response is Map && response['error'] != null
              ? response['error']['message']
              : 'Failed to approve message';
          completer.completeError(ServerException(errorMsg));
        }
      },
    );
    return completer.future;
  }

  Future<Map<String, dynamic>> sendMessage(
    String conversationId,
    String content,
  ) async {
    final completer = Completer<Map<String, dynamic>>();
    _socket?.emitWithAck(
      'chat:send-message',
      {'conversationId': conversationId, 'content': content},
      ack: (dynamic response) {
        if (response is Map && response['ok'] == true) {
          completer.complete(Map<String, dynamic>.from(response['data'] ?? {}));
        } else {
          final errorMsg = response is Map && response['error'] != null
              ? response['error']['message']
              : 'Failed to send message via socket';
          completer.completeError(ServerException(errorMsg));
        }
      },
    );
    return completer.future;
  }
}
