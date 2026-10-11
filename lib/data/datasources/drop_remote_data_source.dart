import 'package:dio/dio.dart';

import '../models/memory_drop_model.dart';

class DropRemoteDataSource {
  final Dio dio;

  DropRemoteDataSource(this.dio);

  Future<List<MemoryDropModel>> getDrops() async {
    try {
      final response = await dio.get('/drops');

      final data = response.data as List<dynamic>;

      return data
          .map(
            (json) => MemoryDropModel.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
    } on DioException catch (error) {
      throw Exception(
        'Не удалось загрузить воспоминания: ${error.message}',
      );
    }
  }
  Future<MemoryDropModel> updateFavorite({
  required String id,
  required bool isFavorite,
}) async {
  try {
    final response = await dio.put(
      '/drops/$id',
      data: {
        'isFavorite': isFavorite,
      },
    );

    return MemoryDropModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  } on DioException catch (error) {
    throw Exception(
      'Ошибка обновления избранного: ${error.message}',
    );
  }
}
}