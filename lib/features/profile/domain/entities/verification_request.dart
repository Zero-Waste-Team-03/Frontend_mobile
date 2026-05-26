import 'package:equatable/equatable.dart';
import '../../../auth/domain/entities/user.dart';

enum VerificationRequestStatus {
  approved,
  pending,
  rejected,
}

class VerificationRequest extends Equatable {
  final String id;
  final String requesterId;
  final User? requester;
  final String targetFoodSaverId;
  final User? targetFoodSaver;
  final VerificationRequestStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const VerificationRequest({
    required this.id,
    required this.requesterId,
    this.requester,
    required this.targetFoodSaverId,
    this.targetFoodSaver,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        requesterId,
        requester,
        targetFoodSaverId,
        targetFoodSaver,
        status,
        createdAt,
        updatedAt,
      ];
}
