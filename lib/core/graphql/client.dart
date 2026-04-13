import 'dart:async';

import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

import '../../features/auth/data/sources/auth_local_data_source.dart';
import '../env.dart';

class GraphQLClientFactory {
  GraphQLClientFactory(this._authLocalDataSource);

  final AuthLocalDataSource _authLocalDataSource;

  Client create() {
    final endpoint = Env.get('GRAPHQL_ENDPOINT');
    if (endpoint == null || endpoint.isEmpty) {
      throw StateError('GRAPHQL_ENDPOINT is missing in environment');
    }

    final httpLink = HttpLink(endpoint);

    final authLink = Link.function((request, [forward]) async* {
      final token = await _authLocalDataSource.getAccessToken();
      final headers = <String, String>{};
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
      final next = request.updateContextEntry<HttpLinkHeaders>(
        (existing) =>
            HttpLinkHeaders(headers: {...?existing?.headers, ...headers}),
      );
      if (forward != null) {
        yield* forward(next);
      }
    });

    final errorLink = Link.function((request, [forward]) async* {
      try {
        if (forward != null) {
          yield* forward(request);
        }
      } catch (_) {
        rethrow;
      }
    });

    final link = Link.from([authLink, errorLink, httpLink]);

    return Client(
      link: link,
      cache: Cache(),
      requestController: StreamController<OperationRequest>.broadcast(),
    );
  }
}
