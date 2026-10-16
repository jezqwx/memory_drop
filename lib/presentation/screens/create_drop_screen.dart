import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../widgets/adaptive_content.dart';

class CreateDropScreen extends StatefulWidget {
  const CreateDropScreen({super.key});

  @override
  State<CreateDropScreen> createState() => _CreateDropScreenState();
}

class _CreateDropScreenState extends State<CreateDropScreen> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.createDrop,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: AdaptiveContent(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              strings.createDrop,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            ),

            const SizedBox(height: 8),

            Text(
              strings.createDescription,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 28),

            TextField(
              controller: titleController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: strings.titleLabel,
                prefixIcon: const Icon(Icons.title_rounded),
              ),
            ),

            const SizedBox(height: 28),

            TextField(
              controller: messageController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: strings.messageLabel,
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.notes_rounded),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          strings.locationLabel,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(strings.locationComingSoon),
                      ],
                    ),
                  ),

                  const Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(strings.createMemoryComingSoon)),
                  );
                },
                icon: const Icon(Icons.auto_awesome_outlined),
                label: Text(strings.createMemoryButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
