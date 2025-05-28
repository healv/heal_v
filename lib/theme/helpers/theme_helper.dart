import 'package:heal_v/common/tools/store.dart';
import 'package:heal_v/common/utils/constants.dart';
import 'package:heal_v/common/utils/store_key.dart';
import 'package:heal_v/theme/enum/theme_enum.dart';

abstract class ThemeHelper {
  static Future<void> init() async {
    _currentTheme = await Store.get<String>(
      key: StoreKey.themeKey,
      defaultValue: ThemeEnum.light.value,
    );
  }

  static String _currentTheme = emptyString;

  static void saveToStore(String theme) {
    Store.set(key: StoreKey.themeKey, value: theme);
    _currentTheme = theme;
  }

  static String getFromStore() {
    return _currentTheme;
  }
}
