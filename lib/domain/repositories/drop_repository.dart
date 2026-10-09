import '../entities/memory_drop.dart';

abstract class DropRepository {
  List<MemoryDrop> getDrops();

  List<MemoryDrop> toggleFavorite(int id);
}