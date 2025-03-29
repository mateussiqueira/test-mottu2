import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/repositories/pokemon_repository.dart';
import '../controllers/pokemon_list_controller.dart';
import '../controllers/pokemon_search_controller.dart';
import '../widgets/pokemon_grid_item.dart';
import '../widgets/pokemon_search_delegate.dart';

class PokemonListPage extends StatelessWidget {
  final PokemonRepository repository;

  const PokemonListPage({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize controllers with repository
    Get.put(PokemonListController(repository));
    Get.put(PokemonSearchController(repository));

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
          return const Center(child: CircularProgressIndicator());
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

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >=
                    scrollInfo.metrics.maxScrollExtent * 0.8 &&
                !listController.isLoading.value &&
                listController.hasMore.value) {
              listController.loadPokemons();
            }
            return true;
          },
          child: GridView.builder(
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
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              final pokemon = listController.pokemons[index];
              return PokemonGridItem(pokemon: pokemon);
            },
          ),
        );
      }),
    );
  }
}
