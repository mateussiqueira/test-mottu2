import 'package:flutter/material.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../../../../features/pokemon_list/presentation/widgets/pokemon_card.dart';

class RelatedPokemons extends StatelessWidget {
  final String title;
  final List<PokemonEntity> pokemons;
  final Function(PokemonEntity) onPokemonTap;

  const RelatedPokemons({
    super.key,
    required this.title,
    required this.pokemons,
    required this.onPokemonTap,
  });

  @override
  Widget build(BuildContext context) {
    if (pokemons.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: pokemons.length,
            itemBuilder: (context, index) {
              final pokemon = pokemons[index];
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: PokemonCard(
                  pokemon: pokemon,
                  onTap: () => onPokemonTap(pokemon),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
