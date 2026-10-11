import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'presentation/providers/settings_providers.dart';
import 'presentation/screens/home_screen.dart';

class MemoryDropApp extends ConsumerWidget {
  const MemoryDropApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeProvider);
    final languageAsync = ref.watch(languageProvider);

    final themeMode =
        themeAsync.value ?? ThemeMode.system;

    final languageCode =
        languageAsync.value ?? 'ru';

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: Locale(languageCode),

      localizationsDelegates:
          AppLocalizations.localizationsDelegates,

      supportedLocales:
          AppLocalizations.supportedLocales,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      home: const HomeScreen(),
    );
  }
}