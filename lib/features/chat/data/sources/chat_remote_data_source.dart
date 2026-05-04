import 'package:flutter/foundation.dart';
import 'package:ferry/ferry.dart' hide ServerException;
import 'package:injectable/injectable.dart';
import 'chat_socket_service.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/conversation.dart';
import '../datasources/graphql/__generated__/conversation_messages.req.gql.dart';
import '../datasources/graphql/__generated__/get_or_create_conversation.req.gql.dart';
import '../datasources/graphql/__generated__/mark_transaction_completed.req.gql.dart';
import '../datasources/graphql/__generated__/send_message.req.gql.dart';
import '../datasources/graphql/__generated__/send_message.var.gql.dart';
import '../datasources/graphql/__generated__/conversation_messages.var.gql.dart';
import '../datasources/graphql/__generated__/my_active_conversations.req.gql.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationEntity>> getMyActiveConversations();
  Future<ConversationEntity> getOrCreateConversation(String reservationId);
  Future<List<ChatMessageEntity>> getConversationMessages(
    String conversationId,
    int page,
    int limit,
  );
  Future<ChatMessageEntity> sendMessage(String conversationId, String content);
  Future<ConversationEntity> markTransactionCompleted(String conversationId);

  Future<void> initSocket();
  void disposeSocket();
  Future<void> joinConversation(String conversationId);
  Future<void> leaveConversation(String conversationId);
  Future<void> approveSensitiveMessage(String conversationId, String messageId);

  Stream<ChatMessageEntity> get onMessageCreated;
  Stream<ChatMessageEntity> get onSensitiveMessageApproved;
  Stream<ConversationEntity> get onTransactionCompleted;
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Client _ferryClient;
  final ChatSocketService _socketService;

  ChatRemoteDataSourceImpl(this._ferryClient, this._socketService);

  @override
  Future<void> initSocket() => _socketService.initSocket();

  @override
  void disposeSocket() => _socketService.dispose();

  @override
  Future<void> joinConversation(String conversationId) =>
      _socketService.joinConversation(conversationId);

  @override
  Future<void> leaveConversation(String conversationId) =>
      _socketService.leaveConversation(conversationId);

  @override
  Future<void> approveSensitiveMessage(
    String conversationId,
    String messageId,
  ) => _socketService.approveSensitiveMessage(conversationId, messageId);

  @override
  Stream<ChatMessageEntity> get onMessageCreated =>
      _socketService.onMessageCreated.map(
        (data) => ChatMessageEntity(
          id: data['id'] ?? '',
          content: data['content'] ?? '',
          createdAt: data['createdAt'] != null
              ? DateTime.parse(data['createdAt'])
              : DateTime.now(),
          isModerated: data['isModerated'] ?? false,
          senderId: data['senderId'] ?? '',
          conversationId: data['conversationId'] ?? '',
        ),
      );

  @override
  Stream<ChatMessageEntity> get onSensitiveMessageApproved =>
      _socketService.onSensitiveMessageApproved.map(
        (data) => ChatMessageEntity(
          id: data['id'] ?? '',
          content: data['content'] ?? '',
          createdAt: data['createdAt'] != null
              ? DateTime.parse(data['createdAt'])
              : DateTime.now(),
          isModerated: data['isModerated'] ?? false,
          senderId: data['senderId'] ?? '',
          conversationId: data['conversationId'] ?? '',
        ),
      );

  @override
  Stream<ConversationEntity> get onTransactionCompleted =>
      _socketService.onTransactionCompleted.map(
        (data) => ConversationEntity(
          id: data['conversationId'] ?? '',
          reservationId: '', // Usually omitted in event
          status: data['status'] ?? 'Archived',
          createdAt: DateTime.now(),
        ),
      );

  @override
  Future<ConversationEntity> getOrCreateConversation(
    String reservationId,
  ) async {
    final req = GGetOrCreateConversationReq(
      (b) => b
        ..vars.reservationId = reservationId
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );
    final response = await _executeRequest(req, 'getOrCreateConversation');
    final data = response.getOrCreateConversation;

    final conversation = ConversationEntity(
      id: data.id,
      reservationId: data.reservationId,
      status: data.status.name,
      createdAt: _safeParseDate(data.createdAt.value),
      lastMessage: data.lastMessage,
    );

    // Proactively join the socket room after getting the conversation ID
    _socketService.joinConversation(conversation.id);

    return conversation;
  }


  @override
  Future<List<ChatMessageEntity>> getConversationMessages(
    String conversationId,
    int page,
    int limit,
  ) async {
    final vars = GGetConversationMessagesVarsBuilder()
      ..input.conversationId = conversationId
      ..input.pagination.page = page
      ..input.pagination.limit = limit;

    final req = GGetConversationMessagesReq(
      (b) => b
        ..vars = vars
        ..fetchPolicy = FetchPolicy.NetworkOnly,
    );
    final response = await _executeRequest(req, 'conversationMessages');

    final messages = response.conversationMessages.items
        .map(
          (e) => ChatMessageEntity(
            id: e.id,
            content: e.content,
            createdAt: _safeParseDate(e.createdAt.value),
            isModerated: e.isModerated,
            senderId: e.senderId,
            conversationId: e.conversationId,
          ),
        )
        .toList();

    // Ensure messages are sorted by date (newest first) for the reverse ListView
    messages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return messages;
  }

  @override
  Future<ChatMessageEntity> sendMessage(
    String conversationId,
    String content,
  ) async {
    debugPrint('DataSouce.sendMessage called for $conversationId');
    try {
      // 1. Attempt via Socket first
      debugPrint('Attempting socket sendMessage...');
      final data = await _socketService.sendMessage(conversationId, content);
      debugPrint('Socket sendMessage success: $data');
      
      return ChatMessageEntity(
        id: data['id'] ?? '',
        content: data['content'] ?? '',
        createdAt: data['createdAt'] != null
            ? DateTime.parse(data['createdAt'])
            : DateTime.now(),
        isModerated: data['isModerated'] ?? false,
        senderId: data['senderId']?.toString() ?? '',
        conversationId: data['conversationId'] ?? '',
      );
    } catch (socketError) {
      // 2. Fallback to GraphQL if socket fails
      debugPrint('Socket sendMessage failed: $socketError. Falling back to GraphQL...');
      try {
        final vars = GSendMessageVarsBuilder()
          ..input.conversationId = conversationId
          ..input.content = content;

        final req = GSendMessageReq((b) => b..vars = vars);
        final response = await _executeRequest(req, 'sendMessage');
        final data = response.sendMessage;

        debugPrint('GraphQL sendMessage success');
        return ChatMessageEntity(
          id: data.id,
          content: data.content,
          createdAt: _safeParseDate(data.createdAt.value),
          isModerated: data.isModerated,
          senderId: data.senderId,
          conversationId: data.conversationId,
        );
      } catch (graphqlError) {
        // 3. If both fail, rethrow with descriptive message
        debugPrint('GraphQL sendMessage failed: $graphqlError');
        throw ServerException('Failed to send message. Socket error: $socketError. GraphQL error: $graphqlError');
      }
    }
  }

  @override
  Future<List<ConversationEntity>> getMyActiveConversations() async {
    final req = GMyActiveConversationsReq((b) => b..fetchPolicy = FetchPolicy.NetworkOnly);
    final response = await _executeRequest(req, 'myActiveConversations');

    return response.myActiveConversations
        .map(
          (e) => ConversationEntity(
            id: e.id,
            reservationId: e.reservationId,
            status: e.status.name,
            createdAt: _safeParseDate(e.createdAt.value),
            lastMessage: e.lastMessage,
            counterpartName: e.counterpart.displayName,
            counterpartAvatarUrl: e.counterpart.avatarUrl,
          ),
        )
        .toList();
  }


  DateTime _safeParseDate(String? value) {
    if (value == null) return DateTime.now();
    try {
      return DateTime.parse(value);
    } catch (_) {
      return DateTime.now();
    }
  }

  @override
  Future<ConversationEntity> markTransactionCompleted(
    String conversationId,
  ) async {
    final req = GMarkTransactionCompletedReq(
      (b) => b..vars.input.conversationId = conversationId,
    );
    final response = await _executeRequest(req, 'markTransactionCompleted');
    final data = response.markTransactionCompleted;

    return ConversationEntity(
      id: data.id,
      reservationId:
          '', // Usually markTransactionCompleted only returns id, status, lastMessage
      status: data.status.name,
      createdAt: DateTime.now(), // Fallback
      lastMessage: data.lastMessage,
    );
  }

  Future<TData> _executeRequest<TData, TVars>(
    OperationRequest<TData, TVars> request,
    String operationName,
  ) async {
    try {
      // Set fetch policy to network only for mutations or if needed
      // Ferry usually handles this via the request, but we can ensure it here
      
      debugPrint('Executing GraphQL Request: $operationName');
      final token = await _socketService.authLocalDataSource.getAccessToken();
      debugPrint('GraphQL Token: Bearer $token');
      
      final response = await _ferryClient.request(request).firstWhere((event) {
        // Skip optimistic data and wait for actual data or error
        if (event.dataSource == DataSource.Optimistic) return false;
        // Also skip cache if it's empty to force network fetch in some scenarios
        if (event.dataSource == DataSource.Cache && event.data == null) return false;
        return true;
      });

      if (response.hasErrors || response.linkException != null) {
        final message =
            response.graphqlErrors?.isNotEmpty == true
                ? response.graphqlErrors!.first.message
                : response.linkException?.toString() ?? 'Unknown error';
        throw ServerException(message);
      }

      final data = response.data;
      if (data == null) {
        throw ServerException('No data returned for $operationName');
      }

      return data;
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Request failed during $operationName: $e');
    }
  }
}
