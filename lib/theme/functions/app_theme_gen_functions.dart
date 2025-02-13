import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heal_v/theme/app_colors_palette.dart';

abstract class AppThemeGenFunctions {
  static ThemeData themeGen(AppColorsPalette palette) {
    return ThemeData(
      textTheme: TextTheme(
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
      ),
      dividerTheme: DividerThemeData(color: palette.onBackground.withOpacity(0.1)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: palette.primary,
        unselectedItemColor: palette.onBackground.withOpacity(0.5),
        backgroundColor: palette.onBackground.withOpacity(0.1),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedIconTheme: const IconThemeData(size: 40),
        unselectedIconTheme: const IconThemeData(size: 26),
        selectedLabelStyle: TextStyle(fontSize: 14, color: palette.primary),
        unselectedLabelStyle: const TextStyle(fontSize: 12, color: Color(0xFF666666)),
      ),
      dialogTheme: DialogTheme(
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
      ),
      scaffoldBackgroundColor: palette.background,
      brightness: Brightness.dark,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      appBarTheme: AppBarTheme(
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
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        surface: palette.onBackground.withOpacity(0.8),
        onSurface: palette.onBackground,
        brightness: Brightness.dark,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      extensions: <ThemeExtension>[
        palette,
      ],
    );
  }
}
