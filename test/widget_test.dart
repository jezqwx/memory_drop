import 'package:flutter_test/flutter_test.dart';
import 'package:memory_drop/app.dart';

void main() {
  testWidgets('Главный экран Memory Drop отображается', (tester) async {
    await tester.pumpWidget(const MemoryDropApp());

    expect(find.text('Капсула воспоминаний'), findsOneWidget);
    expect(
      find.text('Оставь воспоминание где-нибудь в мире.'),
      findsOneWidget,
    );
  });
}