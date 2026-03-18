# GraphQL Integration Guide

## Overview

This Flutter starter uses GraphQL as the primary backend communication protocol. All API interactions (auth, queries, mutations) are handled through GraphQL, making the app flexible and backend-agnostic.

## Architecture Flow

```
┌─────────────────┐
│   Flutter UI    │
│   (Widgets)     │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   BLoC/Cubit    │
│  (State Mgmt)   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  GraphQL Service│ ◄── Uses GraphQLConfig
│  or Auth Service│     for token management
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ GraphQL Client  │ ◄── Auto-adds auth headers
│ (graphql_flutter│     from secure storage
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Backend API   │
│  (GraphQL)      │
└─────────────────┘
```

## How Authentication Works

### 1. Login Flow

```dart
User enters credentials → LoginScreen
         ↓
AuthCubit.signIn() called
         ↓
GraphQLAuthService.signIn()
         ↓
Send GraphQL login mutation:
  mutation Login($username, $password) {
    login(...) {
      token
      refreshToken
      user { ... }
    }
  }
         ↓
Backend validates & returns tokens
         ↓
Tokens stored in flutter_secure_storage
         ↓
GraphQL client refreshed with new auth header
         ↓
AuthCubit emits Authenticated(userId)
         ↓
UI automatically shows HomeScreen
```

### 2. Authenticated Requests

Once logged in, all GraphQL requests automatically include the auth header:

```
Authorization: Bearer <jwt-token>
```

This happens transparently in `GraphQLConfig.createClient()`:

```dart
final token = await getToken();
if (token != null) {
  authLink = AuthLink(
    getToken: () async => 'Bearer $token',
  );
}
```

### 3. Logout Flow

```dart
User clicks logout → HomeScreen
         ↓
AuthCubit.signOut()
         ↓
GraphQLAuthService.signOut()
         ↓
(Optional) Send logout mutation to backend
         ↓
Clear tokens from secure storage
         ↓
Refresh GraphQL client (removes auth header)
         ↓
AuthCubit emits Unauthenticated()
         ↓
UI shows LoginScreen
```

## Usage Patterns

### Pattern 1: Simple Service Call (Recommended for Business Logic)

Use this in Cubits or service classes:

```dart
class ProductsCubit extends Cubit<ProductsState> {
  Future<void> loadProducts() async {
    emit(ProductsLoading());
    
    try {
      final result = await GraphQLService.query(
        '''
        query GetProducts {
          products {
            id
            name
            price
          }
        }
        ''',
      );

      if (result.hasException) {
        emit(ProductsError(result.exception.toString()));
        return;
      }

      final products = result.data?['products'] as List;
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
```

### Pattern 2: Query Widget (Recommended for Direct UI Binding)

Use this when you want reactive UI that auto-updates:

```dart
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(GraphQLQueries.getProducts),
        pollInterval: Duration(seconds: 30), // Auto-refresh
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return CircularProgressIndicator();
        }

        if (result.hasException) {
          return Text('Error: ${result.exception}');
        }

        final products = result.data?['products'] as List;
        
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, i) => ListTile(
            title: Text(products[i]['name']),
            subtitle: Text('\$${products[i]['price']}'),
          ),
        );
      },
    );
  }
}
```

### Pattern 3: Mutation Widget (For User Actions)

```dart
class AddToCartButton extends StatelessWidget {
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql('''
          mutation AddToCart($productId: ID!) {
            addToCart(productId: $productId) {
              cart {
                items { id quantity }
              }
            }
          }
        '''),
        onCompleted: (data) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Added to cart!')),
          );
        },
      ),
      builder: (runMutation, result) {
        return ElevatedButton(
          onPressed: result!.isLoading
              ? null
              : () => runMutation({'productId': productId}),
          child: result.isLoading
              ? CircularProgressIndicator()
              : Text('Add to Cart'),
        );
      },
    );
  }
}
```

## Backend Schema Requirements

Your GraphQL backend should implement this minimal schema:

```graphql
type Query {
  # Auth
  me: User
  
  # Add your app-specific queries
  products: [Product!]!
  product(id: ID!): Product
}

type Mutation {
  # Auth (REQUIRED)
  login(username: String!, password: String!): AuthPayload!
  register(username: String!, email: String!, password: String!): AuthPayload!
  logout: LogoutPayload
  
  # Add your app-specific mutations
  createProduct(input: ProductInput!): Product!
  updateProduct(id: ID!, input: ProductInput!): Product!
}

type User {
  id: ID!
  username: String!
  email: String!
}

type AuthPayload {
  token: String!           # JWT access token
  refreshToken: String     # Optional refresh token
  user: User!
}

type LogoutPayload {
  success: Boolean!
}

# Add your app-specific types
type Product {
  id: ID!
  name: String!
  price: Float!
}

input ProductInput {
  name: String!
  price: Float!
}
```

## Token Management

### Storage

Tokens are stored securely using `flutter_secure_storage`:

- **Android**: EncryptedSharedPreferences
- **iOS**: Keychain
- **Web**: Web Crypto API
- **Desktop**: Platform-specific secure storage

### Access

```dart
// Get current token
final token = await GraphQLConfig.getToken();

// Set new token
await GraphQLConfig.setToken('new-jwt-token');

// Clear tokens (logout)
await GraphQLConfig.clearTokens();
```

### Refresh Logic (Optional)

To implement automatic token refresh:

1. Backend returns `refreshToken` on login
2. App stores both `token` and `refreshToken`
3. When API returns 401, use refresh token to get new access token
4. Retry original request

Example implementation:

```dart
import 'package:gql_error_link/gql_error_link.dart';

ErrorLink errorLink = ErrorLink(
  onException: (request, forward, exception) async {
    if (exception is ServerException && exception.statusCode == 401) {
      // Token expired
      final refreshToken = await GraphQLConfig.getRefreshToken();
      
      if (refreshToken != null) {
        // Call refresh mutation
        final newToken = await _callRefreshMutation(refreshToken);
        await GraphQLConfig.setToken(newToken);
        
        // Retry original request
        return forward(request);
      }
    }
    return forward(request);
  },
);

// Add to link chain in GraphQLConfig.createClient()
final link = errorLink.concat(authLink).concat(httpLink);
```

## Error Handling

### Check for Errors

```dart
final result = await GraphQLService.query('...');

if (result.hasException) {
  final exception = result.exception;
  
  // Check for network errors
  if (exception!.linkException != null) {
    print('Network error: ${exception.linkException}');
  }
  
  // Check for GraphQL errors
  if (exception.graphqlErrors.isNotEmpty) {
    for (var error in exception.graphqlErrors) {
      print('GraphQL error: ${error.message}');
      print('Error code: ${error.extensions?['code']}');
    }
  }
}
```

### Common Error Patterns

```dart
// Unauthorized
if (error.extensions?['code'] == 'UNAUTHENTICATED') {
  // Force logout
  context.read<AuthCubit>().signOut();
}

// Validation error
if (error.extensions?['code'] == 'BAD_USER_INPUT') {
  // Show validation messages
  showDialog(...);
}

// Not found
if (error.extensions?['code'] == 'NOT_FOUND') {
  // Navigate back or show 404
}
```

## Testing

### Mock GraphQL Responses

```dart
import 'package:mockito/mockito.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MockGraphQLClient extends Mock implements GraphQLClient {}

test('Load products successfully', () async {
  final mockClient = MockGraphQLClient();
  
  when(mockClient.query(any)).thenAnswer((_) async => QueryResult(
    data: {
      'products': [
        {'id': '1', 'name': 'Product 1', 'price': 10.0},
      ],
    },
    source: QueryResultSource.network,
  ));

  // Test your cubit with mockClient
});
```

## Performance Tips

### 1. Use Caching

```dart
QueryOptions(
  document: gql(query),
  fetchPolicy: FetchPolicy.cacheFirst, // Use cache if available
)
```

### 2. Optimize Query Size

Only request fields you need:

```graphql
# Bad: fetches everything
query GetProducts {
  products {
    id
    name
    description
    price
    stock
    images { url }
    reviews { ... }
  }
}

# Good: only what's needed for the list
query GetProductsList {
  products {
    id
    name
    price
  }
}
```

### 3. Use Pagination

```graphql
query GetProducts($limit: Int!, $offset: Int!) {
  products(limit: $limit, offset: $offset) {
    id
    name
  }
}
```

### 4. Batch Requests

Use `fetchMore` for infinite scroll:

```dart
fetchMore(
  FetchMoreOptions(
    variables: {'offset': currentItems.length},
    updateQuery: (prev, fetchMoreResult) {
      final List prevItems = prev?['products'] ?? [];
      final List newItems = fetchMoreResult?['products'] ?? [];
      return {'products': [...prevItems, ...newItems]};
    },
  ),
);
```

## Debugging

### Enable GraphQL Logging

In `main.dart`:

```dart
void main() {
  // Add GraphQL logging
  HttpLink.enableGraphQLLogging = true;
  
  runApp(MyApp());
}
```

This logs all GraphQL requests/responses to console.

### Use GraphQL Playground

Test queries directly: https://your-api.com/graphql

### Flutter DevTools

Use Network tab to inspect GraphQL traffic.

## Migration from REST

If migrating from REST:

| REST | GraphQL |
|------|---------|
| GET /api/products | query { products { ... } } |
| GET /api/products/123 | query { product(id: "123") { ... } } |
| POST /api/products | mutation { createProduct(...) { ... } } |
| PUT /api/products/123 | mutation { updateProduct(id: "123", ...) { ... } } |
| DELETE /api/products/123 | mutation { deleteProduct(id: "123") { ... } } |

Benefits of GraphQL:
- Single endpoint
- Request exactly what you need
- Strong typing
- Real-time subscriptions
- Better error handling
