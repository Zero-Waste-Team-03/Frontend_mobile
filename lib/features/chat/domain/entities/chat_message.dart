class ChatMessageEntity {
  final String id;
  final String content;
  final DateTime createdAt;
  final bool isModerated;
  final String senderId;
  final String conversationId;

  ChatMessageEntity({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isModerated,
    required this.senderId,
    required this.conversationId,
  });
}
