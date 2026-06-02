import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaspzero/features/notification/domain/entities/notification.dart'
    show Notification;
import 'package:gaspzero/features/notification/domain/entities/notification_type.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:gaspzero/core/theme/app_colors.dart';
import 'package:gaspzero/core/theme/app_text_styles.dart';
import 'package:gaspzero/core/di/injection.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;
import '../../presentation/bloc/notification_bloc.dart';
import '../../presentation/bloc/notification_event.dart';
import '../../presentation/bloc/notification_state.dart';
import '../widgets/notification_card.dart';
import '../notification_action_handler.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late ScrollController _scrollController;
  NotificationBloc? _notificationBloc;
  static const int _pageSize = 10;
  Completer<void>? _refreshCompleter;
  bool _didRequestInitialNotifications = false;

  // Filter state
  String _selectedFilter = 'All';
  static const String _filterAll = 'All';
  // ignore: unused_field
  static final List<String> _filterOptions = [
    _filterAll,
    ...NotificationType.values.map((e) => e.displayName),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Listen to scroll events for infinite scroll
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Acquire the bloc from the nearest provider (safe here). If none, fall back to DI.
    try {
      _notificationBloc ??= BlocProvider.of<NotificationBloc>(context);
    } catch (_) {
      _notificationBloc ??= getIt<NotificationBloc>();
    }

    // Fetch initial notifications once bloc is available.
    if (!_didRequestInitialNotifications) {
      _didRequestInitialNotifications = true;
      _notificationBloc!.add(
        FetchNotificationsEvent(page: 1, limit: _pageSize),
      );
    }
  }

  void _onScroll() {
    final currentState = _notificationBloc?.state;
    if (currentState is! NotificationsLoaded) {
      return;
    }

    // Check if user is near the bottom (within 500 pixels)
    if (_scrollController.position.extentAfter < 500 &&
        !currentState.isLoadingMore &&
        !currentState.hasReachedMax) {
      _loadMoreNotifications();
    }
  }

  void _loadMoreNotifications() {
    final currentState = _notificationBloc?.state;
    if (currentState is! NotificationsLoaded) {
      return;
    }

    final nextPage = currentState.currentPage + 1;
    _notificationBloc!.add(
      FetchNotificationsEvent(page: nextPage, limit: _pageSize),
    );
  }

  List<Notification> _filterNotifications(List<Notification> notifications) {
    if (_selectedFilter == _filterAll) {
      return notifications;
    }

    final selectedType = NotificationType.values.firstWhere(
      (type) => type.displayName == _selectedFilter,
      orElse: () => NotificationType.test,
    );

    return notifications.where((notif) => notif.type == selectedType).toList();
  }

  Future<void> _refreshNotifications() async {
    if (!mounted) return;

    // Create a completer that will be resolved when BLoC finishes loading
    _refreshCompleter = Completer<void>();

    _notificationBloc!.add(const RefreshNotificationsEvent());

    // Return the future from the completer - it will be completed by BlocBuilder
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            child: Icon(Icons.arrow_back_rounded, color: colors.primary),
          ),
        ),
        title: Text(
          'Notifications',
          textAlign: TextAlign.start,
          style: AppTextStyles.titleLarge.copyWith(color: colors.primary),
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
                    _notificationBloc!.add(
                      const MarkAllNotificationsAsReadEvent(),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.sm,
                    ),
                    child: Icon(
                      Icons.done_all_rounded,
                      color: colors.textPrimary,
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
          // Complete refresh future when we get fresh data from page 1
          if (state is NotificationsLoaded &&
              state.currentPage == 1 &&
              _refreshCompleter != null &&
              !_refreshCompleter!.isCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_refreshCompleter!.isCompleted) {
                _refreshCompleter!.complete();
              }
            });
          }

          if (state is NotificationsError &&
              _refreshCompleter != null &&
              !_refreshCompleter!.isCompleted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!_refreshCompleter!.isCompleted) {
                _refreshCompleter!.complete();
              }
            });
          }

          return Column(children: [Expanded(child: _buildContent(state))]);
        },
      ),
    );
  }

  Widget _buildContent(NotificationState state) {
    final colors = context.themeColors;
    if (state is NotificationsLoading) {
      return _buildLoadingSkeleton();
    }

    if (state is NotificationsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.0, color: colors.textMuted),
            const SizedBox(height: 16.0),
            Text(
              'Failed to load notifications',
              style: AppTextStyles.bodyLarge.copyWith(
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              state.message,
              style: AppTextStyles.bodySmall.copyWith(
                color: colors.textTertiary,
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
                      color: colors.textMuted,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'No notifications',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'You\'re all caught up!',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }

      final filteredNotifications = _filterNotifications(state.notifications);

      if (filteredNotifications.isEmpty) {
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
                      color: colors.textMuted,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'No notifications',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'You\'re all caught up!',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: colors.textTertiary,
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
              filteredNotifications.length +
              (state.isLoadingMore ? 1 : 0) +
              _countSectionHeaders(filteredNotifications),
          itemBuilder: (context, index) => _buildListItem(
            context,
            index,
            filteredNotifications,
            state.isLoadingMore,
          ),
        ),
      );
    }

    return const SizedBox();
  }

  Widget _buildLoadingSkeleton() {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: 12.0,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSkeletonBox(
                height: 136.0,
                borderRadius: BorderRadius.circular(AppRadius.xl),
              ),
              const SizedBox(height: AppSpacing.lg),
              _buildSkeletonBox(
                width: 130.0,
                height: 14.0,
                borderRadius: BorderRadius.circular(6.0),
              ),
            ],
          );
        }

        return _buildSkeletonNotificationCard(context);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12.0),
      itemCount: 6,
    );
  }

  Widget _buildSkeletonNotificationCard(BuildContext context) {
    final colors = context.themeColors;
    final screenWidth = MediaQuery.of(context).size.width;

    return ExcludeSemantics(
      child: Shimmer.fromColors(
        baseColor: colors.surface.withValues(alpha: 0.72),
        highlightColor: colors.surface.withValues(alpha: 0.92),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: colors.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildSkeletonBox(
                    width: 34,
                    height: 34,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSkeletonBox(
                          height: 12,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        const SizedBox(height: 8),
                        _buildSkeletonBox(
                          width: screenWidth * 0.42,
                          height: 10,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _buildSkeletonBox(
                height: 10,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(height: 6),
              _buildSkeletonBox(
                width: screenWidth * 0.58,
                height: 10,
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonBox({
    double? width,
    required double height,
    required BorderRadius borderRadius,
  }) {
    final colors = context.themeColors;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: borderRadius,
      ),
    );
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
    bool isLoadingMore,
  ) {
    // Map the display index to a concrete slot: alert, header, notification, or loading.
    final slot = _slotForDisplayIndex(index, notifications, isLoadingMore);

    switch (slot['type'] as String) {
      case 'header':
        return Padding(
          padding: const EdgeInsets.only(
            top: AppSpacing.lg,
            bottom: AppSpacing.md,
          ),
          child: Text(
            slot['text'] as String,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.textTertiary,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        );
      case 'notification':
        final notifIndex = slot['index'] as int;
        final notification = notifications[notifIndex];

        // Mark as read when card is rendered AND visible on screen
        if (!notification.isRead) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            try {
              final RenderObject? renderObject = context.findRenderObject();
              if (renderObject != null && renderObject.attached) {
                final translation = renderObject
                    .getTransformTo(null)
                    .getTranslation();
                final size = renderObject.semanticBounds.size;
                final screenHeight = MediaQuery.of(context).size.height;
                final appBarHeight = kToolbarHeight;

                // Check if card bottom is within screen bounds
                final cardTop = translation.y;
                final cardBottom = translation.y + size.height;

                if (cardBottom > appBarHeight && cardTop < screenHeight) {
                  _notificationBloc!.add(
                    MarkNotificationsAsReadEvent([notification.id]),
                  );
                }
              }
            } catch (e) {
              // Silently fail if we can't determine visibility
            }
          });
        }

        return NotificationCard(
          notification: notification,
          onTap: () async {
            // handle smart action routing
            try {
              await NotificationActionHandler.handle(context, notification);
            } catch (_) {
              // fallback to notification details
              context.push('/notification-details', extra: notification);
            }
          },
          onDelete: () {
            _notificationBloc!.add(DeleteNotificationEvent(notification.id));
          },
        );
      case 'loading':
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
      default:
        return const SizedBox();
    }
  }

  /// Simulate the displayed list slots and map a builder index to a logical slot.
  /// Returns a map with `type` in {'alert','header','notification','loading','empty'}.
  Map<String, Object?> _slotForDisplayIndex(
    int displayIndex,
    List<Notification> notifications,
    bool isLoadingMore,
  ) {
    // Index 0 reserved for the alert banner
    if (displayIndex == 0) return {'type': 'alert'};

    var pos = 1; // next display position after alert

    final now = DateTime.now();

    for (var i = 0; i < notifications.length; i++) {
      // Insert a section header before item i when transition occurs (i > 0)
      if (i > 0 && _isNewSection(notifications, i - 1)) {
        if (pos == displayIndex) {
          final diff = now.difference(notifications[i - 1].createdAt).inDays;
          final isRecent = diff == 0;
          final headerText = isRecent ? 'RECENT UPDATES' : 'EARLIER';
          return {'type': 'header', 'text': headerText};
        }
        pos++;
      }

      // Notification item
      if (pos == displayIndex) return {'type': 'notification', 'index': i};
      pos++;
    }

    // Loading indicator after all items and headers
    if (isLoadingMore) {
      if (pos == displayIndex) return {'type': 'loading'};
      pos++;
    }

    return {'type': 'empty'};
  }

  bool _isNewSection(List<Notification> notifications, int index) {
    if (index < 0 || index >= notifications.length - 1) return false;

    final now = DateTime.now();
    final current = now.difference(notifications[index].createdAt).inDays;
    final next = now.difference(notifications[index + 1].createdAt).inDays;

    return (current == 0 && next > 0) || (current > 0 && next == 0);
  }

  
}
