import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/memory_drop.dart';
import '../../l10n/app_localizations.dart';
import '../providers/drop_providers.dart';

class DropDetailsScreen extends ConsumerWidget {
  final String id;

  const DropDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppLocalizations.of(context)!;
    final dropId = int.tryParse(id);

    final body = dropId == null
        ? _NotFoundState(message: strings.dropNotFound)
        : ref
              .watch(dropsProvider)
              .when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off_rounded, size: 56),
                        const SizedBox(height: 16),
                        Text(strings.loadError, textAlign: TextAlign.center),
                        const SizedBox(height: 20),
                        FilledButton.icon(
                          onPressed: () => ref.invalidate(dropsProvider),
                          icon: const Icon(Icons.refresh),
                          label: Text(strings.retry),
                        ),
                      ],
                    ),
                  ),
                ),
                data: (drops) {
                  for (final drop in drops) {
                    if (drop.id == dropId) {
                      return _DropContent(drop: drop);
                    }
                  }
                  return _NotFoundState(message: strings.dropNotFound);
                },
              );

    return Scaffold(appBar: AppBar(), body: body);
  }
}

class _NotFoundState extends StatelessWidget {
  final String message;

  const _NotFoundState({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.search_off_rounded, size: 56),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _DropContent extends StatelessWidget {
  final MemoryDrop drop;

  const _DropContent({required this.drop});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Spacer(),

          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: drop.locked
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              drop.locked
                  ? Icons.lock_outline_rounded
                  : Icons.lock_open_rounded,
              size: 44,
            ),
          ),

          const SizedBox(height: 28),

          Text(
            drop.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on_outlined, size: 18),
              const SizedBox(width: 4),
              Text(drop.location),
            ],
          ),

          const SizedBox(height: 36),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(24),
            ),
            child: drop.locked
                ? Column(
                    children: [
                      Text(
                        strings.dropLockedTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(strings.dropLockedText, textAlign: TextAlign.center),
                    ],
                  )
                : Column(
                    children: [
                      const Icon(Icons.auto_awesome, size: 30),
                      const SizedBox(height: 12),
                      Text(
                        strings.dropAvailableTitle,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        strings.dropAvailableText,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
