import 'package:flutter/material.dart';

import '../../models/memory_drop.dart';

class DropProvider extends ChangeNotifier {
  final List<MemoryDrop> _drops = [
    const MemoryDrop(
      id: 1,
      title: 'Наше первое место',
      location: 'Алматы',
      locked: true,
    ),
    const MemoryDrop(
      id: 2,
      title: 'Воспоминание об университете',
      location: 'AlmaU',
      locked: false,
    ),
    const MemoryDrop(
      id: 3,
      title: 'Летняя поездка',
      location: 'Астана',
      locked: true,
    ),
  ];

  List<MemoryDrop> get drops => List.unmodifiable(_drops);

  void toggleFavorite(int id) {
    final index = _drops.indexWhere(
      (drop) => drop.id == id,
    );

    if (index == -1) {
      return;
    }

    final currentDrop = _drops[index];

    _drops[index] = currentDrop.copyWith(
      isFavorite: !currentDrop.isFavorite,
    );

    notifyListeners();
  }
}