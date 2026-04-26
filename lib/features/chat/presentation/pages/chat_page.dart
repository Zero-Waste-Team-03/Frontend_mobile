import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/core/di/injection.dart';

import '../../../../shared/theme/app_colors.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';

class ChatPage extends StatelessWidget {
  final String reservationId;

  const ChatPage({super.key, required this.reservationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ChatBloc>()
            ..add(ChatInitializeRequested(reservationId: reservationId)),
      child: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgController = TextEditingController();

  void _sendMessage(BuildContext context) {
    if (_msgController.text.trim().isEmpty) return;

    final state = context.read<ChatBloc>().state;
    if (state is ChatLoaded) {
      context.read<ChatBloc>().add(
        ChatMessageSent(
          conversationId: state.conversation.id,
          content: _msgController.text.trim(),
        ),
      );
      _msgController.clear();
    }
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = context.watch<ChatBloc>().state;
    final bool isActive = chatState is ChatLoaded
        ? chatState.conversation.status == 'Active'
        : false;
    final String statusText = chatState is ChatLoaded
        ? chatState.conversation.status
        : '';

    return Scaffold(
      backgroundColor: AuthColors.background,
      appBar: AppBar(
        backgroundColor: AuthColors.background,
        elevation: 1,
        title: Text(
          'Chat',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            color: AuthColors.headingText,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AuthColors.headingText),
        actions: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoaded) {
                return IconButton(
                  icon: const Icon(
                    Icons.check_circle_outline,
                    color: AuthColors.primary,
                  ),
                  tooltip: 'Mark Complete',
                  onPressed: () {
                    context.read<ChatBloc>().add(
                      ChatMarkCompletedRequested(
                        conversationId: state.conversation.id,
                      ),
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (chatState is ChatLoaded && !isActive)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              color: AuthColors.subText.withValues(alpha: 0.2),
              child: Text(
                'Conversation is $statusText',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AuthColors.headingText,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
            ),
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: AuthColors.primary),
                  );
                } else if (state is ChatLoaded) {
                  final msgs = state.messages;

                  if (msgs.isEmpty) {
                    return Center(
                      child: Text(
                        'Say hi!',
                        style: TextStyle(
                          color: AuthColors.subText,
                          fontSize: 16.sp,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.all(AppDimensions.paddingMedium.w),
                    itemCount: msgs.length,
                    itemBuilder: (context, index) {
                      final msg = msgs[index];
                      final bool isMe = msg.senderId.isNotEmpty;

                      return Align(
                        alignment: isMe
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? AuthColors.primary
                                : AuthColors.inputBackground,
                            border: isMe
                                ? null
                                : Border.all(color: AuthColors.inputBorder),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: isMe
                                  ? const Radius.circular(16)
                                  : const Radius.circular(4),
                              bottomRight: isMe
                                  ? const Radius.circular(4)
                                  : const Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            msg.content,
                            style: TextStyle(
                              color: isMe
                                  ? Colors.white
                                  : AuthColors.headingText,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(
                    child: Text(
                      'Failed to load chat: \n\${state.message}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          // Input box
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: AuthColors.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      enabled: isActive,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: const TextStyle(color: AuthColors.inputText),
                        filled: true,
                        fillColor: AuthColors.inputBackground,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AuthColors.inputBorder,
                          ),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AuthColors.primary,
                          ),
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(context),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: isActive ? () => _sendMessage(context) : null,
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AuthColors.primary
                            : AuthColors.inputBorder,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
