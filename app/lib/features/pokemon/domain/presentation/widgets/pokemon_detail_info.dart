import 'package:flutter/material.dart';
import 'package:pokemon_list/features/pokemon/domain/entities/pokemon_entity_impl.dart';

class PokemonDetailInfo extends StatelessWidget {
  final PokemonEntityImpl pokemon;

  const PokemonDetailInfo({
    super.key,
    required this.pokemon,
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
              'Pokédex Number: #${pokemon.id}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Height: ${pokemon.height / 10} m',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Weight: ${pokemon.weight / 10} kg',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              pokemon.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
