import 'package:flutter/material.dart';

void main() {
  runApp(const MemoryDropApp());
}

class MemoryDropApp extends StatelessWidget {
  const MemoryDropApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memory Drop',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Memory Drop'),
        ),
        body: const Center(
          child: Text(
            'Welcome to Memory Drop',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}