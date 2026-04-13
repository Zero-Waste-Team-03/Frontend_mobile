import 'package:flutter/material.dart';
import '../../domain/entities/notification.dart';
import '../../../../shared/theme/app_colors.dart';

class NotificationFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const NotificationFilterChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2D6C50) : const Color(0xFFE5F0ED),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2D6C50)
                : const Color(0xFFD1E8E3),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16.0,
                color: isSelected
                    ? Colors.white
                    : AuthColors.statusCompletedText,
              ),
              const SizedBox(width: 6.0),
            ],
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: isSelected ? Colors.white : AuthColors.subText,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationFiltersBar extends StatelessWidget {
  final String? activeTypeFilter;
  final bool? activeReadFilter;
  final Function(String?) onTypeFilterChanged;
  final Function(bool?) onReadFilterChanged;
  final VoidCallback onClearFilters;

  const NotificationFiltersBar({
    Key? key,
    this.activeTypeFilter,
    this.activeReadFilter,
    required this.onTypeFilterChanged,
    required this.onReadFilterChanged,
    required this.onClearFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasActiveFilters =
        activeTypeFilter != null || activeReadFilter != null;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // All filter
            NotificationFilterChip(
              label: 'All',
              isSelected: activeTypeFilter == null && activeReadFilter == null,
              onTap: onClearFilters,
            ),
            const SizedBox(width: 8.0),
            // Unread filter
            NotificationFilterChip(
              label: 'Unread',
              isSelected: activeReadFilter == false,
              onTap: () =>
                  onReadFilterChanged(activeReadFilter == false ? null : false),
            ),
            const SizedBox(width: 8.0),
            // Type filters
            ...NotificationType.values.map((type) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: NotificationFilterChip(
                  label: type.displayName,
                  isSelected: activeTypeFilter == type.value,
                  onTap: () => onTypeFilterChanged(
                    activeTypeFilter == type.value ? null : type.value,
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
