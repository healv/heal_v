import 'package:heal_v/theme/app_colors_palette.dart';
import 'package:heal_v/theme/palette/dark_palette.dart';
import 'package:heal_v/theme/palette/light_palette.dart';

enum ThemeEnum {
  light(
    value: 'light',
    palette: lightPalette,
  ),
  dark(
    value: 'dark',
    palette: darkPalette,
  );

  const ThemeEnum({
    required this.value,
    required this.palette,
  });

  static ThemeEnum? parseInstance(String? value) {
    for (final type in ThemeEnum.values) {
      if (type.value == value) {
        return type;
      }
    }
    return null;
  }

  final String value;
  final AppColorsPalette palette;
}
