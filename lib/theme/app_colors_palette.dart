import 'package:flutter/material.dart';

class AppColorsPalette extends ThemeExtension<AppColorsPalette> {
  const AppColorsPalette({
    required this.background,
    required this.onBackground,
    required this.primary,
    required this.unselectedItemColor,
    required this.secondary,
  });

  final Color onBackground;
  final Color background;
  final Color primary;
  final Color unselectedItemColor;
  final Color secondary;

  @override
  AppColorsPalette copyWith({
    Color? background,
    Color? onBackground,
    Color? primary,
    Color? unselectedItemColor,
    Color? secondary,
  }) {
    return AppColorsPalette(
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      primary: primary ?? this.primary,
      unselectedItemColor: unselectedItemColor ?? this.unselectedItemColor,
      secondary: secondary ?? this.secondary,
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
      secondary: Color.lerp(unselectedItemColor, other.unselectedItemColor, t) ?? secondary,
    );
  }
}
