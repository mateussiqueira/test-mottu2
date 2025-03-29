import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pokemon_list_controller.dart';
import 'pokemon_grid_item.dart';
import 'pokemon_grid_item_skeleton.dart';

class PokemonSearchDelegate extends SearchDelegate<void> {
  final PokemonListController controller = Get.find<PokemonListController>();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            controller.loadPokemons();
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            close(context, null);
            controller.loadPokemons();
          },
        ),
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            close(context, null);
            controller.loadPokemons();
            Get.offAllNamed(
                '/'); // Navega para a home e remove todas as rotas anteriores
          },
        ),
      ],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Type to search for Pokémon'),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                close(context, null);
                controller.loadPokemons();
                Get.offAllNamed('/');
              },
              icon: const Icon(Icons.home),
              label: const Text('Voltar para Home'),
            ),
          ],
        ),
      );
    }

    _debouncer.run(() {
      controller.searchPokemon(query);
    });

    return Obx(() {
      if (controller.isLoading.value) {
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: 6,
          itemBuilder: (context, index) => const PokemonGridItemSkeleton(),
        );
      }

      if (controller.error.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.error.value),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  close(context, null);
                  controller.loadPokemons();
                  Get.offAllNamed('/');
                },
                icon: const Icon(Icons.home),
                label: const Text('Voltar para Home'),
              ),
            ],
          ),
        );
      }

      if (controller.pokemons.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No Pokémon found'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  close(context, null);
                  controller.loadPokemons();
                  Get.offAllNamed('/');
                },
                icon: const Icon(Icons.home),
                label: const Text('Voltar para Home'),
              ),
            ],
          ),
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

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
