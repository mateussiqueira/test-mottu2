
import 'package:flutter/material.dart';
import '../../../../core/domain/entities/pokemon.dart';

class PokemonStats extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonStats({super.key, required this.pokemon});

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
              'Estatísticas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            if (pokemon.stats.isNotEmpty) ...[
              for (var stat in pokemon.stats)
                statBar(
                  context,
                  stat.name.toUpperCase().replaceAll('-', ' '),
                  stat.baseStat,
                ),
            ] else
              Text(
                'Nenhuma estatística disponível',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
          ],
        ),
      ),
    );
  }

  Widget statBar(BuildContext context, String statName, int baseStat) {
    final double percentage = baseStat / 255; // Máximo possível em Pokémon
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  statName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Text(
                '$baseStat',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColorForStat(baseStat),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForStat(int value) {
    if (value < 50) return Colors.red;
    if (value < 90) return Colors.orange;
    if (value < 120) return Colors.yellow;
    if (value < 150) return Colors.lightGreen;
    return Colors.green;
  }
}
