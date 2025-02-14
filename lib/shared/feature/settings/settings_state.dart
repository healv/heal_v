part of 'settings_bloc.dart';

@immutable
final class SettingsState extends BaseState {
  final LanguageEnum? currentLanguage;
  final bool? isNotificationsEnable;
  final bool? isSoundsEnable;

  const SettingsState._({
    this.currentLanguage,
    this.isNotificationsEnable,
    this.isSoundsEnable,
  });

  factory SettingsState.initial() => const SettingsState._();

  @override
  List<Object?> get props => [currentLanguage, isNotificationsEnable, isSoundsEnable];

  SettingsState copyWith({
    Optional<LanguageEnum?>? currentLanguage,
    Optional<bool?>? isNotificationsEnable,
    Optional<bool?>? isSoundsEnable,
  }) {
    return SettingsState._(
      currentLanguage: currentLanguage?.isValid == true ? currentLanguage?.value : this.currentLanguage,
      isNotificationsEnable: isNotificationsEnable?.isValid == true ? isNotificationsEnable?.value : this.isNotificationsEnable,
      isSoundsEnable: isSoundsEnable?.isValid == true ? isSoundsEnable?.value : this.isSoundsEnable,
    );
  }
}
