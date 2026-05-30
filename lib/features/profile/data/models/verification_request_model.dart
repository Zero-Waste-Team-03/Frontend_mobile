import '../../../auth/data/models/user_model.dart';
import '../../domain/entities/verification_request.dart';

class VerificationRequestModel extends VerificationRequest {
  const VerificationRequestModel({
    required super.id,
    required super.requesterId,
    super.requester,
    required super.targetFoodSaverId,
    super.targetFoodSaver,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory VerificationRequestModel.fromJson(Map<String, dynamic> json) {
    return VerificationRequestModel(
      id: (json['id'] ?? '').toString(),
      requesterId: (json['requesterId'] ?? '').toString(),
      requester: json['requester'] != null
          ? UserModel.fromJson(json['requester'] as Map<String, dynamic>).toEntity()
          : null,
      targetFoodSaverId: (json['targetFoodSaverId'] ?? '').toString(),
      targetFoodSaver: json['targetFoodSaver'] != null
          ? UserModel.fromJson(json['targetFoodSaver'] as Map<String, dynamic>).toEntity()
          : null,
      status: _mapStatus((json['status'] ?? 'PENDING').toString()),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'].toString())
          : DateTime.now(),
    );
  }

  static VerificationRequestStatus _mapStatus(String status) {
    switch (status.toUpperCase()) {
      case 'APPROVED':
        return VerificationRequestStatus.approved;
      case 'REJECTED':
        return VerificationRequestStatus.rejected;
      case 'PENDING':
      default:
        return VerificationRequestStatus.pending;
    }
  }
}
