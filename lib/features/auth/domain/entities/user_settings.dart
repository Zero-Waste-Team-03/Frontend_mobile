import 'package:equatable/equatable.dart';

class UserSettings extends Equatable {
  final String id;
  final String userId;
  final String appearance;
  final bool isNewDonationsAlertsEnabled;
  final bool isSystemReports;
  final bool isUrgentAlertsEnabled;
  final bool isPushNotificationsEnabled;

  const UserSettings({
    required this.id,
    required this.userId,
    this.appearance = 'SYSTEM',
    this.isNewDonationsAlertsEnabled = true,
    this.isSystemReports = true,
    this.isUrgentAlertsEnabled = true,
    this.isPushNotificationsEnabled = true,
  });

  UserSettings copyWith({
    String? id,
    String? userId,
    String? appearance,
    bool? isNewDonationsAlertsEnabled,
    bool? isSystemReports,
    bool? isUrgentAlertsEnabled,
    bool? isPushNotificationsEnabled,
  }) {
    return UserSettings(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      appearance: appearance ?? this.appearance,
      isNewDonationsAlertsEnabled:
          isNewDonationsAlertsEnabled ?? this.isNewDonationsAlertsEnabled,
      isSystemReports: isSystemReports ?? this.isSystemReports,
      isUrgentAlertsEnabled:
          isUrgentAlertsEnabled ?? this.isUrgentAlertsEnabled,
      isPushNotificationsEnabled:
          isPushNotificationsEnabled ?? this.isPushNotificationsEnabled,
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
