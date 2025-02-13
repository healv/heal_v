import 'package:flutter/material.dart';
import 'package:heal_v/theme/app_colors_palette.dart';

extension ThemeExt on BuildContext {
  AppColorsPalette get appPalette => Theme.of(this).extension<AppColorsPalette>()!;

  Color get background => appPalette.background;

  Color get onBackground => appPalette.onBackground;

  Color get primary => appPalette.primary;
}
