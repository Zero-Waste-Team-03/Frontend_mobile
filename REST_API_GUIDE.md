# REST API Backend Setup Guide

## Overview
This project has been successfully converted from GraphQL to REST API backend. This guide explains the new architecture and how to use the REST API services.

## What Changed

### Removed
- ❌ `graphql_flutter` package
- ❌ `lib/services/graphql/graphql_config.dart`
- ❌ `lib/services/graphql/graphql_service.dart`
- ❌ `lib/services/graphql/queries.dart`
- ❌ `lib/services/graphql/mutations.dart`
- ❌ `lib/services/auth/graphql_auth_service.dart`
- ❌ `lib/screens/example_graphql_screen.dart`

### Added
- ✅ `dio` package (v5.4.0) - Advanced HTTP client
- ✅ `lib/services/api/api_service.dart` - REST API client
- ✅ `lib/services/auth/rest_auth_service.dart` - REST-based authentication
- ✅ `lib/screens/example_api_screen.dart` - REST API example screen

## Architecture

### API Service (`lib/services/api/api_service.dart`)

The `ApiService` is a singleton that manages all REST API calls. It uses Dio for HTTP requests with built-in features:

- **Token Management**: Automatically adds Bearer tokens to requests
- **Error Handling**: Converts HTTP errors to user-friendly messages
- **Logging**: Logs all requests/responses for debugging
- **Interceptors**: Auth and logging interceptors

#### Usage Example

```dart
final apiService = ApiService.instance;

// GET request
final response = await apiService.get('/api/items', queryParameters: {'limit': 10});

// POST request
final response = await apiService.post('/api/items', data: {'title': 'New Item'});

// PUT request
final response = await apiService.put('/api/items/123', data: {'title': 'Updated'});

// DELETE request
final response = await apiService.delete('/api/items/123');
```

### REST Auth Service (`lib/services/auth/rest_auth_service.dart`)

The `RestAuthService` implements the `AuthService` interface using REST API endpoints.

#### Expected API Endpoints

Your backend should implement these endpoints:

| Method | Endpoint | Request Body | Response |
|--------|----------|--------------|----------|
| POST | `/auth/login` | `{ "username": "...", "password": "..." }` | `{ "token": "...", "refreshToken": "...", "user": {...} }` |
| POST | `/auth/register` | `{ "username": "...", "email": "...", "password": "..." }` | `{ "token": "...", "refreshToken": "...", "user": {...} }` |
| POST | `/auth/logout` | - | `{ "success": true }` |
| GET | `/auth/me` | - | `{ "id": "...", "username": "...", "email": "..." }` |

#### Usage Example

```dart
final authService = RestAuthService();

// Login
final success = await authService.signIn(
  username: 'user@example.com',
  password: 'password123',
);

// Register
final success = await authService.register(
  username: 'newuser',
  email: 'user@example.com',
  password: 'password123',
);

// OAuth
final success = await authService.signInWithOAuth(
  provider: 'google',
  backendUrl: 'https://api.example.com/auth/oauth',
);

// Check auth status
final isLoggedIn = await authService.isSignedIn();

// Get current user ID
final userId = await authService.currentUserId();

// Logout
await authService.signOut();
```

## Configuration

### Environment Variables

Set your API base URL in the `.env` file:

```env
API_BASE_URL=https://api.example.com
APP_NAME=MyFlutterStarter
```

The `ApiService` will use `API_BASE_URL` as the base for all requests. If not set, it defaults to `https://api.example.com`.

### Token Storage

Tokens are stored securely using `flutter_secure_storage`:

- **Access Token**: Stored as `auth_token`
- **Refresh Token**: Stored as `refresh_token`

Tokens are automatically:
- Added to request headers as `Authorization: Bearer <token>`
- Retrieved from secure storage
- Cleared on logout or 401 errors

## OAuth Flow (Deep Linking)

The OAuth flow remains the same:

1. Call `signInWithOAuth(provider: 'google', backendUrl: '...')`
2. App opens external browser with OAuth URL
3. User authenticates with provider
4. Provider redirects back to app via deep link: `myflutterstarter://oauth-callback?token=...&refresh_token=...`
5. App extracts tokens and stores them
6. App verifies tokens by calling `/auth/me`

Deep link scheme: `myflutterstarter://oauth-callback`

## Example Screen

The `ExampleApiScreen` demonstrates:

- ✅ GET requests with query parameters
- ✅ POST requests with JSON body
- ✅ DELETE requests
- ✅ Error handling and retry
- ✅ Loading states
- ✅ Pull-to-refresh
- ✅ Empty states

Access it at route: `/example`

## Testing

The REST API can be tested with:

```dart
import 'package:my_flutter_starter/services/api/api_service.dart';

void testApi() async {
  final apiService = ApiService.instance;
  
  try {
    final response = await apiService.get('/api/health');
    print('API Status: ${response.statusCode}');
  } catch (e) {
    print('Error: $e');
  }
}
```

## Migration Checklist for Your Backend

To support this Flutter app, your backend needs:

- [ ] REST API endpoints for auth (login, register, logout, me)
- [ ] JWT token generation and validation
- [ ] Bearer token authentication on protected routes
- [ ] OAuth callback endpoint that returns tokens
- [ ] CORS enabled for web platform
- [ ] Error responses in format: `{ "message": "Error description" }`

## Common API Response Formats

### Success Response
```json
{
  "data": { ... },
  "message": "Success"
}
```

### Error Response
```json
{
  "message": "Error description",
  "code": "ERROR_CODE"
}
```

### List Response
```json
{
  "items": [...],
  "total": 100,
  "page": 1,
  "limit": 10
}
```

## Debugging

All API requests and responses are logged using `AppLogger`. Check the console for:

- Request method, URL, headers, and body
- Response status code and data
- Error messages and stack traces

Example log output:
```
INFO POST https://api.example.com/auth/login
Data: {username: user@example.com, password: ****}

INFO Response 200:
{token: eyJhbGc..., user: {...}}
```

## Next Steps

1. **Set up your backend** with the required REST API endpoints
2. **Update `.env`** file with your API base URL
3. **Test authentication** using the login/register screens
4. **Test OAuth flow** if you're using social authentication
5. **Implement your API endpoints** following the example screen patterns

## Additional Notes

- The `http` package (v1.1.0) is also available for simpler requests
- `dio` is used for advanced features like interceptors and better error handling
- All network calls are async and use try-catch for error handling
- Token refresh logic can be added to the `_AuthInterceptor` in `api_service.dart`

---

**Previous Backend**: GraphQL
**Current Backend**: REST API
**Conversion Date**: 2024
**Status**: ✅ Complete
