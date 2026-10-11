import '../../domain/entities/memory_drop.dart';
import '../../domain/repositories/drop_repository.dart';
import '../datasources/drop_remote_data_source.dart';
import '../local/drop_local_data_source.dart';
import '../models/memory_drop_model.dart';

class DropRepositoryImpl implements DropRepository {
  final DropRemoteDataSource remoteDataSource;
  final DropLocalDataSource localDataSource;

  DropRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
  );

  @override
  Future<List<MemoryDrop>> getDrops() async {
    try {
      // 1. Пытаемся получить свежие данные из интернета.
      final remoteModels =
          await remoteDataSource.getDrops();

      // 2. Если получили — сохраняем их в Hive.
      await localDataSource.saveDrops(
        remoteModels,
      );

      // 3. Отдаём данные приложению.
      return remoteModels
          .map((model) => model.toEntity())
          .toList();
    } catch (error) {
      // 4. Если интернет/API не работает —
      // пробуем получить последние данные из Hive.
      final cachedModels =
          localDataSource.getCachedDrops();

      if (cachedModels.isNotEmpty) {
        return cachedModels
            .map((model) => model.toEntity())
            .toList();
      }

      // Если ни сети, ни кэша нет —
      // показываем настоящую ошибку.
      rethrow;
    }
  }

  @override
  Future<MemoryDrop> updateFavorite({
    required int id,
    required bool isFavorite,
  }) async {
    try {
      // Сначала пробуем сохранить на сервере.
      final remoteModel =
          await remoteDataSource.updateFavorite(
        id: id.toString(),
        isFavorite: isFavorite,
      );

      // После успешного ответа обновляем Hive.
      await _updateFavoriteInCache(
        id: id,
        isFavorite: remoteModel.isFavorite ?? false,
      );

      return remoteModel.toEntity();
    } catch (error) {
      // Если интернета нет —
      // сохраняем изменение хотя бы локально.
      await _updateFavoriteInCache(
        id: id,
        isFavorite: isFavorite,
      );

      final cachedDrops =
          localDataSource.getCachedDrops();

      final cachedDrop = cachedDrops.firstWhere(
        (drop) =>
            int.tryParse(drop.id ?? '') == id,
      );

      return cachedDrop.toEntity();
    }
  }

  Future<void> _updateFavoriteInCache({
    required int id,
    required bool isFavorite,
  }) async {
    final cachedDrops =
        localDataSource.getCachedDrops();

    if (cachedDrops.isEmpty) {
      return;
    }

    final updatedDrops = cachedDrops.map((drop) {
      final dropId =
          int.tryParse(drop.id ?? '') ?? 0;

      if (dropId != id) {
        return drop;
      }

      return MemoryDropModel(
        id: drop.id,
        title: drop.title,
        location: drop.location,
        locked: drop.locked,
        isFavorite: isFavorite,
      );
    }).toList();

    await localDataSource.saveDrops(
      updatedDrops,
    );
  }
}