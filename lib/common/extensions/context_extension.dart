import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/model/language_enum.dart';

import '../../shared/feature/auth/auth_bloc.dart';
import '../../shared/feature/settings/settings_bloc.dart';
import '../tools/store.dart';
import '../utils/store_key.dart';

extension ContextExtension on BuildContext {
  Future<void> updateCurrentLanguage(LanguageEnum language) async {
    await setLocale(Locale(language.short));
    await Store.set(key: StoreKey.languageKey, value: language.short);
    read<SettingsBloc>().add(SettingsEvent.updateCurrentLanguage(language: language));
  }

  void setupLanguageAfterLogin() {
    final language = read<AuthBloc>().state.user?.settings?.language;
    if (language != null && LanguageEnum.from(language) != null) {
      updateCurrentLanguage(LanguageEnum.from(language)!);
    }
  }
}
