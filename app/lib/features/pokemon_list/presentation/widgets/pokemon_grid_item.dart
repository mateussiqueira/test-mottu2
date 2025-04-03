import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../features/pokemon/domain/entities/pokemon_entity.dart';
import '../controllers/i_pokemon_list_controller.dart';

/// Widget for displaying a Pokemon in the grid
class PokemonGridItem extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonGridItem({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IPokemonListController>();

    return Hero(
      tag: 'pokemon-${pokemon.id}',
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () => controller.navigateToDetail(pokemon),
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                pokemon.imageUrl,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '#${pokemon.id.toString().padLeft(3, '0')}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
