import 'package:flutter/material.dart';

import '../../domain/entities/i_pokemon_entity.dart';
import 'pokemon_card.dart';

/// Widget that displays a Pokemon card
class PokemonCardWidget extends StatelessWidget {
  final IPokemonEntity pokemon;

  const PokemonCardWidget({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return PokemonCard(pokemon: pokemon);
  }
}
