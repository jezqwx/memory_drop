import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_drop/app.dart';
import 'package:memory_drop/core/router/app_router.dart';
import 'package:memory_drop/presentation/providers/auth_provider.dart';
import 'package:memory_drop/presentation/screens/create_drop_screen.dart';
import 'package:memory_drop/presentation/screens/login_screen.dart';
import 'package:memory_drop/presentation/screens/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Прямой /profile без входа перенаправляет на /login', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    router.go('/profile');

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MemoryDropApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(ProfileScreen), findsNothing);
    expect(router.routeInformationProvider.value.uri.path, '/login');

    router.go('/create');
    await tester.pumpAndSettle();
    expect(find.byType(CreateDropScreen), findsOneWidget);
  });

  testWidgets('Вход открывает профиль, выход снова защищает маршрут', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final router = container.read(appRouterProvider);
    router.go('/');

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MemoryDropApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byType(NavigationBar),
        matching: find.text('Профиль'),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(router.routeInformationProvider.value.uri.path, '/login');

    await tester.tap(find.text('Войти'));
    await tester.pumpAndSettle();
    expect(container.read(authProvider), isTrue);
    expect(find.byType(ProfileScreen), findsOneWidget);
    expect(router.routeInformationProvider.value.uri.path, '/profile');

    await tester.tap(find.text('Выйти'));
    await tester.pumpAndSettle();
    expect(container.read(authProvider), isFalse);
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(router.routeInformationProvider.value.uri.path, '/login');

    router.go('/profile');
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.tap(find.text('Войти'));
    await tester.pumpAndSettle();
    expect(find.byType(ProfileScreen), findsOneWidget);
  });
}
