import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/local/settings_local_data_source.dart';

final settingsLocalDataSourceProvider =
    Provider<SettingsLocalDataSource>((ref) {
  return SettingsLocalDataSource();
});

class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  SettingsLocalDataSource get _localDataSource {
    return ref.read(settingsLocalDataSourceProvider);
  }

  @override
  Future<ThemeMode> build() async {
    return _localDataSource.getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
  state = AsyncData(mode);

  await _localDataSource.saveThemeMode(mode);
}
}

final themeProvider =
    AsyncNotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

class LanguageNotifier extends AsyncNotifier<String> {
  SettingsLocalDataSource get _localDataSource {
    return ref.read(settingsLocalDataSourceProvider);
  }

  @override
  Future<String> build() async {
    return _localDataSource.getLanguageCode();
  }

  Future<void> setLanguage(String code) async {
    state = AsyncData(code);

    await _localDataSource.saveLanguageCode(code);
  }
}

final languageProvider =
    AsyncNotifierProvider<LanguageNotifier, String>(
  LanguageNotifier.new,
);