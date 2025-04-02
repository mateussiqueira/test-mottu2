import 'package:flutter/material.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon/presentation/widgets/pokemon_grid_item.dart';

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
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
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
