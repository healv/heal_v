import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/app/main/profile/common/setting_description.dart';
import 'package:heal_v/app/main/profile/common/settings_check_line.dart';
import 'package:heal_v/app/main/profile/settings/settings_page_bloc.dart';
import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:heal_v/common/widgets/app_bar/heal_v_app_bar.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../common/tools/localization_tools.dart';

const Map<String, String> availableLanguages = {'en': 'English', 'ru': 'Russian'};

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
          BlocSelector<SettingsPageBloc, SettingsPageState, bool?>(
            selector: (state) => state.isNotificationsEnable,
            builder: (context, isEnable) {
              return Switch(
                  value: isEnable ?? false,
                  onChanged: (isChecked) {
                    context.read<SettingsPageBloc>().add(SettingsPageEvent.updateNotificationStatus(isEnable: isChecked));
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
          BlocSelector<SettingsPageBloc, SettingsPageState, bool?>(
            selector: (state) => state.isSoundsEnable,
            builder: (context, isEnable) {
              return Switch(
                  value: isEnable ?? false,
                  onChanged: (isChecked) {
                    context.read<SettingsPageBloc>().add(SettingsPageEvent.updateSoundsStatus(isEnable: isChecked));
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
        onTap: () => openLanguageBottomSheet(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tr('app_language'),
              style: TextStyle(fontSize: 16, color: context.onBackground, fontWeight: FontWeight.w500),
            ),
            const Text('en'),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return const Padding(padding: EdgeInsets.symmetric(horizontal: 16.0), child: Divider());
  }

  void openLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: context.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      useSafeArea: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (_) => SettingsPageBloc()..add(SettingsPageEvent.initial()),
          child: BlocSelector<SettingsPageBloc, SettingsPageState, String>(
            selector: (state) => state.currentLanguage ?? 'en',
            builder: (context, language) {
              return ListView(
                children: [
                  SettingDescription(
                    text: tr('app_language'),
                  ),
                  for (final langEntry in availableLanguages.entries)
                    SettingsCheckLine(
                      checkedStatus: language == langEntry.key,
                      title: langEntry.value,
                      callback: () {
                        if (language == langEntry.key) {
                          return;
                        }
                        context.setLocale(Locale(langEntry.key));
                        Store.set(key: StoreKey.languageKey, value: langEntry.key);
                        context.pop();
                      },
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
