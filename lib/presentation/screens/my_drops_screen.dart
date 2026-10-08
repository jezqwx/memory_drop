import 'package:flutter/material.dart';

import 'drop_details_screen.dart';

class MyDropsScreen extends StatelessWidget {
  const MyDropsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final drops = [
      {
        'title': 'Наше первое место',
        'location': 'Алматы',
        'locked': true,
      },
      {
        'title': 'Воспоминание об университете',
        'location': 'AlmaU',
        'locked': false,
      },
      {
        'title': 'Летняя поездка',
        'location': 'Астана',
        'locked': true,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мои воспоминания',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: drops.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final drop = drops[index];

          final title = drop['title'] as String;
          final location = drop['location'] as String;
          final locked = drop['locked'] as bool;

          return InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DropDetailsScreen(
                    title: title,
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
                      color: locked
                          ? Theme.of(context)
                              .colorScheme
                              .secondaryContainer
                          : Theme.of(context)
                              .colorScheme
                              .primaryContainer,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      locked
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
                          title,
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
                            Text(location),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          locked ? 'Закрыто' : 'Доступно',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: locked
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
                  const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}