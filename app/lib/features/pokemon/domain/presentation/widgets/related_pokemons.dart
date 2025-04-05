import 'package:flutter/material.dart';
import 'package:pokemon_list/features/pokemon/domain/entities/pokemon_entity_impl.dart';
import 'package:pokemon_list/features/pokemon/domain/presentation/widgets/pokemon_card.dart';

class RelatedPokemons extends StatelessWidget {
  final List<PokemonEntityImpl> relatedPokemons;
  final Function(PokemonEntityImpl) onPokemonTap;

  const RelatedPokemons({
    super.key,
    required this.relatedPokemons,
    required this.onPokemonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Related Pokémon',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: relatedPokemons.length,
                itemBuilder: (context, index) {
                  final pokemon = relatedPokemons[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      width: 150,
                      child: PokemonCard(
                        pokemon: pokemon,
                        onTap: () => onPokemonTap(pokemon),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
