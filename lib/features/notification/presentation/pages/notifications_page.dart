import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/notification_bloc.dart';
import '../../presentation/bloc/notification_event.dart';
import '../../presentation/bloc/notification_state.dart';
import 'package:gaspzero/core/di/injection.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_filter_chip.dart';
import '../../../../shared/theme/app_colors.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationBloc _notificationBloc;
  String? _activeTypeFilter;
  bool? _activeReadFilter;

  @override
  void initState() {
    super.initState();
    _notificationBloc = getIt<NotificationBloc>();
    // TODO: Replace 'user_123' with actual userId from auth context
    _notificationBloc.add(const FetchNotificationsEvent('user_123'));
  }

  void _handleTypeFilterChange(String? filter) {
    setState(() {
      _activeTypeFilter = filter;
    });

    if (filter == null && _activeReadFilter == null) {
      _notificationBloc.add(const ClearNotificationFilterEvent('user_123'));
    } else {
      _notificationBloc.add(
        FilterNotificationsEvent(
          'user_123',
          typeFilter: _activeTypeFilter,
          isReadFilter: _activeReadFilter,
        ),
      );
    }
  }

  void _handleReadFilterChange(bool? filter) {
    setState(() {
      _activeReadFilter = filter;
    });

    if (_activeTypeFilter == null && filter == null) {
      _notificationBloc.add(const ClearNotificationFilterEvent('user_123'));
    } else {
      _notificationBloc.add(
        FilterNotificationsEvent(
          'user_123',
          typeFilter: _activeTypeFilter,
          isReadFilter: _activeReadFilter,
        ),
      );
    }
  }

  void _handleClearFilters() {
    setState(() {
      _activeTypeFilter = null;
      _activeReadFilter = null;
    });
    _notificationBloc.add(const ClearNotificationFilterEvent('user_123'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AuthColors.headingText,
          ),
        ),
        title: Text(
          'Notifications',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AuthColors.headingText,
          ),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            bloc: _notificationBloc,
            builder: (context, state) {
              final hasUnread = state is NotificationsLoaded
                  ? state.notifications.any((n) => !n.isRead)
                  : false;

              if (hasUnread) {
                return GestureDetector(
                  onTap: () {
                    _notificationBloc.add(
                      const MarkAllNotificationsAsReadEvent('user_123'),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.done_all_rounded,
                      color: AuthColors.headingText,
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
          return Column(
            children: [
              // Filter chips
              NotificationFiltersBar(
                activeTypeFilter: _activeTypeFilter,
                activeReadFilter: _activeReadFilter,
                onTypeFilterChanged: _handleTypeFilterChange,
                onReadFilterChanged: _handleReadFilterChange,
                onClearFilters: _handleClearFilters,
              ),
              // Content
              Expanded(child: _buildContent(state)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(NotificationState state) {
    if (state is NotificationsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is NotificationsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.0, color: Colors.grey.shade400),
            const SizedBox(height: 16.0),
            Text(
              'Failed to load notifications',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8.0),
            Text(
              state.message,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state is NotificationsLoaded) {
      if (state.notifications.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_off_outlined,
                size: 48.0,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16.0),
              Text(
                'No notifications',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8.0),
              Text(
                'You\'re all caught up!',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        itemCount: state.notifications.length,
        itemBuilder: (context, index) {
          final notification = state.notifications[index];
          return NotificationCard(
            notification: notification,
            onTap: () {
              // TODO: Handle notification tap - navigate to relevant page
            },
            onMarkAsRead: () {
              _notificationBloc.add(
                MarkNotificationAsReadEvent(notification.id),
              );
            },
          );
        },
      );
    }

    return const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
