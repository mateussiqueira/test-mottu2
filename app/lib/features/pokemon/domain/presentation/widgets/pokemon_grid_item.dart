import 'package:flutter/material.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import 'pokemon_card.dart';

/// Widget that displays a Pokemon in a grid format
class PokemonGridItem extends StatelessWidget {
  final IPokemonEntity pokemon;

  const PokemonGridItem({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return PokemonCard(pokemon: pokemon);
  }
}
