import '../entities/memory_drop.dart';

abstract class DropRepository {
  Future<List<MemoryDrop>> getDrops();

  Future<MemoryDrop> updateFavorite({
    required int id,
    required bool isFavorite,
  });
}