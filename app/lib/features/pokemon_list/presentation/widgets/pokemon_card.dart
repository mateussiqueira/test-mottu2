import 'package:flutter/material.dart';
import 'package:mobile/features/pokemon/domain/entities/pokemon_entity.dart';

class PokemonCard extends StatelessWidget {
  final PokemonEntityImpl pokemon;
  final VoidCallback? onTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    height: 120,
                    width: 120,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                    ),
                  ),
                  Image.network(
                    pokemon.imageUrl,
                    height: 120,
                    width: 120,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: pokemon.types.map((type) {
                  return Chip(
                    label: Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: _getTypeColor(type),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'grass':
        return Colors.green;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'electric':
        return Colors.yellow;
      case 'psychic':
        return Colors.purple;
      case 'ice':
        return Colors.lightBlue;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pink;
      case 'normal':
        return Colors.grey;
      case 'fighting':
        return Colors.orange;
      case 'flying':
        return Colors.indigo;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'rock':
        return Colors.grey;
      case 'bug':
        return Colors.lightGreen;
      case 'ghost':
        return Colors.deepPurple;
      case 'steel':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }
}
