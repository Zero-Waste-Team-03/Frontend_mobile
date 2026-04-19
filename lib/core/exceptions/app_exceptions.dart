/// Base exception class for all app exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException(this.message, {this.code, this.originalError});

  @override
  String toString() => message;
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException(String message, {String? code, dynamic originalError})
    : super(message, code: code, originalError: originalError);

  factory NetworkException.noInternet() =>
      const NetworkException('No internet connection');

  factory NetworkException.timeout() =>
      const NetworkException('Connection timeout');

  factory NetworkException.serverError() =>
      const NetworkException('Server error occurred');
}

/// Authentication-related exceptions
class AuthenticationException extends AppException {
  const AuthenticationException(
    String message, {
    String? code,
    dynamic originalError,
  }) : super(message, code: code, originalError: originalError);

  factory AuthenticationException.invalidCredentials() =>
      const AuthenticationException('Invalid username or password');

  factory AuthenticationException.tokenExpired() =>
      const AuthenticationException('Your session has expired');

  factory AuthenticationException.unauthorized() =>
      const AuthenticationException('Unauthorized access');

  factory AuthenticationException.accountDisabled() =>
      const AuthenticationException('Your account has been disabled');
}

/// Validation-related exceptions
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException(
    String message, {
    String? code,
    this.fieldErrors,
    dynamic originalError,
  }) : super(message, code: code, originalError: originalError);

  factory ValidationException.invalidEmail() =>
      const ValidationException('Invalid email address');

  factory ValidationException.weakPassword() =>
      const ValidationException('Password is too weak');

  factory ValidationException.requiredField(String field) =>
      ValidationException('$field is required');
}

/// Server-related exceptions
class ServerException extends AppException {
  final int? statusCode;

  const ServerException(
    String message, {
    String? code,
    this.statusCode,
    dynamic originalError,
  }) : super(message, code: code, originalError: originalError);

  factory ServerException.internalError() =>
      const ServerException('Internal server error', statusCode: 500);

  factory ServerException.notFound() =>
      const ServerException('Resource not found', statusCode: 404);

  factory ServerException.badRequest() =>
      const ServerException('Bad request', statusCode: 400);
}

/// GraphQL-specific exceptions
class GraphQLException extends AppException {
  final List<dynamic>? graphqlErrors;

  const GraphQLException(
    String message, {
    String? code,
    this.graphqlErrors,
    dynamic originalError,
  }) : super(message, code: code, originalError: originalError);

  factory GraphQLException.fromGraphQLErrors(List<dynamic> errors) {
    final messages = errors
        .map((e) => e['message'] ?? 'Unknown error')
        .join(', ');
    return GraphQLException(messages, graphqlErrors: errors);
  }
}

/// Cache-related exceptions
class CacheException extends AppException {
  const CacheException(String message, {String? code, dynamic originalError})
    : super(message, code: code, originalError: originalError);

  factory CacheException.notFound() =>
      const CacheException('Data not found in cache');

  factory CacheException.readError() =>
      const CacheException('Failed to read from cache');

  factory CacheException.writeError() =>
      const CacheException('Failed to write to cache');
}

/// Parse exceptions to user-friendly messages
class ExceptionHandler {
  static String getErrorMessage(dynamic error) {
    if (error is AppException) {
      return error.message;
    }

    if (error is Exception) {
      return error.toString().replaceFirst('Exception: ', '');
    }

    return 'An unexpected error occurred';
  }

  static AppException parseException(dynamic error) {
    if (error is AppException) {
      return error;
    }

    // Parse network errors
    if (error.toString().contains('SocketException') ||
        error.toString().contains('Failed host lookup')) {
      return NetworkException.noInternet();
    }

    if (error.toString().contains('TimeoutException')) {
      return NetworkException.timeout();
    }

    // Default to generic exception
    return ServerException(
      'An error occurred: ${error.toString()}',
      originalError: error,
    );
  }
}
