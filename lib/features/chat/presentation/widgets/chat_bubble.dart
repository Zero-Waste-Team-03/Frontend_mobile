import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/chat_message.dart';
import '../../../../shared/theme/app_colors.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity message;
  final bool isMe;
  final VoidCallback? onApproveReveal;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.onApproveReveal,
  });

  @override
  Widget build(BuildContext context) {
    // Detect sensitive message placeholder
    // Logic: if content contains markers and is moderated
    // For now using a simple check as per requirements: "detect placeholder"
    final bool isSensitive = !isMe && message.isModerated && message.content.contains('[REDACTED]');
    
    // Marker stripping for the sender (if applicable)
    // Assuming marker format is [REDACTED] or similar based on backend integration
    String displayContent = message.content;
    if (isMe) {
      displayContent = displayContent.replaceAll('[REDACTED]', '');
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
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                bottomRight: isMe ? Radius.zero : const Radius.circular(16),
              ),
              boxShadow: isMe ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ] : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSensitive ? 'Message hidden for safety' : displayContent,
                  style: TextStyle(
                    color: isMe ? Colors.white : const Color(0xFF131615),
                    fontSize: 14.sp,
                    fontFamily: AppFonts.primaryFont,
                    height: 1.6,
                  ),
                ),
                if (isSensitive) ...[
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: onApproveReveal,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AuthColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      minimumSize: Size(double.infinity, 36.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Approve & reveal',
                      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              DateFormat('h:mm a').format(message.createdAt),
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 10.sp,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
