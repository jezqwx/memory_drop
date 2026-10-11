import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/memory_drop.dart';

part 'memory_drop_model.g.dart';

@JsonSerializable()
class MemoryDropModel {
  final String? id;
  final String? title;
  final String? location;
  final bool? locked;
  final bool? isFavorite;

  const MemoryDropModel({
    this.id,
    this.title,
    this.location,
    this.locked,
    this.isFavorite,
  });

  factory MemoryDropModel.fromJson(Map<String, dynamic> json) =>
      _$MemoryDropModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MemoryDropModelToJson(this);

  MemoryDrop toEntity() {
    return MemoryDrop(
      id: int.tryParse(id ?? '') ?? 0,
      title: title ?? 'Без названия',
      location: location ?? 'Неизвестное место',
      locked: locked ?? false,
      isFavorite: isFavorite ?? false,
    );
  }
}