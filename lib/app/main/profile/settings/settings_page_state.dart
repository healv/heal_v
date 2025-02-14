part of 'settings_page_bloc.dart';

@immutable
final class SettingsPageState extends BaseState {
  final String? currentLanguage;
  final bool? isNotificationsEnable;
  final bool? isSoundsEnable;

  const SettingsPageState._({
    this.currentLanguage,
    this.isNotificationsEnable,
    this.isSoundsEnable,
  });

  factory SettingsPageState.initial() => const SettingsPageState._();

  @override
  List<Object?> get props => [currentLanguage, isNotificationsEnable, isSoundsEnable];

  SettingsPageState copyWith({
    Optional<String?>? currentLanguage,
    Optional<bool?>? isNotificationsEnable,
    Optional<bool?>? isSoundsEnable,
  }) {
    return SettingsPageState._(
      currentLanguage: currentLanguage?.isValid == true ? currentLanguage?.value : this.currentLanguage,
      isNotificationsEnable: isNotificationsEnable?.isValid == true ? isNotificationsEnable?.value : this.isNotificationsEnable,
      isSoundsEnable: isSoundsEnable?.isValid == true ? isSoundsEnable?.value : this.isSoundsEnable,
    );
  }
}
