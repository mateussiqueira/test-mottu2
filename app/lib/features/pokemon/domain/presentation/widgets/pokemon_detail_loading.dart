import 'package:flutter/material.dart';

/// Widget that displays a loading state for Pokemon details
class PokemonDetailLoading extends StatelessWidget {
  const PokemonDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading Pokémon details...'),
        ],
      ),
    );
  }
}
