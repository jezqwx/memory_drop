import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.dark_mode_outlined),
            title: Text('Тема'),
            subtitle: Text('Системная тема'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language_outlined),
            title: Text('Язык'),
            subtitle: Text('Русский'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text('Уведомления'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('О приложении Memory Drop'),
          ),
        ],
      ),
    );
  }
}