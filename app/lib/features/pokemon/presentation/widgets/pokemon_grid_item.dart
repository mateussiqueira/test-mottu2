import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/pokemon_entity.dart';

class PokemonGridItem extends StatelessWidget {
  final PokemonEntity pokemon;

  const PokemonGridItem({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/pokemon-detail', arguments: pokemon),
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: 'pokemon-${pokemon.id}',
                child: Image.network(
                  pokemon.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
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
          ],
        ),
      ),
    );
  }
}
