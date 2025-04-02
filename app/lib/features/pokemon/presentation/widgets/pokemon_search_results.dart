import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pokemon_list_controller.dart';
import 'pokemon_grid_item.dart';

/// Widget that displays Pokemon search results
class PokemonSearchResults extends StatelessWidget {
  final PokemonListController controller;
  final String query;

  const PokemonSearchResults({
    super.key,
    required this.controller,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
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

      final error = controller.error;
      if (error != null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error),
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
          final pokemon = controller.pokemons[index];
          return PokemonGridItem(pokemon: pokemon);
        },
      );
    });
  }
}
