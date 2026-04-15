import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaspzero/features/notification/domain/entities/notification.dart' show Notification;
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:gaspzero/core/theme/app_text_styles.dart';
import 'package:gaspzero/core/di/injection.dart';
import '../../presentation/bloc/notification_bloc.dart';
import '../../presentation/bloc/notification_event.dart';
import '../../presentation/bloc/notification_state.dart';
import '../widgets/notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationBloc _notificationBloc;
  late ScrollController _scrollController;
  int _currentPage = 1;
  static const int _pageSize = 10;
  bool _isLoadingMore = false;
  Completer<void>? _refreshCompleter;

  // Filter state
  String _selectedFilter = 'All';
  static const List<String> _filterOptions = ['All', 'Test'];

  @override
  void initState() {
    super.initState();
    _notificationBloc = getIt<NotificationBloc>();
    _scrollController = ScrollController();

    // Fetch initial notifications
    _notificationBloc.add(
      FetchNotificationsEvent(page: _currentPage, limit: _pageSize),
    );

    // Listen to scroll events for infinite scroll
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Check if user is near the bottom (within 500 pixels)
    if (_scrollController.position.extentAfter < 500 && !_isLoadingMore) {
      _loadMoreNotifications();
    }
  }

  void _loadMoreNotifications() {
    setState(() => _isLoadingMore = true);
    _currentPage++;
    _notificationBloc.add(
      FetchNotificationsEvent(page: _currentPage, limit: _pageSize),
    );
  }

  Future<void> _refreshNotifications() async {
    if (!mounted) return;

    // Create a completer that will be resolved when BLoC finishes loading
    _refreshCompleter = Completer<void>();

    setState(() {
      _currentPage = 1;
      _isLoadingMore = false;
    });

    _notificationBloc.add(FetchNotificationsEvent(page: 1, limit: _pageSize));

    // Return the future from the completer - it will be completed by BlocBuilder
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.sm,
                    ),
            child: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.primary,
            ),
          ),
        ),
        title: Text(
            'Notifications',
            textAlign: TextAlign.start,
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primary,
            ),
          ),
        centerTitle: false,
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            bloc: _notificationBloc,
            builder: (context, state) {
              final unreadNotifications = state is NotificationsLoaded
                  ? state.notifications.where((n) => !n.isRead).toList()
                  : [];

              if (unreadNotifications.isNotEmpty) {
                return GestureDetector(
                  onTap: () {
                    final ids = unreadNotifications
                        .map((n) => n.id)
                        .cast<String>()
                        .toList();
                    _notificationBloc.add(MarkNotificationsAsReadEvent(ids));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.sm,
                    ),
                    child: Icon(
                      Icons.done_all_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        bloc: _notificationBloc,
        builder: (context, state) {
          // When we receive new data, stop the loading indicator
          if (state is NotificationsLoaded && _isLoadingMore) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() => _isLoadingMore = false);
              }
            });
          }

          // Complete refresh future when we get fresh data from page 1
          if (state is NotificationsLoaded &&
              _currentPage == 1 &&
              _refreshCompleter != null &&
              !_refreshCompleter!.isCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_refreshCompleter!.isCompleted) {
                _refreshCompleter!.complete();
              }
            });
          }

          return Column(
            children: [
              // Filter chips
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenHorizontal,
                    vertical: 8.0,
                  ),
                  itemCount: _filterOptions.length,
                  itemBuilder: (context, index) {
                    final option = _filterOptions[index];
                    final isSelected = option == _selectedFilter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(option),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() => _selectedFilter = option);
                        },
                        showCheckmark: false,
                        backgroundColor: isSelected
                            ? AppColors.primary
                            : const Color(0xFFE8F1ED),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? AppColors.onPrimary
                              : AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(NotificationState state) {
    if (state is NotificationsLoading && _currentPage == 1) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is NotificationsError && _currentPage == 1) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.0, color: AppColors.textMuted),
            const SizedBox(height: 16.0),
            Text(
              'Failed to load notifications',
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              state.message,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _refreshNotifications,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is NotificationsLoaded) {
      if (state.notifications.isEmpty) {
        return RefreshIndicator(
          onRefresh: _refreshNotifications,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_off_outlined,
                      size: 48.0,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'No notifications',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'You\'re all caught up!',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      // Build list with sections, infinite scroll and pulldown refresh
      return RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: ListView.builder(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: 12.0,
          ),
          itemCount:
              state.notifications.length +
              (_isLoadingMore ? 1 : 0) +
              _countSectionHeaders(state.notifications),
          itemBuilder: (context, index) =>
              _buildListItem(context, index, state.notifications),
        ),
      );
    }

    return const SizedBox();
  }

  int _countSectionHeaders(List<Notification> notifications) {
    final now = DateTime.now();
    bool hasRecent = false;
    bool hasEarlier = false;

    for (var notif in notifications) {
      final difference = now.difference(notif.createdAt).inDays;
      if (difference == 0) {
        hasRecent = true;
      } else {
        hasEarlier = true;
      }
    }

    return (hasRecent ? 1 : 0) + (hasEarlier ? 1 : 0);
  }

  Widget _buildListItem(
    BuildContext context,
    int index,
    List<Notification> notifications,
  ) {
    // Show loading indicator at the end
    if (index == notifications.length + _countSectionHeaders(notifications)) {
      if (_isLoadingMore) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
        );
      }
      return const SizedBox();
    }

    // Build alerts and section headers
    final now = DateTime.now();
    int notificationIndex = 0;
    int headerCount = 0;

    for (int i = 0; i < index; i++) {
      if (i == 0 || (i > 0 && _isNewSection(notifications, i - 1))) {
        headerCount++;
      } else if (i > 0) {
        notificationIndex++;
      }
    }

    // Check if this is a section header
    if (index > 0 && _isNewSection(notifications, index - 1)) {
      final difference = now
          .difference(notifications[index - 1].createdAt)
          .inDays;
      final isRecent = difference == 0;
      final nextDifference = index < notifications.length
          ? now.difference(notifications[index].createdAt).inDays
          : 1;
      final isNextEarlier = nextDifference > 0;

      if ((isRecent && isNextEarlier) || (!isRecent)) {
        final headerText = isRecent ? 'RECENT UPDATES' : 'EARLIER';
        return Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.lg,
            bottom: AppSpacing.md,
          ),
          child: Text(
            headerText,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        );
      }
    }

    // First item is alert banner
    if (index == 0) {
      return _buildAlertBanner(context);
    }

    // Regular notification card
    final notification = notifications[index - 1];
    return NotificationCard(
      notification: notification,
      onTap: () {
        context.push('/notification-details', extra: notification);
      },
      onMarkAsRead: () {
        _notificationBloc.add(MarkNotificationsAsReadEvent([notification.id]));
      },
      onDelete: () {
        _notificationBloc.add(DeleteNotificationEvent(notification.id));
      },
    );
  }

  bool _isNewSection(List<Notification> notifications, int index) {
    if (index < 0 || index >= notifications.length - 1) return false;

    final now = DateTime.now();
    final current = now.difference(notifications[index].createdAt).inDays;
    final next = now.difference(notifications[index + 1].createdAt).inDays;

    return (current == 0 && next > 0) || (current > 0 && next == 0);
  }

  Widget _buildAlertBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.lg, top: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.notificationAlertBackground,
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_rounded, color: AppColors.surface, size: 24.0),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'URGENT ALERT',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '3 items expiring soon!',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.surface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Save food in your area before it goes to waste.',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.surface,
              height: 1.5,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            height: 44.0,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.surface,
                foregroundColor: AppColors.notificationAlertBackground,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                ),
              ),
              child: Text(
                'View Now',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.notificationAlertBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
