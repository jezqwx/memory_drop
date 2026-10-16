import 'package:flutter/material.dart';
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
  testWidgets(
    'Вкладки сохраняют состояние, детали и настройки открываются поверх',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      appRouter.go('/');

      await tester.pumpWidget(
        ProviderScope(
          overrides: [dropsProvider.overrideWith(_TestDropsNotifier.new)],
          child: const MemoryDropApp(),
        ),
      );
      await tester.pumpAndSettle();

      Future<void> openTab(String label, int index) async {
        await tester.tap(
          find.descendant(
            of: find.byType(NavigationBar),
            matching: find.text(label),
          ),
        );
        await tester.pumpAndSettle();
        expect(
          tester
              .widget<NavigationBar>(find.byType(NavigationBar))
              .selectedIndex,
          index,
        );
      }

      await openTab('Мои воспоминания', 1);
      await tester.enterText(find.byType(TextField), 'уни');
      await tester.pump(const Duration(milliseconds: 550));
      await tester.pumpAndSettle();

      await openTab('Создать', 2);
      await openTab('Профиль', 3);
      await openTab('Главная', 0);
      await openTab('Мои воспоминания', 1);
      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        'уни',
      );

      await tester.tap(find.text('Воспоминание об университете'));
      await tester.pumpAndSettle();
      expect(find.text('AlmaU'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
        1,
      );

      await openTab('Главная', 0);
      await tester.tap(find.byIcon(Icons.settings_outlined));
      await tester.pumpAndSettle();
      expect(find.text('Настройки'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(
        tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex,
        0,
      );
    },
  );
}
