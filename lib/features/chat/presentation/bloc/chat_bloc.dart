import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../../core/di/injection.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_event.dart';
import 'chat_state.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  final Logger _logger = Logger();

  StreamSubscription? _messageSubscription;
  StreamSubscription? _transactionSubscription;

  ChatBloc({required this.chatRepository}) : super(ChatInitial()) {
    on<ChatInitializeRequested>(_onInitialize);
    on<ChatMessagesLoadRequested>(_onLoadMessages);
    on<ChatMessageSent>(_onSendMessage);
    on<ChatMarkCompletedRequested>(_onMarkCompleted);
    on<ChatMessageReceived>(_onMessageReceived);
    on<ChatTransactionCompletedReceived>(_onTransactionCompletedReceived);
    on<ChatLeaveConversationRequested>(_onLeaveConversation);
    on<ChatApproveSensitiveMessageRequested>(_onApproveSensitiveMessage);
    on<ChatSensitiveMessageApprovedReceived>(_onSensitiveMessageApprovedReceived);
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _transactionSubscription?.cancel();
    _sensitiveMessageSubscription?.cancel();
    chatRepository.disposeSocket();
    return super.close();
  }

  StreamSubscription? _sensitiveMessageSubscription;

  Future<void> _onInitialize(
    ChatInitializeRequested event,
    Emitter<ChatState> emit,
  ) async {
    _logger.i('Initializing chat for reservation: ${event.reservationId}');
    emit(ChatLoading());

    try {
      // 1. Get or create conversation
      final result = await chatRepository.getOrCreateConversation(
        event.reservationId,
      );

      await result.fold(
        (failure) async {
          _logger.e('Chat Init Failed: ${failure.message}');
          emit(ChatError(failure.message));
        },
        (conversation) async {
          _logger.i('Conversation obtained: ${conversation.id}');
          // Initialize socket
          await chatRepository.initSocket();

          _messageSubscription?.cancel();
          _messageSubscription = chatRepository.onMessageCreated.listen((
            message,
          ) {
            add(ChatMessageReceived(message));
          });

          _transactionSubscription?.cancel();
          _transactionSubscription =
              chatRepository.onTransactionCompleted.listen((conv) {
                add(ChatTransactionCompletedReceived(conv));
              });

          _sensitiveMessageSubscription?.cancel();
          _sensitiveMessageSubscription =
              chatRepository.onSensitiveMessageApproved.listen((message) {
                add(ChatSensitiveMessageApprovedReceived(message));
              });

          // Join conversation room in background
          chatRepository.joinConversation(conversation.id).then((_) {
            _logger.i('Joined conversation room: ${conversation.id}');
          }).catchError((e) {
            _logger.e('Failed to join conversation room: $e');
          });

          // Fetch initial messages
          final messagesResult = await chatRepository.getConversationMessages(
            conversation.id,
          );

          messagesResult.fold(
            (f) {
              _logger.e('Failed to fetch messages: ${f.message}');
              emit(ChatError(f.message));
            },
            (msgs) {
              _logger.i('Chat loaded with ${msgs.length} messages');
              emit(ChatLoaded(conversation: conversation, messages: msgs));
            },
          );
        },
      );
    } catch (e) {
      _logger.e('Unexpected error during chat initialization: $e');
      emit(ChatError('An unexpected error occurred: $e'));
    }
  }


  Future<void> _onLoadMessages(
    ChatMessagesLoadRequested event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is ChatLoaded && !currentState.hasReachedMax) {
      final messagesResult = await chatRepository.getConversationMessages(
        event.conversationId,
        page: event.page,
        limit: event.limit,
      );

      messagesResult.fold(
        (failure) => _logger.e('Failed to load messages page \${event.page}'),
        (msgs) {
          emit(
            currentState.copyWith(
              // We append below, assume the backend sorts them, or sort dynamically.
              messages: [...currentState.messages, ...msgs],
              hasReachedMax: msgs.isEmpty,
            ),
          );
        },
      );
    }
  }

  Future<void> _onSendMessage(
    ChatMessageSent event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is ChatLoaded) {
      final authState = getIt<AuthBloc>().state;
      final String currentUserId =
          authState is AuthSuccess ? authState.user!.id : '';

      // 1. Create a temporary "sending" message
      final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
      final tempMessage = ChatMessageEntity(
        id: tempId,
        content: event.content,
        createdAt: DateTime.now(),
        isModerated: false,
        senderId: currentUserId,
        conversationId: event.conversationId,
        status: MessageStatus.sending,
      );

      // 2. Prepend the temporary message to the list immediately
      final msgsBefore = List.of(currentState.messages);
      msgsBefore.insert(0, tempMessage);
      emit(currentState.copyWith(messages: msgsBefore));

      // 3. Send to server
      final result = await chatRepository.sendMessage(
        event.conversationId,
        event.content,
      );

      final postSendState = state;
      if (postSendState is ChatLoaded) {
        final currentMsgs = List.of(postSendState.messages);

        result.fold(
          (failure) {
            // Update temp message to "error"
            final index = currentMsgs.indexWhere((m) => m.id == tempId);
            if (index != -1) {
              currentMsgs[index] = currentMsgs[index].copyWith(
                status: MessageStatus.error,
              );
              emit(postSendState.copyWith(messages: currentMsgs));
            }
          },
          (newMessage) {
            // Replace temp message with real "sent" message
            final index = currentMsgs.indexWhere((m) => m.id == tempId);
            final messageToInsert = currentUserId.isNotEmpty &&
                    (newMessage.senderId.isEmpty || newMessage.senderId == '')
                ? newMessage.copyWith(senderId: currentUserId, status: MessageStatus.sent)
                : newMessage.copyWith(status: MessageStatus.sent);

            if (index != -1) {
              currentMsgs[index] = messageToInsert;
              emit(postSendState.copyWith(messages: currentMsgs));
            } else {
              // If temp was already removed or list changed drastically
              final exists = currentMsgs.any((m) => m.id == messageToInsert.id);
              if (!exists) {
                currentMsgs.insert(0, messageToInsert);
                emit(postSendState.copyWith(messages: currentMsgs));
              }
            }
          },
        );
      }
    }
  }

  Future<void> _onMarkCompleted(
    ChatMarkCompletedRequested event,
    Emitter<ChatState> emit,
  ) async {
    final currentState = state;
    if (currentState is ChatLoaded) {
      final result = await chatRepository.markTransactionCompleted(
        event.conversationId,
      );
      result.fold(
        (f) => _logger.e('Failed marking transaction completed'),
        (conv) => emit(currentState.copyWith(conversation: conv)),
      );
    }
  }

  void _onMessageReceived(ChatMessageReceived event, Emitter<ChatState> emit) {
    final currentState = state;
    if (currentState is ChatLoaded) {
      // Prevent duplicates by checking ID
      final exists = currentState.messages.any((m) => m.id == event.message.id);
      if (!exists) {
        final updatedMessages = List.of(currentState.messages)
          ..insert(0, event.message);
        emit(currentState.copyWith(messages: updatedMessages));
      }
    }
  }

  void _onTransactionCompletedReceived(
    ChatTransactionCompletedReceived event,
    Emitter<ChatState> emit,
  ) {
    final currentState = state;
    if (currentState is ChatLoaded) {
      emit(currentState.copyWith(conversation: event.conversation));
    }
  }

  Future<void> _onLeaveConversation(
    ChatLeaveConversationRequested event,
    Emitter<ChatState> emit,
  ) async {
    await chatRepository.leaveConversation(event.conversationId);
  }

  Future<void> _onApproveSensitiveMessage(
    ChatApproveSensitiveMessageRequested event,
    Emitter<ChatState> emit,
  ) async {
    final result = await chatRepository.approveSensitiveMessage(
      event.conversationId,
      event.messageId,
    );
    result.fold(
      (f) => _logger.e('Failed to approve message: ${f.message}'),
      (_) => null,
    );
  }

  void _onSensitiveMessageApprovedReceived(
    ChatSensitiveMessageApprovedReceived event,
    Emitter<ChatState> emit,
  ) {
    final currentState = state;
    if (currentState is ChatLoaded) {
      final updatedMessages = currentState.messages.map((m) {
        if (m.id == event.message.id) {
          return event.message;
        }
        return m;
      }).toList();
      emit(currentState.copyWith(messages: updatedMessages));
    }
  }
}
