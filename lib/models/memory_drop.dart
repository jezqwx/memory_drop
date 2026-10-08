class MemoryDrop {
  final int id;
  final String title;
  final String location;
  final bool locked;
  final bool isFavorite;

  const MemoryDrop({
    required this.id,
    required this.title,
    required this.location,
    required this.locked,
    this.isFavorite = false,
  });

  MemoryDrop copyWith({
    int? id,
    String? title,
    String? location,
    bool? locked,
    bool? isFavorite,
  }) {
    return MemoryDrop(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      locked: locked ?? this.locked,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}