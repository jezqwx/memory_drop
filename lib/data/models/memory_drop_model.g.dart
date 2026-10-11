// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memory_drop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemoryDropModel _$MemoryDropModelFromJson(Map<String, dynamic> json) =>
    MemoryDropModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      location: json['location'] as String?,
      locked: json['locked'] as bool?,
      isFavorite: json['isFavorite'] as bool?,
    );

Map<String, dynamic> _$MemoryDropModelToJson(MemoryDropModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'locked': instance.locked,
      'isFavorite': instance.isFavorite,
    };
