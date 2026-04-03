class AppConstants {
  static const String appName =
      String.fromEnvironment('APP_NAME', defaultValue: 'ZeroWaste');
  static const String graphqlEndpoint = String.fromEnvironment(
      'GRAPHQL_ENDPOINT',
      defaultValue: 'https://api.example.com/graphql');
}
