import 'package:flutter/material.dart';

class AppColorsPalette extends ThemeExtension<AppColorsPalette> {
  const AppColorsPalette({
    required this.background,
    required this.onBackground,
    required this.primary,
    required this.unselectedItemColor,
    required this.textSecondary,
    required this.quizDialogItemColor,
  });

  final Color onBackground;
  final Color background;
  final Color primary;
  final Color unselectedItemColor;
  final Color textSecondary;
  final Color quizDialogItemColor;

  @override
  AppColorsPalette copyWith({
    Color? background,
    Color? onBackground,
    Color? primary,
    Color? unselectedItemColor,
    Color? textSecondary,
    Color? quizDialogItemColor,
  }) {
    return AppColorsPalette(
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      primary: primary ?? this.primary,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
      textSecondary: textSecondary ?? this.textSecondary,
      quizDialogItemColor: quizDialogItemColor ?? this.quizDialogItemColor,
    );
  }

  @override
  AppColorsPalette lerp(AppColorsPalette? other, double t) {
    if (other == null) {
      return this;
    }
    return AppColorsPalette(
      background: Color.lerp(background, other.background, t) ?? background,
      onBackground: Color.lerp(onBackground, other.onBackground, t) ?? onBackground,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      unselectedItemColor: Color.lerp(unselectedItemColor, other.unselectedItemColor, t) ?? unselectedItemColor,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      quizDialogItemColor: Color.lerp(quizDialogItemColor, other.quizDialogItemColor, t) ?? quizDialogItemColor,
    );
  }
}
