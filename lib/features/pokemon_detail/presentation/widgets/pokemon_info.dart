import 'package:flutter/material.dart';
import '../../../../core/domain/entities/pokemon.dart';

class PokemonInfo extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonInfo({super.key, required this.pokemon});

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
              'Informações Básicas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            infoRow(context, 'ID', '${pokemon.id}'),
            infoRow(context, 'Altura', '${pokemon.height / 10} m'),
            infoRow(context, 'Peso', '${pokemon.weight / 10} kg'),
            infoRow(context, 'Experiência Base', '${pokemon.baseExperience}'),
          ],
        ),
      ),
    );
  }

  Widget infoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}