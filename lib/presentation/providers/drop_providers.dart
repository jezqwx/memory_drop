import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/drop_remote_data_source.dart';
import '../../data/repositories/drop_repository_impl.dart';
import '../../domain/entities/memory_drop.dart';
import '../../domain/repositories/drop_repository.dart';
import 'network_providers.dart';
import '../../data/local/drop_local_data_source.dart';

final dropRemoteDataSourceProvider =
    Provider<DropRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);

  return DropRemoteDataSource(dio);
});

final dropLocalDataSourceProvider =
    Provider<DropLocalDataSource>((ref) {
  return DropLocalDataSource();
});

final dropRepositoryProvider =
    Provider<DropRepository>((ref) {
  final remoteDataSource =
      ref.read(dropRemoteDataSourceProvider);

  final localDataSource =
      ref.read(dropLocalDataSourceProvider);

  return DropRepositoryImpl(
    remoteDataSource,
    localDataSource,
  );
});

class DropsNotifier extends AsyncNotifier<List<MemoryDrop>> {
  DropRepository get _repository {
    return ref.read(dropRepositoryProvider);
  }

  @override
  Future<List<MemoryDrop>> build() async {
    return _repository.getDrops();
  }

  Future<void> refreshDrops() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () => _repository.getDrops(),
    );
  }

Future<void> toggleFavorite(MemoryDrop drop) async {
  final currentList = state.value;

  if (currentList == null) {
    return;
  }

  final newFavoriteValue = !drop.isFavorite;

  // Сразу меняем сердечко локально.
  final optimisticList = currentList.map((item) {
    if (item.id == drop.id) {
      return item.copyWith(
        isFavorite: newFavoriteValue,
      );
    }

    return item;
  }).toList();

  state = AsyncData(optimisticList);

  try {
    // А сервер обновляем уже после этого.
    final updatedDrop = await _repository.updateFavorite(
      id: drop.id,
      isFavorite: newFavoriteValue,
    );

    final updatedList = optimisticList.map((item) {
      if (item.id == updatedDrop.id) {
        return updatedDrop;
      }

      return item;
    }).toList();

    state = AsyncData(updatedList);
  } catch (error) {
    // Если сервер не смог сохранить —
    // возвращаем предыдущее состояние.
    state = AsyncData(currentList);
  }
}
}

final dropsProvider =
    AsyncNotifierProvider<
        DropsNotifier,
        List<MemoryDrop>>(
  DropsNotifier.new,
);