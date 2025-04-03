import 'package:flutter/material.dart';

import '../../../pokemon/domain/entities/pokemon_entity.dart';
import '../controllers/i_pokemon_detail_controller.dart';

class PokemonTypeAbilitySection extends StatelessWidget {
  final PokemonEntity pokemon;
  final IPokemonDetailController controller;

  const PokemonTypeAbilitySection({
    super.key,
    required this.pokemon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Types
        Wrap(
          spacing: 8,
          children: pokemon.types.map((type) {
            return GestureDetector(
              onTap: () async {
                await controller.fetchPokemonsByType(type);
                controller.navigateToRelatedPokemons(
                  controller.sameTypePokemons,
                  'Pokémons of type $type',
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
        // Abilities
        const Text(
          'Abilities',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: pokemon.abilities.map((ability) {
            return GestureDetector(
              onTap: () async {
                await controller.fetchPokemonsByAbility(ability);
                controller.navigateToRelatedPokemons(
                  controller.sameAbilityPokemons,
                  'Pokémons with ability $ability',
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  ability,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
