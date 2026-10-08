// ignore_for_file: avoid_print

class MemoryDrop {
  String title;
  String message;

  MemoryDrop({
    required this.title,
    required this.message,
  });
}

void main() {
  final drop = MemoryDrop(
    title: 'First Memory',
    message: 'Hello from Memory Drop',
  );

  print(drop.title);
  print(drop.message);
}