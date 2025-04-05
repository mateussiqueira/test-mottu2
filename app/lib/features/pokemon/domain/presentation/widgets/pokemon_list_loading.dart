import 'package:flutter/material.dart';

/// Widget that displays a loading state for Pokemon list
class PokemonListLoading extends StatelessWidget {
  const PokemonListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading Pokémon...'),
        ],
      ),
    );
  }
}
