import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pokemon_list_controller.dart';
import '../widgets/pokemon_grid_item.dart';
import '../widgets/pokemon_list_error.dart';
import '../widgets/pokemon_list_loading.dart';
import '../widgets/pokemon_search_delegate.dart';

/// Page that displays a grid of Pokemon
class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PokemonListController>();

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
        if (controller.isLoading) {
          return const PokemonListLoading();
        }

        final error = controller.error;
        if (error != null) {
          return PokemonListError(
            message: error,
            onRetry: controller.loadPokemons,
          );
        }

        if (controller.pokemons.isEmpty) {
          return const Center(
            child: Text('No Pokémon found'),
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
      }),
    );
  }
}
