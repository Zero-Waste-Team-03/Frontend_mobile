import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:ferry/ferry.dart';
import 'package:gaspzero/features/chat/data/repositories/chat_repository_impl.dart';
import '../../../reservation/data/datasources/graphql/__generated__/my_reservation.req.gql.dart';
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
  final Client _ferryClient;
  final Logger _logger = Logger();

  StreamSubscription? _messageSubscription;
  StreamSubscription? _transactionSubscription;

  ChatBloc({required this.chatRepository, required Client ferryClient}) 
      : _ferryClient = ferryClient, 
        super(ChatInitial()) {
    on<ChatInitializeRequested>(_onInitialize);
    on<ChatMessagesLoadRequested>(_onLoadMessages);
    on<ChatMessageSent>(_onSendMessage);
    on<ChatMarkCompletedRequested>(_onMarkCompleted);
    on<ChatMessageReceived>(_onMessageReceived);
    on<ChatTransactionCompletedReceived>(_onTransactionCompletedReceived);
    on<ChatLeaveConversationRequested>(_onLeaveConversation);
    on<ChatApproveSensitiveMessageRequested>(_onApproveSensitiveMessage);
    on<ChatSensitiveMessageApprovedReceived>(_onSensitiveMessageApprovedReceived);
    on<ChatUserReportRequested>(_onReportUser);
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
    _logger.i(
      'Initializing chat for reservation: ${event.reservationId}, conversation: ${event.conversationId}',
    );
    emit(ChatLoading());

    try {
      // 1. Get or create conversation
      final result = await chatRepository.getOrCreateConversation(
        reservationId: event.reservationId,
        conversationId: event.conversationId,
      );

      await result.fold(
        (failure) async {
          _logger.e('Chat Init Failed: ${failure.message}');
          emit(ChatError(failure.message));
        },
        (conversation) async {
          _logger.i('Conversation obtained: ${conversation.id}');

          // CRITICAL: Initialize socket and setup listeners FIRST
          // This ensures that when we join the room, we are ready to receive events
          await chatRepository.initSocket();

          _messageSubscription?.cancel();
          _messageSubscription = chatRepository.onMessageCreated.listen((
            message,
          ) {
            _logger.d('Socket Event: New Message Received [${message.id}]');
            add(ChatMessageReceived(message));
          });

          _transactionSubscription?.cancel();
          _transactionSubscription = chatRepository.onTransactionCompleted
              .listen((conv) {
                _logger.d('Socket Event: Transaction Completed [${conv.id}]');
                add(ChatTransactionCompletedReceived(conv));
              });

          _sensitiveMessageSubscription?.cancel();
          _sensitiveMessageSubscription = chatRepository
              .onSensitiveMessageApproved
              .listen((message) {
                _logger.d(
                  'Socket Event: Sensitive Message Approved [${message.id}]',
                );
                add(ChatSensitiveMessageApprovedReceived(message));
              });

          // Join conversation room
          try {
            await chatRepository.joinConversation(conversation.id);
            _logger.i('Joined conversation room: ${conversation.id}');
          } catch (e) {
            _logger.e('Failed to join conversation room: $e');
          }

          // Fetch reservation/donation details to avoid hardcoded UI
          _logger.i('Fetching reservation details for reservationId: ${conversation.reservationId}');
          final reservationReq = GMyReservationReq(
            (b) => b
              ..vars.id = conversation.reservationId
              ..fetchPolicy = FetchPolicy.NetworkOnly,
          );

          String? donationTitle;
          String? donationImageUrl;
          String? counterpartName = conversation.counterpartName;
          String? counterpartAvatarUrl = conversation.counterpartAvatarUrl;
          String? counterpartId = conversation.counterpartId;

          final authState = getIt<AuthBloc>().state;
          String? currentUserId;
          if (authState is AuthSuccess) {
            currentUserId = authState.user?.id;
          } else {
            // Fallback: decode JWT from repository if Bloc state is not yet ready or in transition
            try {
              final dataSource = (chatRepository as ChatRepositoryImpl).remoteDataSource;
              final token = await dataSource.authLocalDataSource.getAccessToken();
              
              if (token != null) {
                // Manual decode to avoid jwt_decoder dependency issue if it's missing from pubspec
                final parts = token.split('.');
                if (parts.length == 3) {
                  final payload = parts[1];
                  final String decoded = String.fromCharCodes(base64Url.decode(base64Url.normalize(payload)));
                  final Map<String, dynamic> decodedToken = jsonDecode(decoded);
                  currentUserId = decodedToken['id'];
                  _logger.i('Recovered currentUserId from payload: $currentUserId');
                }
              }
            } catch (e) {
              _logger.e('Failed to recover userId from token: $e');
            }
          }

          try {
            final res = await _ferryClient.request(reservationReq).first;
            final reservationData = res.data?.myReservation;
            
            if (reservationData != null) {
              donationTitle = reservationData.donation?.title;
              donationImageUrl = reservationData.donation?.mainAttachment?.url;
              
              if (currentUserId != null) {
                if (reservationData.beneficiaryId == currentUserId) {
                  counterpartName = reservationData.donation?.user.displayName;
                  counterpartAvatarUrl = reservationData.donation?.user.avatar?.url;
                  counterpartId = reservationData.donation?.user.id;
                } else {
                  counterpartName = reservationData.beneficiary?.displayName;
                  counterpartAvatarUrl = reservationData.beneficiary?.avatar?.url;
                  counterpartId = reservationData.beneficiary?.id;
                }
              }
            }
          } catch (e) {
            _logger.e('Failed to fetch reservation details: $e');
          }

          final updatedConversation = conversation.copyWith(
            donationTitle: donationTitle,
            donationImageUrl: donationImageUrl,
            counterpartName: counterpartName ?? 'User',
            counterpartAvatarUrl: counterpartAvatarUrl,
            counterpartId: counterpartId,
          );

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
              emit(ChatLoaded(conversation: updatedConversation, messages: msgs));
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
        (failure) => _logger.e('Failed to load messages page ${event.page}'),
        (msgs) {
          // Prevent duplicate messages when backend pages overlap or indexing differs.
          final existingIds = currentState.messages.map((m) => m.id).toSet();
          final newMsgs = msgs
              .where((m) => !existingIds.contains(m.id))
              .toList();

          final combined = [...currentState.messages, ...newMsgs];

          // If the backend returned no items, we've reached the end.
          // Also consider we've reached the end if none of the fetched items were new.
          final reachedMax = msgs.isEmpty || newMsgs.isEmpty;

          _logger.d(
            'Loaded page ${event.page}: fetched=${msgs.length}, new=${newMsgs.length}',
          );

          emit(
            currentState.copyWith(
              messages: combined,
              hasReachedMax: reachedMax,
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
      final String currentUserId = authState is AuthSuccess
          ? authState.user!.id
          : '';

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
            final messageToInsert =
                currentUserId.isNotEmpty &&
                    (newMessage.senderId.isEmpty || newMessage.senderId == '')
                ? newMessage.copyWith(
                    senderId: currentUserId,
                    status: MessageStatus.sent,
                  )
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

  Future<void> _onReportUser(
    ChatUserReportRequested event,
    Emitter<ChatState> emit,
  ) async {
    final result = await chatRepository.reportUser(
      userId: event.userId,
      reason: event.reason,
      description: event.description,
    );
    result.fold(
      (f) => _logger.e('Failed to report user: ${f.message}'),
      (_) => _logger.i('User reported successfully'),
    );
  }
}
