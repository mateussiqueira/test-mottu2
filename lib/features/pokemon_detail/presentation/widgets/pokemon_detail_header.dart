import 'package:flutter/material.dart';

class PokemonDetailHeader extends StatelessWidget {
  final String imageUrl;
  final List<String> types;

  const PokemonDetailHeader({
    super.key,
    required this.imageUrl,
    required this.types,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _getTypeColor(types.first),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error_outline,
                    size: 48,
                    color: Colors.red,
                  );
                },
              )
            : const Icon(
                Icons.image_not_supported,
                size: 48,
                color: Colors.grey,
              ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    final Map<String, Color> typeColors = {
      'normal': Colors.grey,
      'fire': Colors.red,
      'water': Colors.blue,
      'electric': Colors.yellow,
      'grass': Colors.green,
      'ice': Colors.lightBlue,
      'fighting': Colors.orange,
      'poison': Colors.purple,
      'ground': Colors.brown,
      'flying': Colors.indigo,
      'psychic': Colors.pink,
      'bug': Colors.lightGreen,
      'rock': Colors.grey[700]!,
      'ghost': Colors.deepPurple,
      'dragon': Colors.deepPurple[700]!,
      'dark': Colors.grey[900]!,
      'steel': Colors.blueGrey,
      'fairy': Colors.pinkAccent,
    };

    return typeColors[type.toLowerCase()] ?? Colors.grey;
  }
}
