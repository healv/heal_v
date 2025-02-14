part of 'settings_page_bloc.dart';

sealed class SettingsPageEvent {
  SettingsPageEvent();

  factory SettingsPageEvent.initial() => SettingsPageInitial._();

  factory SettingsPageEvent.updateNotificationStatus({required bool isEnable}) => UpdateNotificationsStatus._(isEnable: isEnable);

  factory SettingsPageEvent.updateSoundsStatus({required bool isEnable}) => UpdateSoundsStatus._(isEnable: isEnable);
}

final class SettingsPageInitial extends SettingsPageEvent {
  SettingsPageInitial._();
}

final class UpdateNotificationsStatus extends SettingsPageEvent {
  bool isEnable;

  UpdateNotificationsStatus._({
    required this.isEnable,
  });
}

final class UpdateSoundsStatus extends SettingsPageEvent {
  bool isEnable;

  UpdateSoundsStatus._({
    required this.isEnable,
  });
}
