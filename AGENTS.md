# Flutter Mobile App - Technical Overview for Development Agents

This document provides a comprehensive technical overview of the CP3 Zero Waste mobile application frontend, including its architecture, components, patterns, and instructions for interacting with the codebase.

---

## 🏗️ Tech Stack

### Framework & Language

- **Flutter**: Cross-platform mobile framework for iOS and Android
- **Dart**: Primary programming language (>=3.9.0 <4.0.0)

### State Management

- **flutter_bloc (8.1.2)**: BLoC pattern implementation for predictable state management
- **Equatable (2.0.5)**: Value equality for objects without needing to override ==

### Network & API Communication

- **ferry (0.16.1)**: GraphQL client with strong typing
- **gql_http_link (1.0.1)**: HTTP transport layer for GraphQL
- **dio (5.4.0)**: HTTP client for REST API calls
- **http (1.1.0)**: Alternative HTTP library

### Authentication & Security

- **flutter_secure_storage (8.0.0)**: Secure token storage
- **jwt_decoder**: JWT token parsing and validation

### Code Generation & Serialization

- **freezed (3.2.5)**: Immutable model generation
- **freezed_annotation (3.1.0)**: Freezed annotations
- **json_annotation (4.9.0)**: JSON serialization annotations
- **json_serializable (6.7.1)**: JSON serialization code generation
- **injectable (2.3.2)**: Service locator code generation
- **build_runner (2.4.13)**: Code generation runner

### Dependency Injection

- **get_it (7.6.0)**: Service locator implementation
- **injectable (2.3.2)**: Annotation-based dependency injection

### Routing & Navigation

- **go_router (14.0.0)**: Production-grade routing solution with nested navigation
- **app_links (6.4.0)**: Deep linking support for OAuth callbacks

### UI & UX

- **flutter_screenutil (5.9.3)**: Responsive screen design adaptation
- **flutter_svg (2.0.10+1)**: SVG rendering support
- **google_fonts (6.2.1)**: Google Fonts integration
- **cached_network_image (3.4.1)**: Image caching and optimization
- **shimmer (3.0.0)**: Shimmer loading animation effects

### Localization & Internationalization

- **flutter_localizations**: Official Flutter localization
- **intl (0.20.2)**: Internationalization and localization package

### Utilities & Tools

- **logger (2.0.2)**: Structured logging
- **connectivity_plus (5.0.2)**: Network connectivity monitoring
- **shared_preferences (2.5.4)**: Local key-value storage
- **flutter_dotenv (5.0.2)**: Environment variable management
- **formz (0.8.0)**: Form validation utilities
- **dartz (0.10.1)**: Functional programming utilities
- **fpdart (1.2.0)**: Functional programming Dart library

### Maps & Location Services

- **flutter_map (8.2.2)**: Interactive map widget
- **latlong2 (0.9.1)**: Latitude/longitude handling
- **geolocator (14.0.2)**: Geolocation services
- **geocoding (4.0.0)**: Address geocoding/reverse geocoding

### Media & File Handling

- **image_picker (1.2.1)**: Image selection from device
- **path_provider (2.1.1)**: File system path access

### Push Notifications & Analytics

- **firebase_core (2.24.2)**: Firebase initialization
- **firebase_analytics (10.8.0)**: Firebase analytics
- **firebase_messaging (14.7.10)**: Push notifications
- **firebase_crashlytics (3.4.9)**: Crash reporting

### Other

- **url_launcher (6.3.1)**: URL launching (web, phone, email)
- **socket_io_client (3.1.4)**: WebSocket real-time communication

---

## 📱 Project Architecture Overview

### Design Pattern: Clean Architecture

The project follows **Clean Architecture** principles with a clear separation of concerns:

```
┌─────────────────────────────────────────────────┐
│         Presentation Layer (UI)                 │
│  - Widgets, Pages, BLoC/Cubit, Event/State    │
└────────────────────┬────────────────────────────┘
                     │
┌─────────────────────▼────────────────────────────┐
│         Domain Layer                            │
│  - Entities, Use Cases, Abstract Repositories  │
└────────────────────┬────────────────────────────┘
                     │
┌─────────────────────▼────────────────────────────┐
│         Data Layer                              │
│  - Repositories, Data Sources, Models          │
└─────────────────────────────────────────────────┘
```

### State Management: BLoC Pattern

- **Events**: User actions or external triggers
- **States**: UI state representations
- **BLoC/Cubit**: Business logic container that manages events → states

Example flow:

```
User Interaction → Event → BLoC Processing → State → UI Update
```

---

## 📁 Complete Folder Structure

```
Frontend_mobile/
├── android/                                      # Android native code
├── ios/                                          # iOS native code
├── web/                                          # Web platform support
├── assets/                                       # App resources
│   ├── icons/
│   │   └── donations/
│   ├── images/
│   └── l10n/                                    # Localization files
│       ├── en.json                              # English translations
│       └── ar.json                              # Arabic translations
├── build/                                        # Generated build artifacts
├── lib/                                          # Main source code
│   ├── main.dart                                # App entry point
│   ├── core/                                    # Core infrastructure & utilities
│   │   ├── app_constants.dart                  # App-wide constants
│   │   ├── app_icons.dart                      # Icon constants
│   │   ├── env.dart                            # Environment variable loader
│   │   ├── theme.dart                          # Legacy theme file
│   │   ├── di/                                 # Dependency Injection
│   │   │   └── injection.dart                  # Service locator setup (injectable)
│   │   ├── errors/
│   │   │   └── failures.dart                   # Failure models for error handling
│   │   ├── exceptions/
│   │   │   ├── app_exceptions.dart             # Custom exception classes
│   │   │   └── exceptions.dart                 # Additional exception types
│   │   ├── graphql/                            # GraphQL setup
│   │   │   └── client.dart                     # GraphQL client factory
│   │   ├── network/
│   │   │   └── auth_interceptor.dart           # Dio interceptor for auth headers
│   │   ├── router/
│   │   │   └── app_router.dart                 # Go Router configuration & routes
│   │   └── theme/
│   │       └── app_theme.dart                  # Material theme configuration
│   ├── features/                               # Feature modules (isolable parts)
│   │   ├── auth/                               # Authentication feature
│   │   │   ├── data/
│   │   │   │   ├── models/                     # Data transfer objects (DTOs)
│   │   │   │   ├── repositories/               # Repository implementations
│   │   │   │   └── sources/                    # Data sources (local/remote)
│   │   │   │       ├── auth_local_data_source.dart
│   │   │   │       ├── auth_remote_data_source.dart
│   │   │   │       ├── graphql/                # GraphQL operations
│   │   │   │       │   ├── login.graphql
│   │   │   │       │   ├── register.graphql
│   │   │   │       │   └── update_profile.graphql
│   │   │   │       └── rest/                   # REST endpoints
│   │   │   ├── domain/
│   │   │   │   ├── entities/                   # Business entities
│   │   │   │   ├── repositories/               # Abstract repositories
│   │   │   │   └── usecases/                   # Use cases (business logic)
│   │   │   └── presentation/
│   │   │       ├── bloc/                       # BLoC for state management
│   │   │       │   ├── auth_bloc.dart
│   │   │       │   ├── auth_event.dart         # Events user can trigger
│   │   │       │   └── auth_state.dart         # Possible states
│   │   │       └── pages/                      # Full-page screens
│   │   │           ├── intro_page.dart
│   │   │           ├── login_page.dart
│   │   │           ├── register_flow_page.dart
│   │   │           └── forgot_password_page.dart
│   │   ├── donations/                          # Donations feature (user contributions)
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   ├── repositories/
│   │   │   │   └── sources/
│   │   │   │       ├── donation_remote_data_source.dart
│   │   │   │       └── graphql/                # Donation queries/mutations
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── donation.dart           # Main donation entity
│   │   │   │   ├── repositories/
│   │   │   │   └── usecases/
│   │   │   └── presentation/
│   │   │       ├── bloc/                       # Donations state management
│   │   │       │   ├── donations_bloc.dart
│   │   │       │   ├── donations_event.dart
│   │   │       │   └── donations_state.dart
│   │   │       ├── pages/
│   │   │       │   ├── donations_home_page.dart
│   │   │       │   ├── donations_list_page.dart
│   │   │       │   ├── donation_details_page.dart
│   │   │       │   ├── donation_details_full_page.dart
│   │   │       │   └── add_donation_page.dart
│   │   │       └── widgets/                    # Reusable components
│   │   ├── profile/                            # User profile management
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   ├── repositories/
│   │   │   │   └── sources/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   ├── repositories/
│   │   │   │   └── usecases/
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── profile_bloc.dart
│   │   │       │   ├── profile_event.dart
│   │   │       │   └── profile_state.dart
│   │   │       └── pages/
│   │   │           ├── profile_page.dart
│   │   │           └── edit_profile_page.dart
│   │   ├── reservation/                       # Activity/donation reservations
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   ├── repositories/
│   │   │   │   └── datasources/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   ├── repositories/
│   │   │   │   └── usecases/
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       └── pages/
│   │   │           ├── my_reservations_page.dart
│   │   │           ├── my_activities_page.dart
│   │   │           └── reservation_details_page.dart
│   │   ├── notification/                      # Push notifications & in-app notifications
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   ├── repositories/
│   │   │   │   └── sources/
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   ├── repositories/
│   │   │   │   └── usecases/
│   │   │   └── presentation/
│   │   │       ├── bloc/
│   │   │       │   ├── notification_bloc.dart
│   │   │       │   ├── notification_event.dart
│   │   │       │   └── notification_state.dart
│   │   │       └── pages/
│   │   │           └── notifications_page.dart
│   │   ├── chat/                               # Real-time messaging (WebSocket)
│   │   │   └── presentation/
│   │   │       └── pages/
│   │   │           └── chat_placeholder_page.dart
│   │   └── map/                                # Map visualization feature
│   ├── l10n/                                   # Localization (generated by Flutter)
│   │   └── app_localizations.dart              # Generated localization class
│   └── shared/                                 # Shared components across features
│       ├── shared.dart
│       ├── theme/
│       │   └── app_colors.dart                 # Color palette constants
│       └── widgets/                            # Reusable UI components
│           ├── main_shell.dart                 # BottomNavigationBar shell widget
│           └── [other shared components]
├── test/                                        # Unit and widget tests
│   ├── smoke_test.dart
│   └── widget_test.dart
├── l10n.yaml                                   # Localization configuration
├── pubspec.yaml                                # Dependencies & app config
├── analysis_options.yaml                       # Code analysis rules
├── build.yaml                                  # Build configuration
├── .env                                        # Environment variables (not in git)
├── README.md
├── QUICKSTART.md
├── GRAPHQL_GUIDE.md
├── I18N_GUIDE.md
├── OAUTH_SETUP.md
├── REST_API_GUIDE.md
├── IMPLEMENTATION_STATUS.md
├── GETTING_STARTED.md
└── [other configuration files]
```

### Key Files to Know

| File                                      | Purpose                                                            |
| ----------------------------------------- | ------------------------------------------------------------------ |
| `lib/main.dart`                           | App entry point, BLoC providers setup, theme & localization config |
| `lib/core/di/injection.dart`              | Service locator & dependency injection configuration               |
| `lib/core/router/app_router.dart`         | Route configuration with nested navigation & auth guards           |
| `lib/core/graphql/client.dart`            | GraphQL client factory with auth token management                  |
| `lib/core/network/auth_interceptor.dart`  | Dio interceptor that adds auth headers to requests                 |
| `lib/core/exceptions/app_exceptions.dart` | Custom exception hierarchy for error handling                      |
| `pubspec.yaml`                            | Complete list of dependencies and Flutter configuration            |

---

## 🎯 Core Architecture Patterns

### 1. **Clean Architecture Layers**

#### Presentation Layer (UI)

- **Responsibility**: Display data and handle user interactions
- **Components**: Pages, Widgets, BLoCs/Cubits, Events, States
- **Location**: `lib/features/[feature]/presentation/`
- **Guidelines**:
  - Pages should be stateless and delegate logic to BLoCs
  - Use BlocBuilder for conditional UI rendering
  - Use BlocListener for navigation and side effects
  - Keep UI logic minimal—push business logic to BLoC

#### Domain Layer (Business Logic)

- **Responsibility**: Core business rules independent of frameworks
- **Components**: Entities, Use Cases, Abstract Repositories
- **Location**: `lib/features/[feature]/domain/`
- **Guidelines**:
  - Entities represent domain models (immutable, core business concepts)
  - Use Cases orchestrate domain logic (contain one business action each)
  - Repository interfaces define the contract for data operations

#### Data Layer (Data Access)

- **Responsibility**: Retrieve and manage data from various sources
- **Components**: Repositories, Data Sources, Models
- **Location**: `lib/features/[feature]/data/`
- **Guidelines**:
  - Models extend entities and add serialization
  - Data Sources abstract specific backends (GraphQL, REST, local)
  - Repositories implement domain interfaces and coordinate data sources

### 2. **BLoC Pattern (Business Logic Component)**

**Purpose**: Isolate business logic from UI, making code testable and reusable.

**Key Components**:

- **Event**: User action or external trigger
- **State**: Immutable representation of UI state
- **BLoC**: Listens to events and emits states

**Example Flow**:

```
User clicks "Login" Button
       ↓
LoginButtonPressed Event added to LoginBloc
       ↓
LoginBloc processes event in `on<LoginButtonPressed>`
       ↓
Calls use case: loginUseCase.call(username, password)
       ↓
Use case returns Result (Right/Left for success/failure)
       ↓
BLoC emits AuthSuccess or AuthFailure state
       ↓
BlocBuilder/BlocListener in UI reacts to state change
```

**State Pattern (Equatable)**:

```dart
@immutable
abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final User user;
  const LoginSuccess(this.user);
  @override
  List<Object?> get props => [user];
}
class LoginError extends LoginState {
  final String message;
  const LoginError(this.message);
  @override
  List<Object?> get props => [message];
}
```

### 3. **Service Locator (Dependency Injection)**

**Tool**: `get_it` with `injectable` code generation

**Purpose**: Manage object creation and lifecycle, decouple dependencies

**Configuration**: `lib/core/di/injection.dart`

**Usage**:

```dart
// Get singleton instance
final authRepository = getIt<AuthRepository>();

// Or use in BlocProvider
BlocProvider(
  create: (context) => getIt<AuthBloc>(),
  child: MyWidget(),
)
```

### 4. **Repository Pattern**

Acts as an abstraction layer between domain and data layers.

**Key Points**:

- Returns `Either<Failure, Success>` (functional programming with dartz)
- Coordinates local and remote data sources
- Handles data transformation between models and entities

**Example**:

```dart
abstract class AuthRepository {
  Future<Either<AuthFailure, AuthSuccess>> login(String email, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteSource;
  final AuthLocalDataSource localSource;

  @override
  Future<Either<AuthFailure, AuthSuccess>> login(String email, String password) async {
    try {
      final result = await remoteSource.login(email, password);
      await localSource.cacheToken(result.token);
      return Right(result);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
```

---

## 🔐 Authentication Architecture

### Auth Flow Diagram

```
┌─────────────────────────────────────────────────────────┐
│                    Auth Flow                            │
└─────────────────────────────────────────────────────────┘

1. STARTUP
   ↓
   AuthBloc.add(AuthCheckRequested())
   ↓
   Checks if token exists in secure storage
   ↓
   Token exists? → AuthAuthenticated
   No token?    → AuthUnauthenticated

2. LOGIN
   User enters credentials → LoginPage
   ↓
   AuthBloc.add(AuthLoginRequested(email, password))
   ↓
   GraphQLAuthService.login() sends GraphQL mutation
   ↓
   Backend returns token + user data
   ↓
   Token stored in flutter_secure_storage
   ↓
   GraphQL client refreshed with auth header
   ↓
   AuthBloc emits AuthAuthenticated(user)
   ↓
   AppRouter navigates to /home

3. AUTHENTICATED REQUESTS
   All subsequent GraphQL/HTTP requests include:
   Authorization: Bearer <jwt_token>

4. TOKEN REFRESH
   If token expired, interceptor detects 401
   ↓
   Attempts refresh token (if available)
   ↓
   Updates token in secure storage
   ↓
   Retries original request

5. LOGOUT
   User clicks logout
   ↓
   AuthBloc.add(AuthLogoutRequested())
   ↓
   GraphQLAuthService.logout() (optional backend call)
   ↓
   Token removed from secure storage
   ↓
   GraphQL client auth header cleared
   ↓
   AuthBloc emits AuthUnauthenticated()
   ↓
   AppRouter navigates to /login
```

### Key Files

| File                                                            | Purpose                                       |
| --------------------------------------------------------------- | --------------------------------------------- |
| `lib/features/auth/presentation/bloc/auth_bloc.dart`            | Main auth state machine                       |
| `lib/features/auth/domain/usecases/`                            | Auth business logic (check user, logout, etc) |
| `lib/features/auth/data/repositories/auth_repository_impl.dart` | Coordinates local/remote auth data            |
| `lib/features/auth/data/sources/auth_remote_data_source.dart`   | GraphQL login/register mutations              |
| `lib/features/auth/data/sources/auth_local_data_source.dart`    | Token storage & retrieval                     |
| `lib/core/network/auth_interceptor.dart`                        | Adds Authorization header to requests         |

### Security Best Practices

✅ **Implemented**:

- JWT tokens stored securely in `flutter_secure_storage` (encrypted)
- Tokens automatically added to all GraphQL/HTTP requests
- Tokens cleared on logout
- Invalid/expired tokens trigger re-authentication

🔄 **Token Management**:

- Check token existence on app startup (AuthCheckRequested event)
- Refresh tokens handled by Dio interceptor (401 response)
- Logout clears all stored tokens

---

## 📡 Data Fetching & API Integration

### GraphQL Integration

**Primary data fetching method** using `ferry` client.

#### Setup

```dart
// lib/core/graphql/client.dart
class GraphQLClientFactory {
  Client create() {
    // Creates ferry GraphQL client
    // Adds auth headers automatically
    // Handles subscriptions, fragments, etc.
  }
}
```

#### GraphQL Operations

**Location**: `lib/features/[feature]/data/sources/graphql/`

**Files**:

- `.graphql` files contain query/mutation/subscription definitions
- Generated `.req.gql.dart` files are typed models

**Example Query**:

```graphql
query GetDonations($limit: Int!) {
  donations(limit: $limit) {
    id
    title
    description
    status
  }
}
```

**Usage in Code**:

```dart
final result = await donationsDataSource.getDonations(limit: 10);
```

#### Benefits

- **Type-safe**: Full TypeScript-like type checking
- **No serialization boilerplate**: Generated from schema
- **Efficient**: Only requests fields needed
- **Real-time**: Subscription support built-in

### REST API Integration

**Secondary method** using `dio` HTTP client.

**Configuration**: `lib/core/di/injection.dart`

**Auth Headers**: Automatically added via `auth_interceptor.dart`

**Usage**:

```dart
class MyRemoteDataSource {
  final Dio dio;

  Future<MyModel> fetchData() async {
    final response = await dio.get('/endpoint');
    return MyModel.fromJson(response.data);
  }
}
```

### Error Handling

**Exception Hierarchy** (`lib/core/exceptions/app_exceptions.dart`):

```dart
NetworkException          // Network/connectivity issues
AuthenticationException   // Auth failures
ValidationException       // Form validation errors
ServerException          // Backend errors (500, etc)
CacheException           // Local caching issues
```

**Usage**:

```dart
try {
  final result = await remoteSource.fetchData();
  return Right(result);
} on NetworkException catch (e) {
  return Left(NetworkFailure(e.message));
} on AuthenticationException catch (e) {
  return Left(AuthFailure(e.message));
}
```

---

## 🛣️ Routing & Navigation

**Tool**: `go_router` (v14+)

**Configuration**: `lib/core/router/app_router.dart`

### Route Structure

```dart
final appRouter = GoRouter(
  routes: [
    // ─── Auth Routes (no bottom nav)
    GoRoute(path: '/', builder: (ctx, state) => IntroPage()),
    GoRoute(path: '/login', builder: (ctx, state) => LoginPage()),
    GoRoute(path: '/register', builder: (ctx, state) => RegisterFlowPage()),

    // ─── Main App Routes (with bottom nav)
    StatefulShellRoute.indexedStack(
      builder: (ctx, state, shell) => MainShell(shell),
      branches: [
        // Tab 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: ...)
          ],
        ),
        // Tab 1: Browse
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/browse', builder: ...)
          ],
        ),
        // Tab 2: Chat
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/chat', builder: ...)
          ],
        ),
        // Tab 3: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/profile', builder: ...)
          ],
        ),
      ],
    ),
  ],
);
```

### Programmatic Navigation

```dart
// Push named route
context.go('/login');

// Pop current route
context.pop();

// Navigate with extras
context.go('/donation-details', extra: donationObject);

// Get route parameters
final params = state.pathParameters;
```

### Auth Guards

Implemented via `appRouter.redirect` (check `app_router.dart`):

- Unauthenticated users redirected to `/login`
- After login, users navigate to `/home`
- Uses `AuthBloc` state to determine access

---

## 🌍 Localization & Multi-Language Support

**Framework**: Flutter's official i18n system with **ARB files**

### Structure

```
assets/l10n/
├── app_en.arb       # English (template)
└── app_ar.arb       # Arabic
```

### How It Works

1. **ARB Files** define translations and placeholders
2. **build_runner** generates type-safe localization class
3. **AppLocalizations** is used throughout the app

### Usage in Code

```dart
import 'l10n/app_localizations.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Text(l10n.welcomeMessage);  // Type-safe!
  }
}
```

### Adding New Strings

1. Add to `app_en.arb`:

```json
{
  "myNewString": "Hello, {name}!",
  "@myNewString": {
    "description": "Greeting with name",
    "placeholders": {
      "name": { "type": "String", "example": "John" }
    }
  }
}
```

2. Add to `app_ar.arb`:

```json
{
  "myNewString": "مرحبا، {name}!"
}
```

3. Run code generation:

```bash
flutter pub get
flutter gen-l10n
```

4. Use in code:

```dart
l10n.myNewString('Ahmed')  // generates: "مرحا، Ahmed!"
```

---

## 🎨 Theming System

**Configuration**: `lib/core/theme/app_theme.dart`

**Features**:

- Light & dark theme support
- Material Design 3 compliance
- Color palette via `lib/shared/theme/app_colors.dart`
- Typography configuration

### Using Themes

```dart
// Get current theme
final theme = Theme.of(context);
final colors = theme.colorScheme;

// Access colors
colors.primary
colors.secondary
colors.surface
colors.error
```

### Dynamic Theme Switching

(To be implemented with theme_bloc)

---

## 📐 Responsive Design

**Tool**: `flutter_screenutil` (5.9.3)

**Purpose**: Adapt UI across different device sizes

### Setup

```dart
// lib/main.dart
ScreenUtilInit(
  designSize: const Size(393, 852),  // iPhone 14 Pro base size
  minTextAdapt: true,
  splitScreenMode: true,
  builder: (context, child) {
    return MaterialApp.router(...);
  },
)
```

### Usage

```dart
// Responsive width
SizedBox(width: 100.w)   // Scales to screen width

// Responsive font size
Text('Hello', style: TextStyle(fontSize: 16.sp))

// Responsive padding/margin
Padding(padding: EdgeInsets.all(16.w))
```

---

## ✅ Dependency Injection

**System**: `get_it` service locator with `injectable` code generation

**Configuration File**: `lib/core/di/injection.dart`

### Registering Dependencies

```dart
Future<void> configureDependencies() async {
  // ─── Storage ───
  getIt.registerLazySingleton(() => const FlutterSecureStorage());

  // ─── Network ───
  final dio = Dio(BaseOptions(...));
  getIt.registerLazySingleton(() => dio);

  // ─── Repositories ───
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt()),
  );

  // ─── BLoCs ───
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(getIt()),
  );
}
```

### Singleton vs Factory

- **Singleton**: One instance for the app's lifetime (storage, repos, services)
- **LazySingleton**: Created on first access
- **Factory**: New instance each time (BLoCs, for state isolation)

---

## 📦 Code Generation

### Freezed (Immutable Models)

**Purpose**: Generate immutable classes with copyWith, toString, etc.

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

**Generated**:

- `freezed.dart` - Immutable implementation
- `.g.dart` - JSON serialization

### Ferry/GraphQL Code Generation

```bash
flutter pub run build_runner build
```

Generates:

- `.req.gql.dart` - Request models (typed from GraphQL schema)
- `.var.gql.dart` - Variable models

### Don't forget to run after schema changes:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 🚀 Key Development Guidelines

### For Agents Implementing Features

#### 1. **Adding a New Feature**

Follow the Clean Architecture template:

```
lib/features/myfeature/
├── data/
│   ├── datasources/          # Local/remote data access
│   ├── models/               # Serializable models
│   └── repositories/         # Implementations
├── domain/
│   ├── entities/             # Business models
│   ├── repositories/         # Contracts
│   └── usecases/             # Business logic
└── presentation/
    ├── bloc/                 # State management
    ├── pages/                # Full screens
    └── widgets/              # Reusable components
```

#### 2. **Adding a GraphQL Query**

1. Create `.graphql` file in `data/datasources/graphql/`
2. Run code generation: `flutter pub run build_runner build`
3. Use generated types in data source

#### 3. **Creating a BLoC**

```dart
class MyBloc extends Bloc<MyEvent, MyState> {
  final MyUseCase useCase;

  MyBloc(this.useCase) : super(MyInitial()) {
    on<MyEvent>(_onMyEvent);
  }

  FutureOr<void> _onMyEvent(MyEvent event, Emitter<MyState> emit) async {
    emit(MyLoading());
    final result = await useCase.call();
    result.fold(
      (failure) => emit(MyError(failure.message)),
      (success) => emit(MySuccess(success)),
    );
  }
}
```

#### 4. **Error Handling**

Always catch specific exceptions:

```dart
try {
  final data = await remoteSource.fetchData();
  return Right(data);
} on NetworkException catch (e) {
  return Left(NetworkFailure(e.message));
} on ServerException catch (e) {
  return Left(ServerFailure(e.statusCode));
} catch (e) {
  return Left(UnknownFailure(e.toString()));
}
```

#### 5. **Using Bloc in Widgets**

```dart
// Listen for state changes & navigation
BlocListener<MyBloc, MyState>(
  listener: (ctx, state) {
    if (state is MySuccess) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(...));
    }
  },
  child: BlocBuilder<MyBloc, MyState>(
    builder: (ctx, state) {
      if (state is MyLoading) return CircularProgressIndicator();
      if (state is MySuccess) return Text('Success: ${state.data}');
      if (state is MyError) return Text('Error: ${state.message}');
      return Text('Initial');
    },
  ),
);
```

#### 6. **Testing Best Practices**

- Mock data sources in repository tests
- Mock repositories in BLoC tests
- Test one concern per test

---

## 🔗 DeepLinking & OAuth

### Deep Link Configuration

**Android**: `android/app/src/main/AndroidManifest.xml`
**iOS**: `ios/Runner/Info.plist`

**Scheme**: `gaspzero://oauth-callback`

### OAuth Flow

1. User clicks OAuth button
2. App requests auth URL from backend
3. Opens browser with OAuth provider
4. On approval, redirects to `gaspzero://oauth-callback?token=...`
5. App extracts token from deep link
6. Updates auth state

See `OAUTH_SETUP.md` for detailed implementation.

---

## 📊 Current Implementation Status

✅ **Completed Features**:

- Authentication (GraphQL-based login/register)
- Route navigation with auth guards
- Secure token storage
- Error handling and exceptions
- Code generation setup (Freezed, Ferry, Injectable)
- Localization (i18n support)
- Theming (light/dark)
- Responsive design (ScreenUtil)
- Network connectivity monitoring
- Dependency injection

⏳ **Features in Progress**:

- Donations feature (CRUD operations)
- Profile feature (viewing/editing)
- Reservations/activities feature
- Chat with WebSocket
- Notifications with Firebase
- Map integration

---

## 📚 Additional Resources

| Document                 | Content                                |
| ------------------------ | -------------------------------------- |
| README.md                | Project overview & quick launch        |
| QUICKSTART.md            | Getting started guide                  |
| GRAPHQL_GUIDE.md         | How to use GraphQL in the app          |
| REST_API_GUIDE.md        | REST API integration patterns          |
| I18N_GUIDE.md            | Localization system explanations       |
| OAUTH_SETUP.md           | OAuth and deep linking setup           |
| IMPLEMENTATION_STATUS.md | Detailed feature implementation status |

---

## 🎯 Development Workflow for Agents

### Before Starting Work

1. **Read the relevant feature folder** to understand current architecture
2. **Check IMPLEMENTATION_STATUS.md** for what's done/in progress
3. **Review existing similar features** for patterns
4. **Plan your feature** following Clean Architecture

### During Development

1. **Create models first** (entities in domain, models in data)
2. **Implement data layer** (data sources, repositories)
3. **Implement domain layer** (usecases, business logic)
4. **Implement presentation layer** (BLoC, pages, widgets)
5. **Add tests** for critical business logic
6. **Run code generation** when adding new models/GraphQL queries

### Before Committing

1. Run `flutter analyze` to check code quality
2. Run tests: `flutter test`
3. Format code: `dart format lib/`
4. Update IMPLEMENTATION_STATUS.md if needed
5. Add comments/JSDoc to new public APIs

### Debugging Tips

- Use `context.read<MyBloc>().state` to inspect current state
- Check `debugPrint()` output in console
- Use Firebase Crashlytics for production errors
- Check network requests with Dio logging interceptor

---

## 🔧 Common Commands

```bash
# Install dependencies
flutter pub get

# Run code generation
flutter pub run build_runner build --delete-conflicting-outputs

# Format code
dart format lib/

# Analyze code
flutter analyze

# Run tests
flutter test

# Run app
flutter run

# Build APK (Android)
flutter build apk

# Build IPA (iOS)
flutter build ios
```

---

## 📋 Summary

This Flutter app exemplifies **modern mobile architecture** with:

- ✅ Clean Architecture separation of concerns
- ✅ BLoC pattern for testable, maintainable state management
- ✅ GraphQL for type-safe data fetching
- ✅ Dependency injection for loose coupling
- ✅ Proper error handling and exception management
- ✅ Multi-language support (i18n)
- ✅ Secure authentication with JWT tokens
- ✅ Responsive design across devices
- ✅ Code generation for less boilerplate

**Key Principle**: Each layer has a single responsibility, making the codebase scalable, testable, and maintainable.

---

**Document Version**: 1.0  
**Last Updated**: 2026-04-14  
**Target Audience**: Development Agents, Backend Integrators, Feature Implementers
