import '../../domain/entities/memory_drop.dart';
import '../../domain/repositories/drop_repository.dart';

class DropRepositoryImpl implements DropRepository {
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

  @override
  List<MemoryDrop> getDrops() {
    return List.unmodifiable(_drops);
  }

  @override
  List<MemoryDrop> toggleFavorite(int id) {
    final index = _drops.indexWhere(
      (drop) => drop.id == id,
    );

    if (index == -1) {
      return List.unmodifiable(_drops);
    }

    final currentDrop = _drops[index];

    _drops[index] = currentDrop.copyWith(
      isFavorite: !currentDrop.isFavorite,
    );

    return List.unmodifiable(_drops);
  }
}