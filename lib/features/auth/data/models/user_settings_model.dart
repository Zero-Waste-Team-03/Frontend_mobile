import 'package:equatable/equatable.dart';
import '../../domain/entities/user_settings.dart';

class UserSettingsModel extends Equatable {
  final String id;
  final String userId;
  final String appearance;
  final bool isNewDonationsAlertsEnabled;
  final bool isSystemReports;
  final bool isUrgentAlertsEnabled;
  final bool isPushNotificationsEnabled;

  const UserSettingsModel({
    required this.id,
    required this.userId,
    this.appearance = 'SYSTEM',
    this.isNewDonationsAlertsEnabled = true,
    this.isSystemReports = true,
    this.isUrgentAlertsEnabled = true,
    this.isPushNotificationsEnabled = true,
  });

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      appearance: json['appearance'] as String? ?? 'SYSTEM',
      isNewDonationsAlertsEnabled:
          (json['isNewDonationsAlertsEnabled'] as bool?) ?? true,
      isSystemReports: (json['isSystemReports'] as bool?) ?? true,
      isUrgentAlertsEnabled: (json['isUrgentAlertsEnabled'] as bool?) ?? true,
      isPushNotificationsEnabled:
          (json['isPushNotificationsEnabled'] as bool?) ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'appearance': appearance,
      'isNewDonationsAlertsEnabled': isNewDonationsAlertsEnabled,
      'isSystemReports': isSystemReports,
      'isUrgentAlertsEnabled': isUrgentAlertsEnabled,
      'isPushNotificationsEnabled': isPushNotificationsEnabled,
    };
  }

  UserSettings toEntity() {
    return UserSettings(
      id: id,
      userId: userId,
      appearance: appearance,
      isNewDonationsAlertsEnabled: isNewDonationsAlertsEnabled,
      isSystemReports: isSystemReports,
      isUrgentAlertsEnabled: isUrgentAlertsEnabled,
      isPushNotificationsEnabled: isPushNotificationsEnabled,
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    appearance,
    isNewDonationsAlertsEnabled,
    isSystemReports,
    isUrgentAlertsEnabled,
    isPushNotificationsEnabled,
  ];
}
