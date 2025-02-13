import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

class LocalizationProvider extends ChangeNotifier {
  static bool _isLocalizationEnabled = true;

  bool get isLocalizationEnabled => _isLocalizationEnabled;
  static bool get isLocalizationEnabledStatic => _isLocalizationEnabled;

  void toggleLocalization() {
    _isLocalizationEnabled = !_isLocalizationEnabled;
    notifyListeners();
  }
}

String tr(
    String key, {
      BuildContext? context,
      List<String>? args,
      Map<String, String>? namedArgs,
      String? gender,
    }) {
  if (!LocalizationProvider.isLocalizationEnabledStatic) {
    return key;
  }

  return easy.tr(
    key,
    context: context,
    args: args,
    namedArgs: namedArgs,
  );
}