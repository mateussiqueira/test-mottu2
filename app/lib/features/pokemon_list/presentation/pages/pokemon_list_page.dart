import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/core/config/di.dart';
import 'package:mobile/features/pokemon/domain/repositories/pokemon_repository.dart';

import '../controllers/pokemon_list_controller.dart';
import '../controllers/pokemon_search_controller.dart';
import '../widgets/pokemon_grid_item.dart';
import '../widgets/pokemon_grid_item_skeleton.dart';
import '../widgets/pokemon_search_delegate.dart';

class PokemonListPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  PokemonListPage({
    super.key,
  }) {
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final controller = Get.find<PokemonListController>();
      if (!controller.isLoadingMore.value && controller.hasMore.value) {
        controller.loadMorePokemons();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with repository
    Get.put(PokemonListController(getIt<PokemonRepository>()));
    Get.put(PokemonSearchController(getIt<PokemonRepository>()));

    final listController = Get.find<PokemonListController>();
    final searchController = Get.find<PokemonSearchController>();

    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          'Pokédex',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PokemonSearchDelegate(listController),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Obx(() {
          if (listController.isLoading.value) {
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => const PokemonGridItemSkeleton(),
            );
          }

          if (listController.error.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    listController.error.value,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => listController.loadPokemons(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novamente'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: listController.pokemons.length +
                (listController.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == listController.pokemons.length) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                );
              }

              final pokemon = listController.pokemons[index];
              return Hero(
                tag: 'pokemon-${pokemon.id}',
                child: PokemonGridItem(pokemon: pokemon),
              );
            },
          );
        }),
      ),
    );
  }
}
