import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/conversation.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class ChatInitializeRequested extends ChatEvent {
  final String reservationId;

  const ChatInitializeRequested({required this.reservationId});

  @override
  List<Object?> get props => [reservationId];
}

class ChatMessagesLoadRequested extends ChatEvent {
  final String conversationId;
  final int page;
  final int limit;

  const ChatMessagesLoadRequested({
    required this.conversationId,
    this.page = 1,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [conversationId, page, limit];
}

class ChatMessageSent extends ChatEvent {
  final String conversationId;
  final String content;

  const ChatMessageSent({required this.conversationId, required this.content});

  @override
  List<Object?> get props => [conversationId, content];
}

class ChatMarkCompletedRequested extends ChatEvent {
  final String conversationId;

  const ChatMarkCompletedRequested({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

class ChatMessageReceived extends ChatEvent {
  final ChatMessageEntity message;

  const ChatMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatTransactionCompletedReceived extends ChatEvent {
  final ConversationEntity conversation;

  const ChatTransactionCompletedReceived(this.conversation);

  @override
  List<Object?> get props => [conversation];
}

class ChatLeaveConversationRequested extends ChatEvent {
  final String conversationId;

  const ChatLeaveConversationRequested(this.conversationId);

  @override
  List<Object?> get props => [conversationId];
}

class ChatApproveSensitiveMessageRequested extends ChatEvent {
  final String conversationId;
  final String messageId;

  const ChatApproveSensitiveMessageRequested({
    required this.conversationId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [conversationId, messageId];
}

class ChatSensitiveMessageApprovedReceived extends ChatEvent {
  final ChatMessageEntity message;

  const ChatSensitiveMessageApprovedReceived(this.message);

  @override
  List<Object?> get props => [message];
}

