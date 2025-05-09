import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:heal_v/res/images/app_icons.dart';
import 'package:heal_v/res/images/language_flags.dart';
import 'package:heal_v/theme/ext/extension.dart';

import '../../../../../common/tools/store.dart';
import '../../../../../common/utils/store_key.dart';
import '../../../../../shared/feature/settings/settings_bloc.dart';
import '../../../model/language_enum.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<StatefulWidget> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('language'),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            letterSpacing: 0.2,
            color: context.onBackground,
          ),
        ),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocSelector<SettingsBloc, SettingsState, LanguageEnum>(
      selector: (state) => state.currentLanguage ?? LanguageEnum.english,
      builder: (context, currentLanguage) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0),
          child: ListView(
            children: LanguageEnum.values.map((language) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _languageItem(language, currentLanguage),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _languageItem(LanguageEnum language, LanguageEnum currentLanguage) {
    final isSelected = language == currentLanguage;
    return InkWell(
      onTap: () {
        if (currentLanguage == language) {
          return;
        }
        context.setLocale(Locale(language.short));
        Store.set(key: StoreKey.languageKey, value: language.short);
        context.read<SettingsBloc>().add(SettingsEvent.updateCurrentLanguage(language: language));
        context.pop();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? context.primary.withValues(alpha: 0.3) : context.background,
          border: Border.all(
            color: isSelected ? context.primary.withValues(alpha: 0.3) : context.onBackground.withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  language.flag.svgAsset(),
                  const SizedBox(width: 21),
                  Text(
                    language.displayName,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                      color: context.onBackground,
                    ),
                  )
                ],
              ),
              if (isSelected) AppIcons.checked.svgAsset(),
            ],
          ),
        ),
      ),
    );
  }
}
