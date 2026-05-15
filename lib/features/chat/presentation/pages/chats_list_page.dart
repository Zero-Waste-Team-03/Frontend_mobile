import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ferry/ferry.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:gaspzero/shared/theme/app_colors.dart';
import '../../../reservation/data/datasources/graphql/__generated__/my_reservation.req.gql.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/entities/conversation.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  final ChatRepository _chatRepository = getIt<ChatRepository>();
  final Client _ferryClient = getIt<Client>();
  List<ConversationEntity>? _conversations;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final result = await _chatRepository.getMyActiveConversations();

    result.fold((failure) => setState(() => _error = failure.message), (
      conversations,
    ) async {
      // Enriched conversations list
      final List<ConversationEntity> enriched = [];

      for (var conv in conversations) {
        try {
          final reservationReq = GMyReservationReq(
            (b) => b
              ..vars.id = conv.reservationId
              ..fetchPolicy = FetchPolicy.CacheFirst,
          );

          final res = await _ferryClient.request(reservationReq).first;
          final reservationData = res.data?.myReservation;

          if (reservationData != null) {
            enriched.add(
              conv.copyWith(
                donationTitle: reservationData.donation?.title,
                donationImageUrl: reservationData.donation?.mainAttachment?.url,
              ),
            );
          } else {
            enriched.add(conv);
          }
        } catch (_) {
          enriched.add(conv);
        }
      }

      if (mounted) {
        setState(() {
          _conversations = enriched;
        });
      }
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
              borderRadius: BorderRadius.circular(10.r),
              image: conversation.donationImageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(conversation.donationImageUrl!),
                      fit: BoxFit.cover,
                    )
                  : conversation.counterpartAvatarUrl != null
                  ? DecorationImage(
                      image: NetworkImage(conversation.counterpartAvatarUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child:
                (conversation.donationImageUrl == null &&
                    conversation.counterpartAvatarUrl == null)
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.shopping_basket_outlined,
                        color: AuthColors.primary,
                        size: 24.sp,
                      ),
                      if (conversation.isOnline)
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 12.r,
                            height: 12.r,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2.w,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                : (conversation.isOnline
                      ? Stack(
                          children: [
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 12.r,
                                height: 12.r,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : null),
          ),
          title: Text(
            conversation.counterpartName ?? 'User',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            conversation.donationTitle ??
                conversation.lastMessage ??
                'No messages yet',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: AuthColors.subText, fontSize: 13.sp),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: AuthColors.inputText,
            size: 20.sp,
          ),
          onTap: () {
            context.push('/chat', extra: conversation.reservationId);
          },
        );
      },
    );
  }
}
