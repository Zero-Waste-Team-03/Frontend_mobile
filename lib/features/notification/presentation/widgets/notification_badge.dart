import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/notification_bloc.dart';
import '../../presentation/bloc/notification_state.dart';

class NotificationBadge extends StatelessWidget {
  final NotificationBloc notificationBloc;
  final VoidCallback onTap;

  const NotificationBadge({
    Key? key,
    required this.notificationBloc,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      bloc: notificationBloc,
      builder: (context, state) {
        int unreadCount = 0;

        if (state is NotificationsLoaded) {
          unreadCount = state.notifications.where((n) => !n.isRead).length;
        }

        return Stack(
          children: [
            GestureDetector(
              onTap: onTap,
              child: const Icon(Icons.notifications_outlined, size: 24.0),
            ),
            if (unreadCount > 0)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFA500),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Text(
                    unreadCount > 99 ? '99+' : unreadCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
