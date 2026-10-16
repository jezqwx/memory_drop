import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_drop/app.dart';
import 'package:memory_drop/core/router/app_router.dart';
import 'package:memory_drop/domain/entities/memory_drop.dart';
import 'package:memory_drop/presentation/providers/auth_provider.dart';
import 'package:memory_drop/presentation/providers/drop_providers.dart';
import 'package:memory_drop/presentation/screens/create_drop_screen.dart';
import 'package:memory_drop/presentation/screens/drop_details_screen.dart';
import 'package:memory_drop/presentation/screens/home_screen.dart';
import 'package:memory_drop/presentation/screens/login_screen.dart';
import 'package:memory_drop/presentation/screens/my_drops_screen.dart';
import 'package:memory_drop/presentation/screens/profile_screen.dart';
import 'package:memory_drop/presentation/screens/settings_screen.dart';
import 'package:memory_drop/presentation/screens/theme_settings_screen.dart';
import 'package:memory_drop/presentation/widgets/adaptive_content.dart';
import 'package:memory_drop/presentation/screens/language_settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _longTitle =
    'Очень длинное название воспоминания, которое должно помещаться в карточке на узком экране';
const _longLocation =
    'Очень длинное название локации, которое должно сокращаться в строке карточки';

class _TestDropsNotifier extends DropsNotifier {
  @override
  Future<List<MemoryDrop>> build() async => const [
    MemoryDrop(
      id: 2,
      title: _longTitle,
      location: _longLocation,
      locked: false,
    ),
  ];
}

void main() {
  for (final size in [
    const Size(390, 844),
    const Size(412, 915),
    const Size(768, 1024),
    const Size(1024, 768),
    const Size(844, 390),
  ]) {
    testWidgets('Экраны адаптируются к ${size.width}x${size.height}', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(size);
      addTearDown(() => tester.binding.setSurfaceSize(null));
      SharedPreferences.setMockInitialValues({});
      final container = ProviderContainer(
        overrides: [dropsProvider.overrideWith(_TestDropsNotifier.new)],
      );
      addTearDown(container.dispose);
      final router = container.read(appRouterProvider);
      container.read(authProvider.notifier).login();
      router.go('/');

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MemoryDropApp(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(
        find.byType(size.width >= 700 ? NavigationRail : NavigationBar),
        findsOneWidget,
      );
      final constrainedContent = find
          .descendant(
            of: find.byType(AdaptiveContent),
            matching: find.byType(ConstrainedBox),
          )
          .first;
      expect(tester.getSize(constrainedContent).width, lessThanOrEqualTo(800));
      expect(tester.takeException(), isNull);

      for (final routeAndScreen in <(String, Type)>[
        ('/drops', MyDropsScreen),
        ('/create', CreateDropScreen),
        ('/profile', ProfileScreen),
        ('/drops/2', DropDetailsScreen),
        ('/settings', SettingsScreen),
        ('/login', LoginScreen),
      ]) {
        if (routeAndScreen.$1 == '/login') {
          container.read(authProvider.notifier).logout();
        }
        router.go(routeAndScreen.$1);
        await tester.pumpAndSettle();
        expect(find.byType(routeAndScreen.$2), findsOneWidget);
        if (routeAndScreen.$2 == ProfileScreen) {
          expect(find.byType(Wrap), findsOneWidget);
        }
        expect(tester.takeException(), isNull);
      }

      router.go('/settings');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Тема'));
      await tester.pumpAndSettle();
      expect(find.byType(ThemeSettingsScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Язык'));
      await tester.pumpAndSettle();
      expect(find.byType(LanguageSettingsScreen), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Длинный текст сокращается, детали прокручиваются в landscape', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(844, 390));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer(
      overrides: [dropsProvider.overrideWith(_TestDropsNotifier.new)],
    );
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    router.go('/drops');
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MemoryDropApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.widget<Text>(find.text(_longTitle)).overflow,
      TextOverflow.ellipsis,
    );
    expect(
      tester.widget<Text>(find.text(_longLocation)).overflow,
      TextOverflow.ellipsis,
    );
    expect(tester.takeException(), isNull);

    router.go('/drops/2');
    await tester.pumpAndSettle();
    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
