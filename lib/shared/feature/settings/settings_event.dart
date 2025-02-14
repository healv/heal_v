part of 'settings_bloc.dart';

sealed class SettingsEvent extends BaseEvent {
  SettingsEvent();

  factory SettingsEvent.initial() => SettingsPageInitial._();

  factory SettingsEvent.updateNotificationStatus({required bool isEnable}) => UpdateNotificationsStatus._(isEnable: isEnable);

  factory SettingsEvent.updateSoundsStatus({required bool isEnable}) => UpdateSoundsStatus._(isEnable: isEnable);

  factory SettingsEvent.updateCurrentLanguage({required LanguageEnum language}) => UpdateCurrentLanguage._(language: language);
}

final class SettingsPageInitial extends SettingsEvent {
  SettingsPageInitial._();
}

final class UpdateNotificationsStatus extends SettingsEvent {
  bool isEnable;

  UpdateNotificationsStatus._({
    required this.isEnable,
  });
}

final class UpdateSoundsStatus extends SettingsEvent {
  bool isEnable;

  UpdateSoundsStatus._({
    required this.isEnable,
  });
}

final class UpdateCurrentLanguage extends SettingsEvent {
  LanguageEnum language;

  UpdateCurrentLanguage._({
    required this.language,
  });
}
