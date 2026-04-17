import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/conversation.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final ConversationEntity conversation;
  final List<ChatMessageEntity> messages;
  final bool hasReachedMax;

  const ChatLoaded({
    required this.conversation,
    required this.messages,
    this.hasReachedMax = false,
  });

  ChatLoaded copyWith({
    ConversationEntity? conversation,
    List<ChatMessageEntity>? messages,
    bool? hasReachedMax,
  }) {
    return ChatLoaded(
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [conversation, messages, hasReachedMax];
}

class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
