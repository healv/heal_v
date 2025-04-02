import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/app/main/model/language_enum.dart';
import 'package:heal_v/common/bloc/base_bloc.dart';
import 'package:heal_v/common/bloc/base_event.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/store_key.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends BaseBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState.initial()) {
    on<SettingsPageInitial>(_handleInitialEvent);
    on<UpdateNotificationsStatus>(_handleUpdateNotificationsStatusEvent);
    on<UpdateSoundsStatus>(_handleUpdateSoundsStatusEvent);
    on<UpdateCurrentLanguage>(_handleUpdateCurrentLanguageEvent);
  }

  Future<void> _handleInitialEvent(SettingsPageInitial event, Emitter<SettingsState> emitter) async {
    final currentLanguageCode = await Store.get(key: StoreKey.languageKey, defaultValue: 'en');
    final isSoundEnable = await Store.get(key: StoreKey.soundsEnable, defaultValue: false);
    emitter(state.copyWith(
      currentLanguage: Optional.value(LanguageEnum.from(currentLanguageCode)),
      isSoundsEnable: Optional.value(isSoundEnable),
    ));
  }

  Future<void> _handleUpdateNotificationsStatusEvent(UpdateNotificationsStatus event, Emitter<SettingsState> emitter) async {
    emitter(state.copyWith(isNotificationsEnable: Optional.value(event.isEnable)));
  }

  Future<void> _handleUpdateSoundsStatusEvent(UpdateSoundsStatus event, Emitter<SettingsState> emitter) async {
    await Store.set(key: StoreKey.soundsEnable, value: event.isEnable);
    emitter(state.copyWith(isSoundsEnable: Optional.value(await Store.get(key: StoreKey.soundsEnable, defaultValue: event.isEnable))));
  }

  Future<void> _handleUpdateCurrentLanguageEvent(UpdateCurrentLanguage event, Emitter<SettingsState> emitter) async {
    emitter(state.copyWith(currentLanguage: Optional.value(event.language)));
  }
}
