import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/drop_providers.dart';
import '../widgets/animated_favorite_button.dart';
import 'drop_details_screen.dart';

class MyDropsScreen extends ConsumerStatefulWidget {
  const MyDropsScreen({super.key});

  @override
  ConsumerState<MyDropsScreen> createState() => _MyDropsScreenState();
}

class _MyDropsScreenState extends ConsumerState<MyDropsScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  Timer? _debounce;

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          _searchQuery = value.trim().toLowerCase();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dropsAsync = ref.watch(dropsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Мои воспоминания',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: dropsAsync.when(
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_off_rounded,
                    size: 56,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Не удалось загрузить воспоминания',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  FilledButton.icon(
                    onPressed: () {
                      ref.invalidate(dropsProvider);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Повторить'),
                  ),
                ],
              ),
            ),
          );
        },
        data: (drops) {
          final filteredDrops = drops.where((drop) {
            if (_searchQuery.isEmpty) {
              return true;
            }

            final title = drop.title.toLowerCase();
            final location = drop.location.toLowerCase();

            return title.contains(_searchQuery) ||
                location.contains(_searchQuery);
          }).toList();

          if (drops.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 56,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Воспоминаний пока нет',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(dropsProvider.notifier)
                  .refreshDrops();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Поиск по названию или месту',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();

                              setState(() {
                                _searchQuery = '';
                              });
                            },
                            icon: const Icon(Icons.close),
                          )
                        : null,
                  ),
                ),

                const SizedBox(height: 20),

                if (filteredDrops.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 56,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Ничего не найдено',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...List.generate(
                    filteredDrops.length,
                    (index) {
                      final drop = filteredDrops[index];

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index ==
                                  filteredDrops.length - 1
                              ? 0
                              : 14,
                        ),
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(24),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    DropDetailsScreen(
                                  title: drop.title,
                                  location: drop.location,
                                  locked: drop.locked,
                                ),
                              ),
                            );
                          },
                          child: Ink(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface,
                              borderRadius:
                                  BorderRadius.circular(24),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 58,
                                  height: 58,
                                  decoration: BoxDecoration(
                                    color: drop.locked
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                    borderRadius:
                                        BorderRadius.circular(18),
                                  ),
                                  child: Icon(
                                    drop.locked
                                        ? Icons.lock_outline
                                        : Icons.lock_open_rounded,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        drop.title,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight:
                                              FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(drop.location),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        drop.locked
                                            ? 'Закрыто'
                                            : 'Доступно',
                                      ),
                                    ],
                                  ),
                                ),
                                AnimatedFavoriteButton(
                                  isFavorite:
                                      drop.isFavorite,
                                  onPressed: () {
                                    ref
                                        .read(
                                          dropsProvider.notifier,
                                        )
                                        .toggleFavorite(drop);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}