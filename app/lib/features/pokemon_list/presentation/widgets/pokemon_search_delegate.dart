import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/presentation/adapters/getx_adapter.dart';
import '../controllers/pokemon_list_controller.dart';
import 'pokemon_grid_item.dart';

class PokemonSearchDelegate extends SearchDelegate<void> {
  final _adapter = GetXAdapter();
  final PokemonListController controller = Get.find<PokemonListController>();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.home),
        onPressed: () {
          close(context, null);
          controller.loadPokemons();
          _adapter.offAllNamed('/');
        },
      ),
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
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
        controller.loadPokemons();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _buildSearchResults();
    }

    _debouncer.run(() {
      controller.searchPokemon(query);
    });

    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.pokemons.isEmpty) {
        return const Center(
          child: Text('Nenhum Pokémon encontrado'),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
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
