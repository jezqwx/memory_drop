import 'package:flutter_test/flutter_test.dart';
import 'package:memory_drop/main.dart';

void main() {
  testWidgets('Memory Drop welcome screen is displayed', (tester) async {
    await tester.pumpWidget(const MemoryDropApp());

    expect(find.text('Memory Drop'), findsOneWidget);
    expect(find.text('Welcome to Memory Drop'), findsOneWidget);
  });
}