# Notification Integration Guide

This guide explains how to integrate the new actionable notifications with:

- Flutter mobile client (donor/beneficiary, primary push target)
- React web client (admin, in-app only — no FCM image rendering)

It covers the FCM payload shape, the namespaced `action` contract, per-type metadata, image handling on iOS/Android, and how to route a notification tap to the right screen.

## 1) What changed

Before, notifications carried free-form `title` + `body` and the mobile app could not deterministically route the user to the right screen when they tapped a push. Now every notification carries:

- A namespaced `action` string in `meta` (e.g. `chat.open`) — single source of truth for navigation.
- A typed bag of supporting fields per action (IDs, names, status) so the destination screen has everything it needs without re-fetching.
- A rich image (donation cover or sender avatar) attached to both `android.notification.imageUrl` and `apns.fcmOptions.imageUrl` for chat and reservation pushes.
- An `idempotencyKey` for client-side dedupe across retries.

The persisted `Notification.meta` (jsonb) carries the exact same shape as the FCM `data` payload, so the in-app notifications list (GraphQL) and the push payload share one contract.

## 2) FCM payload shape

A push delivered by the backend looks like:

```json
{
  "notification": {
    "title": "Jane Doe",
    "body": "Hey, is the donation still available?"
  },
  "data": {
    "type": "CHAT_MESSAGE",
    "idempotencyKey": "chat:019058b0-...-msg",
    "action": "chat.open",
    "chatId": "019058b0-...-conv",
    "conversationId": "019058b0-...-conv",
    "messageId": "019058b0-...-msg",
    "senderId": "019058b0-...-user",
    "senderName": "Jane Doe",
    "senderAvatarUrl": "https://cdn.example.com/avatars/jane.jpg"
  },
  "android": {
    "notification": {
      "imageUrl": "https://cdn.example.com/avatars/jane.jpg"
    }
  },
  "apns": {
    "fcmOptions": {
      "imageUrl": "https://cdn.example.com/avatars/jane.jpg"
    }
  }
}
```

Notes:

- **All `data` values are strings.** Numbers and booleans are stringified by the worker; nested objects are JSON-encoded. Parse them on the client.
- `notification.body` is truncated to ≤120 chars with `...` so it never breaks the OS push UI.
- `imageUrl` is set when the action carries one; absent otherwise. See section 5.

## 3) Action contract (single source of truth)

The mobile/web client routes on `data.action`. The required and optional fields per action are guaranteed by the backend.

| action              | required meta                                  | optional meta                                                                       | image source                                   |
| ------------------- | ---------------------------------------------- | ----------------------------------------------------------------------------------- | ---------------------------------------------- |
| `chat.open`         | `chatId`, `conversationId`, `messageId`, `senderId` | `senderName`, `senderAvatarUrl`                                                | `senderAvatarUrl`                              |
| `donation.open`     | `donationId`                                   | `donationTitle`, `donationImageUrl`, `donorId`                                      | `donationImageUrl`                             |
| `reservation.open`  | `reservationId`, `donationId`, `status`        | `beneficiaryName`, `donationTitle`, `donationImageUrl`, `senderAvatarUrl`, `quantity` | `donationImageUrl` preferred, else `senderAvatarUrl` |
| `report.open`       | `reportId`, `targetType`, `targetId`           | `status`                                                                            | —                                              |
| `account.open`      | `userId`, `status`                             | —                                                                                   | —                                              |
| `achievement.open`  | `achievementId`, `badgeCode`                   | —                                                                                   | —                                              |
| `post.open`         | `postId`                                       | `commentId`, `authorId`                                                             | —                                              |
| `message.open`      | `threadId` or `senderId`                       | —                                                                                   | —                                              |
| `notification.open` | —                                              | —                                                                                   | — (fallback)                                   |

Any unknown action string the client encounters MUST be treated as `notification.open` (open the in-app notifications list).

> The canonical constants live in `src/core/notifications/constants/notification-actions.ts` (`NOTIFICATION_ACTION`). Keep the mobile/web enum in sync with that file.

## 4) Per-type push content rules

The backend formats `notification.title` and `notification.body` per type. The client should NOT re-format them — render as received.

| type                  | title                                  | body                                                          |
| --------------------- | -------------------------------------- | ------------------------------------------------------------- |
| `CHAT_MESSAGE`        | sender display name (or `"New message"` if missing) | the message content, ellipsised at 120 chars         |
| `RESERVATION_ALERT`   | `"Donation reserved"`                  | `"{beneficiaryName} reserved qty of {donationTitle}."`        |
| `REPORT_ALERT`        | type-specific (set by backend)         | type-specific                                                 |
| `ACCOUNT_STATUS_ALERT`| type-specific                          | type-specific                                                 |
| `NEW_ACHIEVEMENT`     | `"New achievement unlocked"`           | `"You unlocked the \"{badgeName}\" badge."`                   |

If the title/body ever look wrong, fix the call site on the backend, not on the client.

## 5) Images on iOS and Android

The backend sets the same URL on both platforms:

- Android: `android.notification.imageUrl` — rendered as the big picture.
- iOS: `apns.fcmOptions.imageUrl` — requires a Notification Service Extension in the iOS app to download and attach the image. Without the extension iOS will show the push without the image. (Standard FCM behaviour; not a backend concern.)

The image is chosen in this order by the worker (`resolveImageUrl`):

1. `meta.imageUrl` (escape hatch — currently unused)
2. `meta.donationImageUrl` (donation cover, where applicable)
3. `meta.senderAvatarUrl` (chat sender)

Currently set for: `chat.open` (sender avatar), `reservation.open` (donation cover, falling back to beneficiary avatar). Other actions have no image.

## 6) Routing on tap (mobile)

Pseudocode the Flutter side should implement when a push is tapped (foreground or background):

```dart
void handleNotificationTap(RemoteMessage msg) {
  final data = msg.data;
  final action = data['action'] ?? 'notification.open';

  switch (action) {
    case 'chat.open':
      router.push('/chat/${data['conversationId']}', extra: {
        'messageId': data['messageId'],
        'senderId':  data['senderId'],
      });
      break;

    case 'donation.open':
      router.push('/donations/${data['donationId']}');
      break;

    case 'reservation.open':
      router.push('/reservations/${data['reservationId']}', extra: {
        'donationId': data['donationId'],
        'status':     data['status'],
      });
      break;

    case 'report.open':
      router.push('/reports/${data['reportId']}');
      break;

    case 'account.open':
      router.push('/settings/account');
      break;

    case 'achievement.open':
      router.push('/profile/achievements/${data['achievementId']}');
      break;

    case 'post.open':
      router.push('/posts/${data['postId']}', extra: {
        'commentId': data['commentId'],
      });
      break;

    case 'message.open':
      router.push('/messages/${data['threadId'] ?? data['senderId']}');
      break;

    default:
      router.push('/notifications');
  }
}
```

The same `action` mapping is reused for in-app taps on the notifications list (the GraphQL `Notification.meta` returns the same fields).

## 7) Client-side dedupe with `idempotencyKey`

The backend computes a stable `idempotencyKey` per notification, e.g.:

- `chat:<messageId>` for chat
- `reservation:<reservationId>` for reservations
- `donation:<donationId>` for donation events
- `report:<reportId>`, `account:<userId>:<status>`, `achievement:<achievementId>`, `post:<postId>:<commentId>`

If two pushes arrive with the same `idempotencyKey` within a short window (e.g. retry, multiple devices), the client SHOULD collapse them: only present the newer one, and treat them as the same logical event.

> Server-side dedupe (BullMQ `jobId` or Redis `SETNX`) is a planned follow-up. Until then, treat `idempotencyKey` as a client-side hint.

## 8) In-app notifications (GraphQL)

The GraphQL `Notification` type exposes `meta: JSON` carrying the exact same fields. Use the same action-router on tap from the in-app list. Example query (existing):

```graphql
query MyNotifications($pagination: PaginationInput) {
  notifications(pagination: $pagination) {
    items {
      id
      type
      title
      body
      isRead
      createdAt
      meta # { action, chatId, ... } — same shape as FCM data
    }
    total
    page
    limit
  }
}
```

`meta` keeps the original types (numbers stay numbers, objects stay objects) — only the FCM `data` channel stringifies values.

## 9) Migration notes for existing clients

- Old chat pushes had `title: "New chat message"`, `body: "You have received a new message."`. New chat pushes carry the actual sender and message content. If your client was matching on those literal strings — stop, route on `data.action` instead.
- Old pushes didn't include `action`. Older saved notifications in the DB also don't have it. Treat any `meta` without an `action` as `notification.open` (open the in-app list).
- `data` payload size: FCM caps `data` at 4KB. Backend already truncates `body` to 120 chars and stringifies meta carefully, but if you add fields to the action contract make sure the total stays well under 4KB.

