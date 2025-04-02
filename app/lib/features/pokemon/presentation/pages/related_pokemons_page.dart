import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/route_names.dart';
import '../../domain/entities/pokemon_entity.dart';
import '../widgets/pokemon_grid_item.dart';

class RelatedPokemonsPage extends StatelessWidget {
  final String title;
  final List<PokemonEntity> pokemons;

  const RelatedPokemonsPage({
    super.key,
    required this.title,
    required this.pokemons,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Get.offAllNamed(RouteNames.pokemonList),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          return PokemonGridItem(pokemon: pokemon);
        },
      ),
    );
  }
}
