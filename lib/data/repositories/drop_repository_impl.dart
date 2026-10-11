import '../../domain/entities/memory_drop.dart';
import '../../domain/repositories/drop_repository.dart';
import '../datasources/drop_remote_data_source.dart';

class DropRepositoryImpl implements DropRepository {
  final DropRemoteDataSource remoteDataSource;

  DropRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MemoryDrop>> getDrops() async {
    final models = await remoteDataSource.getDrops();

    return models
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<MemoryDrop> updateFavorite({
    required int id,
    required bool isFavorite,
  }) async {
    final model = await remoteDataSource.updateFavorite(
      id: id.toString(),
      isFavorite: isFavorite,
    );

    return model.toEntity();
  }
}