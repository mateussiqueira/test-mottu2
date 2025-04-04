import 'package:flutter/material.dart';

import '../../../../features/pokemon/domain/entities/i_pokemon_entity.dart';

class PokemonStatsCard extends StatelessWidget {
  final IPokemonEntity pokemon;

  const PokemonStatsCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Base Stats',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ...pokemon.stats.entries.map((entry) {
              final statName = entry.key;
              final statValue = entry.value;
              final progress = statValue / 255;

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          statName,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          statValue.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getStatColor(progress),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getStatColor(double value) {
    if (value < 0.5) {
      return Colors.red;
    } else if (value < 0.7) {
      return Colors.orange;
    } else if (value < 0.8) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }
}
