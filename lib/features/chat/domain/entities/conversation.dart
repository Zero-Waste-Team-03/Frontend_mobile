class ConversationEntity {
  final String id;
  final String reservationId;
  final String status;
  final DateTime createdAt;
  final String? lastMessage;

  ConversationEntity({
    required this.id,
    required this.reservationId,
    required this.status,
    required this.createdAt,
    this.lastMessage,
  });
}
