import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsLocalDataSource {
  static const _themeKey = 'theme_mode';
  static const _languageKey = 'language_code';

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();

    final value = prefs.getString(_themeKey);

    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _themeKey,
      mode.name,
    );
  }

  Future<String> getLanguageCode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_languageKey) ?? 'ru';
  }

  Future<void> saveLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _languageKey,
      code,
    );
  }
}