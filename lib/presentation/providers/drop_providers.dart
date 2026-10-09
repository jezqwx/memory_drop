import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/drop_repository_impl.dart';
import '../../domain/entities/memory_drop.dart';
import '../../domain/repositories/drop_repository.dart';

final dropRepositoryProvider = Provider<DropRepository>((ref) {
  return DropRepositoryImpl();
});

class DropsNotifier extends Notifier<List<MemoryDrop>> {
  late final DropRepository _repository;

  @override
  List<MemoryDrop> build() {
    _repository = ref.read(dropRepositoryProvider);

    return _repository.getDrops();
  }

  void toggleFavorite(int id) {
    state = _repository.toggleFavorite(id);
  }
}

final dropsProvider =
    NotifierProvider<DropsNotifier, List<MemoryDrop>>(
  DropsNotifier.new,
);