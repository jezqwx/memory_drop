import 'package:go_router/go_router.dart';

import '../../presentation/screens/create_drop_screen.dart';
import '../../presentation/screens/drop_details_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/my_drops_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/create',
      builder: (context, state) => const CreateDropScreen(),
    ),
    GoRoute(path: '/drops', builder: (context, state) => const MyDropsScreen()),
    GoRoute(
      path: '/drops/:id',
      builder: (context, state) =>
          DropDetailsScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
