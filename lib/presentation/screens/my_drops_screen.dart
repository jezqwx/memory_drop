import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/drop_provider.dart';
import 'drop_details_screen.dart';

class MyDropsScreen extends StatelessWidget {
  const MyDropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мои воспоминания',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Consumer<DropProvider>(
        builder: (context, provider, child) {
          final drops = provider.drops;

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: drops.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 14);
            },
            itemBuilder: (context, index) {
              final drop = drops[index];

              return InkWell(
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DropDetailsScreen(
                        title: drop.title,
                        location: drop.location,
                        locked: drop.locked,
                      ),
                    ),
                  );
                },
                child: Ink(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: drop.locked
                              ? Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(
                          drop.locked
                              ? Icons.lock_outline
                              : Icons.lock_open_rounded,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              drop.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(drop.location),
                              ],
                            ),

                            const SizedBox(height: 6),

                            Text(
                              drop.locked
                                  ? 'Закрыто'
                                  : 'Доступно',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: drop.locked
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondary
                                    : Theme.of(context)
                                        .colorScheme
                                        .primary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        tooltip: drop.isFavorite
                            ? 'Убрать из избранного'
                            : 'Добавить в избранное',
                        onPressed: () {
                          context
                              .read<DropProvider>()
                              .toggleFavorite(drop.id);
                        },
                        icon: Icon(
                          drop.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: drop.isFavorite
                              ? Colors.red
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}