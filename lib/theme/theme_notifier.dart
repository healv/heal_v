import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heal_v/theme/enum/theme_enum.dart';
import 'package:heal_v/theme/functions/app_theme_gen_functions.dart';
import 'package:heal_v/theme/helpers/theme_helper.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier() {
    _updateStatusBarColor();
  }

  ThemeData selectedTheme = AppThemeGenFunctions.themeGen(ThemeEnum.light.palette);

  String selectedThemeKey = ThemeEnum.light.value;

  void changeTheme(ThemeEnum themeKey) {
    _updateThemeData(themeKey.value);
  }

  void _updateStatusBarColor() {
    final lightTheme = (ThemeEnum.parseInstance(selectedThemeKey) ?? ThemeEnum.light).palette.background.computeLuminance() > 0.5;
    if (lightTheme) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      );
    }
  }

  void _updateThemeData(String key) {
    final theme = ThemeEnum.parseInstance(key);
    if (theme != null) {
      selectedThemeKey = theme.value;
      selectedTheme = AppThemeGenFunctions.themeGen(theme.palette);
      _updateStatusBarColor();
      ThemeHelper.saveToStore(selectedThemeKey);
      notifyListeners();
    }
  }
}
