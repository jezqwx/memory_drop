import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../providers/settings_providers.dart';

class ThemeSettingsScreen extends ConsumerWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeProvider);
    final currentTheme = themeAsync.value ?? ThemeMode.system;
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.theme),
      ),
      body: RadioGroup<ThemeMode>(
        groupValue: currentTheme,
        onChanged: (value) {
          if (value != null) {
            ref
                .read(themeProvider.notifier)
                .setThemeMode(value);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            RadioListTile<ThemeMode>(
              title: Text(strings.systemTheme),
              subtitle: Text(strings.themeSystemSubtitle),
              value: ThemeMode.system,
            ),
            RadioListTile<ThemeMode>(
              title: Text(strings.lightTheme),
              value: ThemeMode.light,
            ),
            RadioListTile<ThemeMode>(
              title: Text(strings.darkTheme),
              value: ThemeMode.dark,
            ),
          ],
        ),
      ),
    );
  }
}