# Notification Feature

This feature provides a complete notification management system for the GaspZero mobile app with filtering, marking as read functionality, and a beautiful UI matching the design system.

## Architecture

The notification feature follows the clean architecture pattern with three main layers:

### Domain Layer

- **Entities**: `Notification` - Core business logic with enum for notification types
- **Repositories**: Abstract repository interface
- **Use Cases**:
  - `GetNotificationsUseCase` - Fetch all notifications
  - `GetFilteredNotificationsUseCase` - Fetch notifications with filters
  - `MarkNotificationAsReadUseCase` - Mark single notification as read
  - `MarkAllNotificationsAsReadUseCase` - Mark all notifications as read

### Data Layer

- **Models**: `NotificationModel` extending `Notification` entity
- **Remote Data Source**: `NotificationRemoteDataSource` interface and implementation
- **Repository Implementation**: `NotificationRepositoryImpl`

### Presentation Layer

- **BLoC**: `NotificationBloc` with events and states
- **Pages**: `NotificationsPage` - Main notifications view
- **Widgets**:
  - `NotificationCard` - Individual notification display
  - `NotificationFilterChip` - Filter selection UI
  - `NotificationFiltersBar` - Filter controls
  - `NotificationBadge` - Unread count badge with icon

## Features

### Core Features

✅ **Notification Display** - Beautiful, responsive notification cards
✅ **Type Filtering** - Filter by notification type (Alert, Confirmation, Donation, Impact)
✅ **Read Status Filtering** - Filter by read/unread status
✅ **Mark as Read** - Mark individual notifications as read
✅ **Mark All as Read** - Mark all notifications as read with one tap
✅ **Unread Badge** - Shows count of unread notifications
✅ **Time Display** - Relative timestamp (e.g., "2m ago", "Yesterday")

### Notification Types

- **Alert**: Urgent notifications (Orange icon)
- **Confirmation**: Confirmations like reservations (Green icon)
- **Donation**: New donations nearby (Green icon)
- **Impact**: Environmental impact achievements (Green icon)

## Setup & Integration

### 1. Dependency Injection (Already Configured)

The feature is registered in `lib/core/di/injection.dart`:

- Remote data source, repository, use cases, and BLoC are pre-registered

### 2. Routing (Already Configured)

Navigate to notifications page:

```dart
context.push('/notifications');
```

### 3. Usage in UI

**Navigate to Notifications Page:**

```dart
GestureDetector(
  onTap: () => context.push('/notifications'),
  child: const Icon(Icons.notifications),
)
```

**Display Notification Badge:**

```dart
NotificationBadge(
  notificationBloc: getIt<NotificationBloc>(),
  onTap: () => context.push('/notifications'),
)
```

**Fetch Notifications in Widget:**

```dart
@override
void initState() {
  super.initState();
  context.read<NotificationBloc>().add(
    const FetchNotificationsEvent('user_id'),
  );
}
```

## API Integration

### Current State

⚠️ **PLACEHOLDER DATA ONLY** - The remote data source returns mock notifications for demonstration

### TODO: Link with API

The `NotificationRemoteDataSourceImpl` in `lib/features/notification/data/sources/notification_remote_data_source.dart` contains TODO comments indicating where to add actual API calls.

**Update these methods with your HTTP client (Dio, etc.):**

1. **getNotifications()**

   ```dart
   // Replace mock with:
   final response = await dio.get('/users/$userId/notifications');
   return (response.data as List).map((n) => NotificationModel.fromJson(n)).toList();
   ```

2. **getFilteredNotifications()**

   ```dart
   // Replace mock with:
   final response = await dio.get(
     '/users/$userId/notifications',
     queryParameters: {
       'type': typeFilter,
       'isRead': isReadFilter,
       'page': page,
       'limit': limit,
     },
   );
   ```

3. **markAsRead()**

   ```dart
   // Replace mock with:
   final response = await dio.patch('/notifications/$notificationId/read');
   return NotificationModel.fromJson(response.data);
   ```

4. **markAllAsRead()**
   ```dart
   // Replace mock with:
   await dio.patch('/users/$userId/notifications/read-all');
   ```

### Expected API Response Format

```json
{
  "id": "notif_123",
  "receiverId": "user_123",
  "title": "URGENT ALERT",
  "body": "3 items expiring soon!",
  "type": "ALERT",
  "isRead": false,
  "meta": {
    "itemCount": 3
    // Custom metadata
  },
  "createdAt": "2026-04-12T10:30:00Z",
  "updatedAt": "2026-04-12T10:30:00Z"
}
```

### TODO: Update userId

The `NotificationsPage` currently uses a hardcoded userId: `'user_123'`. Replace with:

```dart
// From auth context or global state
final userId = context.read<AuthBloc>().state.user.id;
```

## Customization

### Colors

The feature uses colors from `lib/shared/theme/app_colors.dart`. Adjust notification type colors in `notification_card.dart`:

- `_getTypeColor()` - Icon color
- `_getAlertBackgroundColor()` - Background color

### Notification Types

Add new types by:

1. Adding to `NotificationType` enum in `notification.dart`
2. Updating `NotificationTypeExt` with display name and value
3. Adding icon and color logic in `notification_card.dart`

### Styling

The feature is fully customizable through:

- Cards: `notification_card.dart`
- Filter chips: `notification_filter_chip.dart`
- Page layout: `notifications_page.dart`

## File Structure

```
lib/features/notification/
├── domain/
│   ├── entities/
│   │   └── notification.dart
│   ├── repositories/
│   │   └── notification_repository.dart
│   └── usecases/
│       └── notification_usecases.dart
├── data/
│   ├── models/
│   │   └── notification_model.dart
│   ├── sources/
│   │   └── notification_remote_data_source.dart
│   └── repositories/
│       └── notification_repository_impl.dart
└── presentation/
    ├── bloc/
    │   ├── notification_bloc.dart
    │   ├── notification_event.dart
    │   └── notification_state.dart
    ├── pages/
    │   └── notifications_page.dart
    └── widgets/
        ├── notification_card.dart
        ├── notification_filter_chip.dart
        └── notification_badge.dart
```

## Next Steps

1. **Link with API**: Update remote data source with actual HTTP calls
2. **Update userId**: Replace hardcoded user IDs with actual auth context
3. **Handle navigation**: Implement tap handlers for notification action navigation
4. **Add tests**: Create unit and widget tests for BLoC and UI
5. **Real-time updates**: Consider adding WebSocket support for live notifications

## Notes

- Mock data is auto-generated with realistic notification types
- Local filtering is applied until API filtering is implemented
- UI is fully responsive and follows Material Design 3 guidelines
- All colors conform to the app's design system
