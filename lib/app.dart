import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'presentation/providers/settings_providers.dart';

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

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      locale: Locale(languageCode),

      localizationsDelegates:
          AppLocalizations.localizationsDelegates,

      supportedLocales:
          AppLocalizations.supportedLocales,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      routerConfig: appRouter,
    );
  }
}
