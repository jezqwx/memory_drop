import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/create_drop_screen.dart';
import '../../presentation/screens/drop_details_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/my_drops_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/widgets/main_navigation_shell.dart';
import '../../presentation/providers/auth_provider.dart';

class _AuthRefreshNotifier extends ChangeNotifier {
  void refresh() => notifyListeners();
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final authRefreshNotifier = _AuthRefreshNotifier();

  ref.listen<bool>(authProvider, (previous, next) {
    authRefreshNotifier.refresh();
  });

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    refreshListenable: authRefreshNotifier,
    redirect: (context, state) {
      final isAuthenticated = ref.read(authProvider);
      final location = state.matchedLocation;

      if (!isAuthenticated && location == '/profile') return '/login';
      if (isAuthenticated && location == '/login') return '/profile';
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainNavigationShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/drops',
                builder: (context, state) => const MyDropsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) =>
                        DropDetailsScreen(id: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/create',
                builder: (context, state) => const CreateDropScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    authRefreshNotifier.dispose();
  });
  return router;
});
