import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:gaspzero/shared/theme/app_colors.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/entities/conversation.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  final ChatRepository _chatRepository = getIt<ChatRepository>();
  List<ConversationEntity>? _conversations;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final result = await _chatRepository.getMyActiveConversations();
    setState(() {
      result.fold(
        (failure) => _error = failure.message,
        (conversations) => _conversations = conversations,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: AppDimensions.appBarTitleSize.sp,
            color: AuthColors.headingText,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: AuthColors.headingText),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to load chats',
              style: TextStyle(color: Colors.red, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(_error!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _error = null;
                  _conversations = null;
                });
                _loadConversations();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_conversations == null) {
      return const Center(
        child: CircularProgressIndicator(color: AuthColors.primary),
      );
    }

    if (_conversations!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64.sp,
              color: AuthColors.inputText,
            ),
            SizedBox(height: 16.h),
            Text(
              'No active chats',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AuthColors.headingText,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your active conversations will appear here.',
              style: TextStyle(color: AuthColors.subText, fontSize: 14.sp),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: _conversations!.length,
      itemBuilder: (context, index) {
        final conversation = _conversations![index];
        return ListTile(
          leading: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AuthColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              image: conversation.counterpartAvatarUrl != null
                  ? DecorationImage(
                      image: NetworkImage(conversation.counterpartAvatarUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: conversation.counterpartAvatarUrl == null
                ? Icon(Icons.person, color: AuthColors.primary, size: 24.sp)
                : null,
          ),
          title: Text(
            conversation.counterpartName ?? 'Reservation Chat',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),

          subtitle: Text(
            conversation.lastMessage ?? 'No messages yet',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AuthColors.subText, fontSize: 14.sp),
          ),
          trailing: Icon(Icons.chevron_right, color: AuthColors.inputText),
          onTap: () {
            context.push('/chat', extra: conversation.reservationId);
          },
        );
      },
    );
  }
}
