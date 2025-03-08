import 'package:flutter/material.dart';
import 'package:heal_v/theme/app_colors_palette.dart';

extension ThemeExt on BuildContext {
  AppColorsPalette get appPalette => Theme.of(this).extension<AppColorsPalette>()!;

  Color get background => appPalette.background;

  Color get onBackground => appPalette.onBackground;

  Color get unselectedItemColor => appPalette.unselectedItemColor;

  Color get primary => appPalette.primary;

  Color get textSecondary => appPalette.textSecondary;

  Color get quizDialogItemColor => appPalette.quizDialogItemColor;

  void unFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
