import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_v/common/bloc/base_state.dart';
import 'package:heal_v/common/dart/optional.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/store_key.dart';

part 'settings_page_event.dart';

part 'settings_page_state.dart';

class SettingsPageBloc extends Bloc<SettingsPageEvent, SettingsPageState> {
  SettingsPageBloc() : super(SettingsPageState.initial()) {
    on<SettingsPageInitial>(_handleInitialEvent);
    on<UpdateNotificationsStatus>(_handleUpdateNotificationsStatusEvent);
    on<UpdateSoundsStatus>(_handleUpdateSoundsStatusEvent);
  }

  Future<void> _handleInitialEvent(SettingsPageInitial event, Emitter<SettingsPageState> emitter) async {
    final currentLanguageCode = await Store.get(key: StoreKey.languageKey, defaultValue: 'en');
    emitter(state.copyWith(currentLanguage: Optional.value(currentLanguageCode)));
  }

  Future<void> _handleUpdateNotificationsStatusEvent(UpdateNotificationsStatus event, Emitter<SettingsPageState> emitter) async {
    emitter(state.copyWith(isNotificationsEnable: Optional.value(event.isEnable)));
  }

  Future<void> _handleUpdateSoundsStatusEvent(UpdateSoundsStatus event, Emitter<SettingsPageState> emitter) async {
    emitter(state.copyWith(isSoundsEnable: Optional.value(event.isEnable)));
  }
}
