import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../providers/settings_providers.dart';

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageAsync = ref.watch(languageProvider);
    final currentLanguage = languageAsync.value ?? 'ru';

    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.language),
      ),
      body: RadioGroup<String>(
        groupValue: currentLanguage,
        onChanged: (value) {
          if (value != null) {
            ref
                .read(languageProvider.notifier)
                .setLanguage(value);
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            RadioListTile<String>(
              title: Text('Русский'),
              value: 'ru',
            ),
            RadioListTile<String>(
              title: Text('English'),
              value: 'en',
            ),
          ],
        ),
      ),
    );
  }
}