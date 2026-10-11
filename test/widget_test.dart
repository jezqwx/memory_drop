import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_drop/app.dart';

void main() {
  testWidgets(
    'Главный экран Memory Drop отображается',
    (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MemoryDropApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('Капсула воспоминаний'),
        findsOneWidget,
      );
    },
  );
}