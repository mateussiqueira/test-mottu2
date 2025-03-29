import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/pokemon_entity.dart';
import '../controllers/pokemon_list_controller.dart';
import 'pokemon_grid_item.dart';

class PokemonSearchDelegate extends SearchDelegate<String> {
  final PokemonListController controller = Get.find<PokemonListController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return const Center(
        child: Text('Enter a Pokemon name to search'),
      );
    }

    return Obx(() {
      if (controller.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (controller.error.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.error),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.searchPokemon(query),
                child: const Text('Try again'),
              ),
            ],
          ),
        );
      }

      if (controller.pokemons.isEmpty) {
        return const Center(
          child: Text('No Pokemon found'),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: controller.pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = controller.pokemons[index] as PokemonEntityImpl;
          return PokemonGridItem(pokemon: pokemon);
        },
      );
    });
  }
}
