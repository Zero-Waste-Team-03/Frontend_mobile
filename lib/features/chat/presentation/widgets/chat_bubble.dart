import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/chat_message.dart';
import '../../../../shared/theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isMe;
  final String? debugInfo;
  final VoidCallback? onApproveReveal;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.debugInfo,
    this.onApproveReveal,
  });

  @override
  Widget build(BuildContext context) {
    if (debugInfo != null) {
      debugPrint('[ChatBubble] $debugInfo');
    }
    // Detect sensitive message placeholder
    // Marker [SENSITIVE:LOCATION] or similar
    final bool hasSensitiveMarker = message.content.contains('[SENSITIVE:');
    final bool isSensitivePlaceholder = !isMe && message.isModerated && hasSensitiveMarker;
    
    // Marker stripping for the sender and for recipients after moderation is cleared
    String displayContent = message.content;
    if (isMe || !message.isModerated) {
      displayContent = _stripMarkers(displayContent);
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 4.h, top: 8.h),
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: isMe ? AuthColors.primary : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomLeft: isMe ? Radius.circular(16.r) : Radius.zero,
                bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
              ),
              boxShadow: isMe ? [
                BoxShadow(
                  color: AuthColors.primary.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ] : null,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isSensitivePlaceholder) ...[
                   Row(
                    children: [
                      Icon(Icons.lock_outline, size: 14.sp, color: AuthColors.headingText),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Sensitive information hidden',
                          style: TextStyle(
                            color: AuthColors.headingText,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppFonts.primaryFont,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'This message contains sensitive details like location or contact info.',
                    style: TextStyle(
                      color: AuthColors.subText,
                      fontSize: 12.sp,
                      fontFamily: AppFonts.primaryFont,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: onApproveReveal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AuthColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: Size(double.infinity, 36.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Approve & reveal',
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ] else ...[
                  Text(
                    displayContent,
                    style: TextStyle(
                      color: isMe ? Colors.white : const Color(0xFF131615),
                      fontSize: 14.sp,
                      fontFamily: AppFonts.primaryFont,
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('h:mm a').format(message.createdAt),
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 10.sp,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
                if (isMe) ...[
                  SizedBox(width: 4.w),
                  _buildStatusIcon(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (message.status) {
      case MessageStatus.sending:
        return SizedBox(
          width: 10.w,
          height: 10.w,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation<Color>(AuthColors.subText.withValues(alpha: 0.5)),
          ),
        );
      case MessageStatus.sent:
        return Icon(Icons.done_all, size: 12.sp, color: AuthColors.primary);
      case MessageStatus.error:
        return Icon(Icons.error_outline, size: 12.sp, color: Colors.red);
    }
  }

  String _stripMarkers(String content) {
    // Regex to find and remove [SENSITIVE:ANYTHING]
    final regex = RegExp(r'\[SENSITIVE:[^\]]+\]');
    return content.replaceAll(regex, '').trim();
  }
}

