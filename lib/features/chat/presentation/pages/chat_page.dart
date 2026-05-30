import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gaspzero/core/di/injection.dart';

import 'package:gaspzero/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gaspzero/features/auth/presentation/bloc/auth_state.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';
import '../bloc/chat_state.dart';
import '../widgets/chat_bubble.dart';

class ChatPage extends StatelessWidget {
  final String? reservationId;
  final String? conversationId;

  const ChatPage({super.key, this.reservationId, this.conversationId})
    : assert(
        reservationId != null || conversationId != null,
        'Either reservationId or conversationId must be provided',
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatBloc>()
        ..add(
          ChatInitializeRequested(
            reservationId: reservationId,
            conversationId: conversationId,
          ),
        ),
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
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.hasClients && !_isLoadingMore) {
        // In a reverse ListView, scrolling up increases pixel offset
        // Load more when user scrolls past 60% from the top (towards older messages)
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;

        if (currentScroll >= maxScroll * 0.6) {
          final chatBloc = context.read<ChatBloc>();
          final state = chatBloc.state;

          if (state is ChatLoaded && !state.hasReachedMax) {
            _isLoadingMore = true;
            _currentPage++;
            chatBloc.add(
              ChatMessagesLoadRequested(
                conversationId: state.conversation.id,
                page: _currentPage,
                limit: 20,
              ),
            );

            // Reset after a brief delay to allow for the state update
            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                _isLoadingMore = false;
              }
            });
          }
        }
      }
    });
  }

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
        final colors = context.themeColors;
        final bool isActive =
            state is ChatLoaded &&
            (state.conversation.status == 'Active' ||
                state.conversation.status == 'ACTIVE');

        return Scaffold(
          backgroundColor: colors.background,
          appBar: _buildAppBar(context, state, colors),
          body: Column(
            children: [
              _buildStatusBanner(state, colors),
              Expanded(child: _buildMessageList(context, state, colors)),
              _buildInputArea(context, isActive, colors),
            ],
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, ChatState state, ThemeColors colors) {
    final String? donationTitle = state is ChatLoaded
        ? state.conversation.donationTitle
        : null;

    return AppBar(
      backgroundColor: colors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          if (state is ChatLoaded &&
              (state.conversation.donationImageUrl != null ||
                  state.conversation.counterpartAvatarUrl != null))
            Stack(
              children: [
                if (state.conversation.donationImageUrl != null)
                  Container(
                    width: 36.r,
                    height: 36.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: NetworkImage(
                          state.conversation.donationImageUrl!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  CircleAvatar(
                    radius: 18.r,
                    backgroundImage: NetworkImage(
                      state.conversation.counterpartAvatarUrl!,
                    ),
                  ),
                if (state.conversation.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                    ),
                  ),
              ],
            )
          else if (state is ChatLoaded)
            Stack(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: colors.primary.withValues(alpha: 0.1),
                  child: Icon(Icons.person, size: 20.sp, color: colors.primary),
                ),
                if (state.conversation.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 10.r,
                      height: 10.r,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                    ),
                  ),
              ],
            ),
          if (state is ChatLoaded) SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state is ChatLoaded
                      ? (state.conversation.counterpartName ?? 'User')
                      : 'Loading...',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: colors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.primaryFont,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (state is ChatLoaded && donationTitle != null)
                  Text(
                    donationTitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: colors.textSecondary,
                      fontFamily: AppFonts.primaryFont,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1.h),
        child: Divider(height: 1.h, color: colors.divider),
      ),
      actions: [
        if (state is ChatLoaded)
          IconButton(
            icon: Icon(Icons.info_outline, size: 24.sp, color: colors.onPrimary),
            onPressed: () {
              _showUserReportDialog(context, state.conversation);
            },
          ),
        if (state is ChatLoaded &&
            (state.conversation.status == 'Active' ||
                state.conversation.status == 'ACTIVE'))
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
              icon: Icon(Icons.check_circle_outline, size: 20.sp, color: colors.onPrimary),
              label: Text(
                'Finish',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              style: TextButton.styleFrom(foregroundColor: colors.headingText),
            ),
          ),
      ],
    );
  }

  Widget _buildStatusBanner(ChatState state,ThemeColors colors) {
    if (state is ChatLoaded &&
        state.conversation.status != 'Active' &&
        state.conversation.status != 'ACTIVE') {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: colors.lightGrayBackground,
          border: Border(bottom: BorderSide(color: colors.divider, width: 0.5)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 16.sp, color: colors.textSecondary),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                'This conversation is ${state.conversation.status.toLowerCase()}. You cannot send messages.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.textSecondary,
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

  Widget _buildMessageList(BuildContext context, ChatState state, ThemeColors colors) {
    if (state is ChatLoading) {
      return  Center(
        child: CircularProgressIndicator(color: colors.primary),
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
                color: colors.textSecondary.withValues(alpha: 0.3),
              ),
              SizedBox(height: 16.h),
              Text(
                'No messages yet',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 16.sp,
                  fontFamily: AppFonts.primaryFont,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Say hello to start the conversation!',
                style: TextStyle(
                  color: colors.textSecondary.withValues(alpha: 0.7),
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
          final authState = context.read<AuthBloc>().state;
          final String? currentUserId = authState is AuthSuccess
              ? authState.user?.id
              : null;

          final bool isMe =
              currentUserId != null &&
              (msg.senderId.trim() == currentUserId.trim() ||
                  msg.senderId == '' ||
                  msg.senderId.isEmpty);

          return ChatBubble(
            message: msg,
            isMe: isMe,
            debugInfo:
                'ID: ${msg.id.length > 5 ? msg.id.substring(0, 5) : msg.id}... | Sender: "${msg.senderId}" | Current: "$currentUserId" | isMe: $isMe',
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
                style: TextStyle(color: colors.textPrimary, fontSize: 14.sp),
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

  Widget _buildInputArea(BuildContext context, bool isActive, ThemeColors colors) {
    // Input area implementation...
    return Container(
      // existing container code...
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: MediaQuery.of(context).padding.bottom + 12.h,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
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
                color: colors.lightGrayBackground,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: _msgController,
                enabled: isActive,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: colors.textPrimary,
                  fontFamily: AppFonts.primaryFont,
                ),
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: colors.textSecondary,
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
                color: isActive
                    ? colors.primary
                    : colors.textSecondary.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: colors.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Icon(Icons.send_rounded, color: Colors.white, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }

  void _showUserReportDialog(BuildContext context, dynamic conversation) {
    final colors = context.themeColors;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (innerContext) => Container(
        height: MediaQuery.of(innerContext).size.height * 0.7,
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'User Information',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: conversation.counterpartAvatarUrl != null
                      ? NetworkImage(conversation.counterpartAvatarUrl!)
                      : null,
                  child: conversation.counterpartAvatarUrl == null
                      ? Icon(Icons.person, size: 30.sp)
                      : null,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        conversation.counterpartName ?? 'Unknown User',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (conversation.donationTitle != null)
                        Text(
                          'Interested in: ${conversation.donationTitle}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: colors.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Text(
              'Actions',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            ListTile(
              leading: const Icon(
                Icons.report_problem_outlined,
                color: Colors.red,
              ),
              title: const Text(
                'Report User',
                style: TextStyle(color: Colors.red),
              ),
              subtitle: const Text('Notify admins about suspicious behavior'),
              onTap: () {
                Navigator.pop(innerContext);
                _showReportReasonSelection(context, conversation);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block_outlined, color: Colors.grey),
              title: const Text('Block User'),
              onTap: () {
                Navigator.pop(innerContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Blocking feature coming soon',style: TextStyle(color: colors.background)),backgroundColor: colors.onBackground,),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showReportReasonSelection(BuildContext context, dynamic conversation) {
    final List<String> reasons = [
      'Inappropriate behavior',
      'Spam or advertising',
      'Scam or fraudulent activity',
      'Hate speech',
      'Harassment',
      'Other',
    ];

    // Capture the bloc before showing the modal
    final chatBloc = context.read<ChatBloc>();
    final colors = context.themeColors;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (innerContext) => Container(
        height: MediaQuery.of(innerContext).size.height * 0.6,
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Reason for reporting',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: colors.textPrimary,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.separated(
                itemCount: reasons.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1.h, color: colors.divider),
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(reasons[index]),
                    onTap: () {
                      Navigator.pop(innerContext);
                      _submitReport(
                        context,
                        chatBloc,
                        conversation,
                        reasons[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReport(
    BuildContext context,
    ChatBloc chatBloc,
    dynamic conversation,
    String reason,
  ) {
    final state = chatBloc.state;
    final colors = context.themeColors;
    if (state is ChatLoaded) {
      final targetUserId = state.conversation.counterpartId;

      if (targetUserId != null) {
        chatBloc.add(
          ChatUserReportRequested(userId: targetUserId, reason: reason),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Report submitted for ${state.conversation.counterpartName}',
            ),
            backgroundColor: colors.primary,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not identify user to report'),
            backgroundColor: colors.error,
          ),
        );
      }
    }
  }
}
