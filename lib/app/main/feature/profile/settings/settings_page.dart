import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/feature/profile/common/setting_description.dart';
import 'package:heal_v/app/main/feature/profile/common/settings_check_line.dart';
import 'package:heal_v/app/main/model/language_enum.dart';
import 'package:heal_v/common/tools/localization_tools.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/shared/feature/settings/settings_bloc.dart';
import 'package:heal_v/theme/ext/extension.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HealVAppBar(title: tr('settings'), isBackEnable: true),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _generalText(context),
          _notificationsRow(context),
          const SizedBox(height: 4.0),
          _divider(),
          _soundRow(context),
          const SizedBox(height: 4.0),
          _divider(),
          _appLanguageRow(context),
        ],
      ),
    );
  }

  Widget _generalText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        tr('general'),
        style: const TextStyle(fontSize: 16, color: Color(0xFF999999), fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _notificationsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tr('notifications'),
            style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
          ),
          BlocSelector<SettingsBloc, SettingsState, bool?>(
            selector: (state) => state.isNotificationsEnable,
            builder: (context, isEnable) {
              return Switch(
                  value: isEnable ?? false,
                  onChanged: (isChecked) {
                    context.read<SettingsBloc>().add(SettingsEvent.updateNotificationStatus(isEnable: isChecked));
                  });
            },
          )
        ],
      ),
    );
  }

  Widget _soundRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tr('sounds'),
            style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
          ),
          BlocSelector<SettingsBloc, SettingsState, bool?>(
            selector: (state) => state.isSoundsEnable,
            builder: (context, isEnable) {
              return Switch(
                  value: isEnable ?? false,
                  onChanged: (isChecked) {
                    context.read<SettingsBloc>().add(SettingsEvent.updateSoundsStatus(isEnable: isChecked));
                  });
            },
          )
        ],
      ),
    );
  }

  Widget _appLanguageRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: InkWell(
        onTap: () => _openLanguageBottomSheet(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('app_language'),
              style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
            ),
            BlocSelector<SettingsBloc, SettingsState, LanguageEnum?>(
              selector: (state) => state.currentLanguage,
              builder: (context, language) => language == null
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(language.displayNameShort),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Divider());
  }

  void _openLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: context.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      useSafeArea: true,
      builder: (BuildContext context) {
        return BlocSelector<SettingsBloc, SettingsState, LanguageEnum>(
          selector: (state) => state.currentLanguage ?? LanguageEnum.english,
          builder: (context, currentLanguage) {
            return ListView(
              children: [
                SettingDescription(
                  text: tr('app_language'),
                ),
                for (final language in LanguageEnum.values)
                  SettingsCheckLine(
                    checkedStatus: currentLanguage == language,
                    title: language.displayName,
                    callback: () {
                      if (currentLanguage == language) {
                        return;
                      }
                      context.setLocale(Locale(language.short));
                      Store.set(key: StoreKey.languageKey, value: language.short);
                      context.read<SettingsBloc>().add(SettingsEvent.updateCurrentLanguage(language: language));
                      context.pop();
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
