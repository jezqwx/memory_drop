import 'package:flutter/material.dart';

import '../../models/memory_drop.dart';

class DropInheritedController extends StatefulWidget {
  final Widget child;

  const DropInheritedController({
    super.key,
    required this.child,
  });

  @override
  State<DropInheritedController> createState() =>
      _DropInheritedControllerState();
}

class _DropInheritedControllerState
    extends State<DropInheritedController> {
  List<MemoryDrop> drops = [
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

  void toggleFavorite(int index) {
    setState(() {
      final currentDrop = drops[index];

      final updatedDrop = currentDrop.copyWith(
        isFavorite: !currentDrop.isFavorite,
      );

      // Создаём НОВЫЙ список.
      final updatedDrops = List<MemoryDrop>.from(drops);

      // Меняем элемент уже в новом списке.
      updatedDrops[index] = updatedDrop;

      // Теперь drops указывает на новый список.
      drops = updatedDrops;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropInheritedScope(
      drops: drops,
      toggleFavorite: toggleFavorite,
      child: widget.child,
    );
  }
}

class DropInheritedScope extends InheritedWidget {
  final List<MemoryDrop> drops;
  final void Function(int index) toggleFavorite;

  const DropInheritedScope({
    super.key,
    required this.drops,
    required this.toggleFavorite,
    required super.child,
  });

  static DropInheritedScope of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<DropInheritedScope>();

    assert(
      scope != null,
      'DropInheritedScope не найден',
    );

    return scope!;
  }

  @override
  bool updateShouldNotify(DropInheritedScope oldWidget) {
    return drops != oldWidget.drops;
  }
}