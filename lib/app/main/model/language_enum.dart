enum LanguageEnum {
  english(short: 'en', long: 'eng', displayName: 'English', displayNameShort: 'Eng'),
  russian(short: 'ru', long: 'rus', displayName: 'Русский', displayNameShort: 'Рус');

  final String short;
  final String long;
  final String displayName;
  final String displayNameShort;

  const LanguageEnum({
    required this.short,
    required this.long,
    required this.displayName,
    required this.displayNameShort,
  });

  static Map<String, LanguageEnum> _map = {for (var item in LanguageEnum.values) item.short: item};

  static LanguageEnum? from(String? key) => _map[key];
}
