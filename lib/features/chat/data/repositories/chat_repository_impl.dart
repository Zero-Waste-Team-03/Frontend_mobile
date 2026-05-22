import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/repositories/chat_repository.dart';
import '../sources/chat_remote_data_source.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ConversationEntity>>>
  getMyActiveConversations() async {
    try {
      final result = await remoteDataSource.getMyActiveConversations();
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>>
  getMyArchivedConversations() async {
    try {
      final result = await remoteDataSource.getMyArchivedConversations();
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> getConversation(
    String conversationId,
  ) async {
    try {
      final result = await remoteDataSource.getConversation(conversationId);
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> getOrCreateConversation({
    String? reservationId,
    String? conversationId,
  }) async {
    try {
      final result = await remoteDataSource.getOrCreateConversation(
        reservationId: reservationId,
        conversationId: conversationId,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessageEntity>>> getConversationMessages(
    String conversationId, {
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final result = await remoteDataSource.getConversationMessages(
        conversationId,
        page,
        limit,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage(
    String conversationId,
    String content,
  ) async {
    try {
      final result = await remoteDataSource.sendMessage(
        conversationId,
        content,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> markTransactionCompleted(
    String conversationId,
  ) async {
    try {
      final result = await remoteDataSource.markTransactionCompleted(
        conversationId,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> initSocket() async {
    try {
      await remoteDataSource.initSocket();
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  void disposeSocket() => remoteDataSource.disposeSocket();

  @override
  Future<Either<Failure, void>> joinConversation(String conversationId) async {
    try {
      await remoteDataSource.joinConversation(conversationId);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leaveConversation(String conversationId) async {
    try {
      await remoteDataSource.leaveConversation(conversationId);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> approveSensitiveMessage(
    String conversationId,
    String messageId,
  ) async {
    try {
      await remoteDataSource.approveSensitiveMessage(conversationId, messageId);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> reportUser({
    required String userId,
    required String reason,
    String? description,
  }) async {
    try {
      await remoteDataSource.reportUser(
        userId: userId,
        reason: reason,
        description: description,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<ChatMessageEntity> get onMessageCreated =>
      remoteDataSource.onMessageCreated;

  @override
  Stream<ChatMessageEntity> get onSensitiveMessageApproved =>
      remoteDataSource.onSensitiveMessageApproved;

  @override
  Stream<ConversationEntity> get onTransactionCompleted =>
      remoteDataSource.onTransactionCompleted;
}
