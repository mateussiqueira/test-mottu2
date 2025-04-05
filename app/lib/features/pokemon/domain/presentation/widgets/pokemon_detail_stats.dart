import 'package:flutter/material.dart';
import 'package:pokemon_list/features/pokemon/domain/entities/pokemon_entity_impl.dart';

class PokemonDetailStats extends StatelessWidget {
  final PokemonEntityImpl pokemon;

  const PokemonDetailStats({
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
              'Stats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...pokemon.stats.entries.map(
              (stat) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stat.key,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: stat.value / 100,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getStatColor(stat.key),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${stat.value}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatColor(String stat) {
    switch (stat.toLowerCase()) {
      case 'hp':
        return Colors.green;
      case 'attack':
        return Colors.red;
      case 'defense':
        return Colors.blue;
      case 'special-attack':
        return Colors.orange;
      case 'special-defense':
        return Colors.purple;
      case 'speed':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }
}
