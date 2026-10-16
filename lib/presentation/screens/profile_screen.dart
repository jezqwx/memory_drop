import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(strings.profileTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 45)),
            const SizedBox(height: 16),
            const Text(
              'Gulsezim',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ProfileStat(number: '3', label: strings.memoriesCount),
                _ProfileStat(number: '1', label: strings.openedCount),
                _ProfileStat(number: '2', label: strings.lockedCount),
              ],
            ),
            const SizedBox(height: 32),
            OutlinedButton.icon(
              onPressed: () => ref.read(authProvider.notifier).logout(),
              icon: const Icon(Icons.logout_rounded),
              label: Text(strings.signOut),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String number;
  final String label;

  const _ProfileStat({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }
}
