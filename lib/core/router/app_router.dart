import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/create_drop_screen.dart';
import '../../presentation/screens/drop_details_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/my_drops_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/settings_screen.dart';
import '../../presentation/widgets/main_navigation_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainNavigationShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
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
                  parentNavigatorKey: _rootNavigatorKey,
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
  ],
);
