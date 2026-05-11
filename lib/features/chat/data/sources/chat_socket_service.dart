import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../core/exceptions/exceptions.dart';
import '../../../auth/data/sources/auth_local_data_source.dart';
import '../../../../core/env.dart';

class ChatSocketService {
  final AuthLocalDataSource authLocalDataSource;
  IO.Socket? _socket;

  StreamController<Map<String, dynamic>> _messageCreatedController =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<Map<String, dynamic>> _sensitiveMessageApprovedController =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<Map<String, dynamic>> _transactionCompletedController =
      StreamController<Map<String, dynamic>>.broadcast();
  StreamController<Map<String, dynamic>> _errorController =
      StreamController<Map<String, dynamic>>.broadcast();

  ChatSocketService(this.authLocalDataSource);

  Stream<Map<String, dynamic>> get onMessageCreated =>
      _messageCreatedController.stream;
  Stream<Map<String, dynamic>> get onSensitiveMessageApproved =>
      _sensitiveMessageApprovedController.stream;
  Stream<Map<String, dynamic>> get onTransactionCompleted =>
      _transactionCompletedController.stream;
  Stream<Map<String, dynamic>> get onError => _errorController.stream;

  Future<void> initSocket() async {
    // If controllers are closed, recreate them
    if (_messageCreatedController.isClosed) {
      _messageCreatedController =
          StreamController<Map<String, dynamic>>.broadcast();
    }
    if (_sensitiveMessageApprovedController.isClosed) {
      _sensitiveMessageApprovedController =
          StreamController<Map<String, dynamic>>.broadcast();
    }
    if (_transactionCompletedController.isClosed) {
      _transactionCompletedController =
          StreamController<Map<String, dynamic>>.broadcast();
    }
    if (_errorController.isClosed) {
      _errorController = StreamController<Map<String, dynamic>>.broadcast();
    }

    final token = await authLocalDataSource.getAccessToken();
    if (token == null) {
      throw ServerException('No auth token available for socket connection');
    }

    debugPrint('Initializing Chat Socket with Token: Bearer $token');

    final baseUrl = const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.gaspzero.qzz.io/',
    );
    final envBaseUrl = Env.get('API_BASE_URL') ?? baseUrl;
    final socketUrl = envBaseUrl.endsWith('/')
        ? '${envBaseUrl}chat'
        : '$envBaseUrl/chat';

    debugPrint('Connecting to socket at: $socketUrl');

    _socket = IO.io(
      socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setAuth({'token': 'Bearer $token'})
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .enableForceNew()
          .enableReconnection()
          .setQuery({'token': 'Bearer $token'}) // Adding token to query as well
          .build(),
    );

    _socket?.onConnect((_) {
      debugPrint('Chat Socket connected: ${_socket?.id}');
      // If we already have a conversation ID in the BLoC, we might need to re-join
      // But typically the BLoC handles initialization
    });
    
    // Listen for all events for debugging
    _socket?.onAny((event, data) {
      debugPrint('Socket Any Event: $event -> $data');
    });

    _socket?.onConnectError((data) {
      debugPrint('Chat Socket Connect Error: $data');
    });

    _socket?.on('chat:message-created', (data) {
      debugPrint('Socket chat:message-created raw data: $data');
      if (data != null) {
        // Handle different possible payload structures from NestJS/Socket.io
        final Map<String, dynamic> raw = data is Map ? Map<String, dynamic>.from(data) : {};
        final Map<String, dynamic> standardized = raw.containsKey('data') && raw['data'] is Map 
            ? Map<String, dynamic>.from(raw['data']) 
            : raw;
        
        // Comprehensive sender identification
        if (standardized['senderId'] == null) {
          if (standardized['sender'] != null) {
            if (standardized['sender'] is Map) {
              standardized['senderId'] = standardized['sender']['id'] ?? standardized['sender']['_id'];
            } else {
              standardized['senderId'] = standardized['sender'].toString();
            }
          } else if (standardized['user'] is Map) {
            standardized['senderId'] = standardized['user']['id'] ?? standardized['user']['_id'];
          } else if (standardized['userId'] != null) {
            standardized['senderId'] = standardized['userId'].toString();
          } else if (standardized['author'] is Map) {
            standardized['senderId'] = standardized['author']['id'];
          }
        }
        
        debugPrint('Standardized message created: id=${standardized['id']} senderId=${standardized['senderId']}');
        if (!_messageCreatedController.isClosed) {
          _messageCreatedController.add(standardized);
        }
      }
    });

    _socket?.on('chat:presence-updated', (data) {
      debugPrint('Socket chat:presence-updated: $data');
      if (data != null && data is Map) {
        final Map<String, dynamic> raw = Map<String, dynamic>.from(data);
        final Map<String, dynamic> standardized = raw.containsKey('data') && raw['data'] is Map 
            ? Map<String, dynamic>.from(raw['data']) 
            : raw;
        
        if (!_transactionCompletedController.isClosed) {
           // We use the transaction controller or add a new one, but for now 
           // let's just make sure we capture it for potential UI updates
           _transactionCompletedController.add({
             'type': 'presence',
             'userId': standardized['userId'],
             'isOnline': standardized['isOnline'],
           });
        }
      }
    });

    _socket?.on('chat:sensitive-message-approved', (data) {
      debugPrint('Socket chat:sensitive-message-approved received: $data');
      if (data != null && !_sensitiveMessageApprovedController.isClosed) {
        _sensitiveMessageApprovedController.add(
          Map<String, dynamic>.from(data),
        );
      }
    });

    _socket?.on('chat:transaction-completed', (data) {
      debugPrint('Socket chat:transaction-completed received: $data');
      if (data != null && !_transactionCompletedController.isClosed) {
        _transactionCompletedController.add(Map<String, dynamic>.from(data));
      }
    });

    _socket?.on('chat:error', (data) {
      debugPrint('Socket chat:error received: $data');
      if (data != null && !_errorController.isClosed) {
        _errorController.add(Map<String, dynamic>.from(data));
      }
    });
    _socket?.on('exception', (data) {
      if (data != null && !_errorController.isClosed) {
        _errorController.add(Map<String, dynamic>.from(data));
      }
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
    if (_socket == null) {
      debugPrint('Error: Socket is null');
      return;
    }

    if (!_socket!.connected) {
      debugPrint('Waiting for socket to connect before joining room...');
      // Wait for connection or timeout
      int retry = 0;
      while (!_socket!.connected && retry < 5) {
        await Future.delayed(const Duration(milliseconds: 500));
        retry++;
      }
    }

    if (!_socket!.connected) {
      debugPrint('Failed to connect to socket after retries');
      return;
    }

    debugPrint('Emitting chat:join-conversation for $conversationId');
    final completer = Completer<void>();
    _socket?.emitWithAck(
      'chat:join-conversation',
      {'conversationId': conversationId},
      ack: (dynamic response) {
        debugPrint('Join Conversation Ack for $conversationId: $response');
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
    debugPrint('Socket sendMessage called for $conversationId');
    if (_socket == null || !_socket!.connected) {
      debugPrint('Socket not connected, throwing exception for fallback');
      throw ServerException('Socket is not connected');
    }

    final completer = Completer<Map<String, dynamic>>();

    // Set a timeout for the acknowledgment
    final timeout = Timer(const Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        debugPrint('Socket sendMessage timed out');
        completer.completeError(
          ServerException('Message acknowledgment timed out'),
        );
      }
    });

    debugPrint(
      'Emitting chat:send-message with payload: {"conversationId": "$conversationId", "content": "$content"}',
    );
    _socket?.emitWithAck(
      'chat:send-message',
      {'conversationId': conversationId, 'content': content},
      ack: (dynamic response) {
        debugPrint('SendMessage Ack received: $response');
        timeout.cancel();
        if (completer.isCompleted) return;

        if (response is Map && response['ok'] == true) {
          // Check if data is nested under 'data' or is the response itself
          final dataMap = response['data'] is Map ? Map<String, dynamic>.from(response['data']) : {};
          
          // If messageId is present but not 'id', map it for the entity parser
          if (dataMap.containsKey('messageId') && !dataMap.containsKey('id')) {
            dataMap['id'] = dataMap['messageId'];
          }
          
          // Ensure mandatory fields for ChatMessageEntity exist in the ack data
          // If the ack is minimal, we merge it with our local knowledge
          final messageData = {
            'id': dataMap['id'] ?? dataMap['messageId'] ?? 'pending_${DateTime.now().millisecondsSinceEpoch}',
            'content': dataMap['content'] ?? content,
            'conversationId': dataMap['conversationId'] ?? conversationId,
            'createdAt': dataMap['createdAt'] ?? DateTime.now().toIso8601String(),
            'senderId': dataMap['senderId'] ?? dataMap['sender']?['id'] ?? '', 
            'isModerated': dataMap['isModerated'] ?? false,
          };
          
          completer.complete(messageData);
        } else {
          final errorMsg = response is Map && response['error'] != null
              ? (response['error'] is Map ? response['error']['message'] : response['error'].toString())
              : 'Failed to send message via socket';
          completer.completeError(ServerException(errorMsg));
        }
      },
    );
    return completer.future;
  }
}
