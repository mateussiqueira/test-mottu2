import 'package:flutter/material.dart';

class PokemonAbilityChip extends StatelessWidget {
  final String ability;

  const PokemonAbilityChip({
    super.key,
    required this.ability,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        ability,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue,
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
