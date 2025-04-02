import 'package:flutter/material.dart';

import 'pokemon_grid_item_skeleton.dart';

/// Widget for displaying loading states in the Pokemon list
class PokemonListLoading extends StatelessWidget {
  const PokemonListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 10,
      itemBuilder: (context, index) => const PokemonGridItemSkeleton(),
    );
  }
}
