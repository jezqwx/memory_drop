import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'presentation/providers/drop_provider.dart';
import 'presentation/screens/home_screen.dart';

class MemoryDropApp extends StatelessWidget {
  const MemoryDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DropProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Memory Drop',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
      ),
    );
  }
}