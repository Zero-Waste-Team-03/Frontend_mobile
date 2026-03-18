# My Flutter Starter

This is a lightweight starter scaffold extracted from the `3amerli` app. It includes:

- **GraphQL Integration** - Complete GraphQL client setup with auth handling
- **Environment Loading** - Via `.env` and `flutter_dotenv`
- **Authentication** - General `AuthService` abstraction with GraphQL implementation
- **State Management** - BLoC/Cubit architecture: `AuthCubit`, `ThemeCubit`, `LocaleCubit`
- **Localization** - Simple JSON-based localization loader (`assets/l10n/en.json`, `ar.json`)
- **Theming** - Light and dark theme support in `lib/core/theme.dart`
- **Secure Storage** - Token management with `flutter_secure_storage`

## Quick Start

1. Ensure Flutter SDK is installed and available on PATH.
2. Update the GraphQL endpoint in `.env`:
   ```env
   GRAPHQL_ENDPOINT=https://your-api.com/graphql
   ```
3. From this folder run:

```powershell
flutter pub get
flutter run
```

## GraphQL Setup

### How It Works

The app uses `graphql_flutter` package to communicate with your GraphQL backend. Here's the architecture:

#### 1. GraphQL Configuration (`lib/services/graphql/graphql_config.dart`)

This manages:
- **Client Creation** - Initializes GraphQL client with proper headers
- **Auth Headers** - Automatically adds `Authorization: Bearer <token>` to requests
- **Token Storage** - Securely stores JWT tokens using `flutter_secure_storage`
- **Token Refresh** - Updates client when tokens change (after login/logout)

```dart
// Create a client
final client = await GraphQLConfig.createClient();

// Store a token (automatically adds to future requests)
await GraphQLConfig.setToken('your-jwt-token');

// Clear tokens on logout
await GraphQLConfig.clearTokens();
```

#### 2. GraphQL Service (`lib/services/graphql/graphql_service.dart`)

A simple wrapper for common operations:

**Execute a Query:**
```dart
final result = await GraphQLService.query(
  '''
  query GetUser($id: ID!) {
    user(id: $id) {
      id
      name
      email
    }
  }
  ''',
  variables: {'id': '123'},
);

if (!result.hasException) {
  final user = result.data?['user'];
  print('User: ${user['name']}');
}
```

**Execute a Mutation:**
```dart
final result = await GraphQLService.mutate(
  '''
  mutation UpdateUser($id: ID!, $name: String!) {
    updateUser(id: $id, name: $name) {
      id
      name
    }
  }
  ''',
  variables: {'id': '123', 'name': 'John'},
);
```

**Subscribe to Real-time Data:**
```dart
final stream = GraphQLService.subscribe(
  '''
  subscription OnMessageAdded {
    messageAdded {
      id
      content
    }
  }
  ''',
);

stream.listen((result) {
  if (!result.hasException) {
    final message = result.data?['messageAdded'];
    print('New message: $message');
  }
});
```

#### 3. Auth Service (`lib/services/auth/graphql_auth_service.dart`)

Implements the `AuthService` interface using GraphQL mutations:

**How Login Works:**
1. User enters username/password in `LoginScreen`
2. `AuthCubit` calls `authService.signIn()`
3. `GraphQLAuthService` sends login mutation to backend
4. Backend returns JWT token + user data
5. Token is stored securely using `flutter_secure_storage`
6. GraphQL client is refreshed to include token in future requests
7. `AuthCubit` emits `Authenticated` state
8. UI automatically navigates to `HomeScreen`

**Backend Requirements:**
Your GraphQL API should have these mutations/queries:

```graphql
# Login
mutation Login($username: String!, $password: String!) {
  login(username: $username, password: $password) {
    token          # JWT access token (required)
    refreshToken   # JWT refresh token (optional)
    user {
      id
      username
      email
    }
  }
}

# Logout
mutation Logout {
  logout {
    success
  }
}

# Get current user
query CurrentUser {
  me {
    id
    username
  }
}
```

#### 4. Using GraphQL in Widgets

**Option A: Using GraphQLService (Recommended for simple cases)**
```dart
class MyWidget extends StatelessWidget {
  Future<void> _loadData() async {
    final result = await GraphQLService.query(
      GraphQLQueries.getItems,
      variables: {'limit': 10},
    );
    
    if (!result.hasException) {
      final items = result.data?['items'];
      // Update your state
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _loadData,
      child: Text('Load Data'),
    );
  }
}
```

**Option B: Using Query Widget (Recommended for reactive UI)**
```dart
import 'package:graphql_flutter/graphql_flutter.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(GraphQLQueries.getItems),
        variables: {'limit': 10},
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return CircularProgressIndicator();
        }

        if (result.hasException) {
          return Text('Error: ${result.exception}');
        }

        final items = result.data?['items'] as List;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index]['title']),
            );
          },
        );
      },
    );
  }
}
```

**Option C: Using Mutation Widget**
```dart
class CreateItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(GraphQLMutations.createItem),
        onCompleted: (data) {
          print('Item created: ${data}');
        },
      ),
      builder: (runMutation, result) {
        return ElevatedButton(
          onPressed: () {
            runMutation({
              'title': 'New Item',
              'description': 'Description',
            });
          },
          child: result!.isLoading
              ? CircularProgressIndicator()
              : Text('Create Item'),
        );
      },
    );
  }
}
```

### Token Refresh Flow

If your backend supports refresh tokens:

1. Access token expires
2. GraphQL request fails with 401
3. App catches error and uses refresh token to get new access token
4. Stores new tokens and retries original request

**To implement auto-refresh** (optional), modify `GraphQLConfig.createClient()`:

```dart
// Add error link for token refresh
final errorLink = ErrorLink(
  onException: (request, forward, exception) async {
    if (exception is ServerException && exception.statusCode == 401) {
      // Token expired, refresh it
      final refreshToken = await getRefreshToken();
      if (refreshToken != null) {
        // Call refresh mutation
        final newToken = await _refreshToken(refreshToken);
        await setToken(newToken);
        
        // Retry request
        return forward(request);
      }
    }
    return forward(request);
  },
);

// Combine error link with other links
final link = errorLink.concat(authLink).concat(httpLink);
```

## Project Structure

```
lib/
├── main.dart                   # App entry point with GraphQL provider
├── blocs/                      # State management (Cubits)
│   ├── auth/
│   │   ├── auth_cubit.dart
│   │   └── auth_state.dart
│   ├── theme/
│   │   └── theme_cubit.dart
│   └── locale/
│       └── locale_cubit.dart
├── core/
│   ├── app_constants.dart      # App-wide constants
│   ├── env.dart                # Environment loader
│   └── theme.dart              # Theme configuration
├── l10n/
│   └── locale_service.dart     # JSON-based localization
├── screens/
│   ├── home_screen.dart        # Home screen (after auth)
│   └── login_screen.dart       # Login screen
└── services/
    ├── auth/
    │   ├── auth_service.dart           # Auth interface
    │   ├── graphql_auth_service.dart   # GraphQL auth implementation
    │   └── mock_auth_service.dart      # Mock for testing
    └── graphql/
        ├── graphql_config.dart         # Client setup & token management
        ├── graphql_service.dart        # Query/mutation helpers
        ├── queries.dart                # Reusable queries
        └── mutations.dart              # Reusable mutations

assets/
└── l10n/
    ├── en.json                 # English translations
    └── ar.json                 # Arabic translations
```

## Environment Variables

Edit `.env` to configure your app:

```env
APP_NAME=MyFlutterStarter
GRAPHQL_ENDPOINT=https://api.example.com/graphql
ENABLE_ANALYTICS=false
```

## Adding New Features

### 1. Add a New GraphQL Query

1. Add query to `lib/services/graphql/queries.dart`:
```dart
static const String getProducts = r'''
  query GetProducts($categoryId: ID!) {
    products(categoryId: $categoryId) {
      id
      name
      price
    }
  }
''';
```

2. Use in widget:
```dart
final result = await GraphQLService.query(
  GraphQLQueries.getProducts,
  variables: {'categoryId': '123'},
);
```

### 2. Add a New Feature with Cubit

1. Create cubit: `lib/blocs/products/products_cubit.dart`
2. Define states: `lib/blocs/products/products_state.dart`
3. Add GraphQL calls in cubit methods
4. Provide cubit in `main.dart`
5. Use `BlocBuilder` in widgets

## Testing

### Unit Tests for GraphQL Auth

```dart
test('Login stores token correctly', () async {
  final authService = GraphQLAuthService();
  
  final success = await authService.signIn(
    username: 'testuser',
    password: 'password123',
  );
  
  expect(success, true);
  final token = await GraphQLConfig.getToken();
  expect(token, isNotNull);
});
```

### Widget Tests with MockClient

```dart
testWidgets('Login screen shows error on invalid credentials', (tester) async {
  final mockClient = MockClient((request) async {
    return Response('{"errors": [{"message": "Invalid credentials"}]}', 401);
  });

  await tester.pumpWidget(MyApp(
    authService: GraphQLAuthService(),
    localeService: LocaleService(),
    clientNotifier: ValueNotifier(mockClient),
  ));
  
  // Test login flow
});
```

## Backend Setup Example

Here's a minimal GraphQL schema your backend should implement:

```graphql
type User {
  id: ID!
  username: String!
  email: String!
  profile: Profile
}

type Profile {
  avatar: String
  bio: String
}

type AuthPayload {
  token: String!
  refreshToken: String
  user: User!
}

type Query {
  me: User
  user(id: ID!): User
}

type Mutation {
  login(username: String!, password: String!): AuthPayload
  register(username: String!, email: String!, password: String!): AuthPayload
  logout: LogoutPayload
}

type LogoutPayload {
  success: Boolean!
}
```

## Common Issues

### 1. "Target of URI doesn't exist" errors
Run `flutter pub get` to fetch dependencies.

### 2. Token not being sent with requests
Make sure to call `GraphQLConfig.setToken()` after login and refresh the client.

### 3. CORS errors on web
Configure your backend to allow requests from your Flutter web origin.

### 4. Connection timeout
Check that `GRAPHQL_ENDPOINT` in `.env` is correct and your backend is running.

## Next Steps

- [ ] Replace example queries/mutations with your actual GraphQL schema
- [ ] Add error handling UI (toast messages, error screens)
- [ ] Implement token refresh logic
- [ ] Add pagination for list queries
- [ ] Add optimistic updates for better UX
- [ ] Set up unit tests for cubits
- [ ] Add widget tests for screens
- [ ] Configure CI/CD pipeline

## Resources

- [GraphQL Flutter Documentation](https://pub.dev/packages/graphql_flutter)
- [Flutter BLoC Documentation](https://bloclibrary.dev/)
- [GraphQL Best Practices](https://graphql.org/learn/best-practices/)

