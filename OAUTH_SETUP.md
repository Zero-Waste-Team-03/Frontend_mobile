# OAuth Setup Guide

This guide explains how to use the OAuth authentication flow in your Flutter app.

## 📱 Deep Link Configuration

The app is configured to handle OAuth callbacks using the following deep link scheme:

**Deep Link URL:** `gaspzero://oauth-callback`

### Configured Platforms:

#### ✅ Android
- **File:** `android/app/src/main/AndroidManifest.xml`
- **Scheme:** `gaspzero`
- **Host:** `oauth-callback`
- **Intent Filter:** Configured with `android:autoVerify="true"`

#### ✅ iOS
- **File:** `ios/Runner/Info.plist`
- **Bundle URL Type:** `com.gaspzero.oauth`
- **URL Scheme:** `gaspzero`

## 🔐 OAuth Flow

### How It Works:

```
┌─────────────┐         ┌──────────────┐         ┌─────────────────┐         ┌─────────────┐
│  Your App   │────────>│ Your Backend │────────>│ OAuth Provider  │────────>│   Browser   │
│             │  (1)    │              │  (2)    │  (Google, etc)  │  (3)    │             │
└─────────────┘         └──────────────┘         └─────────────────┘         └─────────────┘
       ^                                                                              │
       │                                                                              │
       │                                              (4) User approves               │
       │                                                                              │
       └──────────────────────────────────────────────────────────────────────────────┘
                                   Deep Link with Token
                          gaspzero://oauth-callback?token=xxx
```

### Steps:

1. **User taps OAuth button** → App calls `AuthCubit.signInWithOAuth()`
2. **App requests auth URL** → Backend returns OAuth provider's authorization URL
3. **Opens external browser** → User sees OAuth provider's consent screen
4. **User approves** → OAuth provider redirects to `gaspzero://oauth-callback?token=xxx`
5. **App receives deep link** → Extracts token and fetches user data
6. **Authentication complete** → User is logged in

## 🚀 Usage

### In Login Screen:

```dart
// Sign in with Google
await context.read<AuthCubit>().signInWithOAuth(
  provider: 'google',
  backendUrl: 'https://your-backend.com',
);

// Sign in with GitHub
await context.read<AuthCubit>().signInWithOAuth(
  provider: 'github',
  backendUrl: 'https://your-backend.com',
);

// Sign in with Facebook
await context.read<AuthCubit>().signInWithOAuth(
  provider: 'facebook',
  backendUrl: 'https://your-backend.com',
);
```

### Backend Integration:

Your backend needs to implement an OAuth initiation endpoint that:

1. Receives the OAuth provider name (e.g., 'google', 'github')
2. Receives the callback URL: `gaspzero://oauth-callback`
3. Generates and returns the OAuth provider's authorization URL

#### Example Backend Endpoint:

**Request:**
```http
POST /auth/oauth/initiate
Content-Type: application/json

{
  "provider": "google",
  "redirect_uri": "gaspzero://oauth-callback"
}
```

**Response:**
```json
{
  "auth_url": "https://accounts.google.com/o/oauth2/v2/auth?client_id=xxx&redirect_uri=gaspzero://oauth-callback&..."
}
```

#### OAuth Callback Handling:

After user authentication, your backend OAuth callback endpoint should:

1. Receive the authorization code from OAuth provider
2. Exchange it for access/refresh tokens
3. Create or update user in your database
4. Redirect to: `gaspzero://oauth-callback?token=YOUR_JWT_TOKEN&refresh_token=REFRESH_TOKEN`

**Important:** The tokens in the deep link should be YOUR backend's JWT tokens, not the OAuth provider's tokens.

## 🔧 Implementation Files

### 1. OAuth Service
**File:** `lib/services/auth/oauth_service.dart`

Handles the OAuth flow:
- Requests auth URL from backend
- Launches external browser
- Listens for deep link callbacks
- Extracts tokens from URL parameters

### 2. Auth Service Interface
**File:** `lib/services/auth/auth_service.dart`

Added new method:
```dart
Future<bool> signInWithOAuth({
  required String provider,
  required String backendUrl,
});
```

### 3. GraphQL Auth Service
**File:** `lib/services/auth/graphql_auth_service.dart`

Implementation of OAuth sign-in:
- Calls `OAuthService.initiateOAuthFlow()`
- Stores received tokens
- Fetches user data to verify authentication

### 4. Auth Cubit
**File:** `lib/blocs/auth/auth_cubit.dart`

Added state management for OAuth:
```dart
Future<void> signInWithOAuth({
  required String provider,
  required String backendUrl,
}) async
```

### 5. Login Screen
**File:** `lib/screens/login_screen.dart`

UI with OAuth buttons:
- Google OAuth button
- GitHub OAuth button
- Facebook OAuth button
- Loading states

## 📝 Customization

### Change Deep Link Scheme:

1. **Update `oauth_service.dart`:**
   ```dart
   static const String callbackScheme = 'yourappname';
   static const String callbackHost = 'oauth-callback';
   ```

2. **Update `AndroidManifest.xml`:**
   ```xml
   <data
       android:scheme="yourappname"
       android:host="oauth-callback" />
   ```

3. **Update `Info.plist`:**
   ```xml
   <string>yourappname</string>
   ```

### Add New OAuth Provider:

1. **Update login screen** with new button:
   ```dart
   _OAuthButton(
     onPressed: () => _handleOAuthSignIn('linkedin'),
     icon: Icons.business,
     label: 'Continue with LinkedIn',
     backgroundColor: const Color(0xFF0077B5),
     textColor: Colors.white,
   ),
   ```

2. **Configure provider on your backend**

### Environment Configuration:

Add to `.env` file:
```env
API_URL=https://your-backend.com
OAUTH_GOOGLE_ENABLED=true
OAUTH_GITHUB_ENABLED=true
OAUTH_FACEBOOK_ENABLED=true
```

## 🧪 Testing

### Testing Deep Links (Android):

```bash
# Test deep link on Android emulator/device
adb shell am start -W -a android.intent.action.VIEW -d "gaspzero://oauth-callback?token=test_token_123&refresh_token=test_refresh_456"
```

### Testing Deep Links (iOS):

```bash
# Test deep link on iOS simulator
xcrun simctl openurl booted "gaspzero://oauth-callback?token=test_token_123&refresh_token=test_refresh_456"
```

### Mock Testing:

The `MockAuthService` automatically succeeds OAuth flows for testing:
```dart
final authService = MockAuthService();
await authService.signInWithOAuth(
  provider: 'google',
  backendUrl: 'https://test.com',
);
// Returns true, simulates success
```

## 🔒 Security Considerations

1. **HTTPS Only:** Always use HTTPS for your backend endpoints
2. **Token Validation:** Validate tokens on the backend before issuing JWT
3. **State Parameter:** Consider adding CSRF protection with state parameter
4. **Token Expiry:** Implement proper token refresh logic
5. **Deep Link Validation:** Verify the deep link origin before processing tokens

## 🐛 Troubleshooting

### Deep link not opening app:

1. **Android:** 
   - Uninstall and reinstall app
   - Check `adb logcat` for intent filter errors
   - Verify `android:autoVerify="true"` is set

2. **iOS:**
   - Check URL schemes in Xcode project settings
   - Verify scheme matches in `Info.plist`
   - Test with Safari first before other apps

### OAuth flow times out:

- Default timeout is 5 minutes
- Check if browser opened successfully
- Verify backend OAuth endpoint is accessible
- Check network connectivity

### Tokens not received:

- Verify deep link format: `scheme://host?token=xxx`
- Check query parameter names match (`token`, `refresh_token`)
- Enable debug logging in `OAuthService`

## 📚 Additional Resources

- [Universal Links (iOS)](https://developer.apple.com/ios/universal-links/)
- [App Links (Android)](https://developer.android.com/training/app-links)
- [uni_links Package](https://pub.dev/packages/uni_links)
- [url_launcher Package](https://pub.dev/packages/url_launcher)

## 🎯 TODO: Backend Implementation

Update the `_getAuthUrlFromBackend` method in `oauth_service.dart` with your actual HTTP call:

```dart
Future<String> _getAuthUrlFromBackend(String backendUrl, String provider) async {
  final response = await http.post(
    Uri.parse('$backendUrl/auth/oauth/initiate'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'provider': provider,
      'redirect_uri': OAuthService.callbackUrl,
    }),
  );
  
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['auth_url'];
  } else {
    throw OAuthException('Backend returned ${response.statusCode}');
  }
}
```

---

**Ready to test!** Run your app and tap on any OAuth button to start the flow. Make sure your backend OAuth endpoints are ready to handle the requests.
