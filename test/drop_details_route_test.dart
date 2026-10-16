import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_drop/app.dart';
import 'package:memory_drop/core/router/app_router.dart';
import 'package:memory_drop/domain/entities/memory_drop.dart';
import 'package:memory_drop/presentation/providers/drop_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TestDropsNotifier extends DropsNotifier {
  @override
  Future<List<MemoryDrop>> build() async => const [
    MemoryDrop(
      id: 2,
      title: 'Воспоминание об университете',
      location: 'AlmaU',
      locked: false,
    ),
  ];
}

void main() {
  testWidgets('Прямой маршрут показывает воспоминание и отсутствие записи', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    appRouter.go('/drops/2');

    await tester.pumpWidget(
      ProviderScope(
        overrides: [dropsProvider.overrideWith(_TestDropsNotifier.new)],
        child: const MemoryDropApp(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Воспоминание об университете'), findsOneWidget);
    expect(find.text('AlmaU'), findsOneWidget);

    appRouter.go('/drops/999');
    await tester.pumpAndSettle();
    expect(find.text('Воспоминание не найдено'), findsOneWidget);

    appRouter.go('/drops/invalid');
    await tester.pumpAndSettle();
    expect(find.text('Воспоминание не найдено'), findsOneWidget);
  });
}
