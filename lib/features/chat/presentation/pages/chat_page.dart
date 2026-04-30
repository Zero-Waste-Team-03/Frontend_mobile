import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/core/di/injection.dart';

import 'package:gaspzero/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaspzero/features/auth/presentation/bloc/auth_state.dart';
import '../../../../shared/theme/app_colors.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/chat_bubble.dart';

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
  final ScrollController _scrollController = ScrollController();

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
      // Scroll to bottom after message sent (since reverse is true, bottom is index 0)
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ChatError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final bool isActive =
            state is ChatLoaded && state.conversation.status == 'Active';

        return Scaffold(
          backgroundColor: AuthColors.background,
          appBar: _buildAppBar(context, state),
          body: Column(
            children: [
              _buildStatusBanner(state),
              Expanded(child: _buildMessageList(context, state)),
              _buildInputArea(context, isActive),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ChatState state) {
    return AppBar(
      backgroundColor: AuthColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          if (state is ChatLoaded && state.conversation.counterpartAvatarUrl != null)
            CircleAvatar(
              radius: 16.r,
              backgroundImage: NetworkImage(state.conversation.counterpartAvatarUrl!),
            )
          else if (state is ChatLoaded)
            CircleAvatar(
              radius: 16.r,
              backgroundColor: AuthColors.primary.withValues(alpha: 0.1),
              child: Icon(Icons.person, size: 18.sp, color: AuthColors.primary),
            ),
          if (state is ChatLoaded) SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state is ChatLoaded ? (state.conversation.counterpartName ?? 'Chat') : 'Chat',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AuthColors.headingText,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.primaryFont,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (state is ChatLoaded)
                  Text(
                    state.conversation.status,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: state.conversation.status == 'Active'
                          ? AuthColors.primary
                          : AuthColors.subText,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Divider(height: 1.h, color: AuthColors.dividerColor),
      ),
      actions: [
        if (state is ChatLoaded && state.conversation.status == 'Active')
          Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: TextButton.icon(
              onPressed: () {
                context.read<ChatBloc>().add(
                  ChatMarkCompletedRequested(
                    conversationId: state.conversation.id,
                  ),
                );
              },
              icon: Icon(Icons.check_circle_outline, size: 20.sp),
              label: Text(
                'Finish',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(foregroundColor: AuthColors.primary),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusBanner(ChatState state) {
    if (state is ChatLoaded && state.conversation.status != 'Active') {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: AuthColors.lightGrayBackground,
          border: Border(
            bottom: BorderSide(color: AuthColors.dividerColor, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 16.sp, color: AuthColors.subText),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                'This conversation is ${state.conversation.status.toLowerCase()}. You cannot send messages.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AuthColors.subText,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildMessageList(BuildContext context, ChatState state) {
    if (state is ChatLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AuthColors.primary),
      );
    }

    if (state is ChatLoaded) {
      final msgs = state.messages;
      if (msgs.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 48.sp,
                color: AuthColors.subText.withValues(alpha: 0.3),
              ),
              SizedBox(height: 16.h),
              Text(
                'No messages yet',
                style: TextStyle(
                  color: AuthColors.subText,
                  fontSize: 16.sp,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Say hello to start the conversation!',
                style: TextStyle(
                  color: AuthColors.subText.withValues(alpha: 0.7),
                  fontSize: 14.sp,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        controller: _scrollController,
        reverse: true,
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium.w,
          vertical: AppDimensions.paddingMedium.h,
        ),
        itemCount: msgs.length,
        itemBuilder: (context, index) {
          final msg = msgs[index];
          final authState = context.watch<AuthBloc>().state;
          final String? currentUserId =
              authState is AuthSuccess ? authState.user?.id : null;

          final bool isMe = currentUserId != null && msg.senderId == currentUserId;

          return ChatBubble(
            message: msg,
            isMe: isMe,
            onApproveReveal: () {
              context.read<ChatBloc>().add(
                    ChatApproveSensitiveMessageRequested(
                      conversationId: state.conversation.id,
                      messageId: msg.id,
                    ),
                  );
            },
          );
        },
      );
    }

    if (state is ChatError) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              SizedBox(height: 16.h),
              Text(
                state.message,
                textAlign: TextAlign.center,
                style: TextStyle(color: AuthColors.headingText, fontSize: 14.sp),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  // Retry logic?
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildInputArea(BuildContext context, bool isActive) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: MediaQuery.of(context).padding.bottom + 12.h,
      ),
      decoration: BoxDecoration(
        color: AuthColors.inputBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AuthColors.lightGrayBackground,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: _msgController,
                enabled: isActive,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AuthColors.headingText,
                  fontFamily: AppFonts.primaryFont,
                ),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: AuthColors.subText,
                    fontSize: 15.sp,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                ),
                maxLines: 4,
                minLines: 1,
                onSubmitted: (_) => _sendMessage(context),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: isActive ? () => _sendMessage(context) : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: isActive ? AuthColors.primary : AuthColors.subText.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                boxShadow: isActive ? [
                  BoxShadow(
                    color: AuthColors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ] : null,
              ),
              child: Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
