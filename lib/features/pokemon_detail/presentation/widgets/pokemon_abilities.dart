
import 'package:flutter/material.dart';
import '../../../../core/domain/entities/pokemon.dart';

class PokemonAbilities extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonAbilities({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Habilidades',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: pokemon.abilities.isNotEmpty
                  ? pokemon.abilities
                      .map((ability) => buildAbilityChip(context, ability))
                      .toList()
                  : [
                      Text(
                        'Nenhuma habilidade disponível',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAbilityChip(BuildContext context, String ability) {
    return Chip(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      label: Text(
        ability.toUpperCase().replaceAll('-', ' '),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
