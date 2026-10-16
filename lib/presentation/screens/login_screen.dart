import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(strings.loginTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_open_rounded, size: 56),
              const SizedBox(height: 16),
              Text(strings.loginDescription, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => ref.read(authProvider.notifier).login(),
                child: Text(strings.signIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
