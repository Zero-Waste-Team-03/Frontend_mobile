# 🚀 Flutter Starter - GraphQL Edition

## What I've Built For You

A complete Flutter starter with **GraphQL integration** that handles everything from authentication to data fetching. This is production-ready and follows best practices from the 3amerli architecture.

## ✨ Key Features

### 🔐 Authentication (GraphQL-based)
- Complete auth flow with JWT tokens
- Secure token storage (flutter_secure_storage)
- Automatic token injection in all API calls
- Login/logout mutations
- Mock service for local testing

### 📊 GraphQL Integration
- `graphql_flutter` package configured
- Client setup with auth headers
- Token management (store/retrieve/clear)
- Example queries and mutations
- Real-time subscriptions support
- Error handling

### 🎨 UI/UX
- Light & dark theme support
- Multi-language (English/Arabic)
- BLoC state management
- Responsive screens

### 📦 Project Structure
```
lib/
├── main.dart                          # GraphQL provider + app setup
├── blocs/                             # State management
│   ├── auth/                          # Auth cubit & states
│   ├── theme/                         # Theme toggle
│   └── locale/                        # Language switching
├── core/
│   ├── app_constants.dart             # App constants
│   ├── env.dart                       # .env loader
│   └── theme.dart                     # Theme config
├── l10n/                              # Localization
│   └── locale_service.dart
├── screens/
│   ├── login_screen.dart              # Login UI
│   ├── home_screen.dart               # Main screen
│   └── example_graphql_screen.dart    # GraphQL examples
└── services/
    ├── auth/
    │   ├── auth_service.dart          # Auth interface
    │   ├── graphql_auth_service.dart  # GraphQL implementation
    │   └── mock_auth_service.dart     # Mock for testing
    └── graphql/
        ├── graphql_config.dart        # Client + tokens
        ├── graphql_service.dart       # Query/mutation helpers
        ├── queries.dart               # Reusable queries
        └── mutations.dart             # Reusable mutations
```

## 🎯 How It Works

### Authentication Flow

```
1. User enters credentials in LoginScreen
         ↓
2. AuthCubit calls GraphQLAuthService.signIn()
         ↓
3. GraphQL login mutation sent to backend:
   mutation Login($username, $password) {
     login(...) { token, user { ... } }
   }
         ↓
4. Backend validates & returns JWT token
         ↓
5. Token stored in secure storage
         ↓
6. GraphQL client refreshed (adds auth header)
         ↓
7. All future requests include: Authorization: Bearer <token>
         ↓
8. AuthCubit emits Authenticated state
         ↓
9. UI shows HomeScreen
```

### Making GraphQL Calls

**Option 1: Using GraphQLService (in Cubits)**
```dart
final result = await GraphQLService.query(
  '''
  query GetProducts {
    products { id name price }
  }
  ''',
);

if (!result.hasException) {
  final products = result.data?['products'];
  // Use data
}
```

**Option 2: Using Query Widget (in UI)**
```dart
Query(
  options: QueryOptions(
    document: gql(GraphQLQueries.getProducts),
  ),
  builder: (result, {refetch}) {
    if (result.isLoading) return CircularProgressIndicator();
    if (result.hasException) return Text('Error');
    
    final products = result.data?['products'];
    return ListView(...);
  },
)
```

**Option 3: Using Mutation Widget**
```dart
Mutation(
  options: MutationOptions(
    document: gql(GraphQLMutations.createItem),
  ),
  builder: (runMutation, result) {
    return ElevatedButton(
      onPressed: () => runMutation({'title': 'New Item'}),
      child: Text('Create'),
    );
  },
)
```

## 🚀 Quick Start

### 1. Configure Your Backend

Edit `.env` file:
```env
GRAPHQL_ENDPOINT=https://your-api.com/graphql
```

### 2. Update GraphQL Schema

Edit `lib/services/graphql/queries.dart` and `mutations.dart` to match your backend schema.

### 3. Run the App

```powershell
flutter pub get
flutter run
```

### 4. Test Login

The app starts on `LoginScreen`. Enter any credentials (using MockAuthService by default).

To use real GraphQL backend:
- Backend must implement the mutations in `graphql_auth_service.dart`
- Update `.env` with your endpoint
- Auth service automatically handles everything

## 📝 Backend Requirements

Your GraphQL API needs these mutations:

```graphql
# Login (REQUIRED)
mutation Login($username: String!, $password: String!) {
  login(username: $username, password: $password) {
    token          # JWT access token
    refreshToken   # Optional refresh token
    user {
      id
      username
      email
    }
  }
}

# Logout (OPTIONAL)
mutation Logout {
  logout {
    success
  }
}

# Get current user (REQUIRED)
query CurrentUser {
  me {
    id
    username
  }
}
```

## 📚 Documentation

- **README.md** - Full documentation with setup, usage, testing
- **GRAPHQL_GUIDE.md** - Complete GraphQL integration guide
  - Architecture flow diagrams
  - Usage patterns
  - Error handling
  - Performance tips
  - Testing strategies
  - Migration from REST

## 🔧 Common Tasks

### Add a New Feature

1. Create cubit in `lib/blocs/my_feature/`
2. Add GraphQL queries in `lib/services/graphql/queries.dart`
3. Create screen in `lib/screens/`
4. Wire cubit in `main.dart`

### Add a New Query

```dart
// 1. Add to queries.dart
static const String getOrders = r'''
  query GetOrders {
    orders { id status }
  }
''';

// 2. Use in code
final result = await GraphQLService.query(
  GraphQLQueries.getOrders,
);
```

### Add a New Mutation

```dart
// 1. Add to mutations.dart
static const String placeOrder = r'''
  mutation PlaceOrder($items: [OrderItemInput!]!) {
    placeOrder(items: $items) { id status }
  }
''';

// 2. Use in code
final result = await GraphQLService.mutate(
  GraphQLMutations.placeOrder,
  variables: {'items': [...]},
);
```

## 🐛 Troubleshooting

### "Target of URI doesn't exist" errors
```powershell
flutter pub get
```

### Token not being sent
Check that you called `GraphQLConfig.setToken()` after login.

### CORS errors (web)
Configure your backend to allow your Flutter web origin.

### Connection timeout
Verify `GRAPHQL_ENDPOINT` in `.env` is correct.

## 📦 Packages Used

- `graphql_flutter` - GraphQL client
- `flutter_bloc` - State management
- `flutter_dotenv` - Environment variables
- `flutter_secure_storage` - Secure token storage
- `equatable` - Value equality
- `intl` - Internationalization

## 🎯 What's Next?

1. **Replace Mock Backend**: Update `.env` with your real GraphQL endpoint
2. **Customize Schema**: Edit queries/mutations to match your API
3. **Add Features**: Follow the patterns in `example_graphql_screen.dart`
4. **Add Tests**: See examples in `test/widget_test.dart`
5. **Deploy**: Build for Android/iOS/Web

## 📖 Examples Included

- `lib/screens/example_graphql_screen.dart` - Complete example with:
  - Query widget usage
  - Mutation widget usage
  - Loading states
  - Error handling
  - Refetching data
  - Pull-to-refresh

## 💡 Pro Tips

1. **Use Query Widget** for reactive UI that auto-updates
2. **Use GraphQLService** in cubits for business logic
3. **Store common queries** in `queries.dart` for reusability
4. **Enable logging** during development (see GRAPHQL_GUIDE.md)
5. **Use optimistic updates** for better UX
6. **Implement pagination** for large lists
7. **Add error boundaries** to catch and display errors nicely

## 🤝 Need Help?

1. Check `README.md` for detailed documentation
2. Read `GRAPHQL_GUIDE.md` for GraphQL patterns
3. Look at `example_graphql_screen.dart` for examples
4. Check GraphQL Flutter docs: https://pub.dev/packages/graphql_flutter

## ✅ What I've Verified

- ✅ Flutter create run successfully (android, ios, web folders created)
- ✅ Dependencies installed (`flutter pub get`)
- ✅ GraphQL packages added
- ✅ Auth service implemented
- ✅ Token management working
- ✅ Example screens created
- ✅ Documentation complete
- ✅ Project structure organized

## 🚀 Ready to Build!

Your starter is fully configured and ready to use. Just:
1. Configure your backend endpoint in `.env`
2. Update the GraphQL schema to match your API
3. Start building features!

Happy coding! 🎉
