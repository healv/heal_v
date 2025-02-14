import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heal_v/theme/app_colors_palette.dart';

abstract class AppThemeGenFunctions {
  static ThemeData themeGen(AppColorsPalette palette) {
    return ThemeData(
      textTheme: _textThemeData(palette),
      dividerTheme: _dividerThemeData(palette),
      bottomNavigationBarTheme: _bottomNavigationBarThemeData(palette),
      dialogTheme: _dialogTheme(palette),
      scaffoldBackgroundColor: palette.background,
      brightness: Brightness.dark,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: _appBarTheme(palette),
      colorScheme: _colorScheme(palette),
      switchTheme: _switchThemeData(palette),
      extensions: <ThemeExtension>[
        palette,
      ],
    );
  }

  static TextTheme _textThemeData(AppColorsPalette palette) {
    return TextTheme(
      displayLarge: TextStyle(color: palette.onBackground),
      displayMedium: TextStyle(color: palette.onBackground),
      displaySmall: TextStyle(color: palette.onBackground),
      headlineLarge: TextStyle(color: palette.onBackground),
      headlineMedium: TextStyle(color: palette.onBackground),
      headlineSmall: TextStyle(color: palette.onBackground),
      titleLarge: TextStyle(color: palette.onBackground),
      titleMedium: TextStyle(color: palette.onBackground),
      titleSmall: TextStyle(color: palette.onBackground),
      bodyLarge: TextStyle(color: palette.onBackground),
      bodyMedium: TextStyle(color: palette.onBackground),
      bodySmall: TextStyle(color: palette.onBackground),
      labelLarge: TextStyle(color: palette.onBackground),
      labelMedium: TextStyle(color: palette.onBackground),
      labelSmall: TextStyle(color: palette.onBackground),
    );
  }

  static _dividerThemeData(AppColorsPalette palette) {
    return DividerThemeData(color: palette.onBackground.withOpacity(0.1));
  }

  static BottomNavigationBarThemeData _bottomNavigationBarThemeData(AppColorsPalette palette) {
    return BottomNavigationBarThemeData(
      selectedItemColor: palette.primary,
      unselectedItemColor: const Color(0xFF666666),
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedIconTheme: const IconThemeData(size: 40),
      unselectedIconTheme: const IconThemeData(size: 26),
      selectedLabelStyle: TextStyle(fontSize: 14, color: palette.primary),
      unselectedLabelStyle: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
    );
  }

  static DialogTheme _dialogTheme(AppColorsPalette palette) {
    return DialogTheme(
      backgroundColor: palette.background,
      surfaceTintColor: palette.onBackground.withOpacity(0.1),
      shadowColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: palette.onBackground,
      ),
      contentTextStyle: TextStyle(
        fontSize: 13,
        color: palette.onBackground.withOpacity(0.6),
      ),
    );
  }

  static AppBarTheme _appBarTheme(AppColorsPalette palette) {
    return AppBarTheme(
      iconTheme: IconThemeData(
        color: palette.onBackground,
      ),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
        color: palette.onBackground,
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: false,
      titleSpacing: 0.0,
      scrolledUnderElevation: 0,
    );
  }

  static ColorScheme _colorScheme(AppColorsPalette palette) {
    return ColorScheme.fromSwatch().copyWith(
      surface: palette.onBackground.withOpacity(0.8),
      onSurface: palette.onBackground,
      brightness: Brightness.dark,
    );
  }

  static SwitchThemeData _switchThemeData(AppColorsPalette palette) {
    return SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          return Colors.white;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return palette.primary;
          } else {
            return const Color(0xFFCCCCCC);
          }
        },
      ),
    );
  }
}
