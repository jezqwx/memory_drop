import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/drop_remote_data_source.dart';
import '../../data/repositories/drop_repository_impl.dart';
import '../../domain/entities/memory_drop.dart';
import '../../domain/repositories/drop_repository.dart';
import 'network_providers.dart';

final dropRemoteDataSourceProvider =
    Provider<DropRemoteDataSource>((ref) {
  final dio = ref.read(dioProvider);

  return DropRemoteDataSource(dio);
});

final dropRepositoryProvider =
    Provider<DropRepository>((ref) {
  final remoteDataSource =
      ref.read(dropRemoteDataSourceProvider);

  return DropRepositoryImpl(remoteDataSource);
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

  try {
    final updatedDrop = await _repository.updateFavorite(
      id: drop.id,
      isFavorite: newFavoriteValue,
    );

    final updatedList = currentList.map((item) {
      if (item.id == updatedDrop.id) {
        return updatedDrop;
      }

      return item;
    }).toList();

    state = AsyncData(updatedList);
  } catch (error) {
    // Если не удалось обновить сердечко,
    // оставляем текущий список на экране.
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