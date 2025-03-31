import 'package:flutter/material.dart';

class PokemonTypeChip extends StatelessWidget {
  final String type;

  const PokemonTypeChip({
    super.key,
    required this.type,
  });

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

  @override
  Widget build(BuildContext context) {
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
  }
}
