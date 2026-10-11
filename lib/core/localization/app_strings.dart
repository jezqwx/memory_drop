class AppStrings {
  static String get(String languageCode, String key) {
    final translations = {
      'ru': {
        'settings': 'Настройки',
        'theme': 'Тема',
        'language': 'Язык',
        'myDrops': 'Мои воспоминания',
        'search': 'Поиск по названию или месту',
      },
      'en': {
        'settings': 'Settings',
        'theme': 'Theme',
        'language': 'Language',
        'myDrops': 'My memories',
        'search': 'Search by title or location',
      },
    };

    return translations[languageCode]?[key] ?? key;
  }
}