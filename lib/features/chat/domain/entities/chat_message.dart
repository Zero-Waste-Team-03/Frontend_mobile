enum MessageStatus { sending, sent, error }

class ChatMessageEntity {
  final String id;
  final String content;
  final DateTime createdAt;
  final bool isModerated;
  final String senderId;
  final String conversationId;
  final MessageStatus status;

  ChatMessageEntity({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isModerated,
    required this.senderId,
    required this.conversationId,
    this.status = MessageStatus.sent,
  });

  ChatMessageEntity copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    bool? isModerated,
    String? senderId,
    String? conversationId,
    MessageStatus? status,
  }) {
    return ChatMessageEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isModerated: isModerated ?? this.isModerated,
      senderId: senderId ?? this.senderId,
      conversationId: conversationId ?? this.conversationId,
      status: status ?? this.status,
    );
  }
}
