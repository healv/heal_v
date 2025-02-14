import 'package:flutter/material.dart';
import 'package:heal_v/app/main/model/language_enum.dart';

class EasyLocalizationConfig {
  static const path = 'assets/translations';

  static List<Locale> supportedLocale = LanguageEnum.values.map((e) => Locale(e.short)).toList();
}
