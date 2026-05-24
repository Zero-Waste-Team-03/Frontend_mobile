import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ferry/ferry.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:gaspzero/core/di/injection.dart';
import 'package:gaspzero/shared/theme/app_colors.dart';
import '../../../reservation/data/datasources/graphql/__generated__/my_reservation.req.gql.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../domain/entities/conversation.dart';

class ArchivedChatsPage extends StatefulWidget {
  const ArchivedChatsPage({super.key});

  @override
  State<ArchivedChatsPage> createState() => _ArchivedChatsPageState();
}

class _ArchivedChatsPageState extends State<ArchivedChatsPage> {
  final ChatRepository _chatRepository = getIt<ChatRepository>();
  final Client _ferryClient = getIt<Client>();

  List<ConversationEntity>? _archivedConversations;
  String? _archivedError;
  bool _loadingArchived = false;

  @override
  void initState() {
    super.initState();
    _loadArchivedConversations();
  }

  Future<void> _loadArchivedConversations() async {
    if (mounted) {
      setState(() {
        _loadingArchived = true;
        _archivedError = null;
      });
    }
    final result = await _chatRepository.getMyArchivedConversations();
    await _handleResult(result);
  }

  Future<void> _handleResult(
    Either<dynamic, List<ConversationEntity>> result,
  ) async {
    await result.fold(
      (failure) async {
        if (mounted) {
          setState(() {
            _archivedError = failure.message;
            _loadingArchived = false;
          });
        }
      },
      (conversations) async {
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
                  donationImageUrl:
                      reservationData.donation?.mainAttachment?.url,
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
            _archivedConversations = enriched;
            _loadingArchived = false;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,
      appBar: AppBar(
        title: Text(
          'Archived Chats',
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
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_archivedError != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Failed to load archived chats',
              style: TextStyle(color: Colors.red, fontSize: 16.sp),
            ),
            SizedBox(height: 8.h),
            Text(_archivedError!, style: const TextStyle(color: Colors.red)),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _loadArchivedConversations,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_loadingArchived || _archivedConversations == null) {
      return const Center(
        child: CircularProgressIndicator(color: AuthColors.primary),
      );
    }

    if (_archivedConversations!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.archive_outlined,
              size: 64.sp,
              color: AuthColors.inputText,
            ),
            SizedBox(height: 16.h),
            Text(
              'No archived chats',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AuthColors.headingText,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your archived conversations will appear here.',
              style: TextStyle(color: AuthColors.subText, fontSize: 14.sp),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadArchivedConversations,
      color: AuthColors.primary,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: _archivedConversations!.length,
        itemBuilder: (context, index) {
          final conversation = _archivedConversations![index];
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
                            image: NetworkImage(
                              conversation.counterpartAvatarUrl!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
              ),
              child: (conversation.donationImageUrl == null &&
                      conversation.counterpartAvatarUrl == null)
                  ? Icon(
                      Icons.shopping_basket_outlined,
                      color: AuthColors.primary,
                      size: 24.sp,
                    )
                  : null,
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
      ),
    );
  }
}
