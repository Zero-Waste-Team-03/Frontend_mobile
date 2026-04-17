import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
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
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    _transactionSubscription?.cancel();
    chatRepository.disposeSocket();
    return super.close();
  }

  Future<void> _onInitialize(
    ChatInitializeRequested event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());

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
        // Initialize socket and join conversation room
        await chatRepository.initSocket();

        _messageSubscription?.cancel();
        _messageSubscription = chatRepository.onMessageCreated.listen((
          message,
        ) {
          add(ChatMessageReceived(message));
        });

        _transactionSubscription?.cancel();
        _transactionSubscription = chatRepository.onTransactionCompleted.listen(
          (conv) {
            add(ChatTransactionCompletedReceived(conv));
          },
        );

        await chatRepository.joinConversation(conversation.id);

        // Fetch initial messages
        final messagesResult = await chatRepository.getConversationMessages(
          conversation.id,
        );

        messagesResult.fold(
          (f) => emit(ChatError(f.message)),
          (msgs) =>
              emit(ChatLoaded(conversation: conversation, messages: msgs)),
        );
      },
    );
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
      final result = await chatRepository.sendMessage(
        event.conversationId,
        event.content,
      );

      result.fold((f) => emit(ChatError(f.message)), (newMessage) {
        // Prepend the new message since standard list views are often reversed or added
        final msgs = List.of(currentState.messages);
        msgs.insert(0, newMessage);

        emit(currentState.copyWith(messages: msgs));
      });
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
}
