import 'package:hive/hive.dart';

import '../models/memory_drop_model.dart';

class DropLocalDataSource {
  static const String boxName = 'drops_cache';
  static const String dropsKey = 'drops';

  Box get _box => Hive.box(boxName);

  Future<void> saveDrops(
    List<MemoryDropModel> drops,
  ) async {
    final data = drops
        .map(
          (drop) => drop.toJson(),
        )
        .toList();

    await _box.put(
      dropsKey,
      data,
    );
  }

  List<MemoryDropModel> getCachedDrops() {
    final cachedData = _box.get(dropsKey);

    if (cachedData == null) {
      return [];
    }

    final list = List<dynamic>.from(cachedData as List);

    return list.map((item) {
      final map = Map<String, dynamic>.from(
        item as Map,
      );

      return MemoryDropModel.fromJson(map);
    }).toList();
  }

  Future<void> clearCache() async {
    await _box.delete(dropsKey);
  }
}