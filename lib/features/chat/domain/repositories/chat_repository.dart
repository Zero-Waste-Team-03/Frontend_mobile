import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/conversation.dart';
import '../entities/chat_message.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ConversationEntity>>> getMyActiveConversations();
  Future<Either<Failure, ConversationEntity>> getOrCreateConversation(
    String reservationId,
  );
  Future<Either<Failure, List<ChatMessageEntity>>> getConversationMessages(
    String conversationId, {
    int page = 1,
    int limit = 20,
  });
  Future<Either<Failure, ChatMessageEntity>> sendMessage(
    String conversationId,
    String content,
  );
  Future<Either<Failure, ConversationEntity>> markTransactionCompleted(
    String conversationId,
  );

  Future<Either<Failure, void>> initSocket();
  void disposeSocket();
  Future<Either<Failure, void>> joinConversation(String conversationId);
  Future<Either<Failure, void>> leaveConversation(String conversationId);
  Future<Either<Failure, void>> approveSensitiveMessage(
    String conversationId,
    String messageId,
  );

  Stream<ChatMessageEntity> get onMessageCreated;
  Stream<ChatMessageEntity> get onSensitiveMessageApproved;
  Stream<ConversationEntity> get onTransactionCompleted;
}
