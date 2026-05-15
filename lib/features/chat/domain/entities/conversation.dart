class ConversationEntity {
  final String id;
  final String reservationId;
  final String status;
  final DateTime createdAt;
  final String? lastMessage;
  final String? counterpartName;
  final String? counterpartAvatarUrl;
  final String? counterpartId;
  final String? donationTitle;
  final String? donationImageUrl;

  final bool isOnline;

  ConversationEntity({
    required this.id,
    required this.reservationId,
    required this.status,
    required this.createdAt,
    this.lastMessage,
    this.counterpartName,
    this.counterpartAvatarUrl,
    this.counterpartId,
    this.donationTitle,
    this.donationImageUrl,
    this.isOnline = false,
  });

  ConversationEntity copyWith({
    String? id,
    String? reservationId,
    String? status,
    DateTime? createdAt,
    String? lastMessage,
    String? counterpartName,
    String? counterpartAvatarUrl,
    String? counterpartId,
    String? donationTitle,
    String? donationImageUrl,
    bool? isOnline,
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      reservationId: reservationId ?? this.reservationId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastMessage: lastMessage ?? this.lastMessage,
      counterpartName: counterpartName ?? this.counterpartName,
      counterpartAvatarUrl: counterpartAvatarUrl ?? this.counterpartAvatarUrl,
      counterpartId: counterpartId ?? this.counterpartId,
      donationTitle: donationTitle ?? this.donationTitle,
      donationImageUrl: donationImageUrl ?? this.donationImageUrl,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}

