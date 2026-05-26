import 'verification_request.dart';

class VerificationRequestsPage {
  final List<VerificationRequest> requests;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int limit;
  final int page;
  final int totalCount;

  const VerificationRequestsPage({
    required this.requests,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.limit,
    required this.page,
    required this.totalCount,
  });
}
