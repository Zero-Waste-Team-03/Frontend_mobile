import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class AppBottomSheet extends StatelessWidget {
  final String? title;
  final Widget content;
  final Widget? footer;

  const AppBottomSheet({
    super.key,
    this.title,
    required this.content,
    this.footer,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    String? title,
    required Widget content,
    Widget? footer,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AppBottomSheet(title: title, content: content, footer: footer);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: 16),
              Text(title!, style: AppTextStyles.titleLarge),
            ],
            const SizedBox(height: 16),
            content,
            if (footer != null) ...[const SizedBox(height: 16), footer!],
          ],
        ),
      ),
    );
  }
}
