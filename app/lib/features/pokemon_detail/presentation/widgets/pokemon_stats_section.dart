import 'package:flutter/material.dart';

import '../../../pokemon/domain/entities/i_pokemon_entity.dart';

class PokemonStatsSection extends StatelessWidget {
  final IPokemonEntity pokemon;
  final Color mainColor;

  const PokemonStatsSection({
    super.key,
    required this.pokemon,
    required this.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stats',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...pokemon.stats.entries.map((stat) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.key,
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: stat.value / 255,
                  backgroundColor: mainColor.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                ),
                const SizedBox(height: 2),
                Text(
                  '${stat.value}',
                  style: TextStyle(
                    color: mainColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
