import 'package:ferry/ferry.dart' hide ServerException;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/graphql/graphql_request_executor.dart';
import '../../domain/entities/leaderboard_period.dart';
import '../models/leaderboard_entry_model.dart';
import '../models/leaderboard_page_model.dart';
import '../sources/graphql/__generated__/my_leaderboard_rank_all_time.req.gql.dart';
import '../sources/graphql/__generated__/my_leaderboard_rank_last_month.req.gql.dart';
import '../sources/graphql/__generated__/get_leaderboard_all_time.req.gql.dart';
import '../sources/graphql/__generated__/get_leaderboard_all_time.var.gql.dart';
import '../sources/graphql/__generated__/get_leaderboard_last_month.req.gql.dart';
import '../sources/graphql/__generated__/get_leaderboard_last_month.var.gql.dart';

abstract class LeaderboardRemoteDataSource {
  Future<LeaderboardPageModel> getLeaderboard({
    required LeaderboardPeriod period,
    int page = 1,
    int limit = 10,
  });

  Future<LeaderboardEntryModel?> getCurrentUserLeaderboardEntry({
    required LeaderboardPeriod period,
  });
}

@LazySingleton(as: LeaderboardRemoteDataSource)
class LeaderboardRemoteDataSourceImpl implements LeaderboardRemoteDataSource {
  LeaderboardRemoteDataSourceImpl(
    this._ferryClient,
    this._graphqlRequestExecutor,
  );

  final Client _ferryClient;
  final GraphqlRequestExecutor _graphqlRequestExecutor;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: false,
    ),
  );

  @override
  Future<LeaderboardPageModel> getLeaderboard({
    required LeaderboardPeriod period,
    int page = 1,
    int limit = 10,
  }) async {
    _logger.i(
      'getLeaderboard called with period=$period, page=$page, limit=$limit',
    );

    try {
      final requestedLimit = page * limit;
      final allEntries = await _fetchEntries(
        period: period,
        limit: requestedLimit,
      );

      final start = (page - 1) * limit;
      final end = (start + limit) > allEntries.length
          ? allEntries.length
          : (start + limit);

      final pageEntries = start >= allEntries.length
          ? <LeaderboardEntryModel>[]
          : allEntries.sublist(start, end);

      _logger.i(
        'getLeaderboard returned ${allEntries.length} total entries, '
        '${pageEntries.length} entries for page $page',
      );

      return LeaderboardPageModel(
        entries: pageEntries,
        currentUser: null,
        hasNextPage: allEntries.length >= requestedLimit,
        hasPreviousPage: page > 1,
        limit: limit,
        page: page,
        totalCount: allEntries.length,
        period: period,
      );
    } catch (e) {
      _logger.e('getLeaderboard error: $e', error: e);
      throw ServerException('Failed to fetch leaderboard: ${e.toString()}');
    }
  }

  @override
  Future<LeaderboardEntryModel?> getCurrentUserLeaderboardEntry({
    required LeaderboardPeriod period,
  }) async {
    try {
      switch (period) {
        case LeaderboardPeriod.monthly:
          return _fetchLastMonthCurrentUserEntry();
        case LeaderboardPeriod.allTime:
          return _fetchAllTimeCurrentUserEntry();
      }
    } catch (e) {
      _logger.e('getCurrentUserLeaderboardEntry error: $e', error: e);
      return null;
    }
  }

  Future<List<LeaderboardEntryModel>> _fetchEntries({
    required LeaderboardPeriod period,
    required int limit,
  }) async {
    switch (period) {
      case LeaderboardPeriod.monthly:
        return _fetchLastMonthEntries(limit: limit);
      case LeaderboardPeriod.allTime:
        return _fetchAllTimeEntries(limit: limit);
    }
  }

  Future<List<LeaderboardEntryModel>> _fetchAllTimeEntries({
    required int limit,
  }) async {
    final vars = GGetLeaderboardAllTimeVars.fromJson({'limit': limit});
    if (vars == null) {
      throw ServerException('Failed to build getLeaderboardAllTime request');
    }

    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GGetLeaderboardAllTimeReq(
        (b) => b
          ..vars = vars.toBuilder()
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..requestId =
              'getLeaderboardAllTime-${DateTime.now().microsecondsSinceEpoch}',
      ),
      operationName: 'getLeaderboardAllTime',
    );

    final items = data.leaderboardAllTime;
    if (items.isEmpty) {
      return const [];
    }

    return items
        .map(
          (item) => LeaderboardEntryModel.fromJson(
            Map<String, dynamic>.from(item.toJson()),
          ),
        )
        .toList();
  }

  Future<List<LeaderboardEntryModel>> _fetchLastMonthEntries({
    required int limit,
  }) async {
    final vars = GGetLeaderboardLastMonthVars.fromJson({'limit': limit});
    if (vars == null) {
      throw ServerException('Failed to build getLeaderboardLastMonth request');
    }

    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GGetLeaderboardLastMonthReq(
        (b) => b
          ..vars = vars.toBuilder()
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..requestId =
              'getLeaderboardLastMonth-${DateTime.now().microsecondsSinceEpoch}',
      ),
      operationName: 'getLeaderboardLastMonth',
    );

    final items = data.leaderboardLastMonth;
    if (items.isEmpty) {
      return const [];
    }

    return items
        .map(
          (item) => LeaderboardEntryModel.fromJson(
            Map<String, dynamic>.from(item.toJson()),
          ),
        )
        .toList();
  }

  Future<LeaderboardEntryModel?> _fetchAllTimeCurrentUserEntry() async {
    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GGetMyLeaderboardRankAllTimeReq(
        (b) => b
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..requestId =
              'getMyLeaderboardRankAllTime-${DateTime.now().microsecondsSinceEpoch}',
      ),
      operationName: 'getMyLeaderboardRankAllTime',
    );

    final item = data.myLeaderboardRankAllTime;
    if (item == null) {
      return null;
    }

    return LeaderboardEntryModel.fromJson(
      Map<String, dynamic>.from(item.toJson()),
    );
  }

  Future<LeaderboardEntryModel?> _fetchLastMonthCurrentUserEntry() async {
    final data = await _graphqlRequestExecutor.execute(
      client: _ferryClient,
      request: GGetMyLeaderboardRankLastMonthReq(
        (b) => b
          ..fetchPolicy = FetchPolicy.NetworkOnly
          ..requestId =
              'getMyLeaderboardRankLastMonth-${DateTime.now().microsecondsSinceEpoch}',
      ),
      operationName: 'getMyLeaderboardRankLastMonth',
    );

    final item = data.myLeaderboardRankLastMonth;
    if (item == null) {
      return null;
    }

    return LeaderboardEntryModel.fromJson(
      Map<String, dynamic>.from(item.toJson()),
    );
  }
}
