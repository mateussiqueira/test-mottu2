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
      appBar: AppBar(
        title: const Text('Pokédex'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PokemonSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
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
                Text(listController.error.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => listController.loadPokemons(),
                  child: const Text('Tentar novamente'),
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
                child: CircularProgressIndicator(),
              );
            }

            final pokemon = listController.pokemons[index];
            return PokemonGridItem(pokemon: pokemon);
          },
        );
      }),
    );
  }
}
