import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../domain/entities/pokemon.dart';

class PokemonGridItem extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonGridItem({
    super.key,
    required this.pokemon,
  });

  String get _imageUrl {
    return pokemon.sprites.other?.officialArtwork?.frontDefault ??
        pokemon.sprites.frontDefault ??
        '';
  }

  Color get _typeColor {
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

    final type = pokemon.types.first.name.toLowerCase();
    return typeColors[type] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => PokemonDetailPage(pokemon: pokemon));
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _typeColor.withOpacity(0.7),
                _typeColor.withOpacity(0.2),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _imageUrl.isNotEmpty
                    ? Image.network(
                        _imageUrl,
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
              Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${pokemon.id.toString().padLeft(3, '0')}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      pokemon.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: pokemon.types.map((type) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            type.name.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
