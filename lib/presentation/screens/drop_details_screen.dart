import 'package:flutter/material.dart';

class DropDetailsScreen extends StatelessWidget {
  final String title;
  final String location;
  final bool locked;

  const DropDetailsScreen({
    super.key,
    required this.title,
    required this.location,
    required this.locked,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Spacer(),

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: locked
                    ? Theme.of(context)
                        .colorScheme
                        .secondaryContainer
                    : Theme.of(context)
                        .colorScheme
                        .primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                locked
                    ? Icons.lock_outline_rounded
                    : Icons.lock_open_rounded,
                size: 44,
              ),
            ),

            const SizedBox(height: 28),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                ),
                const SizedBox(width: 4),
                Text(location),
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
              child: locked
                  ? const Column(
                      children: [
                        Text(
                          'Это воспоминание пока закрыто',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Чтобы открыть воспоминание, нужно находиться рядом с этим местом.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : const Column(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          size: 30,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Воспоминание доступно',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Это воспоминание уже можно открыть.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}