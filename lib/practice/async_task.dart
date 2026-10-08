// ignore_for_file: avoid_print

Future<String> loadDrop() async {
  await Future.delayed(
    const Duration(seconds: 2),
  );

  return 'Memory Drop loaded';
}

void main() async {
  print('Loading...');

  final result = await loadDrop();

  print(result);
}