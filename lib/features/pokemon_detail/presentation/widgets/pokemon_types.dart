
import 'package:flutter/material.dart';
import '../../../../core/domain/entities/pokemon.dart';

class PokemonTypes extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonTypes({super.key, required this.pokemon});

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
              'Tipos',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: pokemon.types.isNotEmpty
                  ? pokemon.types
                      .map((type) => buildTypeChip(context, type))
                      .toList()
                  : [
                      Text(
                        'Nenhum tipo disponível',
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTypeChip(BuildContext context, String type) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/related-pokemons/$type',
        );
      },
      child: Chip(
        backgroundColor: _getTypeColor(type),
        label: Text(
          type.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    final typeColors = {
      'normal': Colors.brown[400],
      'fire': Colors.red,
      'water': Colors.blue,
      'electric': Colors.amber,
      'grass': Colors.green,
      'ice': Colors.cyan,
      'fighting': Colors.orange[800],
      'poison': Colors.purple,
      'ground': Colors.brown,
      'flying': Colors.indigo[200],
      'psychic': Colors.pink,
      'bug': Colors.lightGreen,
      'rock': Colors.grey,
      'ghost': Colors.deepPurple,
      'dragon': Colors.indigo,
      'dark': Colors.grey[800],
      'steel': Colors.blueGrey,
      'fairy': Colors.pinkAccent[100],
    };

    return typeColors[type.toLowerCase()] ?? Colors.grey;
  }
}
