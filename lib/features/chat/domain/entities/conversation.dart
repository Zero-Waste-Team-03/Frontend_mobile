class ConversationEntity {
  final String id;
  final String reservationId;
  final String status;
  final DateTime createdAt;
  final String? lastMessage;
  final String? counterpartName;
  final String? counterpartAvatarUrl;
  final String? donationTitle;
  final String? donationImageUrl;

  ConversationEntity({
    required this.id,
    required this.reservationId,
    required this.status,
    required this.createdAt,
    this.lastMessage,
    this.counterpartName,
    this.counterpartAvatarUrl,
    this.donationTitle,
    this.donationImageUrl,
  });

  ConversationEntity copyWith({
    String? id,
    String? reservationId,
    String? status,
    DateTime? createdAt,
    String? lastMessage,
    String? counterpartName,
    String? counterpartAvatarUrl,
    String? donationTitle,
    String? donationImageUrl,
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      reservationId: reservationId ?? this.reservationId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      counterpartName: counterpartName ?? this.counterpartName,
      counterpartAvatarUrl: counterpartAvatarUrl ?? this.counterpartAvatarUrl,
      donationTitle: donationTitle ?? this.donationTitle,
      donationImageUrl: donationImageUrl ?? this.donationImageUrl,
    );
  }
}

