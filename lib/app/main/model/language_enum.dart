import 'package:heal_v/res/images/language_flags.dart';

enum LanguageEnum {
  english(short: 'en', long: 'eng', displayName: 'English', displayNameShort: 'Eng', flag: LanguageFlags.english),
  russian(short: 'ru', long: 'rus', displayName: 'Русский', displayNameShort: 'Рус', flag: LanguageFlags.russian);

  final String short;
  final String long;
  final String displayName;
  final String displayNameShort;
  final LanguageFlags flag;

  const LanguageEnum({
    required this.short,
    required this.long,
    required this.displayName,
    required this.displayNameShort,
    required this.flag,
  });

  static Map<String, LanguageEnum> _map = {for (var item in LanguageEnum.values) item.short: item};

  static LanguageEnum? from(String? key) => _map[key];
}
